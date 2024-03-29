#Include %A_LineFile%\..\includes.ahk

/** Class TabsManager
*/
Class TabsManager Extends Accessors
{
	_Tabsets	:= new Tabsets().TabsManager(this)
	_TargetInfo	:= new TargetInfo()	
	_Gui	:= new Gui().TabsManager(this)
	_Install 	:= new Install()
	_PathsReplacer 	:= new PathsReplacer()
	_MsgBox 	:= new MsgBox()
	_TotalCmd 	:= new TotalCmd().TabsManager(this)

	__New()
	{
		$TabsManager := this

		If ( ! FileExist( $ini_path ))
			MsgBox,262144,, Test,2 		
			;this.install()
			
		this._Tabsets.loadTabsets()
		this._TargetInfo.findCurrentTabset( this._Tabsets )

		;Dump(this._Tabsets, "this._Tabsets", 0)
		;Dump(this._TargetInfo, "this._TargetInfo", 0)		
		;Dump(this._Tabsets._Tabsets.Tabs, "this._Tabsets._Tabsets.Tabs", 1)
		;Dump(this._Tabsets._Tabsets.Users, "this._Tabsets._Tabsets.Users", 1)				
	}

	/** createGui
	*/	
	createGui()
	{
		if( ! this._Tabsets.tabsetsExists())
			new Example().parent(this).createExample()

		this._Gui.createGui()
	}
	
	/**
	 */
	install()
	{
		;new TabsLoader().createCommandRunTabSwitcher( $path )
		this._Install
				.createCommands()
				.createIniFile()						
				.createTabsFolder()
	}
	
	/** get all unique files from all ini files
	 */
	_getAllUniqueFiles()
	{
		MsgBox,262144,, TabsManager._getAllUniqueFiles() `n unused method,2 
		;$unique_files := []
		;For $i, $Tabfiles in this._Tabsets._Tabsets
		;	$unique_files.insert($Tabfiles.get("unique_file"))
		;;Dump($unique_files, "unique_files", 1)
		;return % $unique_files 
	} 

	/** Load Tabs file or go to target root folder
	  *
	  * Go to target root path if user try to load "_shared" tabs directly and current path is not in target
	  *		E.G.: if A_WorkingDir == "C:\foo\folder" and try to load tabs to "C:\program\files"  then go to "C:\program\files"
	  *
	  */
	loadTabs($tabset:="", $tabsgroup:="", $tabfile:="")
	{
		;MsgBox,262144,tabset, %$tabset%,3 
		;MsgBox,262144,tabsgroup, %$tabsgroup%,3 
		;MsgBox,262144,tabfile, %$tabfile%,3 
		
		$data	:= this._getData( $tabset, $tabsgroup, $tabfile )
		$Tabset	:= this.Tabset($data)
		$path_tab_file	:= this.Tabfile($data).getPath()
		$target_folder	:= $data.folder ? $data.folder : this.TargetInfo().get( "folder_current" )
		
		;MsgBox,262144,data.tabsetroot, % $data.tabsetroot,3 
		;MsgBox,262144,data.tabset, % $data.tabset,3 
		;MsgBox,262144,data.tabsgroup, % $data.tabsgroup,3 
		;MsgBox,262144,data.tabfile, % $data.tabfile,3
		
		;MsgBox,262144,path_tab_file, %$path_tab_file%

		
		/* GO TO PATH
		*/
		;if( $tabfile && ! $Tabset.isPathInTarget( A_WorkingDir ) )
			;this._goToTargetRoot( $Tabset.pathTarget() )
		
		/* REPLACE SHARED TABS
		*/
		if( $data.replace )
			this._PathsReplacer.clone()
					.pathTabFile( $path_tab_file )
					.searchRoots( $Tabset.getTabsRootsPaths() )
					.replaceRoot( $data.tabsetroot )
					.searchFolders( $Tabset.getTabsRootFoldersAll()  )
					.replaceFolder( $data.folder )
					.replace( $data.replace )
				
		this.Tabset($data).saveLastToIni( $data )
		
		/* LOAD TAB FILE
		*/
		this._TotalCmd._TcTabs.load( $path_tab_file, this._Gui._getOption("active_pane") )		

		if( this._Gui._getOption("title") )
			this._TotalCmd._setWindowTitleByTabs($data)
		
		this._saveLastTabsetRoot()
		
		if( this._Gui._getOption("exit_onload") )
			ExitApp
	}
	
	/** open *.tab file
	 */
	openTabs( $Event:="" )
	{
		$data	:= this._getData( $tabset, $tabsgroup, $tabfile )
		
		$path_tab_file	:= this.Tabfile( $data ).getPath()
		
		Run, Notepad++ %$path_tab_file%
	}
	
	/** get data object from gui or params
	 */
	_getData( $tabset:="", $tabsgroup:="", $tabfile:="" )
	{
		if( ! $tabset && ! $tabsgroup && ! $tabfile )
			return % this._gui._getGuiData()
	
		return %	{"tabsetroot":	$tabset
			,"tabset":	$tabset
			,"tabsgroup":	$tabsgroup
			,"tabfile":	$tabfile}
	}
	
	/**
	 */
	_goToTargetRoot( $path )
	{
		WinGet, $process_name , ProcessName, ahk_class TTOTAL_CMD
		Run, %COMMANDER_PATH%\%$process_name% /O /S /L=%$path%
		exitApp
	}
	
	/**
	 */
	_saveLastTabsetRoot()
	{
		IniWrite, % this._Gui._getActiveTab().tab_num, %$ini_path%, last, tabs
	} 

	/** set\get parent class
	 * @return object parent class
	*/
	TabsManager(){
		return this
	}

}


/** 
*/
loadTabsCallback($Event)
{
	$TabsManager.loadTabs($Event)
}	










