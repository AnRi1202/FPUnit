#!/usr/bin/env python3
"""
FloPoCo excなし / * バージョンの comb (純粋組み合わせ) Area を取得。
run_ppa.tcl の TASK=10 (4ops excなし), TASK=12 (4ops excなし+*), TASK=9 (6ops VHDL), TASK=13 (6ops excなし+*) を実行し、
結果を comb_flopoco_origin_area.csv にまとめる。
"""
import os
import subprocess
import glob

syn_dir = os.path.abspath(os.path.dirname(__file__))
os.chdir(syn_dir)
ROOT = os.path.abspath(os.path.join(syn_dir, ".."))

# TASK -> (label, description)
TASKS = [
    (10, "FPALL_origin_4op_exc_removed", "4ops excなし (FloPoCo mult)"),
    (12, "FPALL_baseline_4op_exc_removed_star", "4ops excなし + FPMult=*"),
    (9, "fpall_6op_origin_VHDL", "6ops VHDL (excあり)"),
    (13, "FPALL_baseline_6op_exc_removed_star", "6ops excなし + FPMult=*"),
    (14, "fpall_shared", "fpall_shared (v2_bf16_full, HW shared)"),
]

def run_task(task_id):
    """Run dc_shell with run_ppa.tcl for given TASK. Returns (label, area, dat)."""
    label = f"flopoco_comb_T{task_id}"
    log_file = os.path.join(syn_dir, "logs", f"comb_flopoco_T{task_id}.log")
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
        return (label, None, None)
    # run_dir = run-$VER-$TASK-$tag → run-comb-10-20251216-141905
    pattern = os.path.join(syn_dir, f"run-comb-{task_id}-*")
    dirs = sorted(glob.glob(pattern))
    rpt = None
    if dirs:
        rpt = os.path.join(dirs[-1], "results_summary.csv")
    area = dat = None
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
                    if len(parts) >= 5:
                        dat = parts[4]
                    break
    return (label, area, dat)


def main():
    print("FloPoCo comb (excなし, *) Area measurement")
    print("=" * 50)
    results = []
    for task_id, label, desc in TASKS:
        print(f"\nRunning TASK={task_id}: {desc}")
        _, area, dat = run_task(task_id)
        results.append((label, desc, area, dat))
        print(f"  -> Area={area}, DAT={dat}")
    out_csv = os.path.join(syn_dir, "comb_flopoco_origin_area.csv")
    with open(out_csv, "w") as f:
        f.write("Design,Description,Area,DAT\n")
        for label, desc, area, dat in results:
            a = f"{area:.1f}" if area is not None else "N/A"
            d = str(dat) if dat else "N/A"
            f.write(f"{label},{desc},{a},{d}\n")
    print(f"\nSaved {out_csv}")


if __name__ == "__main__":
    main()
