#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Professional RISC-V Log Comparator v3.0
Based on classical LCS (Longest Common Subsequence) dynamic programming algorithm
Research-driven implementation using industry-standard diff approaches

Key Features:
1. Classical LCS algorithm with dynamic programming (O(n×m))
2. Proper traceback mechanism for generating differences
3. Separate infinite loop detection (keeps existing pattern removal)
4. Unified diff-style output with context
5. Accurate register value and memory operation comparison

References:
- "An Algorithm for Differential File Comparison" by Hunt & McIlroy (1976)
- "An O(ND) Difference Algorithm and its Variations" by Myers (1986)
- Classical LCS dynamic programming approach from CLRS textbook
"""

import sys
import os
import re
from typing import List, Tuple, Dict, Set, Optional, NamedTuple
from collections import defaultdict
from dataclasses import dataclass
from enum import Enum

class DiffType(Enum):
    EQUAL = "equal"
    DELETE = "delete" 
    INSERT = "insert"

@dataclass
class LogEntry:
    """RISC-V log entry with complete parsing"""
    pc: str
    instruction: str
    extra: str
    original: str
    line_num: int
    
    @classmethod
    def parse(cls, line: str, line_num: int = 0):
        """Parse RISC-V log entry"""
        line = line.strip()
        if not line:
            return None
            
        # Pattern: 0xPC (0xINSTR) extra_info
        match = re.match(r'0x([0-9a-fA-F]+)\s+\(0x([0-9a-fA-F]+)\)(.*)$', line)
        if not match:
            return None
            
        return cls(
            pc=match.group(1).upper(),
            instruction=match.group(2).upper(), 
            extra=match.group(3).strip(),
            original=line,
            line_num=line_num
        )
    
    def pattern_key(self) -> str:
        """Simple key for pattern detection (PC:instruction only)"""
        return f"{self.pc}:{self.instruction}"
    
    def full_key(self) -> str:
        """Complete key for comparison (includes register values)"""
        return f"{self.pc}:{self.instruction}:{self.extra}"
    
    def __eq__(self, other):
        """Equality based on full comparison including register values"""
        if not isinstance(other, LogEntry):
            return False
        return self.full_key() == other.full_key()
    
    def __hash__(self):
        return hash(self.full_key())

@dataclass
class DiffResult:
    """Result of LCS diff operation"""
    diff_type: DiffType
    core_idx: int
    spike_idx: int
    entry: Optional[LogEntry]

class InfiniteLoopDetector:
    """Pattern detection for removing infinite loops (unchanged)"""
    
    def __init__(self, min_pattern_length=3, min_repetitions=20):
        self.min_pattern_length = min_pattern_length
        self.min_repetitions = min_repetitions
        self.removed_count = 0
        self.patterns_found = []
    
    def remove_patterns(self, entries: List[LogEntry]) -> List[LogEntry]:
        """Remove infinite loops using simple pattern keys"""
        if len(entries) < self.min_pattern_length * self.min_repetitions:
            return entries
            
        print(f"Detecting infinite loops in {len(entries)} entries...")
        
        # Use simple pattern keys (PC:instruction) for loop detection
        keys = [entry.pattern_key() for entry in entries]
        keep_indices = set(range(len(entries)))
        
        # Detect patterns of various lengths
        for pattern_len in range(self.min_pattern_length, min(30, len(entries) // self.min_repetitions)):
            self._detect_pattern_length(keys, keep_indices, pattern_len)
        
        # Keep only non-repetitive entries
        result = [entries[i] for i in sorted(keep_indices)]
        removed = len(entries) - len(result)
        
        if removed > 0:
            print(f"Removed {removed} repetitive entries from {len(self.patterns_found)} patterns")
            self.removed_count = removed
            
        return result
    
    def _detect_pattern_length(self, keys: List[str], keep_indices: Set[int], pattern_len: int):
        """Detect patterns of specific length"""
        i = 0
        while i <= len(keys) - (pattern_len * self.min_repetitions):
            if i not in keep_indices:
                i += 1
                continue
                
            # Extract potential pattern
            pattern = keys[i:i + pattern_len]
            
            # Count consecutive repetitions
            reps = 1
            pos = i + pattern_len
            
            while pos + pattern_len <= len(keys) and keys[pos:pos + pattern_len] == pattern:
                reps += 1
                pos += pattern_len
            
            # If pattern repeats enough times, remove excess
            if reps >= self.min_repetitions:
                # Keep first 2 occurrences, remove the rest
                total_removed = (reps - 2) * pattern_len
                remove_start = i + (2 * pattern_len)
                remove_end = i + (reps * pattern_len)
                
                # Remove from keep_indices
                for idx in range(remove_start, remove_end):
                    keep_indices.discard(idx)
                
                # Record pattern
                self.patterns_found.append({
                    'length': pattern_len,
                    'repetitions': reps,
                    'location': f"Line {i}",
                    'removed': total_removed
                })
                
                i = remove_end
            else:
                i += 1

class LCSComparator:
    """Classical LCS algorithm implementation using dynamic programming"""
    
    def __init__(self):
        self.lcs_table = None
        self.sequence_a = None
        self.sequence_b = None
    
    def compute_lcs_table(self, seq_a: List[LogEntry], seq_b: List[LogEntry]) -> List[List[int]]:
        """
        Compute LCS table using classical dynamic programming approach
        Based on CLRS textbook algorithm
        """
        print(f"Computing LCS table for sequences of length {len(seq_a)} and {len(seq_b)}")
        
        self.sequence_a = seq_a
        self.sequence_b = seq_b
        
        m, n = len(seq_a), len(seq_b)
        
        # Initialize LCS table with dimensions (m+1) x (n+1)
        lcs_table = [[0 for _ in range(n + 1)] for _ in range(m + 1)]
        
        # Fill the table using classical LCS recurrence relation
        for i in range(1, m + 1):
            for j in range(1, n + 1):
                if seq_a[i-1] == seq_b[j-1]:  # Elements match
                    lcs_table[i][j] = lcs_table[i-1][j-1] + 1
                else:  # Elements don't match
                    lcs_table[i][j] = max(lcs_table[i-1][j], lcs_table[i][j-1])
        
        self.lcs_table = lcs_table
        print(f"LCS length: {lcs_table[m][n]}")
        return lcs_table
    
    def traceback_differences(self) -> List[DiffResult]:
        """
        Traceback through LCS table to generate diff operations
        This is the classical traceback algorithm from diff literature
        """
        if not self.lcs_table or not self.sequence_a or not self.sequence_b:
            return []
        
        print("Performing LCS traceback to generate differences...")
        
        diffs = []
        m, n = len(self.sequence_a), len(self.sequence_b)
        i, j = m, n
        
        # Traceback from bottom-right to top-left
        while i > 0 or j > 0:
            if i > 0 and j > 0 and self.sequence_a[i-1] == self.sequence_b[j-1]:
                # Elements match - this is part of LCS
                diffs.append(DiffResult(DiffType.EQUAL, i-1, j-1, self.sequence_a[i-1]))
                i -= 1
                j -= 1
            elif j > 0 and (i == 0 or self.lcs_table[i][j-1] >= self.lcs_table[i-1][j]):
                # Element exists in sequence_b but not in LCS
                diffs.append(DiffResult(DiffType.INSERT, -1, j-1, self.sequence_b[j-1]))
                j -= 1
            elif i > 0:
                # Element exists in sequence_a but not in LCS
                diffs.append(DiffResult(DiffType.DELETE, i-1, -1, self.sequence_a[i-1]))
                i -= 1
        
        # Reverse to get correct order
        diffs.reverse()
        return diffs

class ProfessionalLogComparator:
    """Main comparator class using research-based LCS approach"""
    
    def __init__(self):
        self.stats = {
            'core_entries': 0,
            'spike_entries': 0,
            'perfect_matches': 0,
            'deletions': 0,
            'insertions': 0,
            'loops_removed': 0,
            'lcs_length': 0
        }
        self.patterns_found = []
    
    def load_log_file(self, filepath: str) -> List[LogEntry]:
        """Load and parse log file"""
        entries = []
        
        if not os.path.exists(filepath):
            print(f"❌ Error: File not found: {filepath}")
            return entries
        
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                for line_num, line in enumerate(f, 1):
                    entry = LogEntry.parse(line, line_num)
                    if entry:
                        entries.append(entry)
            
            print(f"✅ Loaded {len(entries)} entries from {os.path.basename(filepath)}")
            return entries
            
        except Exception as e:
            print(f"❌ Error reading {filepath}: {e}")
            return []
    
    def compare_logs(self, core_file: str, spike_file: str) -> str:
        """Main comparison function using LCS algorithm"""
        print("🚀 PROFESSIONAL RISC-V LOG COMPARISON v3.0")
        print("Using Classical LCS Dynamic Programming Algorithm")
        print("=" * 70)
        
        # Load files
        core_entries = self.load_log_file(core_file)
        spike_entries = self.load_log_file(spike_file)
        
        if not core_entries or not spike_entries:
            return "❌ Failed to load log files"
        
        # Remove infinite loops
        print("\n🔄 Step 1: Removing infinite loops...")
        detector = InfiniteLoopDetector(min_pattern_length=3, min_repetitions=20)
        
        core_clean = detector.remove_patterns(core_entries)
        core_patterns = detector.patterns_found.copy()
        
        detector.patterns_found.clear()
        spike_clean = detector.remove_patterns(spike_entries)
        spike_patterns = detector.patterns_found.copy()
        
        # Update stats
        self.stats['core_entries'] = len(core_clean)
        self.stats['spike_entries'] = len(spike_clean)
        self.stats['loops_removed'] = len(core_entries) + len(spike_entries) - len(core_clean) - len(spike_clean)
        self.patterns_found = core_patterns + spike_patterns
        
        # Compute LCS and generate differences
        print("\n🔍 Step 2: Computing LCS using dynamic programming...")
        lcs_comparator = LCSComparator()
        lcs_table = lcs_comparator.compute_lcs_table(core_clean, spike_clean)
        self.stats['lcs_length'] = lcs_table[len(core_clean)][len(spike_clean)]
        
        print("📊 Step 3: Generating differences via traceback...")
        differences = lcs_comparator.traceback_differences()
        
        # Analyze results
        self._analyze_differences(differences)
        
        # Generate report
        return self._generate_report(core_file, spike_file, differences)
    
    def _analyze_differences(self, differences: List[DiffResult]):
        """Analyze diff results and update statistics"""
        for diff in differences:
            if diff.diff_type == DiffType.EQUAL:
                self.stats['perfect_matches'] += 1
            elif diff.diff_type == DiffType.DELETE:
                self.stats['deletions'] += 1
            elif diff.diff_type == DiffType.INSERT:
                self.stats['insertions'] += 1
    
    def _generate_report(self, core_file: str, spike_file: str, differences: List[DiffResult]) -> str:
        """Generate comprehensive comparison report"""
        total_ops = self.stats['perfect_matches'] + self.stats['deletions'] + self.stats['insertions']
        match_pct = (self.stats['perfect_matches'] / total_ops * 100) if total_ops > 0 else 0
        
        report = []
        report.append("🚀 PROFESSIONAL RISC-V LOG COMPARISON REPORT v3.0")
        report.append("=" * 70)
        report.append(f"Core File:  {os.path.basename(core_file)}")
        report.append(f"Spike File: {os.path.basename(spike_file)}")
        report.append("Algorithm:  Classical LCS Dynamic Programming")
        report.append("Generated by Professional Log Comparator v3.0")
        report.append("")
        
        # Algorithm info
        report.append("🎯 ALGORITHM DETAILS")
        report.append("-" * 30)
        report.append("• LCS Algorithm: Classical Dynamic Programming O(n×m)")
        report.append("• Pattern Detection: Simple keys (PC:instruction)")
        report.append("• Final Comparison: Full keys (PC:instruction:registers)")
        report.append("• Traceback: Standard diff generation approach")
        report.append("")
        
        # Statistics
        report.append("📊 COMPARISON STATISTICS")
        report.append("-" * 30)
        report.append(f"Core entries (after cleanup):   {self.stats['core_entries']:,}")
        report.append(f"Spike entries (after cleanup):  {self.stats['spike_entries']:,}")
        report.append(f"Infinite loops removed:         {self.stats['loops_removed']:,}")
        report.append(f"LCS length:                     {self.stats['lcs_length']:,}")
        report.append("")
        report.append(f"Perfect matches:                {self.stats['perfect_matches']:,}")
        report.append(f"Deletions (Core only):          {self.stats['deletions']:,}")
        report.append(f"Insertions (Spike only):        {self.stats['insertions']:,}")
        report.append(f"Match percentage:               {match_pct:.2f}%")
        report.append("")
        
        # Pattern information
        if self.patterns_found:
            report.append("🔄 INFINITE LOOP PATTERNS DETECTED")
            report.append("-" * 40)
            for i, pattern in enumerate(self.patterns_found[:10], 1):
                report.append(f"Pattern {i}: {pattern['length']} instructions × {pattern['repetitions']} repetitions")
                report.append(f"  Location: {pattern['location']}, Removed: {pattern['removed']} entries")
            if len(self.patterns_found) > 10:
                report.append(f"  ... and {len(self.patterns_found) - 10} more patterns")
            report.append("")
        
        # Detailed differences (unified diff style)
        diff_only = [d for d in differences if d.diff_type != DiffType.EQUAL]
        if diff_only:
            report.append("🔍 DETAILED DIFFERENCES (Unified Diff Style)")
            report.append("-" * 50)
            report.append("Legend: - = Core only, + = Spike only")
            report.append("")
            
            # Group consecutive differences into hunks
            hunks = self._group_into_hunks(differences)
            
            for i, hunk in enumerate(hunks, 1):  # Limit to first 30 hunks
                report.append(f"@@ HUNK #{i} @@")
                
                for diff in hunk:
                    if diff.diff_type == DiffType.DELETE:
                        report.append(f"- {diff.entry.original}")
                    elif diff.diff_type == DiffType.INSERT:
                        report.append(f"+ {diff.entry.original}")
                    elif diff.diff_type == DiffType.EQUAL:
                        report.append(f"  {diff.entry.original}")
                
                report.append("")
            
            if len(hunks) > 30:
                report.append(f"... and {len(hunks) - 30} more difference hunks")
        else:
            report.append("✅ NO DIFFERENCES FOUND - PERFECT MATCH!")
            report.append("All entries match exactly including register values!")
        
        return "\n".join(report)
    
    def _group_into_hunks(self, differences: List[DiffResult]) -> List[List[DiffResult]]:
        """Group differences into hunks with context (like unified diff)"""
        hunks = []
        current_hunk = []
        context_lines = 3
        
        i = 0
        while i < len(differences):
            diff = differences[i]
            
            if diff.diff_type != DiffType.EQUAL:
                # Start a new hunk
                current_hunk = []
                
                # Add leading context
                start_context = max(0, i - context_lines)
                for j in range(start_context, i):
                    if differences[j].diff_type == DiffType.EQUAL:
                        current_hunk.append(differences[j])
                
                # Add the difference and any following differences
                while i < len(differences) and (differences[i].diff_type != DiffType.EQUAL or 
                                                 (i + 1 < len(differences) and differences[i + 1].diff_type != DiffType.EQUAL)):
                    current_hunk.append(differences[i])
                    i += 1
                
                # Add trailing context
                end_context = min(len(differences), i + context_lines)
                for j in range(i, end_context):
                    if differences[j].diff_type == DiffType.EQUAL:
                        current_hunk.append(differences[j])
                
                if current_hunk:
                    hunks.append(current_hunk)
            else:
                i += 1
        
        return hunks

def main():
    """Main function"""
    if len(sys.argv) != 3:
        print("Usage: python professional_log_comparator.py <core_log> <spike_log>")
        print("\nPROFESSIONAL VERSION v3.0:")
        print("• Classical LCS Dynamic Programming Algorithm")
        print("• Proper traceback for difference generation")
        print("• Research-based approach from diff literature")
        print("• Accurate register value comparison")
        sys.exit(1)
    
    core_file = sys.argv[1]
    spike_file = sys.argv[2]
    
    comparator = ProfessionalLogComparator()
    report = comparator.compare_logs(core_file, spike_file)
    
    # Save report
    output_file = "professional_comparison_v3.txt"
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(report)
    
    print(f"\n💾 Report saved to: {output_file}")
    print("\n" + "=" * 70)
    print("🎯 PROFESSIONAL APPROACH v3.0:")
    print("   • Based on classical LCS algorithm research")
    print("   • Dynamic programming with proper traceback")
    print("   • Detects ALL differences including register values")
    print("   • Separate loop detection using simple pattern keys")
    print("   • Final comparison using complete entry matching")
    print("=" * 70)

if __name__ == "__main__":
    main()
