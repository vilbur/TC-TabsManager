#NoEnv
#SingleInstance Force
#Persistent
SetBatchLines, -1
SetTitleMatchMode, 2

script_version := "0.02"
timer_paused := false
watch_interval_ms := 200

global tc_titles := {}

recordTotalCommanderTitles()

SetTimer, watchTotalCommanderTitlesTimer, %watch_interval_ms%
return


watchTotalCommanderTitlesTimer:
watchTotalCommanderTitles()
return


/*
Record titles of all currently open Total Commander windows.

Each title is stored by the window's unique HWND.
*/
recordTotalCommanderTitles()
{
    global tc_titles

    tc_titles := {}

    WinGet, tc_window_list, List, ahk_class TTOTAL_CMD

    Loop, %tc_window_list%
    {
        tc_window_id := tc_window_list%A_Index%

        WinGetTitle, tc_window_title, ahk_id %tc_window_id%

        if (tc_window_title != "")
        {
            tc_titles[tc_window_id] := tc_window_title
        }
    }

    recorded_count := tc_titles.Count()

    TrayTip, Total Commander Title Lock, % "Recorded " recorded_count " Total Commander window title(s).", 3, 1
}


/*
Restore every recorded Total Commander title.

Closed windows and reused HWND values are removed from the list.
*/
watchTotalCommanderTitles()
{
    global tc_titles

    removed_window_ids := []

    for tc_window_id, recorded_title in tc_titles
    {
        if !WinExist("ahk_id " . tc_window_id)
        {
            removed_window_ids.Push(tc_window_id)
            continue
        }

        WinGetClass, current_window_class, ahk_id %tc_window_id%

        if (current_window_class != "TTOTAL_CMD")
        {
            removed_window_ids.Push(tc_window_id)
            continue
        }

        WinGetTitle, current_title, ahk_id %tc_window_id%

        if (current_title != recorded_title)
        {
            WinSetTitle, ahk_id %tc_window_id%,, %recorded_title%
        }
    }

    for removed_index, removed_window_id in removed_window_ids
    {
        tc_titles.Delete(removed_window_id)
    }
}


/*
Re-record all currently open Total Commander titles.

Press Ctrl+Alt+R after opening another Total Commander window.
*/
^!r::
recordTotalCommanderTitles()
return


/*
Test restoration on the active Total Commander window.

The temporary title should be restored within 200 milliseconds.
*/
^!t::
WinGetClass, active_window_class, A

if (active_window_class = "TTOTAL_CMD")
{
    WinSetTitle, A,, TEMPORARY TEST TITLE
}
return


/*
Pause or resume automatic title restoration.

Uses explicit timer On and Off states for AutoHotkey v1 compatibility.
*/
^!p::
if (timer_paused)
{
    SetTimer, watchTotalCommanderTitlesTimer, On
    timer_paused := false
    TrayTip, Total Commander Title Lock, Title restoration resumed., 2, 1
}
else
{
    SetTimer, watchTotalCommanderTitlesTimer, Off
    timer_paused := true
    TrayTip, Total Commander Title Lock, Title restoration paused., 2, 1
}
return
