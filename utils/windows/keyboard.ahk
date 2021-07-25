#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; Swap windows and ctrl keys
LWin::LCtrl
LCtrl::LWin

; Swap menu and right ctrl
AppsKey::RCtrl
RCtrl::AppsKey

CapsLock::Esc
Esc::`

return