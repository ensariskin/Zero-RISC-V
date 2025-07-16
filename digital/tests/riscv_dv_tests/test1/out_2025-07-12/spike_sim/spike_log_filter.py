#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Spike Log Filter Script
Filters Spike simulation log to keep only execution lines (core   0: 3)
and removes the prefix for cleaner output.

Created by Şükrü-AI for RISC-V log processing
"""

import sys
import os

def filter_spike_log(input_file, output_file=None):
    """
    Filter Spike log file to keep only execution lines
    
    Args:
        input_file (str): Path to input Spike log file
        output_file (str): Path to output file (optional)
    """
    
    if not os.path.exists(input_file):
        print(f"Error: Input file '{input_file}' not found!")
        return False
    
    # If no output file specified, create one based on input filename
    if output_file is None:
        base_name = os.path.splitext(input_file)[0]
        output_file = f"{base_name}_filtered.log"
    
    try:
        with open(input_file, 'r', encoding='utf-8') as infile:
            with open(output_file, 'w', encoding='utf-8') as outfile:
                
                filtered_lines = 0
                total_lines = 0
                
                print(f"Processing: {input_file}")
                print(f"Output: {output_file}")
                print("=" * 50)
                
                for line in infile:
                    total_lines += 1
                    
                    # Check if line starts with "core   0: 3"
                    if line.strip().startswith("core   0: 3"):
                        # Remove "core   0: 3" prefix and any extra spaces
                        filtered_line = line.replace("core   0: 3", "", 1).lstrip()
                        
                        # Write the cleaned line
                        outfile.write(filtered_line)
                        filtered_lines += 1
                        
                        # Show progress for every 1000 lines
                        if filtered_lines % 1000 == 0:
                            print(f"Processed {filtered_lines} execution lines...")
                
                print("=" * 50)
                print(f"Summary:")
                print(f"Total lines read: {total_lines:,}")
                print(f"Execution lines found: {filtered_lines:,}")
                print(f"Lines filtered out: {total_lines - filtered_lines:,}")
                print(f"Compression ratio: {(1 - filtered_lines/total_lines)*100:.1f}%")
                print(f"Filtered log saved to: {output_file}")
                
                return True
                
    except Exception as e:
        print(f"Error processing file: {e}")
        return False

def main():
    """Main function to handle command line arguments"""
    
    print("Spike Log Filter - by Şükrü-AI")
    print("=" * 40)
    
    # Check command line arguments
    if len(sys.argv) < 2:
        print("Usage:")
        print(f"   python {sys.argv[0]} <input_log_file> [output_file]")
        print("\nExamples:")
        print(f"   python {sys.argv[0]} spike_sim.log")
        print(f"   python {sys.argv[0]} spike_sim.log filtered_output.log")
        print("\nIf no output file is specified, it will create one automatically.")
        return
    
    input_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else None
    
    # Process the file
    success = filter_spike_log(input_file, output_file)
    
    if success:
        print("\nProcessing completed successfully!")
    else:
        print("\nProcessing failed!")
        sys.exit(1)

if __name__ == "__main__":
    main()
