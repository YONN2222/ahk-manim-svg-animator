; #####################################################################################
; # Manim SVG Animator - AHK v2 (Version 2.1)                                         #
; #                                                                                   #
; # Automates the animation of SVG files with Manim                                   #
; #                                                                                   #
; # Usage:                                                                            #
; #   Select an SVG file in Windows Explorer and press Ctrl + Alt + M                 #
; #                                                                                   #
; # Requirements:                                                                     #
; #   - AutoHotkey v2                                                                 #
; #   - Python (recommended: 3.8+)                                                    #
; #   - Manim (https://www.manim.community/)                                          #
; #                                                                                   #
; # Tip: Place a shortcut to this script in your shell:startup folder for autostart.  #
; #                                                                                   #
; # License: MIT                                                                      #
; #####################################################################################

#Requires AutoHotkey v2.0
#SingleInstance force
#Warn LocalSameAsGlobal, Off

^!m::
{
    if not WinActive("ahk_class CabinetWClass") and not WinActive("ahk_class ExploreWClass")
    {
        MsgBox("Please select an SVG file in the File Explorer first.", "Error", 48)
        return
    }

    Clipboard_Backup := ClipboardAll()
    A_Clipboard := ""
    Send("^c")
    
    if !ClipWait(1)
    {
        MsgBox("No file was selected or the copy operation took too long.", "Error", 48)
        A_Clipboard := Clipboard_Backup
        return
    }
    
    SelectedFilePath := A_Clipboard
    A_Clipboard := Clipboard_Backup

    if not RegExMatch(SelectedFilePath, "\.svg$")
    {
        MsgBox("The selected file is not an SVG file.`n`nSelected: " . SelectedFilePath, "Error", 48)
        return
    }

    SplitPath(SelectedFilePath, , &OutDir, , &OutNameNoExt)
    
    PythonReadyPath := StrReplace(SelectedFilePath, "\", "\\")
    
    ; Generate Python script for Manim
    ManimPythonCode := "from manim import *" . "`n"
    ManimPythonCode .= "class SvgAnimationFromAhk(Scene):" . "`n"
    ManimPythonCode .= "    def construct(self):" . "`n"
    ManimPythonCode .= "        m = SVGMobject(r'" . PythonReadyPath . "')" . "`n"
    ManimPythonCode .= "        t = Text('" . OutNameNoExt . "').next_to(m, DOWN)" . "`n"
    ManimPythonCode .= "        self.play(Write(m, run_time = 2), Write(t))" . "`n"
    ManimPythonCode .= "        self.wait(2)"

    TempPythonFile := A_Temp . "\temp_manim_script.py"
    try
    {
        File := FileOpen(TempPythonFile, "w", "UTF-8")
        File.Write(ManimPythonCode)
        File.Close()
    }
    catch
    {
        MsgBox("Error writing the temporary Python file.", "Error", 16)
        return
    }

    ; Run Manim to render the animation
    RunWait('py -m manim -qh "' . TempPythonFile . '" SvgAnimationFromAhk')

    ManimClassName := "SvgAnimationFromAhk"
    SplitPath(TempPythonFile, , , , &TempPythonFileNameNoExt)
    SourceFile := A_ScriptDir . "\media\videos\" . TempPythonFileNameNoExt . "\1080p60\" . ManimClassName . ".mp4"
    DestinationFile := OutDir . "\" . OutNameNoExt . ".mp4"

    if FileExist(SourceFile)
    {
        FileMove(SourceFile, DestinationFile)
        ; Open the video file with the default player
        Run(DestinationFile) 
    }
    else
    {
        MsgBox("Could not find the expected file.`n`nSearched in: " . SourceFile . "`n`nDid Manim show an error?", "Error", 48)
    }
}