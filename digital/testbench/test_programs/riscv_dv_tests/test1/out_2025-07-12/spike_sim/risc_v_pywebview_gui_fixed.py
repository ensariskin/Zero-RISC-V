import json
import threading
import tkinter as tk
from tkinter import filedialog, messagebox
import os
import sys
import re

try:
    import webview
    WEBVIEW_AVAILABLE = True
except ImportError:
    WEBVIEW_AVAILABLE = False
    print("⚠️  PyWebView bulunamadı. Lütfen 'pip install pywebview' komutu ile yükleyin.")

from professional_log_comparator import ProfessionalLogComparator

# HTML interface embedded as a multi-line string
def get_html():
    return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RISC-V Log Comparator</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .diff-container {
            font-family: 'Courier New', monospace;
            white-space: pre-wrap;
            line-height: 1.4;
        }
        .highlight-diff {
            background-color: #fee;
            padding: 2px;
        }
        .highlight-match {
            background-color: #efe;
            padding: 2px;
        }
    </style>
</head>
<body class="bg-gray-100 p-6">
    <div class="max-w-6xl mx-auto bg-white shadow-md rounded-lg p-6">
        <h1 class="text-3xl font-bold mb-6 text-gray-800">🚀 RISC-V Log Comparator</h1>
        
        <!-- File Selection -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
            <div class="bg-gray-50 p-4 rounded-lg">
                <h3 class="font-semibold mb-2">Core Log File</h3>
                <input type="file" id="file1" accept=".log,.txt" class="mb-2" onchange="updateFileName('file1', 'filename1')">
                <div id="filename1" class="text-sm text-gray-600">No file selected</div>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
                <h3 class="font-semibold mb-2">Spike Log File</h3>
                <input type="file" id="file2" accept=".log,.txt" class="mb-2" onchange="updateFileName('file2', 'filename2')">
                <div id="filename2" class="text-sm text-gray-600">No file selected</div>
            </div>
        </div>
        
        <!-- Compare Button -->
        <div class="text-center mb-6">
            <button id="compareBtn" class="bg-green-500 hover:bg-green-600 text-white px-8 py-3 rounded-lg text-lg font-semibold" onclick="compare()">
                🔍 Compare Logs
            </button>
        </div>
        
        <!-- Progress -->
        <div id="progress" class="hidden mb-4">
            <div class="bg-blue-100 rounded-lg p-4">
                <div class="flex items-center">
                    <div class="animate-spin rounded-full h-6 w-6 border-b-2 border-blue-600 mr-3"></div>
                    <span class="text-blue-800">Processing logs...</span>
                </div>
            </div>
        </div>
        
        <!-- Results Tabs -->
        <div id="results" class="hidden">
            <div class="border-b border-gray-200 mb-4">
                <nav class="-mb-px flex space-x-8">
                    <button class="tab-btn py-2 px-1 border-b-2 border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 font-medium text-sm active" data-tab="overview" onclick="showTab('overview')">
                        📊 Overview
                    </button>
                    <button class="tab-btn py-2 px-1 border-b-2 border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 font-medium text-sm" data-tab="differences" onclick="showTab('differences')">
                        🔍 Differences
                    </button>
                    <button class="tab-btn py-2 px-1 border-b-2 border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 font-medium text-sm" data-tab="search" onclick="showTab('search')">
                        🔎 Search
                    </button>
                </nav>
            </div>
            
            <!-- Tab Contents -->
            <div id="overview" class="tab-content">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                    <div class="bg-blue-50 p-4 rounded-lg">
                        <h4 class="font-semibold text-blue-800">📊 Statistics</h4>
                        <div id="stats" class="text-sm text-blue-600 mt-2"></div>
                    </div>
                    <div class="bg-green-50 p-4 rounded-lg">
                        <h4 class="font-semibold text-green-800">✅ Matches</h4>
                        <div id="matches" class="text-sm text-green-600 mt-2"></div>
                    </div>
                    <div class="bg-red-50 p-4 rounded-lg">
                        <h4 class="font-semibold text-red-800">❌ Differences</h4>
                        <div id="differences-count" class="text-sm text-red-600 mt-2"></div>
                    </div>
                </div>
                <div class="bg-gray-50 p-4 rounded-lg">
                    <h4 class="font-semibold mb-2">📝 Summary</h4>
                    <div id="summary" class="text-sm text-gray-600"></div>
                </div>
            </div>
            
            <div id="differences" class="tab-content hidden">
                <div class="flex justify-between items-center mb-4">
                    <h4 class="font-semibold">🔍 Found Differences</h4>
                    <div class="text-sm text-gray-600">
                        <span id="diff-navigation"></span>
                    </div>
                </div>
                <div id="diff-content" class="bg-gray-50 p-4 rounded-lg max-h-96 overflow-y-auto diff-container"></div>
            </div>
            
            <div id="search" class="tab-content hidden">
                <div class="mb-4">
                    <input type="text" id="searchInput" placeholder="Search in comparison results..." 
                           class="w-full p-2 border border-gray-300 rounded-lg" onkeyup="performSearch()">
                </div>
                <div id="search-results" class="bg-gray-50 p-4 rounded-lg max-h-96 overflow-y-auto diff-container"></div>
            </div>
        </div>
    </div>
    
    <script>
        let comparisonData = null;
        
        function updateFileName(inputId, displayId) {
            const input = document.getElementById(inputId);
            const display = document.getElementById(displayId);
            if (input.files.length > 0) {
                display.textContent = input.files[0].name;
                display.className = 'text-sm text-green-600';
            } else {
                display.textContent = 'No file selected';
                display.className = 'text-sm text-gray-600';
            }
        }
        
        async function compare() {
            const file1 = document.getElementById('file1').files[0];
            const file2 = document.getElementById('file2').files[0];
            
            if (!file1 || !file2) {
                alert('Please select both files before comparing');
                return;
            }
            
            // Show progress
            document.getElementById('progress').classList.remove('hidden');
            document.getElementById('compareBtn').disabled = true;
            document.getElementById('compareBtn').textContent = '⏳ Processing...';
            
            try {
                // Read files
                const content1 = await readFile(file1);
                const content2 = await readFile(file2);
                
                // Save files temporarily and compare
                const result = await pywebview.api.compare_logs(content1, content2, file1.name, file2.name);
                
                if (result.success) {
                    comparisonData = result.data;
                    displayResults(result.data);
                } else {
                    alert('Error: ' + result.error);
                }
                
            } catch (error) {
                alert('Error processing files: ' + error);
            } finally {
                // Hide progress
                document.getElementById('progress').classList.add('hidden');
                document.getElementById('compareBtn').disabled = false;
                document.getElementById('compareBtn').textContent = '🔍 Compare Logs';
            }
        }
        
        function readFile(file) {
            return new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.onload = e => resolve(e.target.result);
                reader.onerror = reject;
                reader.readAsText(file);
            });
        }
        
        function displayResults(data) {
            // Show results section
            document.getElementById('results').classList.remove('hidden');
            
            // Update overview
            document.getElementById('stats').innerHTML = 
                `Total Lines: ${data.total_lines}<br>` +
                `Core Lines: ${data.core_lines}<br>` +
                `Spike Lines: ${data.spike_lines}`;
            
            document.getElementById('matches').innerHTML = 
                `Matching Lines: ${data.matches}<br>` +
                `Match Rate: ${data.match_percentage}%`;
                
            document.getElementById('differences-count').innerHTML = 
                `Different Lines: ${data.differences}<br>` +
                `Core Only: ${data.core_only}<br>` +
                `Spike Only: ${data.spike_only}`;
                
            document.getElementById('summary').textContent = data.summary;
            
            // Update differences
            if (data.diff_lines && data.diff_lines.length > 0) {
                document.getElementById('diff-content').innerHTML = data.diff_lines.join('<br>');
            } else {
                document.getElementById('diff-content').innerHTML = '<p class="text-green-600">No differences found!</p>';
            }
            
            // Set navigation
            document.getElementById('diff-navigation').textContent = 
                `Showing ${Math.min(data.differences, 100)} of ${data.differences} differences`;
        }
        
        function showTab(tabName) {
            // Hide all tab contents
            document.querySelectorAll('.tab-content').forEach(content => {
                content.classList.add('hidden');
            });
            
            // Remove active class from all tabs
            document.querySelectorAll('.tab-btn').forEach(btn => {
                btn.classList.remove('active', 'border-blue-500', 'text-blue-600');
                btn.classList.add('border-transparent', 'text-gray-500');
            });
            
            // Show selected tab content
            document.getElementById(tabName).classList.remove('hidden');
            
            // Add active class to selected tab
            const activeTab = document.querySelector(`[data-tab="${tabName}"]`);
            activeTab.classList.add('active', 'border-blue-500', 'text-blue-600');
            activeTab.classList.remove('border-transparent', 'text-gray-500');
        }
        
        function performSearch() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const resultsDiv = document.getElementById('search-results');
            
            if (!comparisonData || !searchTerm.trim()) {
                resultsDiv.innerHTML = '<p class="text-gray-500">Enter a search term to find specific content...</p>';
                return;
            }
            
            try {
                const matches = [];
                
                // Search in differences
                if (comparisonData.diff_lines) {
                    comparisonData.diff_lines.forEach((line, index) => {
                        if (line.toLowerCase().includes(searchTerm)) {
                            matches.push(`<div class="mb-2 p-2 bg-yellow-100 rounded">
                                <strong>Difference ${index + 1}:</strong><br>
                                <span class="highlight-diff">${escapeHtml(line)}</span>
                            </div>`);
                        }
                    });
                }
                
                if (matches.length > 0) {
                    resultsDiv.innerHTML = `
                        <p class="mb-4 text-green-600">Found ${matches.length} matches:</p>
                        ${matches.join('')}
                    `;
                } else {
                    resultsDiv.innerHTML = '<p class="text-red-600">No matches found for your search term.</p>';
                }
                
            } catch (error) {
                resultsDiv.innerHTML = '<p class="text-red-600">Error performing search: ' + error + '</p>';
            }
        }
        
        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }
        
        // Initialize first tab as active
        document.addEventListener('DOMContentLoaded', function() {
            showTab('overview');
        });
    </script>
