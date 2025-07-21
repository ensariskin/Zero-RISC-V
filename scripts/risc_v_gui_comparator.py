#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Professional RISC-V Log Comparator GUI v3.0
Beautiful graphical interface for the research-based LCS comparator

Features:
🎨 Modern GUI with syntax highlighting
📊 Real-time statistics dashboard  
🔍 Interactive diff viewer
📁 File drag-and-drop support
⚡ Progress tracking for LCS computation
🌙 Dark/Light theme support
💾 Export results to multiple formats

Created by: Ensar
Based on: Classical LCS Dynamic Programming Algorithm
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox
from tkinter.font import Font
import threading
import queue
import os
import sys
import json
import re
from datetime import datetime
from typing import List, Tuple, Optional

# Import our professional comparator
from professional_log_comparator import ProfessionalLogComparator, LogEntry, DiffResult, DiffType

class ModernTheme:
    """Modern theme configuration"""
    
    DARK = {
        'bg': '#1e1e1e',            # Ana arkaplan - koyu gri
        'fg': '#ffffff',            # Ana yazı - beyaz
        'select_bg': '#0078d4',     # Seçim arka planı - modern mavi
        'select_fg': '#ffffff',     # Seçim yazısı - beyaz
        'button_bg': '#404040',     # Normal buton arka planı - orta gri
        'button_fg': '#ffffff',     # Buton yazısı - beyaz
        'entry_bg': '#2d2d2d',      # Giriş/etiket arka planı - koyu gri
        'entry_fg': '#ffffff',      # Giriş yazısı - beyaz
        'text_bg': '#1e1e1e',       # Metin widget arka planı
        'text_fg': '#ffffff',       # Metin widget yazısı
        'accent': '#0078d4',        # Vurgu rengi - modern mavi
        'error': '#ff6b6b',         # Hata rengi - kırmızı
        'success': '#16c79a',       # Başarı rengi - yeşil
        'warning': '#ffa726',       # Uyarı rengi - turuncu
        'panel_bg': '#252526',      # Panel arka planı - daha açık gri
        'border': '#3c3c3c'         # Kenar çizgileri
    }
    
    LIGHT = {
        'bg': '#ffffff',            # Ana arkaplan - beyaz
        'fg': '#333333',            # Ana yazı - koyu gri
        'select_bg': '#e3f2fd',     # Seçim arka planı - açık mavi
        'select_fg': '#1976d2',     # Seçim yazısı - mavi
        'button_bg': '#f0f0f0',     # Normal buton arka planı - açık gri
        'button_fg': '#333333',     # Buton yazısı - koyu gri
        'entry_bg': '#ffffff',      # Giriş/etiket arka planı - beyaz
        'entry_fg': '#333333',      # Giriş yazısı - koyu gri
        'text_bg': '#ffffff',       # Metin widget arka planı
        'text_fg': '#333333',       # Metin widget yazısı
        'accent': '#1976d2',        # Vurgu rengi - material mavi
        'error': '#d32f2f',         # Hata rengi - kırmızı
        'success': '#4caf50',       # Başarı rengi - yeşil
        'warning': '#ff9800',       # Uyarı rengi - turuncu
        'panel_bg': '#f8f9fa',      # Panel arka planı - açık gri
        'border': '#e0e0e0'         # Kenar çizgileri
    }

class ProgressDialog:
    """Professional progress dialog with cancellation support"""
    
    def __init__(self, parent, title="Processing..."):
        self.parent = parent
        self.cancelled = False
        
        # Create toplevel window
        self.dialog = tk.Toplevel(parent)
        self.dialog.title(title)
        self.dialog.geometry("400x200")
        self.dialog.resizable(False, False)
        self.dialog.transient(parent)
        self.dialog.grab_set()
        
        # Center the dialog
        self.dialog.geometry("+%d+%d" % (
            parent.winfo_rootx() + 50,
            parent.winfo_rooty() + 50
        ))
        
        # Create widgets
        self.setup_widgets()
        
    def setup_widgets(self):
        """Setup progress dialog widgets"""
        main_frame = ttk.Frame(self.dialog, padding="20")
        main_frame.pack(fill=tk.BOTH, expand=True)
        
        # Title
        self.title_label = ttk.Label(main_frame, text="Processing Log Files...", 
                                   font=('Segoe UI', 12, 'bold'))
        self.title_label.pack(pady=(0, 10))
        
        # Progress bar
        self.progress = ttk.Progressbar(main_frame, mode='indeterminate')
        self.progress.pack(fill=tk.X, pady=(0, 10))
        self.progress.start()
        
        # Status label
        self.status_label = ttk.Label(main_frame, text="Loading files...")
        self.status_label.pack(pady=(0, 20))
        
        # Cancel button
        self.cancel_btn = ttk.Button(main_frame, text="Cancel", 
                                   command=self.cancel)
        self.cancel_btn.pack()
        
        # Handle window close
        self.dialog.protocol("WM_DELETE_WINDOW", self.cancel)
    
    def update_status(self, status_text):
        """Update status text"""
        try:
            if hasattr(self, 'status_label') and self.status_label.winfo_exists():
                self.status_label.config(text=status_text)
                self.dialog.update()
        except tk.TclError:
            # Dialog was destroyed, ignore
            pass
    
    def cancel(self):
        """Cancel the operation"""
        self.cancelled = True
        self.destroy()
    
    def destroy(self):
        """Destroy the dialog"""
        try:
            if hasattr(self, 'progress') and self.progress.winfo_exists():
                self.progress.stop()
            if hasattr(self, 'dialog') and self.dialog.winfo_exists():
                self.dialog.destroy()
        except tk.TclError:
            # Already destroyed, ignore
            pass

class StatisticsPanel:
    """Professional statistics display panel"""
    
    def __init__(self, parent):
        self.parent = parent
        self.frame = ttk.Frame(parent, padding="15")  # Modern spacing
        self.setup_widgets()
        
    def setup_widgets(self):
        """Setup statistics widgets with modern flat design"""
        # Modern title with better spacing
        title_frame = ttk.Frame(self.frame)
        title_frame.pack(fill=tk.X, pady=(0, 20))
        
        title_label = ttk.Label(title_frame, text="📊 Comparison Statistics", 
                               font=('Segoe UI', 12, 'bold'))
        title_label.pack(side=tk.LEFT)
        
        # Modern flat card-style layout without borders
        stats_container = ttk.Frame(self.frame)
        stats_container.pack(fill=tk.BOTH, expand=True)
        
        # Left column - File Stats with modern flat styling
        left_card = ttk.Frame(stats_container, padding="15", relief='flat', borderwidth=0)
        left_card.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, padx=(0, 10))
        
        # Left card header
        left_header = ttk.Label(left_card, text="📁 File Information", 
                               font=('Segoe UI', 10, 'bold'))
        left_header.pack(anchor=tk.W, pady=(0, 10))
        
        # Right column - Match Stats with modern flat styling
        right_card = ttk.Frame(stats_container, padding="15", relief='flat', borderwidth=0)
        right_card.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True, padx=(10, 0))
        
        # Right card header
        right_header = ttk.Label(right_card, text="🎯 Match Results", 
                                font=('Segoe UI', 10, 'bold'))
        right_header.pack(anchor=tk.W, pady=(0, 10))
        
        # Left column stats with improved formatting
        self.core_entries_var = tk.StringVar(value="Core Entries: -")
        self.spike_entries_var = tk.StringVar(value="Spike Entries: -")
        self.loops_removed_var = tk.StringVar(value="Loops Removed: -")
        self.lcs_length_var = tk.StringVar(value="LCS Length: -")
        
        for var in [self.core_entries_var, self.spike_entries_var, self.loops_removed_var, self.lcs_length_var]:
            label = ttk.Label(left_card, textvariable=var, font=('Segoe UI', 9))
            label.pack(anchor=tk.W, pady=4)
        
        # Right column stats with improved formatting
        self.matches_var = tk.StringVar(value="Perfect Matches: -")
        self.deletions_var = tk.StringVar(value="Deletions: -")
        self.insertions_var = tk.StringVar(value="Insertions: -")
        self.match_pct_var = tk.StringVar(value="Match %: -")
        
        for var in [self.matches_var, self.deletions_var, self.insertions_var, self.match_pct_var]:
            label = ttk.Label(right_card, textvariable=var, font=('Segoe UI', 9))
            label.pack(anchor=tk.W, pady=4)
    
    def update_stats(self, stats):
        """Update statistics display"""
        self.core_entries_var.set(f"Core Entries: {stats.get('core_entries', 0):,}")
        self.spike_entries_var.set(f"Spike Entries: {stats.get('spike_entries', 0):,}")
        self.loops_removed_var.set(f"Loops Removed: {stats.get('loops_removed', 0):,}")
        self.lcs_length_var.set(f"LCS Length: {stats.get('lcs_length', 0):,}")
        
        total = stats.get('perfect_matches', 0) + stats.get('deletions', 0) + stats.get('insertions', 0)
        match_pct = (stats.get('perfect_matches', 0) / total * 100) if total > 0 else 0
        
        self.matches_var.set(f"Perfect Matches: {stats.get('perfect_matches', 0):,}")
        self.deletions_var.set(f"Deletions: {stats.get('deletions', 0):,}")
        self.insertions_var.set(f"Insertions: {stats.get('insertions', 0):,}")
        self.match_pct_var.set(f"Match %: {match_pct:.2f}%")

