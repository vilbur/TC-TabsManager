/** Tabset
 *
 */
Class TabControl extends TabControlMethods
{
	_index	:= 0
	static _LB_WIDTH	:= " w164 "
	static _LB_HEIGHT	:= " h164 "
	
	/**
	 */
	__New( ByRef $Tab )
	{
		this._Tab	:= $Tab
		
		this._Tabset	:= this.Tabset($Tab.name())
	}
	/**
	 */
	addControls()
	{
		this._tabsgroup_last	:= this._Tabset.getLast("tabsgroup")
		this._last_root	:= this._Tabset.getLast("root")	
		
		;Dump(this._Tabset, "this._Tabset", 1)
		this._addTargetRoot()
		this._tabControls().layout("row")

		this._addFoldersSection()
		this._addTabsGroupSection()				
		this._addTabfileSection()
		
		return this  
	} 
	/*---------------------------------------
		TARGET ROOT
	-----------------------------------------
	*/
	/**
	 */
	_addTargetRoot()
	{		
		;if( $Tabset.getIniValue("options", "unique") )
			;return
			
		this._GroupBox( "TabsetRoot" )
			.ListBox( this._Tabset.getTabsRootsPaths() )
				;.checked( $Tabset.getLast("root") )					
				.callback( &this "._LB_TabsetRootChanged" )
				.options("w520 h64 -Multi")
				.add("LB_TabsetRoot")
			
			this._addDropdown("TabsetRoot", "Add|Remove", "x-92 y-24")
		.section()
	}

	/*---------------------------------------
		ROOT FOLDERS
	-----------------------------------------
	*/
	/** Add folders in target root
	  * not showed if unique tabs
	 */
	_addFoldersSection()
	{		
		;if( $Tabset.getIniValue("options", "unique") )
			;return
		
		$root_last	:= this._Tabset.getLast("root")
		$tab_folders	:= this._tabsgroup_last=="_shared" ? this._Tabset._getTabsRootFolders($root_last) : ""

		this._GroupBox("Folders", "Folders in root")
				.ListBox( $tab_folders )
					.checked( this._Tabset.getLastFolder($root_last) )					
					.callback( &this "._LB_FolderChanged" )
					.options("y+8 -Multi " this._LB_WIDTH this._LB_HEIGHT)
					.add("LB_Folder")
	} 
	/*---------------------------------------
		TABSGROUP
	-----------------------------------------
	*/
	/**
	 */
	_addTabsGroupSection()
	{
		this._GroupBox("TabsGroup" )
			this._addDropdown("TabsGroup")
			
		.section()
		
			.Radio()
				.items(["Root","Folder"])
				;.callback( &this "._R_replaceChanged" )
				.options("x+8 w72 h30")
				.checked( this._tabsgroup_last=="_shared"?1:0 )
				;.checked( this._tabsgroup_last )				
				.add("R_replace")
		.section()
			.ListBox( this._Tabset._getTabsGroupsNames() )
		;		;.checked( this._tabsgroup_last!="_shared" ? this._tabsgroup_last : 0 )					
		;		.checked( this._tabsgroup_last )				
				.callback( &this "._LB_TabsGroupChanged" )
				.options("h128 -Multi " this._LB_WIDTH)
				.add("LB_TabsGroup")
	}
	/*---------------------------------------
		TABS FILES
	-----------------------------------------
	*/
	/** Add Listbox and other controls
	 */
	_addTabfileSection()
	{
		this._GroupBox("Tabfile", "*.tab files", "column" )
			this._addDropdown("TabFile")

			.ListBox( this._Tabset.getTabsGroup( this._tabsgroup_last!=1 ? this._tabsgroup_last : "_shared" ).getTabFilenames() )
			;	;.checked( this.Tabset(this._tab.name).get("last_tabs") )
				.checked( this._Tabset.getLast("tabfile") )					
				.callback( &this "._LB_TabfileChanged" )
				.options("x-78 -Multi red" this._LB_WIDTH this._LB_HEIGHT)
				.add("LB_Tabfile")
				
			;.section()
		.GroupEnd()
	}
	
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/** Add styled groupbox
	 */
	_GroupBox( $name, $label:="", $layout:="row")
	{
		this._setFont()
		;$options := this._tab.name=="_Tabs"	? ($name=="TabsGroup" ? "y+64 " : "") "x+64" : ""	

		$GroupBox	:= this._Tab.Controls
					 .GroupBox( $label ? $label : $name )
						.layout($layout)
						.options( $options )
						.add("GB_" $name)

		this._resetFont()
		
		return $GroupBox
	}
	/**
	 */
	_addDropdown( $name, $items:="Add|Rename|Remove", $options:="x+78" )
	{
		return % this._Tab.Controls
						.Dropdown( $items )
							;.options("x+78 y-24 w72 " $options)
							.options("y-24 w72 " $options)							
							;.options($options)							
							.callback( &this "._DD_Changed", $name ) 
							.add("DD_" $name)
	}
	
	/**
	 */
	_tabControls()
	{
		return this._Tab.Controls
	}
	
	
	;/*---------------------------------------
	;	PARENT
	;-----------------------------------------
	;*/
	;static _Gui := {"address":""}
	;
	;/** set\get parent class
	; * @return object parent class
	;*/
	;Gui($Gui:=""){
	;	;MsgBox,262144,, Gui,2 
	;
	;	if($Gui)
	;		this._Gui.address	:= &$Gui
	;	return % $Gui ? this : Object(this._Gui.address)
	;}
	;
	
	
}