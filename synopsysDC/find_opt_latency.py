#!/usr/bin/env python3
import os
import subprocess
import re
import csv
from datetime import datetime

# Configuration
TCL_SCRIPT = "ret_v1.tcl"
LOG_FILE = "optimization_log.csv"
MAX_STAGES = 25  # Start search from this safe value
TARGET_PERIOD = 0.5 # 2GHz

def parse_timing_report(report_path):
    """Parses the timing report to extract slack and data arrival time."""
    if not os.path.exists(report_path):
        return None, None
    
    with open(report_path, 'r') as f:
        content = f.read()
    
    # Extract Slack
    slack = None
    match_slack = re.search(r'slack \((VIOLATED|MET)\)\s+([0-9\.\-]+)', content)
    if match_slack:
        slack = float(match_slack.group(2))
        
    # Extract Data Arrival Time
    # usually appears as "data arrival time       5.65"
    arrival = None
    match_arr = re.search(r'data arrival time\s+([0-9\.]+)', content)
    if match_arr:
        arrival = float(match_arr.group(1))
        
    return slack, arrival

def run_synthesis(A, M, D, S):
    """Runs synthesis and returns (slack, arrival_time)."""
    env = os.environ.copy()
    env["PIPE_A"] = str(A)
    env["PIPE_M"] = str(M)
    env["PIPE_D"] = str(D)
    env["PIPE_S"] = str(S)
    
    print(f"Running Synthesis with A={A}, M={M}, D={D}, S={S}...")
    
    # Run DC Shell
    cmd = ["dc_shell", "-f", TCL_SCRIPT]
    
    try:
        result = subprocess.run(cmd, env=env, cwd=os.getcwd(), capture_output=True, text=True)
    except Exception as e:
        print(f"Error running synthesis: {e}")
        return -999.0, None

    # Logic to find the latest run directory
    dirs = [d for d in os.listdir(".") if d.startswith(f"run-v1_ret-A{A}M{M}-D{D}S{S}-T{TARGET_PERIOD}")]
    if not dirs:
        print("Output directory not found!")
        return -999.0, None
    
    latest_dir = max(dirs, key=os.path.getmtime)
    report_path = os.path.join(latest_dir, "timing_setup.rpt")
    
    slack, arrival = parse_timing_report(report_path)
    if slack is None:
        print("Could not parse timing report.")
        return -999.0, None
        
    print(f"  -> Result: Slack = {slack} ns, Arrival Time = {arrival} ns")
    return slack, arrival


def find_min_stages_relative(target_op, baseline, best_arrival, tolerance=0.10, lower_bound=1):
    """
    Finds minimum stages for target_op such that arrival time is within tolerance of best_arrival.
    """
    start_val = baseline[target_op]
    print(f"\nOptimization: Finding minimum stages for {target_op} (Baseline Arrival: {best_arrival}, Tol: {tolerance})...")
    
    low = lower_bound
    high = start_val
    best_config_val = start_val
    
    # Binary Search
    while low <= high:
        mid = (low + high) // 2
        
        # Construct params
        curr = baseline.copy()
        curr[target_op] = mid
        
        print(f"  Checking {target_op}={mid}...")
        slack, arrival = run_synthesis(curr['A'], curr['M'], curr['D'], curr['S'])
        
        if arrival is None: # Error case
            print("Skipping due to synthesis error.")
            low = mid + 1
            continue

        # Check if result is acceptable
        # Acceptable if arrival <= (best_arrival + tolerance)
        # Note: Arrival time is delay, so lower is better. We allow it to be slightly worse (higher) by tolerance.
        limit = best_arrival + tolerance
        
        if arrival <= limit:
            print(f"    Pass (Arrival={arrival} <= {limit:.3f}). Slack={slack}. Trying lower...")
            best_config_val = mid
            high = mid - 1
        else:
            print(f"    Fail (Arrival={arrival} > {limit:.3f}). Slack={slack}. Need more...")
            low = mid + 1
            
    print(f"Min stages for {target_op}: {best_config_val}")
    return best_config_val

def main():
    # Configuration for search upper bounds (Safe maximums)
    HIGH_CFG = {'A': 10, 'M': 10, 'D': 20, 'S': 24}
    
    print("Step 1: Establishing Best Possible Performance (Baseline)...")
    print(f"Running with high pipeline depth: {HIGH_CFG}")
    best_slack, best_arrival = run_synthesis(**HIGH_CFG)
    
    if best_arrival is None:
        print("Error: Baseline synthesis failed.")
        return
        
    print(f"\nBaseline Arrival Time: {best_arrival} ns (Slack: {best_slack} ns)")
    if best_slack < 0:
        print("Note: Timing is violated even at max stages. Optimizing for 'saturation point' based on Arrival Time.")
    
    # Store optimized values
    opt_cfg = HIGH_CFG.copy()
    
    # 2. Optimize each independently based on deviation from Best Arrival Time
    # Tolerance is now in nanoseconds of delay deviation allowed.
    # 0.05ns = 50ps.
    TOLERANCE = 0.05 
    
    opt_cfg['A'] = find_min_stages_relative('A', HIGH_CFG, best_arrival, TOLERANCE, lower_bound=2)
    opt_cfg['M'] = find_min_stages_relative('M', HIGH_CFG, best_arrival, TOLERANCE, lower_bound=2)
    opt_cfg['D'] = find_min_stages_relative('D', HIGH_CFG, best_arrival, TOLERANCE, lower_bound=4)
    opt_cfg['S'] = find_min_stages_relative('S', HIGH_CFG, best_arrival, TOLERANCE, lower_bound=4)
    
    print("\n--------------------------")
    print("Optimization Results:")
    print(f"Target Clock Period: {TARGET_PERIOD} ns")
    print(f"Best Achievable Arrival Time: {best_arrival} ns")
    print(f"Tolerance Used: {TOLERANCE} ns")
    print("--------------------------")
    print(f"Recommended Configuration (Min Stages for Saturation):")
    print(f"  Add : {opt_cfg['A']}")
    print(f"  Mul : {opt_cfg['M']}")
    print(f"  Div : {opt_cfg['D']}")
    print(f"  Sqrt: {opt_cfg['S']}")
    print("--------------------------")
    
    # 3. Final Validation
    print("Step 3: Validation of final combined configuration...")
    final_slack, final_arrival = run_synthesis(**opt_cfg)
    print(f"Final Combined Arrival Time: {final_arrival} ns (Slack: {final_slack} ns)")
    
    diff = final_arrival - best_arrival
    if diff <= 2 * TOLERANCE: # loose check for combined effect (lower is better or close)
        print("Success: Final performance is comparable to baseline.")
    else:
        print(f"Warning: Combined arrival time worsened by {diff:.3f} ns. Combined effect of reducing all stages might be significant.")



if __name__ == "__main__":
    main()