class DiffViewer:
    """Professional side-by-side diff viewer with synchronized scrolling"""
    
    def __init__(self, parent):
        self.parent = parent
        self.frame = ttk.Frame(parent, padding="15", relief='flat')  # Modern flat frame
        self.font_size_var = tk.IntVar(value=10)  # Initialize font size variable first
        self.setup_widgets()
        self.configure_tags()
        self.current_diff_lines = []
        
    def setup_widgets(self):
        """Setup side-by-side diff viewer widgets with modern design"""
        # Modern header
        header_frame = ttk.Frame(self.frame)
        header_frame.pack(fill=tk.X, pady=(0, 15))
        
        header_label = ttk.Label(header_frame, text="🔍 Side-by-Side Difference Viewer", 
                               font=('Segoe UI', 12, 'bold'))
        header_label.pack(side=tk.LEFT)
        
        # Create modern toolbar with flat styling
        toolbar = ttk.Frame(self.frame, padding="10", relief='flat')
        toolbar.pack(fill=tk.X, pady=(0, 15))
        
        # Search functionality with modern styling
        search_frame = ttk.Frame(toolbar)
        search_frame.pack(side=tk.LEFT)
        
        ttk.Label(search_frame, text="🔍 Search:", font=('Segoe UI', 9)).pack(side=tk.LEFT, padx=(0, 5))
        self.search_var = tk.StringVar()
        self.search_entry = ttk.Entry(search_frame, textvariable=self.search_var, width=20, 
                                     style='Modern.TEntry')
        self.search_entry.pack(side=tk.LEFT, padx=(0, 5))
        self.search_entry.bind('<Return>', self.search_text)
        
        ttk.Button(search_frame, text="Find", command=self.search_text, 
                  style='Accent.TButton').pack(side=tk.LEFT, padx=(0, 15))
        
        # Font size controls with modern styling
        font_frame = ttk.Frame(toolbar)
        font_frame.pack(side=tk.LEFT)
        
        ttk.Label(font_frame, text="📝 Font:", font=('Segoe UI', 9)).pack(side=tk.LEFT, padx=(0, 5))
        self.font_size_var = tk.IntVar(value=10)
        font_spinbox = ttk.Spinbox(font_frame, from_=8, to=20, width=5, 
                                  textvariable=self.font_size_var, 
                                  command=self.update_font_size,
                                  style='Modern.TSpinbox')
        font_spinbox.pack(side=tk.LEFT, padx=(0, 5))
        font_spinbox.bind('<Return>', self.update_font_size)
        
        ttk.Button(font_frame, text="🔍+", command=self.increase_font, 
                  style='Modern.TButton').pack(side=tk.LEFT, padx=(5, 2))
        ttk.Button(font_frame, text="🔍-", command=self.decrease_font, 
                  style='Modern.TButton').pack(side=tk.LEFT, padx=(2, 15))
        
        # Navigation buttons with modern styling
        nav_frame = ttk.Frame(toolbar)
        nav_frame.pack(side=tk.LEFT)
        
        ttk.Button(nav_frame, text="⬆️ Prev", command=self.prev_diff, 
                  style='Modern.TButton').pack(side=tk.LEFT, padx=(0, 5))
        ttk.Button(nav_frame, text="⬇️ Next", command=self.next_diff, 
                  style='Modern.TButton').pack(side=tk.LEFT, padx=(0, 15))
        
        # Go to line feature with modern styling
        goto_frame = ttk.Frame(toolbar)
        goto_frame.pack(side=tk.LEFT, padx=(20, 0))
        
        ttk.Label(goto_frame, text="Go to Line:").pack(side=tk.LEFT, padx=(0, 5))
        self.goto_line_var = tk.StringVar()
        goto_entry = ttk.Entry(goto_frame, textvariable=self.goto_line_var, width=8)
        goto_entry.pack(side=tk.LEFT, padx=(0, 5))
        goto_entry.bind('<Return>', self.goto_line)
        ttk.Button(goto_frame, text="Go", command=self.goto_line).pack(side=tk.LEFT)
        
        # Line count display
        self.line_count_var = tk.StringVar(value="Lines: 0")
        ttk.Label(goto_frame, textvariable=self.line_count_var).pack(side=tk.LEFT, padx=(10, 0))
        
        # Diff counter
        self.diff_counter_var = tk.StringVar(value="Differences: 0")
        ttk.Label(nav_frame, textvariable=self.diff_counter_var).pack(side=tk.LEFT, padx=(10, 0))
        
        # Export button
        ttk.Button(toolbar, text="💾 Export", command=self.export_diff).pack(side=tk.RIGHT)
        
        # Create main comparison frame
        comparison_frame = ttk.Frame(self.frame)
        comparison_frame.pack(fill=tk.BOTH, expand=True)
        
        # Left panel - Core Log with modern flat design
        left_panel = ttk.Frame(comparison_frame, padding="10", relief='flat', borderwidth=0)
        left_panel.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, padx=(0, 8))
        
        # Core Log header
        core_header = ttk.Label(left_panel, text="🔧 Core Log", 
                               font=('Segoe UI', 11, 'bold'))
        core_header.pack(anchor=tk.W, pady=(0, 8))
        
        # Right panel - Spike Log with modern flat design
        right_panel = ttk.Frame(comparison_frame, padding="10", relief='flat', borderwidth=0)
        right_panel.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True, padx=(8, 0))
        
        # Spike Log header
        spike_header = ttk.Label(right_panel, text="⚡ Spike Log", 
                                font=('Segoe UI', 11, 'bold'))
        spike_header.pack(anchor=tk.W, pady=(0, 8))
        
        # Create text widgets with line numbers
        self.setup_text_panel(left_panel, 'core')
        self.setup_text_panel(right_panel, 'spike')
        
        # Bind synchronized scrolling
        self.core_text.bind('<MouseWheel>', self.on_mousewheel)
        self.spike_text.bind('<MouseWheel>', self.on_mousewheel)
        self.core_text.bind('<Button-4>', self.on_mousewheel)
        self.core_text.bind('<Button-5>', self.on_mousewheel)
        self.spike_text.bind('<Button-4>', self.on_mousewheel)
        self.spike_text.bind('<Button-5>', self.on_mousewheel)
        
    def setup_text_panel(self, parent, side):
        """Setup text panel with line numbers and modern theming"""
        panel_frame = ttk.Frame(parent, relief='flat')
        panel_frame.pack(fill=tk.BOTH, expand=True)
        
        # Line numbers frame
        line_frame = ttk.Frame(panel_frame, relief='flat')
        line_frame.pack(side=tk.LEFT, fill=tk.Y)
        
        # Get current theme colors
        current_theme = getattr(self.parent, 'theme', ModernTheme.DARK)
        
        # Line numbers text with theme colors
        line_text = tk.Text(line_frame, width=6, padx=3, takefocus=0,
                           font=('Consolas', 9), 
                           bg=current_theme['panel_bg'], 
                           fg=current_theme['border'],
                           state=tk.DISABLED, wrap=tk.NONE, cursor='arrow',
                           relief='flat', borderwidth=0)
        line_text.pack(side=tk.LEFT, fill=tk.Y)
        
        # Main text frame
        text_frame = ttk.Frame(panel_frame, relief='flat')
        text_frame.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True)
        
        # Main text widget with theme colors
        text_widget = tk.Text(text_frame, wrap=tk.NONE, font=('Consolas', 10),
                             state=tk.DISABLED, 
                             bg=current_theme['text_bg'], 
                             fg=current_theme['text_fg'],
                             selectbackground=current_theme['select_bg'], 
                             cursor='arrow',
                             relief='flat', borderwidth=0,
                             maxundo=0, undo=False)  # Disable undo to improve performance with large files
        
        # Scrollbars
        v_scrollbar = ttk.Scrollbar(text_frame, orient=tk.VERTICAL, command=text_widget.yview)
        h_scrollbar = ttk.Scrollbar(text_frame, orient=tk.HORIZONTAL, command=text_widget.xview)
        
        text_widget.config(yscrollcommand=v_scrollbar.set, xscrollcommand=h_scrollbar.set)
        
        text_widget.config(yscrollcommand=v_scrollbar.set, xscrollcommand=h_scrollbar.set)
        
        # Pack scrollbars and text
        v_scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        h_scrollbar.pack(side=tk.BOTTOM, fill=tk.X)
        text_widget.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        
        # Store references
        if side == 'core':
            self.core_text = text_widget
            self.core_lines = line_text
            self.core_v_scroll = v_scrollbar
            self.core_h_scroll = h_scrollbar
        else:
            self.spike_text = text_widget
            self.spike_lines = line_text
            self.spike_v_scroll = v_scrollbar
            self.spike_h_scroll = h_scrollbar
        
    def configure_tags(self):
        """Configure syntax highlighting tags for both panels"""
        font_size = self.font_size_var.get()
        for text_widget in [self.core_text, self.spike_text]:
            # Difference highlighting
            text_widget.tag_configure('different', background='#4a1a1a', foreground='#ff6b6b')
            text_widget.tag_configure('missing', background='#2a2a2a', foreground='#888888')
            text_widget.tag_configure('normal', background='#2d2d2d', foreground='#ffffff')
            text_widget.tag_configure('highlight', background='#404040', foreground='#ffd43b')
            
            # RISC-V instruction highlighting
            text_widget.tag_configure('address', foreground='#74c0fc', font=('Consolas', font_size, 'bold'))
            text_widget.tag_configure('instruction', foreground='#ffa8a8')
            text_widget.tag_configure('register', foreground='#a9e34b')
            text_widget.tag_configure('memory', foreground='#da77f2')
            text_widget.tag_configure('csr', foreground='#ff9800')
        
    def display_diff(self, diff_text):
        """Display side-by-side comparison from diff text"""
        print(f"🔍 DEBUG: Starting display_diff with {len(diff_text)} characters of diff text")
        
        # Parse the comparison report to extract the unified diff section
        lines = diff_text.split('\n')
        print(f"🔍 DEBUG: Split diff text into {len(lines)} lines")
        
        # Find the differences section
        diff_lines = []
        in_diff_section = False
        
        for line in lines:
            if line.startswith("🔍 DETAILED DIFFERENCES"):
                in_diff_section = True
                print(f"🔍 DEBUG: Found detailed differences section")
                continue
            elif not in_diff_section:
                continue
            elif line.startswith(('@@ HUNK', '- ', '+ ', '  ')):
                diff_lines.append(line)
        
        print(f"🔍 DEBUG: Extracted {len(diff_lines)} diff lines from report")
        
        # Process the unified diff sequentially to maintain correct order
        core_entries = []
        spike_entries = []
        
        self.process_unified_diff_sequentially(diff_lines, core_entries, spike_entries)
        
        print(f"🔍 DEBUG: After processing: {len(core_entries)} core entries, {len(spike_entries)} spike entries")
        
        # Display the entries
        self.populate_text_widgets_sequential(core_entries, spike_entries)
    
    def process_unified_diff_sequentially(self, diff_lines, core_entries, spike_entries):
        """Process unified diff line by line, maintaining order and smart pairing"""
        i = 0
        while i < len(diff_lines):
            line = diff_lines[i]
            
            if line.startswith('@@ HUNK'):
                # Skip hunk headers
                i += 1
                continue
                
            elif line.startswith('  '):  # Context line
                content = line[2:]
                core_entries.append(('normal', content))
                spike_entries.append(('normal', content))
                i += 1
                
            elif line.startswith('- '):  # Deletion
                deletions = []
                j = i
                
                # Collect all consecutive deletions
                while j < len(diff_lines) and diff_lines[j].startswith('- '):
                    deletions.append(diff_lines[j][2:])
                    j += 1
                
                # Collect all consecutive insertions that follow
                insertions = []
                while j < len(diff_lines) and diff_lines[j].startswith('+ '):
                    insertions.append(diff_lines[j][2:])
                    j += 1
                
                # Now intelligently pair deletions and insertions
                self.pair_deletions_insertions(deletions, insertions, core_entries, spike_entries)
                
                i = j  # Skip to after the processed block
                
            elif line.startswith('+ '):  # Pure insertion (no preceding deletions)
                insertions = []
                j = i
                
                # Collect all consecutive insertions
                while j < len(diff_lines) and diff_lines[j].startswith('+ '):
                    insertions.append(diff_lines[j][2:])
                    j += 1
                
                # Add as pure insertions
                for insertion in insertions:
                    core_entries.append(('missing', '--- (missing) ---'))
                    spike_entries.append(('different', insertion))
                
                i = j
            else:
                i += 1
    
    def pair_deletions_insertions(self, deletions, insertions, core_entries, spike_entries):
        """Process insertions first in order, then pair remaining deletions"""
        # Create PC mappings for matching
        deletion_pcs = {}
        for deletion in deletions:
            pc = self.extract_pc_address(deletion)
            if pc:
                deletion_pcs[pc] = deletion
        
        # Track which deletions have been used
        used_deletions = set()
        
        # Process ALL insertions in their original order first
        for insertion in insertions:
            ins_pc = self.extract_pc_address(insertion)
            
            # Check if this insertion has a matching deletion
            if ins_pc and ins_pc in deletion_pcs:
                # This insertion has a matching deletion - pair them
                matching_deletion = deletion_pcs[ins_pc]
                core_entries.append(('different', matching_deletion))
                spike_entries.append(('different', insertion))
                used_deletions.add(matching_deletion)
            else:
                # This is a pure insertion (no matching deletion)
                core_entries.append(('missing', '--- (missing) ---'))
                spike_entries.append(('different', insertion))
        
        # Add any remaining unmatched deletions as pure deletions
        for deletion in deletions:
            if deletion not in used_deletions:
                core_entries.append(('different', deletion))
                spike_entries.append(('missing', '--- (missing) ---'))
    
    def extract_pc_address(self, line_content):
        """Extract PC address from a log line for matching purposes"""
        # Look for the first hex address in the line (PC address)
        match = re.search(r'0x[0-9a-fA-F]+', line_content)
        return match.group(0) if match else None
    
    def populate_text_widgets_sequential(self, core_entries, spike_entries):
        """Populate both text widgets with entries in the correct order"""
        # Debug logging
        print(f"🔍 DEBUG: Populating text widgets with {len(core_entries)} core entries and {len(spike_entries)} spike entries")
        
        # Enable editing
        self.core_text.config(state=tk.NORMAL)
        self.spike_text.config(state=tk.NORMAL)
        self.core_lines.config(state=tk.NORMAL)
        self.spike_lines.config(state=tk.NORMAL)
        
        # Clear existing content
        self.core_text.delete(1.0, tk.END)
        self.spike_text.delete(1.0, tk.END)
        self.core_lines.delete(1.0, tk.END)
        self.spike_lines.delete(1.0, tk.END)
        
        # Store diff line numbers for navigation
        self.current_diff_lines = []
        
        # Ensure both lists have the same length
        max_len = max(len(core_entries), len(spike_entries))
        print(f"🔍 DEBUG: Maximum length calculated as {max_len}")
        
        while len(core_entries) < max_len:
            core_entries.append(('missing', '--- (missing) ---'))
        while len(spike_entries) < max_len:
            spike_entries.append(('missing', '--- (missing) ---'))
        
        # Optimize for large datasets - batch insertions and use efficient text operations
        core_content = []
        spike_content = []
        line_numbers = []
        
        # Prepare all content first
        for i, ((core_tag, core_content_line), (spike_tag, spike_content_line)) in enumerate(zip(core_entries, spike_entries), 1):
            core_content.append((core_tag, core_content_line))
            spike_content.append((spike_tag, spike_content_line))
            line_numbers.append(f"{i:5d}")
            
            # Track diff lines
            if core_tag == 'different' or spike_tag == 'different':
                self.current_diff_lines.append(i)
        
        print(f"🔍 DEBUG: Prepared {len(core_content)} lines for core and {len(spike_content)} lines for spike")
        print(f"🔍 DEBUG: Found {len(self.current_diff_lines)} difference lines")
        
        # Batch insert content to improve performance
        self.insert_content_batch(self.core_text, self.core_lines, core_content, line_numbers)
        self.insert_content_batch(self.spike_text, self.spike_lines, spike_content, line_numbers)
        
        # Update diff counter
        diff_count = len(self.current_diff_lines)
        self.diff_counter_var.set(f"Differences: {diff_count}")
        
        # Update line count display
        self.line_count_var.set(f"Lines: {max_len:,}")
        
        # Disable editing
        self.core_text.config(state=tk.DISABLED)
        self.spike_text.config(state=tk.DISABLED)
        self.core_lines.config(state=tk.DISABLED)
        self.spike_lines.config(state=tk.DISABLED)
        
        # Synchronize scrollbars
        self.sync_scrollbars()
        
        print(f"🔍 DEBUG: Text widgets populated successfully")
    
    def insert_content_batch(self, text_widget, line_widget, content_list, line_numbers):
        """Insert content in batches for better performance with large datasets"""
        batch_size = 1000  # Process in batches to avoid UI freezing
        total_lines = len(content_list)
        print(f"🔍 DEBUG: Starting batch insertion of {total_lines} lines")
        
        # Show progress for large files
        if total_lines > 1000:
            print(f"📊 Processing large file with {total_lines:,} lines - this may take a moment...")
        
        for batch_start in range(0, len(content_list), batch_size):
            batch_end = min(batch_start + batch_size, len(content_list))
            print(f"🔍 DEBUG: Processing batch {batch_start} to {batch_end}")
            
            # Show progress
            if hasattr(self, 'parent') and hasattr(self.parent, 'root'):
                self.show_load_progress(batch_end, total_lines)
            
            # Insert text content in batch
            text_batch = []
            line_batch = []
            
            for i in range(batch_start, batch_end):
                tag, content_line = content_list[i]
                text_batch.append(content_line + '\n')
                line_batch.append(line_numbers[i] + '\n')
            
            # Insert all text at once for this batch
            batch_start_pos = text_widget.index(tk.INSERT)
            text_widget.insert(tk.END, ''.join(text_batch))
            line_widget.insert(tk.END, ''.join(line_batch))
            
            # Apply tags to the batch
            current_line = batch_start + 1
            for i in range(batch_start, batch_end):
                tag, content_line = content_list[i]
                
                line_start = f"{current_line}.0"
                line_end = f"{current_line}.end"
                
                # Apply main tag
                text_widget.tag_add(tag, line_start, line_end)
                
                # Apply RISC-V highlighting if not missing
                if tag != 'missing':
                    self.apply_riscv_highlighting(text_widget, content_line, line_start)
                
                current_line += 1
            
            # Update UI periodically for very large datasets
            if batch_end % 2000 == 0:  # Update every 2000 lines
                text_widget.update_idletasks()
                print(f"🔍 DEBUG: UI updated at line {batch_end}")
        
        # Final check - verify all content was inserted
        final_line_count = int(text_widget.index('end-1c').split('.')[0]) - 1
        print(f"🔍 DEBUG: Batch insertion complete. Expected: {total_lines}, Actual: {final_line_count}")
        
        if final_line_count < total_lines:
            print(f"⚠️  WARNING: Some lines may not have been inserted properly!")
            print(f"⚠️  This could be due to Text widget limitations or memory constraints.")
        else:
            print(f"✅ All {total_lines:,} lines inserted successfully!")
        
        # Force final UI update
        text_widget.update_idletasks()
        
    def apply_riscv_highlighting(self, text_widget, content, line_start):
        """Apply RISC-V instruction syntax highlighting"""
        # Highlight PC addresses (0x...)
        for match in re.finditer(r'0x[0-9a-fA-F]+', content):
            start_idx = f"{line_start}+{match.start()}c"
            end_idx = f"{line_start}+{match.end()}c"
            text_widget.tag_add('address', start_idx, end_idx)
        
        # Highlight register names (x1, x2, etc.)
        for match in re.finditer(r'\bx\d+\b', content):
            start_idx = f"{line_start}+{match.start()}c"
            end_idx = f"{line_start}+{match.end()}c"
            text_widget.tag_add('register', start_idx, end_idx)
        
        # Highlight CSR names (c###_name)
        for match in re.finditer(r'\bc\d+_\w+\b', content):
            start_idx = f"{line_start}+{match.start()}c"
            end_idx = f"{line_start}+{match.end()}c"
            text_widget.tag_add('csr', start_idx, end_idx)
        
        # Highlight memory operations
        for match in re.finditer(r'\bmem\b', content):
            start_idx = f"{line_start}+{match.start()}c"
            end_idx = f"{line_start}+{match.end()}c"
            text_widget.tag_add('memory', start_idx, end_idx)
    
    def on_mousewheel(self, event):
        """Handle synchronized scrolling"""
        # Determine scroll direction and amount
        if event.delta:
            delta = -1 * (event.delta / 120)
        else:
            delta = -1 if event.num == 4 else 1
        
        # Scroll both text widgets
        self.core_text.yview_scroll(int(delta), "units")
        self.spike_text.yview_scroll(int(delta), "units")
        self.core_lines.yview_scroll(int(delta), "units")
        self.spike_lines.yview_scroll(int(delta), "units")
        
        return "break"
    
    def sync_scrollbars(self):
        """Synchronize scrollbar commands"""
        def sync_yview(*args):
            self.core_text.yview(*args)
            self.spike_text.yview(*args)
            self.core_lines.yview(*args)
            self.spike_lines.yview(*args)
        
        def sync_xview_core(*args):
            self.core_text.xview(*args)
        
        def sync_xview_spike(*args):
            self.spike_text.xview(*args)
        
        self.core_v_scroll.config(command=sync_yview)
        self.spike_v_scroll.config(command=sync_yview)
        self.core_h_scroll.config(command=sync_xview_core)
        self.spike_h_scroll.config(command=sync_xview_spike)
    
    def search_text(self, event=None):
        """Search for text in both panels"""
        search_term = self.search_var.get()
        if not search_term:
            return
        
        # Clear previous highlights
        for text_widget in [self.core_text, self.spike_text]:
            text_widget.tag_remove('search_highlight', 1.0, tk.END)
        
        # Search in both panels
        found_positions = []
        
        for text_widget in [self.core_text, self.spike_text]:
            start_pos = 1.0
            while True:
                pos = text_widget.search(search_term, start_pos, stopindex=tk.END)
                if not pos:
                    break
                
                end_pos = f"{pos}+{len(search_term)}c"
                text_widget.tag_add('search_highlight', pos, end_pos)
                found_positions.append((text_widget, pos))
                start_pos = end_pos
        
        # Configure search highlight
        for text_widget in [self.core_text, self.spike_text]:
            text_widget.tag_configure('search_highlight', background='#ffd43b', foreground='#000000')
        
        # Jump to first occurrence
        if found_positions:
            first_widget, first_pos = found_positions[0]
            first_widget.see(first_pos)
    
    def next_diff(self):
        """Navigate to next difference"""
        if not self.current_diff_lines:
            return
        
        current_line = int(self.core_text.index(tk.INSERT).split('.')[0])
        
        # Find next diff line
        next_line = None
        for line_num in self.current_diff_lines:
            if line_num > current_line:
                next_line = line_num
                break
        
        if next_line is None and self.current_diff_lines:
            next_line = self.current_diff_lines[0]  # Wrap to first
        
        if next_line:
            self.jump_to_line(next_line)
    
    def prev_diff(self):
        """Navigate to previous difference"""
        if not self.current_diff_lines:
            return
        
        current_line = int(self.core_text.index(tk.INSERT).split('.')[0])
        
        # Find previous diff line
        prev_line = None
        for line_num in reversed(self.current_diff_lines):
            if line_num < current_line:
                prev_line = line_num
                break
        
        if prev_line is None and self.current_diff_lines:
            prev_line = self.current_diff_lines[-1]  # Wrap to last
        
        if prev_line:
            self.jump_to_line(prev_line)
    
    def jump_to_line(self, line_num):
        """Jump to specific line in both panels"""
        line_pos = f"{line_num}.0"
        
        # Jump in both text widgets
        self.core_text.see(line_pos)
        self.spike_text.see(line_pos)
        self.core_lines.see(line_pos)
        self.spike_lines.see(line_pos)
        
        # Set cursor position
        self.core_text.mark_set(tk.INSERT, line_pos)
        self.spike_text.mark_set(tk.INSERT, line_pos)
    
    def goto_line(self, event=None):
        """Go to specific line number"""
        try:
            line_num = int(self.goto_line_var.get())
            total_lines = int(self.core_text.index('end-1c').split('.')[0]) - 1
            
            if 1 <= line_num <= total_lines:
                self.jump_to_line(line_num)
                self.goto_line_var.set("")  # Clear the entry
            else:
                messagebox.showwarning("Invalid Line Number", 
                                     f"Please enter a line number between 1 and {total_lines}")
        except ValueError:
            messagebox.showwarning("Invalid Input", "Please enter a valid line number")
    
    def update_font_size(self, event=None):
        """Update font size for both text widgets"""
        try:
            new_size = self.font_size_var.get()
            new_font = ('Consolas', new_size)
            
            # Update main text widgets
            self.core_text.configure(font=new_font)
            self.spike_text.configure(font=new_font)
            
            # Update line number widgets
            line_font = ('Consolas', max(8, new_size - 1))
            self.core_lines.configure(font=line_font)
            self.spike_lines.configure(font=line_font)
            
            # Reconfigure tags with new font size
            self.configure_tags()
            
        except (tk.TclError, ValueError):
            # Ignore invalid font size values
            pass
    
    def increase_font(self):
        """Increase font size"""
        current_size = self.font_size_var.get()
        if current_size < 20:
            self.font_size_var.set(current_size + 1)
            self.update_font_size()
    
    def decrease_font(self):
        """Decrease font size"""
        current_size = self.font_size_var.get()
        if current_size > 8:
            self.font_size_var.set(current_size - 1)
            self.update_font_size()
    
    def update_theme_colors(self, theme_name):
        """Update syntax highlighting colors based on theme"""
        if theme_name == 'dark':
            # Dark theme colors
            colors = {
                'different': {'background': '#4a1a1a', 'foreground': '#ff6b6b'},
                'missing': {'background': '#2a2a2a', 'foreground': '#888888'},
                'normal': {'background': '#2d2d2d', 'foreground': '#ffffff'},
                'highlight': {'background': '#404040', 'foreground': '#ffd43b'},
                'address': {'foreground': '#74c0fc'},
                'instruction': {'foreground': '#ffa8a8'},
                'register': {'foreground': '#a9e34b'},
                'memory': {'foreground': '#da77f2'},
                'csr': {'foreground': '#ff9800'},
                'search_highlight': {'background': '#ffd43b', 'foreground': '#000000'}
            }
        else:
            # Light theme colors
            colors = {
                'different': {'background': '#ffebee', 'foreground': '#d32f2f'},
                'missing': {'background': '#f5f5f5', 'foreground': '#666666'},
                'normal': {'background': '#ffffff', 'foreground': '#333333'},
                'highlight': {'background': '#e3f2fd', 'foreground': '#1976d2'},
                'address': {'foreground': '#1976d2'},
                'instruction': {'foreground': '#d32f2f'},
                'register': {'foreground': '#388e3c'},
                'memory': {'foreground': '#7b1fa2'},
                'csr': {'foreground': '#f57c00'},
                'search_highlight': {'background': '#fff59d', 'foreground': '#000000'}
            }
        
        # Apply colors to both text widgets
        for text_widget in [self.core_text, self.spike_text]:
            for tag, tag_colors in colors.items():
                if tag == 'address':
                    # Address tags need font specification
                    font_size = self.font_size_var.get()
                    text_widget.tag_configure(tag, foreground=tag_colors['foreground'], 
                                            font=('Consolas', font_size, 'bold'))
                else:
                    text_widget.tag_configure(tag, **tag_colors)
    
    def show_load_progress(self, current_line, total_lines):
        """Show progress during large file loading"""
        if total_lines > 1000:  # Only show progress for large files
            progress_percent = (current_line / total_lines) * 100
            if current_line % 500 == 0:  # Update every 500 lines
                print(f"📊 Loading progress: {current_line}/{total_lines} ({progress_percent:.1f}%)")
                # Try to update the main window title through parent chain
                try:
                    root_window = self.parent
                    while hasattr(root_window, 'parent') and root_window.parent:
                        root_window = root_window.parent
                    if hasattr(root_window, 'title'):
                        root_window.title(f"🚀 RISC-V Log Comparator - Loading {progress_percent:.1f}%")
                        root_window.update_idletasks()
                except:
                    pass
        
        # Reset title when done
        if current_line >= total_lines:
            try:
                root_window = self.parent
                while hasattr(root_window, 'parent') and root_window.parent:
                    root_window = root_window.parent
                if hasattr(root_window, 'title'):
                    root_window.title("🚀 RISC-V Log Comparator v3.0 ")
            except:
                pass
    
    def export_diff(self):
        """Export side-by-side comparison"""
        filename = filedialog.asksaveasfilename(
            title="Export Side-by-Side Comparison",
            defaultextension=".txt",
            filetypes=[
                ("Text files", "*.txt"),
                ("HTML files", "*.html"),
                ("All files", "*.*")
            ]
        )
        
        if filename:
            try:
                core_content = self.core_text.get(1.0, tk.END)
                spike_content = self.spike_text.get(1.0, tk.END)
                
                # Create side-by-side export
                export_content = "🚀 PROFESSIONAL RISC-V SIDE-BY-SIDE COMPARISON\n"
                export_content += "=" * 80 + "\n\n"
                
                core_lines = core_content.strip().split('\n')
                spike_lines = spike_content.strip().split('\n')
                
                max_lines = max(len(core_lines), len(spike_lines))
                
                export_content += f"{'CORE LOG':<40} | {'SPIKE LOG':<40}\n"
                export_content += "-" * 40 + " | " + "-" * 40 + "\n"
                
                for i in range(max_lines):
                    core_line = core_lines[i] if i < len(core_lines) else ""
                    spike_line = spike_lines[i] if i < len(spike_lines) else ""
                    
                    # Truncate long lines
                    if len(core_line) > 37:
                        core_line = core_line[:37] + "..."
                    if len(spike_line) > 37:
                        spike_line = spike_line[:37] + "..."
                    
                    export_content += f"{core_line:<40} | {spike_line:<40}\n"
                
                with open(filename, 'w', encoding='utf-8') as f:
                    f.write(export_content)
                
                messagebox.showinfo("Export Success", f"Side-by-side comparison exported to:\n{filename}")
                
            except Exception as e:
                messagebox.showerror("Export Error", f"Failed to export comparison:\n{str(e)}")

