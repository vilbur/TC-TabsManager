/** TabControlCallbackMethod
 *
 */
Class TabControlCallbackMethod Extends Parent
{
	/*---------------------------------------
		TABSET
	-----------------------------------------
	*/
	/** reate New tabset
	 */
	_tabSetAdd()
	{
		$new_root 	:= this._askPathToRoot()

		if( ! $new_root )
			return
			
		SplitPath, $new_root, $dir_name
			
		$tabset_name := this._MsgBox.Input("SET TABSET NAME", "Name of new tabset" , {"default":$dir_name})
		
		if( $tabset_name )
			this.Tabsets()
				.createTabset( $new_root, $tabset_name )
				.createTabsRoot( $new_root )
				
		Reload
	}
	/**
	 */
	_tabSetRemove()
	{
		$data	:= this.Gui()._getGuiData()
		
		if( this._MsgBox.confirm("REMOVE TABSET", "Remove tabset: " $data.tabset, "no") )
			this.Tabset($data).delete()
			
		Reload
	}
	/*---------------------------------------
		TABSROOT
	-----------------------------------------
	*/
	/**
	 */
	_tabsetRootAdd( $Event, $data )
	{
		this.Tabset( $data.tabset )
			.createTabsRoot( this._askPathToRoot() )
	} 
	/**
	 */
	_tabsetRootRemove( $Event, $data )
	{
		if( this._MsgBox.confirm("REMOVE ROOT", "Remove root ?`n`n" $data.tabsetroot ) )
			this.Tabset( $data.tabset ).removeTabsRoot( $data.tabsetroot )
	}
	/** 
	 */
	_tabsetRootUnique( $Event, $data )
	{
		;$Event.message()
		;MsgBox,262144,, Test,2
		;$Event.control().select()
		$Tabset := this.Tabset( $data.tabset )
		
		if( this._MsgBox.confirm("UNIQUE TABS", "Set tabs to unique mode ?`n`n" $Tabset.name() ) )
			$Tabset.setIniValue("options", "unique", true)
	}
	/*---------------------------------------
		TABSGROUP
	-----------------------------------------
	*/
	/**
	 */
	_tabsGroupAdd($data)
	{				
		$name := $data.folder ? $data.folder : this.TotalCmd().getDir()
		
		$tabsgroup := this.Tabset( $data.tabset )
						.createTabsGroup( this._MsgBox.Input("ADD NEW TABSGROUP", "New tabsgroup name" , {"w":320, "default":$name} ) )
		
		if( $tabsgroup )
			this._LB_add( "LB_TabsGroup", $name )
		
	}
	/**
	 */
	_tabsGroupRemove($data)
	{
		if( this._MsgBox.confirm("REMOVE GROUP", "Remove group ?`n`n" $data.tabsgroup ) )
			this.TabsGroup( $data).delete()

		reload
		
	} 
	/**
	 */
	_tabsGroupUnselect($data)
	{
		this._LB_unselect("LB_TabsGroup")
		this._LB_set( "LB_Folder", this._getTabsRootFolders( $data ), this._getLastSeletedFolder($data) )
		
		$data.tabsgroup := "_shared" 
		this._updateTabfile( $data )
	}
	/**
	 */
	_tabsGroupUpdateGui( $data )
	{
		this._R_replaceUnselect()
		
		this._updateTabfile( $data )
		
		this._LB_set( "LB_Folder" )
		
		this._TEXT_update()
	}
	
	/*---------------------------------------
		TABS FOLDERS
	-----------------------------------------
	*/
	_updateFolderList( $data )
	{
		this._LB_set( "LB_Folder", this._getTabsRootFolders( $data ), this.Tabset( $data.tabset ).getIniValue("roots", $data.tabsetroot) )		
	}
	/**
	 */
	_folderChanged($Event)
	{
		$data	:= this.Gui()._getGuiData()
		;MsgBox,262144,, % $data.tabset,2
		;MsgBox,262144,, % $data.tabsetroot,2
		;MsgBox,262144,, % $data.folder,2 				
		this.Tabset( $data.tabset ).setIniValue("roots", $data.tabsetroot, $data.folder )
	}
	/**
	 */
	_getLastSeletedFolder( $data )
	{
		$last_folder := this._last_state[$data.tabset][$data.tabsetroot]
		
		return % $last_folder ? $last_folder : 1
	} 
	/*---------------------------------------
		TAB FILE
	-----------------------------------------
	*/
	/**
	 */
	_tabFileAdd( $data )
	{
		$active_pane	:= this.TotalCmd().activePane()

		this.new_tabs	:= new VilGUI("AddNewTabs")
		
		this.new_tabs.Controls
		.options("button", "h", 48 )
		.options("Checkbox", "h", 48 ) 		
		.Layout("row")
			.Edit().label("Name of tabs").options("w128").add("tabfile")
				.section()
			.GroupBox("Save Tabs on side").add()
				.Checkbox("Left").options("x+24 w96").checked(InStr($active_pane, "Left" )? 1 : 0).add()
				.Checkbox("Right").options("x+24 w96").checked(InStr($active_pane, "Right")? 1 : 0).add()						
			.section()
				.Button().Submit("Ok")
				.Button().close("Cancel")			
		
		this.new_tabs.Events.Gui
		    .onSubmit( &this ".GUI_AddNewTabsSubmit", $data.tabset, $data.tabsgroup ) 
		    ;.onSubmit("close")
		    .onEscape("close")			
		    .onEnter("submit")
			
		this.new_tabs.create()
	}
	/**
	 */
	_tabFileRename( $data )
	{		
		$new_name := this._MsgBox.Input("RENAME TABS", "New name of tabs" , {"w":256, "default":$data.tabfile})
		
		if( $new_name )
			this.Tabfile($data).rename($new_name)

		;$Tabfile	:= this.Tabfile($data)
	} 
	/**
	 */
	_tabFileRemove()
	{
		$data	:= this.Gui()._getGuiData()

		$tabs_name := $data.tabset " \ " ($data.tabsgroup=="_shared" ? "" : $data.tabsgroup " \ ") $data.tabfile

		if( this._MsgBox.confirm("REMOVE TABS", "Remove tabs ?`n`n" $tabs_name ) )
			this.Tabfile($data).delete()
		
	} 
	/**
	 */
	_tabFileSelected($Event)
	{
		$data	:= this.Gui()._getGuiData()

		this._last_state[$data.tabset][$data.tabsgroup] := $Event.value
	
		this._TEXT_update()

	} 
	/**
	 */
	_updateTabfile( $data )
	{
		$tab_filenames := this.TabsGroup($data).getTabFilenames()
		
		$last_tabfile	:= this._last_state[$data.tabset][$data.tabsgroup]
		
		this._LB_set( "LB_Tabfile", $tab_filenames, ($last_tabfile ? $last_tabfile : 1) )
	}
	
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/**
	 */
	_getTabsRootFolders( $data )
	{
		return % this.Tabset($data)._getTabsRootFolders($data.tabsetroot)
	}
	
}