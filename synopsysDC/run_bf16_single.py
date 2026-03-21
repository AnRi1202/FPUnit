#!/usr/bin/env python3
"""
BF16 Add / BF16 Mult 単体の Area を取得。
TASK=15 (BF16 Add), TASK=16 (BF16 Mult) を実行し、bf16_single_area.csv に出力。
"""
import os
import subprocess
import glob

syn_dir = os.path.abspath(os.path.dirname(__file__))
os.chdir(syn_dir)
ROOT = os.path.abspath(os.path.join(syn_dir, ".."))

TASKS = [
    (15, "BF16_Add", "BF16 Add (FloPoCo, 18-bit)"),
    (16, "BF16_Mult", "BF16 Mult (FloPoCo, 18-bit)"),
]

def run_task(task_id):
    log_file = os.path.join(syn_dir, "logs", f"bf16_T{task_id}.log")
    os.makedirs(os.path.join(syn_dir, "logs"), exist_ok=True)
    cmd = (
        f"source ~/.cshrc; dc_shell-xg-t -x "
        f"'set TASK {task_id}; set VER comb; set ROOT {ROOT}' "
        f"-f run_ppa.tcl -o {log_file}"
    )
    try:
        subprocess.run(["tcsh", "-c", cmd], check=True, cwd=syn_dir)
    except subprocess.CalledProcessError as e:
        print(f"  Error TASK={task_id}: {e}")
        return None
    pattern = os.path.join(syn_dir, f"run-comb-{task_id}-*")
    dirs = sorted(glob.glob(pattern))
    rpt = os.path.join(dirs[-1], "results_summary.csv") if dirs else None
    area = None
    if rpt and os.path.exists(rpt):
        with open(rpt) as f:
            for line in f:
                if line.startswith("Entity,") or not line.strip():
                    continue
                parts = line.strip().split(",")
                if len(parts) >= 2:
                    try:
                        area = float(parts[1])
                    except ValueError:
                        pass
                    break
    return area

def main():
    print("BF16 Add / BF16 Mult single Area")
    print("=" * 40)
    results = []
    for task_id, label, desc in TASKS:
        print(f"\nRunning TASK={task_id}: {desc}")
        area = run_task(task_id)
        results.append((label, desc, area))
        print(f"  -> Area={area}")
    out_csv = os.path.join(syn_dir, "bf16_single_area.csv")
    with open(out_csv, "w") as f:
        f.write("Module,Description,Area\n")
        for label, desc, area in results:
            a = f"{area:.1f}" if area is not None else "N/A"
            f.write(f"{label},{desc},{a}\n")
    print(f"\nSaved {out_csv}")

if __name__ == "__main__":
    main()