class RISCVLogComparatorGUI:
    """Main GUI application class"""
    
    def __init__(self):
        self.root = tk.Tk()
        self.setup_window()
        self.setup_theme()
        self.setup_widgets()
        self.setup_menu()
        
        # Comparison state
        self.core_file = None
        self.spike_file = None
        self.last_comparison_report = None
        self.comparator = ProfessionalLogComparator()
        
    def setup_window(self):
        """Setup main window"""
        self.root.title("🚀 RISC-V Log Comparator v3.0 ")
        self.root.geometry("1200x800")
        self.root.minsize(800, 600)
        
        # Center window
        screen_width = self.root.winfo_screenwidth()
        screen_height = self.root.winfo_screenheight()
        x = (screen_width - 1200) // 2
        y = (screen_height - 800) // 2
        self.root.geometry(f"1200x800+{x}+{y}")
        
        # Set icon (if available)
        try:
            # You can add an icon file here
            pass
        except:
            pass
    
    def setup_theme(self):
        """Setup modern theme with Adapta"""
        self.current_theme = 'dark'
        self.theme = ModernTheme.DARK
        
        # Configure ttk styles with Adapta theme for better scrollbars
        style = ttk.Style()
        
        # Try to use Adapta theme if available, otherwise fall back to clam
        try:
            style.theme_use('adapta')
        except tk.TclError:
            try:
                style.theme_use('arc')
            except tk.TclError:
                style.theme_use('clam')
        
        # Modern flat button design
        style.configure('TButton', 
                       background=self.theme['button_bg'], 
                       foreground=self.theme['button_fg'],
                       borderwidth=0,
                       relief='flat',
                       focuscolor='none',
                       font=('Segoe UI', 9))
        
        # Modern entry fields
        style.configure('TEntry', 
                       fieldbackground=self.theme['entry_bg'], 
                       foreground=self.theme['entry_fg'],
                       borderwidth=1,
                       relief='flat',
                       insertcolor=self.theme['fg'])
        
        # Flat frames
        style.configure('TFrame', 
                       background=self.theme['bg'],
                       relief='flat',
                       borderwidth=0)
        
        # Modern labels
        style.configure('TLabel', 
                       background=self.theme['bg'], 
                       foreground=self.theme['fg'],
                       font=('Segoe UI', 9))
        
        # Modern labelframes
        style.configure('TLabelFrame', 
                       background=self.theme['bg'], 
                       foreground=self.theme['fg'],
                       relief='flat',
                       borderwidth=1,
                       lightcolor=self.theme['border'],
                       darkcolor=self.theme['border'])
        style.configure('TLabelFrame.Label', 
                       background=self.theme['bg'], 
                       foreground=self.theme['fg'],
                       font=('Segoe UI', 9, 'bold'))
        
        # Modern notebook tabs
        style.configure('TNotebook', 
                       background=self.theme['bg'],
                       borderwidth=0)
        style.configure('TNotebook.Tab', 
                       background=self.theme['panel_bg'], 
                       foreground=self.theme['fg'],
                       padding=[16, 8],
                       borderwidth=0,
                       focuscolor='none')
        
        # Modern progressbar
        style.configure('TProgressbar',
                       background=self.theme['accent'],
                       troughcolor=self.theme['panel_bg'],
                       borderwidth=0,
                       lightcolor=self.theme['accent'],
                       darkcolor=self.theme['accent'])
        
        # Modern thin scrollbars - optimized for Adapta theme
        style.configure('TScrollbar',
                       background=self.theme['panel_bg'],
                       troughcolor=self.theme['bg'],
                       arrowcolor=self.theme['border'],
                       bordercolor=self.theme['bg'],
                       relief='flat',
                       borderwidth=0,
                       lightcolor=self.theme['panel_bg'],
                       darkcolor=self.theme['panel_bg'])
        
        style.configure('Vertical.TScrollbar',
                       background=self.theme['panel_bg'],
                       troughcolor=self.theme['bg'],
                       arrowcolor=self.theme['border'],
                       bordercolor=self.theme['bg'],
                       relief='flat',
                       borderwidth=0,
                       width=14,  # Slightly wider for better visibility
                       arrowsize=14)
        
        style.configure('Horizontal.TScrollbar',
                       background=self.theme['panel_bg'],
                       troughcolor=self.theme['bg'],
                       arrowcolor=self.theme['border'],
                       bordercolor=self.theme['bg'],
                       relief='flat',
                       borderwidth=0,
                       height=14,  # Slightly taller for better visibility
                       arrowsize=14)
        
        # Modern button states
        style.map('TButton',
                 background=[('active', self.theme['accent']),
                           ('pressed', self.theme['button_bg'])])
        style.map('TNotebook.Tab',
                 background=[('selected', self.theme['bg']),
                           ('active', self.theme['select_bg'])])
        
        # Modern scrollbar hover effects
        style.map('TScrollbar',
                 background=[('active', self.theme['accent']),
                           ('pressed', self.theme['select_bg'])])
        style.map('Vertical.TScrollbar',
                 background=[('active', self.theme['accent']),
                           ('pressed', self.theme['select_bg'])])
        style.map('Horizontal.TScrollbar',
                 background=[('active', self.theme['accent']),
                           ('pressed', self.theme['select_bg'])])
        
        # Custom styles
        style.configure('Title.TLabel', 
                       font=('Segoe UI', 14, 'bold'), 
                       background=self.theme['bg'], 
                       foreground=self.theme['fg'])
        style.configure('Subtitle.TLabel', 
                       font=('Segoe UI', 9),
                       background=self.theme['bg'], 
                       foreground=self.theme['accent'])
        
        # Modern accent button
        style.configure('Accent.TButton', 
                       background=self.theme['accent'], 
                       foreground='white',
                       font=('Segoe UI', 9, 'bold'),
                       borderwidth=0,
                       relief='flat',
                       focuscolor='none')
        style.map('Accent.TButton',
                 background=[('active', '#005a9e'),
                           ('pressed', self.theme['accent'])])
        
        self.root.configure(bg=self.theme['bg'])
    
    def setup_widgets(self):
        """Setup main widgets"""
        # Main container with minimal padding
        main_frame = ttk.Frame(self.root, padding="5")
        main_frame.pack(fill=tk.BOTH, expand=True)
        
        # Ultra-compact title and controls
        title_frame = ttk.Frame(main_frame)
        title_frame.pack(fill=tk.X, pady=(0, 5))
        
        ttk.Label(title_frame, text="🚀 RISC-V Log Comparator v3.0", 
                 style='Title.TLabel').pack(side=tk.LEFT)
        
        ttk.Label(title_frame, text="LCS Algorithm", 
                 style='Subtitle.TLabel').pack(side=tk.LEFT, padx=(10, 0))
        
        ttk.Button(title_frame, text="❓", width=3,
                  command=self.show_about).pack(side=tk.RIGHT)
        
        # Ultra-compact file selection and controls in one row
        control_frame = ttk.Frame(main_frame)
        control_frame.pack(fill=tk.X, pady=(0, 5))
        
        # Core file (minimal)
        ttk.Label(control_frame, text="Core:", width=4).pack(side=tk.LEFT)
        self.core_file_var = tk.StringVar(value="Select...")
        self.core_label = ttk.Label(control_frame, textvariable=self.core_file_var, 
                                   background=self.theme['entry_bg'], 
                                   foreground=self.theme['entry_fg'], 
                                   relief='flat', padding="2", width=15)
        self.core_label.pack(side=tk.LEFT, padx=(2, 3))
        
        ttk.Button(control_frame, text="📂", width=3,
                  command=self.select_core_file).pack(side=tk.LEFT, padx=(0, 8))
        
        # Spike file (minimal)
        ttk.Label(control_frame, text="Spike:", width=5).pack(side=tk.LEFT)
        self.spike_file_var = tk.StringVar(value="Select...")
        self.spike_label = ttk.Label(control_frame, textvariable=self.spike_file_var, 
                                    background=self.theme['entry_bg'], 
                                    foreground=self.theme['entry_fg'], 
                                    relief='flat', padding="2", width=15)
        self.spike_label.pack(side=tk.LEFT, padx=(2, 3))
        
        ttk.Button(control_frame, text="📂", width=3,
                  command=self.select_spike_file).pack(side=tk.LEFT, padx=(0, 15))
        
        # Action buttons in same row
        self.compare_btn = ttk.Button(control_frame, text="🔍 Compare", 
                                     command=self.compare_logs, 
                                     style='Accent.TButton',
                                     state='disabled')
        self.compare_btn.pack(side=tk.LEFT, padx=(0, 5))
        
        ttk.Button(control_frame, text="🌙", width=3,
                  command=self.toggle_theme).pack(side=tk.LEFT, padx=(0, 5))
        
        ttk.Button(control_frame, text="💾", width=3,
                  command=self.export_report).pack(side=tk.LEFT)
        
        # Create notebook for tabs
        self.notebook = ttk.Notebook(main_frame)
        self.notebook.pack(fill=tk.BOTH, expand=True)
        
        # Statistics tab
        stats_frame = ttk.Frame(self.notebook)
        self.notebook.add(stats_frame, text="📊 Statistics")
        self.statistics_panel = StatisticsPanel(stats_frame)
        self.statistics_panel.frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        # Diff viewer tab
        diff_frame = ttk.Frame(self.notebook)
        self.notebook.add(diff_frame, text="🔍 Differences")
        self.diff_viewer = DiffViewer(diff_frame)
        self.diff_viewer.frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        # Console tab
        console_frame = ttk.Frame(self.notebook)
        self.notebook.add(console_frame, text="📟 Console")
        self.setup_console(console_frame)
        
        # Compact status bar
        self.status_var = tk.StringVar(value="Ready")
        status_bar = ttk.Label(main_frame, textvariable=self.status_var, 
                              relief=tk.SUNKEN, padding="2")
        status_bar.pack(fill=tk.X, pady=(5, 0))
    
    def setup_console(self, parent):
        """Setup console output with modern design"""
        console_frame = ttk.Frame(parent, padding="15")
        console_frame.pack(fill=tk.BOTH, expand=True)
        
        # Modern console header
        header_frame = ttk.Frame(console_frame)
        header_frame.pack(fill=tk.X, pady=(0, 10))
        
        ttk.Label(header_frame, text="📟 Console Output", 
                 font=('Segoe UI', 12, 'bold')).pack(side=tk.LEFT)
        
        # Clear button
        ttk.Button(header_frame, text="🗑️ Clear", 
                  command=self.clear_console).pack(side=tk.RIGHT)
        
        # Modern console with better colors and custom scrollbar
        console_container = ttk.Frame(console_frame)
        console_container.pack(fill=tk.BOTH, expand=True)
        
        # Create Text widget with custom scrollbar instead of ScrolledText
        self.console_text = tk.Text(
            console_container,
            wrap=tk.WORD,
            font=('Consolas', 9),
            bg=self.theme['panel_bg'],
            fg=self.theme['text_fg'],
            selectbackground=self.theme['select_bg'],
            relief='flat',
            borderwidth=0
        )
        
        # Add modern thin scrollbar
        console_scrollbar = ttk.Scrollbar(console_container, orient=tk.VERTICAL, 
                                        command=self.console_text.yview,
                                        style='Vertical.TScrollbar')
        self.console_text.config(yscrollcommand=console_scrollbar.set)
        
        # Pack with modern layout
        console_scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.console_text.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        
        # Add initial message
        self.log_to_console("🚀 RISC-V Log Comparator v3.0")
        self.log_to_console("📚 LCS Algorithm")
        self.log_to_console("📁 Select log files to begin...")
    
    def setup_menu(self):
        """Setup menu bar"""
        menubar = tk.Menu(self.root)
        self.root.config(menu=menubar)
        
        # File menu
        file_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="File", menu=file_menu)
        file_menu.add_command(label="Open Core Log...", command=self.select_core_file)
        file_menu.add_command(label="Open Spike Log...", command=self.select_spike_file)
        file_menu.add_separator()
        file_menu.add_command(label="Export Report...", command=self.export_report)
        file_menu.add_separator()
        file_menu.add_command(label="Exit", command=self.root.quit)
        
        # View menu
        view_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="View", menu=view_menu)
        view_menu.add_command(label="Toggle Theme", command=self.toggle_theme)
        view_menu.add_command(label="Clear Console", command=self.clear_console)
        
        # Help menu
        help_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Help", menu=help_menu)
        help_menu.add_command(label="About", command=self.show_about)
        help_menu.add_command(label="User Guide", command=self.show_help)
    
    def log_to_console(self, message):
        """Log message to console"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        formatted_message = f"[{timestamp}] {message}\n"
        
        self.console_text.insert(tk.END, formatted_message)
        self.console_text.see(tk.END)
        self.root.update_idletasks()
    
    def clear_console(self):
        """Clear console output"""
        self.console_text.delete(1.0, tk.END)
        self.log_to_console("Console cleared")
    
    def select_core_file(self):
        """Select core log file"""
        filename = filedialog.askopenfilename(
            title="Select Core Log File",
            filetypes=[
                ("Log files", "*.log"),
                ("Text files", "*.txt"),
                ("All files", "*.*")
            ]
        )
        
        if filename:
            self.core_file = filename
            # Show ultra-short filename
            display_name = os.path.basename(filename)
            if len(display_name) > 18:
                display_name = display_name[:15] + "..."
            self.core_file_var.set(display_name)
            self.log_to_console(f"📂 Core: {os.path.basename(filename)}")
            self.update_compare_button()
    
    def select_spike_file(self):
        """Select spike log file"""
        filename = filedialog.askopenfilename(
            title="Select Spike Log File",
            filetypes=[
                ("Log files", "*.log"),
                ("Text files", "*.txt"),
                ("All files", "*.*")
            ]
        )
        
        if filename:
            self.spike_file = filename
            # Show ultra-short filename
            display_name = os.path.basename(filename)
            if len(display_name) > 18:
                display_name = display_name[:15] + "..."
            self.spike_file_var.set(display_name)
            self.log_to_console(f"📂 Spike: {os.path.basename(filename)}")
            self.update_compare_button()
    
    def update_compare_button(self):
        """Update compare button state"""
        if self.core_file and self.spike_file:
            self.compare_btn.config(state='normal')
            self.status_var.set("Ready")
        else:
            self.compare_btn.config(state='disabled')
            self.status_var.set("Select files")
    
    def compare_logs(self):
        """Start log comparison in background thread"""
        if not self.core_file or not self.spike_file:
            messagebox.showerror("Error", "Please select both core and spike log files")
            return
        
        # Create progress dialog
        self.progress_dialog = ProgressDialog(self.root, "Comparing Logs")
        
        # Start comparison in background thread
        self.comparison_thread = threading.Thread(
            target=self.run_comparison,
            daemon=True
        )
        self.comparison_thread.start()
        
        # Monitor thread completion
        self.monitor_comparison()
    
    def run_comparison(self):
        """Run comparison in background thread"""
        try:
            self.log_to_console("🔍 Starting log comparison...")
            
            # Update progress safely
            def safe_update_progress(message):
                try:
                    if hasattr(self, 'progress_dialog') and not self.progress_dialog.cancelled:
                        self.root.after(0, lambda: self.progress_dialog.update_status(message))
                except:
                    pass
            
            safe_update_progress("Loading log files...")
            
            # Prepare for comparison with better progress updates
            safe_update_progress("Parsing log entries...")
            
            # Create a callback for progress updates during comparison
            def progress_callback(step, message):
                safe_update_progress(f"{step}: {message}")
            
            # Run comparison with progress callback
            safe_update_progress("Computing LCS differences...")
            report = self.comparator.compare_logs(self.core_file, self.spike_file)
            
            safe_update_progress("Finalizing comparison report...")
            
            if hasattr(self, 'progress_dialog') and not self.progress_dialog.cancelled:
                self.last_comparison_report = report
                self.root.after(0, self.comparison_completed)
            
        except Exception as e:
            if hasattr(self, 'progress_dialog') and not self.progress_dialog.cancelled:
                self.root.after(0, lambda: self.comparison_failed(str(e)))
    
    def monitor_comparison(self):
        """Monitor comparison thread"""
        if hasattr(self, 'comparison_thread') and self.comparison_thread.is_alive():
            self.root.after(100, self.monitor_comparison)
        else:
            # Comparison finished, clean up progress dialog
            if hasattr(self, 'progress_dialog'):
                try:
                    self.progress_dialog.destroy()
                except:
                    pass
    
    def comparison_completed(self):
        """Handle successful comparison completion"""
        # Clean up progress dialog safely
        if hasattr(self, 'progress_dialog'):
            try:
                self.progress_dialog.destroy()
                del self.progress_dialog
            except:
                pass

        
        
        # Update statistics
        self.statistics_panel.update_stats(self.comparator.stats)
        
        # Extract diff content for viewer
        report_lines = self.last_comparison_report.split('\n')
        diff_start = -1
        
        for i, line in enumerate(report_lines):
            if line.startswith("🔍 DETAILED DIFFERENCES"):
                diff_start = i
                break
        
        if diff_start >= 0:
            diff_content = '\n'.join(report_lines[diff_start:])
            self.diff_viewer.display_diff(diff_content)
        
        # Switch to statistics tab
        self.notebook.select(0)
        
        # Update status
        match_pct = (self.comparator.stats.get('perfect_matches', 0) / 
                    (self.comparator.stats.get('perfect_matches', 0) + 
                     self.comparator.stats.get('deletions', 0) + 
                     self.comparator.stats.get('insertions', 0)) * 100) if \
                    (self.comparator.stats.get('perfect_matches', 0) + 
                     self.comparator.stats.get('deletions', 0) + 
                     self.comparator.stats.get('insertions', 0)) > 0 else 0
        
        self.status_var.set(f"Comparison completed - {match_pct:.2f}% match rate")
        self.log_to_console(f"✅ Comparison completed successfully!")
        self.log_to_console(f"📊 Match rate: {match_pct:.2f}%")
        self.log_to_console(f"🔢 LCS Length: {self.comparator.stats.get('lcs_length', 0):,}")
        
        # Show success message
        messagebox.showinfo(
            "Comparison Complete", 
            f"Log comparison completed successfully!\n\n"
            f"Match Rate: {match_pct:.2f}%\n"
            f"Perfect Matches: {self.comparator.stats.get('perfect_matches', 0):,}\n"
            f"Differences: {self.comparator.stats.get('deletions', 0) + self.comparator.stats.get('insertions', 0):,}"
        )
    
    def comparison_failed(self, error_message):
        """Handle comparison failure"""
        # Clean up progress dialog safely
        if hasattr(self, 'progress_dialog'):
            try:
                self.progress_dialog.destroy()
                del self.progress_dialog
            except:
                pass
        
        self.log_to_console(f"❌ Comparison failed: {error_message}")
        self.status_var.set("Comparison failed")
        messagebox.showerror("Comparison Failed", f"Failed to compare logs:\n\n{error_message}")
    
    def export_report(self):
        """Export comparison report"""
        if not self.last_comparison_report:
            messagebox.showwarning("No Report", "No comparison report available to export")
            return
        
        filename = filedialog.asksaveasfilename(
            title="Export Comparison Report",
            defaultextension=".txt",
            filetypes=[
                ("Text files", "*.txt"),
                ("JSON files", "*.json"),
                ("HTML files", "*.html"),
                ("All files", "*.*")
            ]
        )
        
        if filename:
            try:
                if filename.endswith('.json'):
                    # Export as JSON
                    data = {
                        'timestamp': datetime.now().isoformat(),
                        'core_file': os.path.basename(self.core_file) if self.core_file else None,
                        'spike_file': os.path.basename(self.spike_file) if self.spike_file else None,
                        'statistics': self.comparator.stats,
                        'report': self.last_comparison_report
                    }
                    with open(filename, 'w', encoding='utf-8') as f:
                        json.dump(data, f, indent=2)
                else:
                    # Export as text
                    with open(filename, 'w', encoding='utf-8') as f:
                        f.write(self.last_comparison_report)
                
                self.log_to_console(f"💾 Report exported to: {os.path.basename(filename)}")
                messagebox.showinfo("Export Success", f"Report exported successfully to:\n{filename}")
                
            except Exception as e:
                messagebox.showerror("Export Error", f"Failed to export report:\n{str(e)}")
    
    def toggle_theme(self):
        """Toggle between dark and light theme with modern styling"""
        if self.current_theme == 'dark':
            self.current_theme = 'light'
            self.theme = ModernTheme.LIGHT
        else:
            self.current_theme = 'dark'
            self.theme = ModernTheme.DARK
        
        # Update root window
        self.root.configure(bg=self.theme['bg'])
        
        # Update ALL ttk styles with modern flat design
        style = ttk.Style()
        
        # Modern flat styling for ALL widgets
        style.configure('TLabel', 
                       background=self.theme['bg'], 
                       foreground=self.theme['fg'],
                       fieldbackground=self.theme['bg'])
        style.configure('TFrame', 
                       background=self.theme['bg'],
                       relief='flat',
                       borderwidth=0)
        style.configure('TLabelFrame', 
                       background=self.theme['panel_bg'],  # Use panel background
                       foreground=self.theme['fg'],
                       relief='flat',
                       borderwidth=0)  # Remove borders for modern look
        style.configure('TLabelFrame.Label', 
                       background=self.theme['panel_bg'], 
                       foreground=self.theme['fg'])
        style.configure('TButton', 
                       background=self.theme['button_bg'], 
                       foreground=self.theme['button_fg'],
                       borderwidth=0,  # Flat buttons
                       relief='flat',
                       focuscolor='none')
        style.configure('Modern.TButton',  # Custom modern button style
                       background=self.theme['panel_bg'], 
                       foreground=self.theme['fg'],
                       borderwidth=0,
                       relief='flat',
                       focuscolor='none')
        style.configure('Accent.TButton',  # Accent button style
                       background=self.theme['accent'], 
                       foreground='white',
                       borderwidth=0,
                       relief='flat',
                       focuscolor='none')
        style.configure('TEntry', 
                       fieldbackground=self.theme['entry_bg'], 
                       foreground=self.theme['entry_fg'],
                       borderwidth=0,  # Flat entries
                       relief='flat',
                       insertcolor=self.theme['fg'])
        style.configure('Modern.TEntry',  # Custom modern entry style
                       fieldbackground=self.theme['panel_bg'], 
                       foreground=self.theme['fg'],
                       borderwidth=0,
                       relief='flat',
                       insertcolor=self.theme['fg'])
        style.configure('TSpinbox', 
                       fieldbackground=self.theme['entry_bg'], 
                       foreground=self.theme['entry_fg'],
                       borderwidth=0,
                       relief='flat')
        style.configure('Modern.TSpinbox',  # Custom modern spinbox style
                       fieldbackground=self.theme['panel_bg'], 
                       foreground=self.theme['fg'],
                       borderwidth=0,
                       relief='flat')
        style.configure('TNotebook', 
                       background=self.theme['bg'],
                       borderwidth=0)
        style.configure('TNotebook.Tab', 
                       background=self.theme['panel_bg'], 
                       foreground=self.theme['fg'],
                       borderwidth=0,
                       padding=[12, 8])
        style.configure('TProgressbar',
                       background=self.theme['accent'],
                       troughcolor=self.theme['panel_bg'])
        
        # Modern thin scrollbars with flat design - optimized for Adapta
        style.configure('TScrollbar',
                       background=self.theme['panel_bg'],
                       troughcolor=self.theme['bg'],
                       arrowcolor=self.theme['border'],
                       bordercolor=self.theme['bg'],
                       relief='flat',
                       borderwidth=0,
                       lightcolor=self.theme['panel_bg'],
                       darkcolor=self.theme['panel_bg'])
        style.configure('Vertical.TScrollbar',
                       background=self.theme['panel_bg'],
                       troughcolor=self.theme['bg'],
                       arrowcolor=self.theme['border'],
                       bordercolor=self.theme['bg'],
                       relief='flat',
                       borderwidth=0,
                       width=14,  # Better visibility with Adapta
                       arrowsize=14)
        style.configure('Horizontal.TScrollbar',
                       background=self.theme['panel_bg'],
                       troughcolor=self.theme['bg'],
                       arrowcolor=self.theme['border'],
                       bordercolor=self.theme['bg'],
                       relief='flat',
                       borderwidth=0,
                       height=14,  # Better visibility with Adapta
                       arrowsize=14)
        
        # Modern flat style mappings
        style.map('TButton',
                 background=[('active', self.theme['accent']),
                           ('pressed', self.theme['select_bg'])])
        style.map('Modern.TButton',
                 background=[('active', self.theme['accent']),
                           ('pressed', self.theme['select_bg'])])
        style.map('Accent.TButton',
                 background=[('active', self.theme['select_bg']),
                           ('pressed', self.theme['accent'])])
        style.map('TNotebook.Tab',
                 background=[('selected', self.theme['bg']),
                           ('active', self.theme['select_bg'])])
        
        # Modern scrollbar hover effects with Adapta theme compatibility
        style.map('TScrollbar',
                 background=[('active', self.theme['accent']),
                           ('pressed', self.theme['select_bg'])],
                 troughcolor=[('active', self.theme['bg'])],
                 arrowcolor=[('active', 'white'),
                           ('pressed', 'white')])
        style.map('Vertical.TScrollbar',
                 background=[('active', self.theme['accent']),
                           ('pressed', self.theme['select_bg'])],
                 troughcolor=[('active', self.theme['bg'])],
                 arrowcolor=[('active', 'white'),
                           ('pressed', 'white')])
        style.map('Horizontal.TScrollbar',
                 background=[('active', self.theme['accent']),
                           ('pressed', self.theme['select_bg'])],
                 troughcolor=[('active', self.theme['bg'])],
                 arrowcolor=[('active', 'white'),
                           ('pressed', 'white')])
        
        # Update custom styles for modern flat appearance
        style.configure('Title.TLabel', 
                       font=('Segoe UI', 16, 'bold'), 
                       background=self.theme['bg'], 
                       foreground=self.theme['fg'])
        style.configure('Subtitle.TLabel', 
                       font=('Segoe UI', 10),
                       background=self.theme['bg'], 
                       foreground=self.theme['fg'])
        style.configure('Success.TLabel', 
                       foreground=self.theme['success'],
                       background=self.theme['bg'])
        style.configure('Error.TLabel', 
                       foreground=self.theme['error'],
                       background=self.theme['bg'])
        
        # Update accent button
        accent_active = '#005a9e' if self.current_theme == 'dark' else '#1565c0'
        style.configure('Accent.TButton', 
                       background=self.theme['accent'], 
                       foreground='white',
                       font=('Segoe UI', 10, 'bold'),
                       borderwidth=0,
                       focuscolor='none')
        style.map('Accent.TButton',
                 background=[('active', accent_active),
                           ('pressed', self.theme['accent'])])
        
        # Update file selection labels with tk.Label styling
        try:
            self.core_label.configure(
                background=self.theme['entry_bg'], 
                foreground=self.theme['entry_fg']
            )
            self.spike_label.configure(
                background=self.theme['entry_bg'], 
                foreground=self.theme['entry_fg']
            )
        except:
            pass
        
        # Update console colors with modern styling
        self.console_text.configure(
            bg=self.theme['panel_bg'],  # Use panel background for modern look
            fg=self.theme['text_fg'],
            selectbackground=self.theme['select_bg'],
            insertbackground=self.theme['fg'],
            relief='flat',
            borderwidth=0
        )
        
        # Update diff viewer colors properly for both text widgets with modern theme
        if hasattr(self, 'diff_viewer'):
            # Set main colors based on theme
            text_bg = self.theme['text_bg']
            text_fg = self.theme['text_fg']
            panel_bg = self.theme['panel_bg']
            border_color = self.theme['border']
            
            # Update both text widgets with flat modern styling
            self.diff_viewer.core_text.configure(
                bg=text_bg,
                fg=text_fg,
                selectbackground=self.theme['select_bg'],
                insertbackground=self.theme['fg'],
                relief='flat',
                borderwidth=0
            )
            
            self.diff_viewer.spike_text.configure(
                bg=text_bg,
                fg=text_fg,
                selectbackground=self.theme['select_bg'],
                insertbackground=self.theme['fg'],
                relief='flat',
                borderwidth=0
            )
            
            # Update line number widgets with panel background
            self.diff_viewer.core_lines.configure(
                bg=panel_bg, 
                fg=border_color,
                relief='flat',
                borderwidth=0
            )
            self.diff_viewer.spike_lines.configure(
                bg=panel_bg, 
                fg=border_color,
                relief='flat',
                borderwidth=0
            )
            
            # Update syntax highlighting tags for current theme
            self.diff_viewer.update_theme_colors(self.current_theme)
        
        # Force complete refresh of all widgets
        def update_all_children(widget):
            """Recursively update all child widgets"""
            try:
                widget.update_idletasks()
                for child in widget.winfo_children():
                    update_all_children(child)
            except:
                pass
        
        update_all_children(self.root)
        self.root.update()
        
        self.log_to_console(f"🌙 Theme switched to {self.current_theme} mode")
    
    def show_about(self):
        """Show about dialog"""
        about_text = """🚀 Professional RISC-V Log Comparator v3.0

