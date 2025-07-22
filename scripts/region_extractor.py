#!/usr/bin/env python3
"""
Region Extractor Script

This script extracts region data from RISC-V assembly files and generates 
separate .hex files for each region found in the assembly code.

Usage: python region_extractor.py <assembly_file>

The script will:
1. Parse the assembly file to find region_N: sections
2. Extract hex data from .word directives in each region
3. Generate region_N.hex files for each region found

Author: Generated for RV32I Processor Project
"""

import re
import sys
import os
from pathlib import Path


def extract_regions_from_assembly(assembly_file):
    """
    Extract region data from assembly file and return dictionary of regions.
    
    Args:
        assembly_file (str): Path to the assembly file
        
    Returns:
        dict: Dictionary with region names as keys and hex data lists as values
    """
    regions = {}
    
    try:
        with open(assembly_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading file {assembly_file}: {e}")
        return regions
    
    # Split content into lines for processing
    lines = content.split('\n')
    current_region = None
    in_region_section = False
    
    for line_num, line in enumerate(lines, 1):
        line = line.strip()
        
        # Check for region label (e.g., "region_0:", "region_1:")
        region_match = re.match(r'^(region_\d+):\s*$', line)
        if region_match:
            current_region = region_match.group(1)
            regions[current_region] = []
            in_region_section = True
            print(f"Found {current_region} at line {line_num}")
            continue
        
        # Check for section directive that indicates we're in a region section
        if line.startswith('.section .region_'):
            in_region_section = True
            continue
        
        # Check for new section that's not a region (end of current region)
        if line.startswith('.section') and '.region_' not in line:
            in_region_section = False
            current_region = None
            continue
        
        # Process .word directives if we're in a region
        if in_region_section and current_region and line.startswith('.word'):
            # Extract hex values from .word directive
            # Pattern matches: .word 0x12345678, 0xabcdef00, ...
            word_pattern = r'\.word\s+(.*)'
            match = re.match(word_pattern, line)
            
            if match:
                hex_values_str = match.group(1)
                # Find all hex values in the line
                hex_values = re.findall(r'0x([0-9a-fA-F]{8})', hex_values_str)
                
                for hex_val in hex_values:
                    # Convert 32-bit hex to 8-bit bytes in little-endian format
                    # 0xAABBCCDD becomes: DD, CC, BB, AA
                    hex_val = hex_val.upper()
                    byte3 = hex_val[6:8]  # DD (LSB)
                    byte2 = hex_val[4:6]  # CC
                    byte1 = hex_val[2:4]  # BB
                    byte0 = hex_val[0:2]  # AA (MSB)
                    
                    # Add bytes in little-endian order
                    regions[current_region].extend([byte3, byte2, byte1, byte0])
    
    return regions


def write_hex_files(regions, output_dir=None):
    """
    Write hex data to separate files for each region.
    
    Args:
        regions (dict): Dictionary with region names and hex data
        output_dir (str, optional): Output directory. If None, uses current directory.
    """
    if output_dir is None:
        output_dir = os.getcwd()
    
    output_path = Path(output_dir)
    output_path.mkdir(exist_ok=True)
    
    files_created = []
    
    for region_name, hex_data in regions.items():
        if not hex_data:
            print(f"Warning: {region_name} contains no data")
            continue
        
        hex_filename = f"{region_name}.hex"
        hex_filepath = output_path / hex_filename
        
        try:
            with open(hex_filepath, 'w') as f:
                for hex_byte in hex_data:
                    f.write(f"{hex_byte}\n")
            
            files_created.append(hex_filepath)
            print(f"Created {hex_filename} with {len(hex_data)} hex bytes")
            
        except Exception as e:
            print(f"Error writing {hex_filename}: {e}")
    
    return files_created


def main():
    """Main function to process command line arguments and extract regions."""
    
    if len(sys.argv) != 2:
        print("Usage: python region_extractor.py <assembly_file>")
        print("\nExample: python region_extractor.py riscv_rand_instr_test_0.S")
        print("\nThis script will extract region data from the assembly file")
        print("and create separate .hex files for each region found.")
        print("Each 32-bit word will be split into 8-bit bytes in little-endian format.")
        sys.exit(1)
    
    assembly_file = sys.argv[1]
    
    # Check if input file exists
    if not os.path.isfile(assembly_file):
        print(f"Error: File '{assembly_file}' not found")
        sys.exit(1)
    
    print(f"Processing assembly file: {assembly_file}")
    print("-" * 50)
    
    # Extract regions from assembly file
    regions = extract_regions_from_assembly(assembly_file)
    
    if not regions:
        print("No regions found in the assembly file")
        print("Make sure the file contains region_N: labels with .word directives")
        sys.exit(1)
    
    print(f"\nFound {len(regions)} region(s):")
    for region_name, hex_data in regions.items():
        word_count = len(hex_data) // 4  # 4 bytes per word
        print(f"  {region_name}: {word_count} words ({len(hex_data)} bytes)")
    
    print("\nGenerating hex files...")
    print("-" * 50)
    
    # Write hex files
    files_created = write_hex_files(regions)
    
    print(f"\nSuccessfully created {len(files_created)} hex file(s):")
    for filepath in files_created:
        print(f"  {filepath}")
    
    print("\nRegion extraction completed!")
    print("Note: 32-bit words have been split into 8-bit bytes in little-endian format")


if __name__ == "__main__":
    main()
