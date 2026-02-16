#!/usr/bin/env python3
import os
import re

def main():
    log_pattern = re.compile(r"Done (.*?): Area=([0-9\.]+), DAT=([0-9\.\-N/A]+)")
    
    results = []
    
    # Iterate over all files in current directory
    for filename in os.listdir("."):
        if filename.endswith(".log"):
            with open(filename, "r") as f:
                content = f.read()
                matches = log_pattern.findall(content)
                for label, area, dat in matches:
                    results.append((label, area, dat))
    
    # Sort results for better readability
    # Attempt to sort by Label (Add/Mult) then frequency/pipe if parseable, or just label string
    results.sort(key=lambda x: x[0])
    
    output_file = "final_summary.csv"
    with open(output_file, "w") as f:
        f.write("Entity,Area,DAT\n")
        for label, area, dat in results:
            f.write(f"{label},{area},{dat}\n")
            
    print(f"Summary written to {output_file}")
    # Print to stdout as well for immediate verification
    print("Entity,Area,DAT")
    for label, area, dat in results:
        print(f"{label},{area},{dat}")

if __name__ == "__main__":
    main()