Created by: Ensar 
Algorithm: Classical LCS Dynamic Programming

Features:
✅ Research-based LCS algorithm
✅ Infinite loop detection
✅ Register value comparison
✅ Syntax-highlighted diff viewer
✅ Professional statistics
✅ Export capabilities
✅ Modern GUI interface

Based on classical computer science research:
• Hunt & McIlroy (1976) - Differential File Comparison
• Myers (1986) - O(ND) Difference Algorithm
• CLRS Textbook - LCS Dynamic Programming

Perfect for RISC-V verification workflows!"""
        
        messagebox.showinfo("About", about_text)
    
    def show_help(self):
        """Show help dialog"""
        help_text = """📚 User Guide - RISC-V Log Comparator

🚀 Getting Started:
1. Select your Core log file (Browse button)
2. Select your Spike log file (Browse button)  
3. Click 'Compare Logs' to start analysis

📊 Understanding Results:
• Perfect Matches: Identical entries (PC + instruction + registers)
• Deletions: Entries only in Core log
• Insertions: Entries only in Spike log
• Match %: Percentage of perfect matches

🔍 Difference Viewer:
• Red lines (-): Core-only entries
• Green lines (+): Spike-only entries
• White lines: Context around differences
• Use Search to find specific patterns
• Navigate with Next/Prev Diff buttons

💾 Export Options:
• Text format: Human-readable report
• JSON format: Machine-readable data
• HTML format: Web-viewable results

🌙 Interface:
• Toggle Theme: Switch dark/light mode
• Console: View processing messages
• Statistics: Overview of comparison results"""
        
        messagebox.showinfo("User Guide", help_text)
    
    def run(self):
        """Run the GUI application"""
        self.log_to_console("🎯 GUI Ready - Welcome to Professional RISC-V Log Comparator!")
        self.root.mainloop()

def main():
    """Main function to run the GUI"""
    try:
        app = RISCVLogComparatorGUI()
        app.run()
    except Exception as e:
        messagebox.showerror("Fatal Error", f"Failed to start application:\n{str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
