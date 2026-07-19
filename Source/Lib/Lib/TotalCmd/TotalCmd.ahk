/** Class Gui
 *
 */
Class TotalCmd Extends Parent
{
	_TcPane 	:= new TcPane()
	_TcTabs 	:= new TcTabs()
	_tc_has_focus	:= false
	_wincmd_ini	:= ""

	__New()
	{
		$wincmd_ini	= %Commander_Path%\wincmd.ini
		this._wincmd_ini	:= $wincmd_ini
	}

	/**
	 */
	activePane($side:="")
	{
		return % this._TcPane.activePane($side)
	}

	/**
	 */
	getDir($pane:="source")
	{
		;$path := $pane=="source" ? this._TcPane.getSourcePath() : this._TcPane.getTargetPath()
		$path := this._TcPane.getPath( $pane )
		;$path := this._TcPane.getPath( $pane =="source"?"source":"target" )

		SplitPath, $path, $dir_name

		return $dir_name
	}

	/*---------------------------------------
		TABS
	-----------------------------------------
	*/

	/** get curretn tabs from ini
	 */
	getTabs( $side )
	{
		$tabs := this._TcPane.TcTabs().getTabs($side)

		return % this.stringifyTabs($tabs) "activetab=" $tabs.activetab
	}

	/**
	 */
	stringifyTabs($tabs)
	{
		For $index, $tab in $tabs
			$tabs_string .= this.stringifySingleTab($index, $tab)

		return % $tabs_string
	}

	/**
	 */
	stringifySingleTab($index ,$tabs)
	{
		For $key, $value in $tabs
			$string .= $index "_" $key "=" $value "`n"

		return $string
	}

	/** Set Total commander window title by loaded tabs
	  * IF TABSGROUP DEFINED:
	  *		"Tabs-Group: TabFile"
	  *
	  * IF TABS ARE SHARED:
	  *		"Root-Folder: TabFile"
	 */
	_setWindowTitleByTabs($data)
	{
		;MsgBox,262144,variable, % $data.tabfile,3
		;MsgBox,%A_ScriptDir%\Lib\Lib\WintTitleKeeper\WintTitleKeeper.ahk
		
		$commander_win := this._TcPane.ahkId()
		
		;WinGetTitle, current_title, %$commander_win%
		
		Sleep, 100

		WinWait, %$commander_win%

		;sleep, 1000
		
		$title := ( $data.tabsgroup != "_shared" ? $data.tabsgroup : $data.folder ) ": " $data.tabfile
		;$title := $data.tabfile
		
		WinSetTitle, %$commander_win%,, %$title%
		
		Run, %A_ScriptDir%\Lib\Lib\WintTitleKeeper\WintTitleKeeper.ahk
	}
}

