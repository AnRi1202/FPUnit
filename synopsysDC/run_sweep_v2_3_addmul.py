import os
import subprocess
import re
import sys

# Configuration
clock_period = 0.5
pipeline_stages = list(range(1, 19)) # 1 to 18

# Synthesis Script Template
scripts = {
    "addmul": {
        "tcl": "ret_v2_3_addmul.tcl",
        "label": "v2_3_addmul",
        "csv": "sweep_summary_v2_3_addmul.csv"
    }
}

def parse_results(run_dir):
    area_rpt = os.path.join(run_dir, "area.rpt")
    timing_rpt = os.path.join(run_dir, "timing_setup.rpt")
    
    area = "N/A"
    data_arrival = "N/A"
    
    if os.path.exists(area_rpt):
        with open(area_rpt, 'r') as f:
            for line in f:
                if "Total cell area:" in line:
                    match = re.search(r"Total cell area:\s+([\d\.]+)", line)
                    if match:
                        area = match.group(1)
                        break

    if os.path.exists(timing_rpt):
        with open(timing_rpt, 'r') as f:
            for line in f:
                if "data arrival time" in line:
                    match = re.search(r"data arrival time\s+([\d\.]+)", line)
                    if match:
                        data_arrival = match.group(1)
                        break
    return area, data_arrival

for key, cfg in scripts.items():
    print(f"Starting {cfg['label']} Pipeline Sweep...")
    
    # Initialize CSV if it doesn't exist
    done_stages = set()
    if not os.path.exists(cfg['csv']):
        with open(cfg['csv'], "w") as f:
            f.write("PipelineStages,Area,MaxDataArrival\n")
    else:
        # Read existing results to skip
        with open(cfg['csv'], "r") as f:
            lines = f.readlines()[1:] # skip header
            for line in lines:
                parts = line.strip().split(',')
                if len(parts) >= 1:
                    done_stages.add(int(parts[0]))

    for pipe in pipeline_stages:
        if pipe in done_stages:
            print(f"  Skipping P{pipe} (already in {cfg['csv']})")
            continue

        print(f"  Running P{pipe}...")
        sys.stdout.flush()
        
        log_file = f"sweep_{cfg['label']}_P{pipe}.log"
        full_cmd = f"source ~/.cshrc; setenv PARAM_PIPE {pipe}; dc_shell-xg-t -f {cfg['tcl']} >& {log_file}"
        
        try:
            subprocess.run(["tcsh", "-c", full_cmd], check=True)
            
            # Find the run directory (it has a timestamp tag)
            pattern = f"run-{cfg['label']}-P{pipe}-T{clock_period}-*"
            run_dirs = sorted([d for d in os.listdir('.') if re.match(pattern, d)])
            if run_dirs:
                latest_run = run_dirs[-1]
                area, arrival = parse_results(latest_run)
                print(f"    Result: Area={area}, Arrival={arrival}")
                
                # Append to CSV immediately
                with open(cfg['csv'], "a") as f:
                    f.write(f"{pipe},{area},{arrival}\n")
            else:
                print(f"    Error: Could not find run directory for P{pipe}")
                
        except subprocess.CalledProcessError as e:
            print(f"    Error: {e}")

print("Sweep Completed.")
