﻿/** Class Install
*/
Class Install
{
	/**
	 */
	__New()
	{
		this.createCommands()
		this.createIniFile()		
	}
	
	
	createCommands()
	{
		new TcCommandCreator()
				.name("Open")
				.prefix("TabsManager")
				.cmd( A_ScriptFullPath )
				.icon( A_ScriptDir "\Icons\tab-switcher.ico" )			
				.create()
	}
	
	/**
	 */
	createIniFile()
	{
		this._setPathToTabsFolder()
		return this
	}
	/**
	 */
	_setPathToTabsFolder()
	{
		$tabs_path := A_ScriptDir "\_tabsets"
		IniWrite, %$tabs_path%, %$ini_path%, paths, tabs_path
	} 
	/**
	 */
	createTabsFolder()
	{
		FileCreateDir, %$tabs_path%
		return this				
	}
	
	
	
}
