import os, re

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
                    if match: area = match.group(1); break
    if os.path.exists(timing_rpt):
        with open(timing_rpt, 'r') as f:
            for line in f:
                if "data arrival time" in line:
                    match = re.search(r"data arrival time\s+([\d\.]+)", line)
                    if match: data_arrival = match.group(1); break
    return area, data_arrival

configs = [
    {"label": "v2_3_addmul", "csv": "sweep_summary_v2_3_addmul.csv"},
    {"label": "v2_4_divsqrt", "csv": "sweep_summary_v2_4_divsqrt.csv"},
    {"label": "v3_addmul", "csv": "sweep_summary_v3_addmul.csv"},
    {"label": "v3_1_divsqrt", "csv": "sweep_summary_v3_1_divsqrt.csv"},
    # Also handle the old label for v3_1
    {"label": "v3_divsqrt", "csv": "sweep_summary_v3_1_divsqrt.csv"},
]

for cfg in configs:
    label = cfg['label']
    csv = cfg['csv']
    results = {}
    pattern = f"run-{label}-P(\\d+)-T0.5-.*"
    for d in os.listdir('.'):
        match = re.match(pattern, d)
        if match:
            pipe = int(match.group(1))
            area, arrival = parse_results(d)
            if area != "N/A" and arrival != "N/A":
                # Keep latest for each pipe stage
                results[pipe] = (area, arrival)
    
    if results:
        # Load existing CSV if it exists
        existing = {}
        if os.path.exists(csv):
             with open(csv, 'r') as f:
                 for line in f.readlines()[1:]:
                     p, a, t = line.strip().split(',')
                     existing[int(p)] = (a, t)
        
        # Merge
        for p, val in results.items():
            if p not in existing:
                existing[p] = val
        
        # Write back sorted
        with open(csv, "w") as f:
            f.write("PipelineStages,Area,MaxDataArrival\n")
            for p in sorted(existing.keys()):
                f.write(f"{p},{existing[p][0]},{existing[p][1]}\n")
