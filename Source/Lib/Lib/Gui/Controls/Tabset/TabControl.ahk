/** Tabset
 *
 */
Class TabControl extends TabControlMethods
{
	_Tab	:= {}
	_Tabset	:= {}	
	
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
		this._Tab.Controls.layout("row")

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
		;if( this._Tabset.getIniValue("options", "unique") )
			;return
			
		this._GroupBox( "TabsetRoot" )
		this._ListBox( "TabsetRoot",this._Tabset.getTabsRootsPaths(), this._Tabset.getLast("root"), "w520 h96" )
		this._addDropdown("TabsetRoot", "Add|Remove|Unique", "x-92 y-24")
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
		;if( this._Tabset.getIniValue("options", "unique") )
			;return
		
		$root_last	:= this._Tabset.getLast("root")
		$tab_folders	:= this._tabsgroup_last=="_shared" ? this._Tabset._getTabsRootFolders($root_last) : ""

		this._GroupBox("Folders", "Folders in root")
		this._ListBox("Folder"
					  ,$tab_folders
					  ,this._Tabset.getLastFolder($root_last)
					  ,"y+8" )
		

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
				.callback( &this "._R_replaceChanged" )
				.options("x+8 w72 h30")
				.checked( this._tabsgroup_last=="_shared"?1:0 )
				;.checked( this._tabsgroup_last )				
				.add("R_replace")
		.section()
			this._ListBox("TabsGroup"
						  ,this._Tabset._getTabsGroupsNames()
						  ,this._tabsgroup_last
						  ,"h128" )
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
			this._ListBox("Tabfile"
						  ,this._Tabset.getTabsGroup( this._tabsgroup_last!=1 ? this._tabsgroup_last : "_shared" ).getTabFilenames()
						  ,this._Tabset.getLast("tabfile")
						  ,"x-78" )

		.GroupEnd()
	}
	
	/*---------------------------------------
		ADDING CONTROL BY TYPE
	-----------------------------------------
	*/
	/** Add styled groupbox
	 */
	_GroupBox( $name, $label:="", $layout:="row")
	{
		this.Gui()._setFont()
		;$options := this._tab.name=="_Tabs"	? ($name=="TabsGroup" ? "y+64 " : "") "x+64" : ""	

		$GroupBox	:= this._Tab.Controls
					 .GroupBox( $label ? $label : $name )
						.layout($layout)
						.options( $options )
						.add("GB_" $name)
	
		this.Gui()._resetFont()
		
		return $GroupBox
	}
	/**
	 */
	_ListBox( $name, $items, $checked, $options:="" )
	{
		$ListBox := this._Tab.Controls.ListBox( $items )
						.checked( $checked )					
						.callback( &this "._LB_Changed", $name )
						.options("-Multi" this._LB_WIDTH this._LB_HEIGHT " " $options)
						.add("LB_" $name)
						.get()

		$ListBox.setItemHeight(1, 18)
			
		return this._Tab.Controls
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
	

	
	
}