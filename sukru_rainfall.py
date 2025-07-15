#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ŞÜKRÜ Rainfall Effect Script
Creates a matrix-style rainfall with ŞÜKRÜ text
"""

import random
import time
import os
import sys

def clear_screen():
    """Clear the terminal screen"""
    os.system('cls' if os.name == 'nt' else 'clear')

def sukru_rainfall():
    """Create a rainfall effect with ŞÜKRÜ text"""
    
    # Terminal dimensions
    try:
        columns = os.get_terminal_size().columns
        rows = os.get_terminal_size().lines
    except:
        columns = 80
        rows = 24
    
    # Initialize drops
    drops = []
    text = "ŞÜKRÜ"
    
    # Create random starting positions for drops
    for _ in range(columns // 6):  # Spacing out the drops
        drops.append({
            'x': random.randint(0, columns - len(text)),
            'y': random.randint(-rows, 0),
            'speed': random.uniform(0.5, 2.0)
        })
    
    print("🌧️  ŞÜKRÜ RAINFALL EFFECT 🌧️")
    print("Press Ctrl+C to stop\n")
    time.sleep(2)
    
    try:
        while True:
            clear_screen()
            
            # Create a screen buffer
            screen = [[' ' for _ in range(columns)] for _ in range(rows)]
            
            # Update and draw drops
            for drop in drops:
                # Place ŞÜKRÜ at current position
                y = int(drop['y'])
                x = drop['x']
                
                if 0 <= y < rows and 0 <= x < columns - len(text):
                    for i, char in enumerate(text):
                        if x + i < columns:
                            screen[y][x + i] = char
                
                # Add trail effect (fading ŞÜKRÜ above)
                for trail in range(1, 4):
                    trail_y = y - trail
                    if 0 <= trail_y < rows and 0 <= x < columns - len(text):
                        fade_chars = ['░', '▒', '▓']
                        fade_char = fade_chars[min(trail - 1, len(fade_chars) - 1)]
                        for i in range(len(text)):
                            if x + i < columns and screen[trail_y][x + i] == ' ':
                                screen[trail_y][x + i] = fade_char
                
                # Update drop position
                drop['y'] += drop['speed']
                
                # Reset drop if it goes off screen
                if drop['y'] > rows + 5:
                    drop['y'] = random.randint(-rows, -1)
                    drop['x'] = random.randint(0, columns - len(text))
                    drop['speed'] = random.uniform(0.5, 2.0)
            
            # Print the screen
            for row in screen:
                print(''.join(row))
            
            time.sleep(0.1)  # Control animation speed
            
    except KeyboardInterrupt:
        clear_screen()
        print("\n🌈 ŞÜKRÜ Rainfall stopped! 🌈")
        print("Thanks for watching the show! 🎭")

if __name__ == "__main__":
    sukru_rainfall()
