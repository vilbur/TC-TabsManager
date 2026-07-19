#NoEnv
#SingleInstance Force

target_script := A_ScriptDir "\..\TabsManager.ahk"

arg_1 := "_Tabs"
arg_2 := "Test" 
arg_3 := "test-tabset"

command_line := """" A_AhkPath """"
    . " """ target_script """"
    . " """ arg_1 """"
    . " """ arg_2 """"
    . " """ arg_3 """"

Run, % command_line