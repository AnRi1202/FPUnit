#!/usr/bin/env python3
"""
Pipeline sweep for FPAdd_origin_ret (FloPoCo FP32 Add only).
Sweeps NUM_PIPE from 1 to 18 with retiming.
"""
import os
import subprocess
import re
import sys

# Configuration
clock_period = 0.5
# Use command line to limit stages: python run_sweep_flopoco_origin_fpadd.py 1 2 3
pipeline_stages = [int(a) for a in sys.argv[1:]] if len(sys.argv) > 1 else list(range(1, 19))

label = "flopoco_origin_fpadd_ret"
tcl_file = "ret_flopoco_origin_fpadd.tcl"
csv_file = "sweep_summary_flopoco_origin_fpadd.csv"


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


def main():
    syn_dir = os.path.abspath(os.path.dirname(__file__))
    os.chdir(syn_dir)
    os.makedirs("logs", exist_ok=True)

    print(f"Starting {label} Pipeline Sweep...")

    done_stages = set()
    if not os.path.exists(csv_file):
        with open(csv_file, "w") as f:
            f.write("PipelineStages,Area,MaxDataArrival\n")
    else:
        with open(csv_file, "r") as f:
            lines = f.readlines()[1:]
            for line in lines:
                parts = line.strip().split(',')
                if len(parts) >= 1 and parts[0].isdigit():
                    done_stages.add(int(parts[0]))

    for pipe in pipeline_stages:
        if pipe in done_stages:
            print(f"  Skipping P{pipe} (already in {csv_file})")
            continue

        print(f"  Running P{pipe}...")
        sys.stdout.flush()

        log_file = f"logs/sweep_{label}_P{pipe}.log"
        full_cmd = f"source ~/.cshrc; setenv NUM_PIPE {pipe}; dc_shell-xg-t -f {tcl_file} >& {log_file}"

        try:
            subprocess.run(["tcsh", "-c", full_cmd], check=True, cwd=syn_dir)

            run_dirs = sorted([d for d in os.listdir(syn_dir)
                              if d.startswith(f"run-{label}-P{pipe}-T{clock_period}-")])
            if run_dirs:
                latest_run = os.path.join(syn_dir, run_dirs[-1])
                area, arrival = parse_results(latest_run)
                print(f"    Result: Area={area}, Arrival={arrival}")

                with open(csv_file, "a") as f:
                    f.write(f"{pipe},{area},{arrival}\n")
            else:
                print(f"    Error: Could not find run directory for P{pipe}")

        except subprocess.CalledProcessError as e:
            print(f"    Error: {e}")

    print("Sweep Completed.")


if __name__ == "__main__":
    main()
