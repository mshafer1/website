#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


AlertTime := 10 ; in minutes



SetTitleMatchMode, 2

GroupAdd, distractions, YouTube
GroupAdd, distractions, YouTube - Google Chrome ahk_exe chrome.exe
GroupAdd, distractions, YouTube ahk_exe firefox.exe
GroupAdd, distractions, Neflix
GroupAdd, distractions, Neflix - Google Chrome ahk_exe chrome.exe
GroupAdd, distractions, Neflix ahk_exe firefox.exe

; convert from minutes to seconds
AlertTime := AlertTime * 60

Loop, 
{
	; wait indefinitely for one of the windows to get focus
    WinWaitActive, ahk_group distractions
    
    ; wait for the window to lose focus - tiemout after AlertTime*60 seconds
    WinWaitNotActive, ahk_group distractions,, %AlertTime%

    ; If wait for it to lose focus timed out,
    if ErrorLevel
    {
    	; Create a centered message box to ask if there's somehting else I should be doing
        OnMessage(0x44, "Center_MsgBox")
        MsgBox, 4096, Is there something else you need to be doing?, Hey`, you've been watching youtube for a bit . . ., 30
    }
}


; from https://www.autohotkey.com/boards/viewtopic.php?p=42603&sid=15ab5b2d8380033e6295f2cf772adae7#p42603
Center_MsgBox(P)
{
	if (P = 1027) 
	{
		if WinExist("ahk_group distractions") ; Window to Center In
		{
			WinGet, State, MinMax
			if !(State = -1)
			{
				WinGetPos, eX, eY, eW, eH
				Process, Exist
				DetectHiddenWindows, On
				if WinExist("ahk_class #32770 ahk_pid " ErrorLevel)
				{
					WinGetPos,,,mW,mH
					WinMove, (eW-mW)/2 + eX, (eH-mH)/2 + eY
				}
                DetectHiddenWindows, Off
			}
		}
	}
}