</body>
</html>
'''

class API:
    def __init__(self):
        self.comparator = ProfessionalLogComparator()
    
    def compare_logs(self, content1, content2, filename1, filename2):
        """Compare two log file contents and return structured results"""
        try:
            # Save contents to temporary files
            import tempfile
            
            with tempfile.NamedTemporaryFile(mode='w', suffix='.log', delete=False) as f1:
                f1.write(content1)
                temp_file1 = f1.name
                
            with tempfile.NamedTemporaryFile(mode='w', suffix='.log', delete=False) as f2:
                f2.write(content2)
                temp_file2 = f2.name
            
            try:
                # Perform comparison
                results = self.comparator.compare_logs(temp_file1, temp_file2)
                
                print(f"🔍 Debug - Results type: {type(results)}")
                
                # Parse string results from professional_log_comparator
                if isinstance(results, str):
                    lines1 = content1.split('\n')
                    lines2 = content2.split('\n')
                    
                    # Extract statistics from the report text
                    stats = self._parse_report_stats(results)
                    diff_lines = self._extract_diff_lines(results)
                    
                    # Calculate basic stats if not found in report
                    total_lines1 = len([l for l in lines1 if l.strip()])
                    total_lines2 = len([l for l in lines2 if l.strip()])
                    
                    return {
                        'success': True,
                        'data': {
                            'total_lines': max(total_lines1, total_lines2),
                            'core_lines': total_lines1,
                            'spike_lines': total_lines2,
                            'matches': stats.get('matches', 0),
                            'differences': stats.get('differences', len(diff_lines)),
                            'core_only': stats.get('deletions', 0),
                            'spike_only': stats.get('insertions', 0),
                            'match_percentage': stats.get('match_percentage', 0.0),
                            'summary': f"Comparison completed. Found {len(diff_lines)} differences.",
                            'diff_lines': diff_lines[:200]  # Limit to first 200 for performance
                        }
                    }
                else:
                    return {'success': False, 'error': f'Unexpected result type: {type(results)}'}
                    
            finally:
                # Clean up temporary files
                try:
                    os.unlink(temp_file1)
                    os.unlink(temp_file2)
                except:
                    pass
                    
        except Exception as e:
            print(f"🔍 Debug - Exception: {type(e).__name__}: {str(e)}")
            return {'success': False, 'error': str(e)}
    
    def _parse_report_stats(self, report_text):
        """Parse statistics from the report text"""
        stats = {}
        try:
            lines = report_text.split('\n')
            for line in lines:
                if 'Perfect Matches:' in line:
                    stats['matches'] = int(re.search(r'(\d+)', line).group(1))
                elif 'Deletions:' in line:
                    stats['deletions'] = int(re.search(r'(\d+)', line).group(1))
                elif 'Insertions:' in line:
                    stats['insertions'] = int(re.search(r'(\d+)', line).group(1))
                elif 'Match Percentage:' in line:
                    stats['match_percentage'] = float(re.search(r'([\d.]+)%', line).group(1))
        except:
            pass  # If parsing fails, return empty stats
        return stats
    
    def _extract_diff_lines(self, report_text):
        """Extract difference lines from the report"""
        diff_lines = []
        try:
            lines = report_text.split('\n')
            in_diff_section = False
            
            for line in lines:
                # Start collecting diffs after "DIFFERENCES FOUND"
                if '🔍 DIFFERENCES FOUND' in line or 'DETAILED DIFFERENCES' in line:
                    in_diff_section = True
                    continue
                elif '=' in line and len(line) > 50:  # End of section
                    in_diff_section = False
                    continue
                
                if in_diff_section and line.strip():
                    # Clean up diff line formatting
                    if line.startswith(('- ', '+ ', '  ')):
                        diff_lines.append(line.strip())
                    elif line and not line.startswith('Hunk'):
                        diff_lines.append(line.strip())
                        
        except Exception as e:
            diff_lines = [f"Error parsing diff: {str(e)}"]
            
        return diff_lines

def main():
    print("🚀 RISC-V Log Comparator başlatılıyor...")
    
    if not WEBVIEW_AVAILABLE:
        print("❌ PyWebView bulunamadı, Tkinter GUI'ye geçiliyor...")
        try:
            import risc_v_gui_comparator
            app = risc_v_gui_comparator.RISCVLogComparatorGUI()
            app.run()
        except Exception as fallback_error:
            print(f"❌ Fallback GUI de başlatılamadı: {fallback_error}")
        return
    
    try:
        print("📱 Web tabanlı arayüz yükleniyor...")
        
        # Get the HTML content
        html = get_html()
        
        # Create API instance
        api = API()
        
        # Create webview window with minimal parameters
        print("🔧 Webview penceresi oluşturuluyor...")
        webview.create_window(
            'RISC-V Log Comparator',
            html=html,
            js_api=api,
            width=1200,
            height=900
        )

        # Start webview
        print("▶️  Webview başlatılıyor...")
        webview.start(debug=False)
        
    except Exception as e:
        print(f"❌ PyWebView hatası: {e}")
        print(f"🔍 Hata detayı: {type(e).__name__}: {str(e)}")
        
        # Fallback to tkinter
        try:
            print("\n🔄 Tkinter GUI'ye geçiliyor...")
            import risc_v_gui_comparator
            app = risc_v_gui_comparator.RISCVLogComparatorGUI()
            app.run()
        except Exception as fallback_error:
            print(f"❌ Fallback GUI de başlatılamadı: {fallback_error}")

if __name__ == '__main__':
    main()
