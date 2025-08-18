# Manim SVG Animator (AutoHotkey v2)

Manim SVG Animator is an AutoHotkey v2 script that automates the animation of SVG files using [Manim](https://www.manim.community/). With a simple hotkey, you can select an SVG file in Windows Explorer and instantly generate an animated video using Manim.

## Features
- Automates SVG animation with Manim
- Easy hotkey integration (Ctrl + Alt + M)
- Automatically generates and runs Python scripts
- Moves the rendered video to the SVG's folder and opens it

## Requirements
- [AutoHotkey v2](https://www.autohotkey.com/download/ahk-v2)
- [Python 3.8+](https://www.python.org/downloads/)
- [Manim Community Edition](https://docs.manim.community/en/stable/installation.html)

## Installation
1. **Install AutoHotkey v2**
   - Download and install from [here](https://www.autohotkey.com/download/ahk-v2).
2. **Install Python (recommended: 3.8+)**
   - Download and install from [here](https://www.python.org/downloads/).
3. **Install Manim**
   - Open a terminal and run:
     ```powershell
     pip install manim
     ```
   - See the [official installation guide](https://docs.manim.community/en/stable/installation.html) for details.
4. Place `manim.ahk` in a convenient location and run it with AutoHotkey v2.
5. (Optional) Add a shortcut to the script in your shell:startup folder for autostart.

## Usage
1. Open Windows Explorer and select an SVG file.
2. Press **Ctrl + Alt + M**.
3. The script will:
   - Copy the selected SVG path
   - Generate a Python script for Manim
   - Render the animation
   - Move the resulting `.mp4` to the SVG's folder
   - Open the video file automatically

## Troubleshooting
- Make sure all requirements are installed and available in your PATH.
- If Manim fails to render, check the terminal for errors and verify your Python/Manim installation.
- The script only works when an SVG file is selected in **Windows Explorer**.
