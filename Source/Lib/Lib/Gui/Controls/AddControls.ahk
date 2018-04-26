/** Create controls
 *
 */
Class AddControls Extends GuiControl
{
	TabsetTabs := {}

	static _LB_WIDTH := " w164 "
	
	static _LB_HEIGHT	:= " h164 "
	
	_Tooltips	:= {Listbox:	{Tabfile:	""
			,TabsGroup:	""
			,Folder:	""
			,TabsetRoot:	""}}	
	/**
	 */
	_addControls()
	{
		this._gui.controls.layout("row")
		
		this._addTabsetControls()
		this._addOptions()
		
		this._gui.controls.section()
		this._addTabs()
		
		this._gui.controls.section()		
		this._addPaneLookUp()		
		this._addMainButtons()
	}
	
	/**
	 */
	_addTabsetControls()
	{
		this._gui.controls
			.Dropdown( "Add|Rename|Remove" )
				.checked( this.Tabset(this._tab.name).get("last_tabsgroup") )
				.callback( &this "._DD_Changed", "tabSet" )
				.tooltip("test")
				.options( "w64" )
				.tooltip("Tabset action")
				.add("DD_tabset")
	}
	/*---------------------------------------
		OPTIONS
	-----------------------------------------
	*/
	/**
	 */
	_addOptions()
	{
		this._gui.controls
			.GroupBox( "Window Options" ).options( "y-10 h16" ).add("GB_WinOptions")
				this._optionCheckbox( "on_top", "On Top", "Set window always on top", "y-8" )
				this._optionCheckbox( "center_window", "Center", "Center Tabs manager to Total Commander" )
			
			.GroupBox( "Loading" ).add("GB_Loading")
				.Dropdown( "Active||left|right" )
					.checked( this._getOption("active_pane") )
					.options( "x-2 y-8 w64" )
					.callback( &this "._setOption", "active_pane" )
					.tooltip("Where active tabs will be loaded.`nIf *.tab file has both sides")
					.add("DD_option_activePane")
					
				this._optionCheckbox( "title", "Title", "Set tabs name as title of Total Commander" )
				this._optionCheckbox( "exit_onload", "Exit", "Exit after load" )	
	}
	/**
	 */
	_optionCheckbox( $name, $label, $tooltip:="", $options:="" )
	{
		return % this._gui.controls
			.Checkbox($label)
				.options( "w64 " $options )
				.checked( this._getOption($name) )
				.callback( &this "._setOption", $name )
				.tooltip($tooltip)
				.add("CBX_" $name)
	}
	/*---------------------------------------
		TABS
	-----------------------------------------
	*/
	/**
	 */
	_addTabs()
	{
		IniRead, $active_tab, %$ini_path%, tabset, last 
		
		$tabsets_names	:= this.Tabsets()._getTabfilesNames()

		this._Tabs	:= this._gui.Tabs( $tabsets_names )
						.checked($active_tab)
						.callback( &this "._TabsChanged" ) 
						.add("Tabs_Tabsets")
						.get()
						
		;Dump($tabsets_names, "tabsets_names", 1)
		
		For $i, $Tab in this._Tabs.Tabs
			this.TabsetTabs[$Tab.name()] := new TabControl( $Tab )
													.TabsManager(this.TabsManager())
													.addControls()
		
	}

	/*---------------------------------------
		LOOKUP
	-----------------------------------------
	*/
	/**
	 */
	_addPaneLookUp()
	{
		this._gui.Controls.GroupBox().options("y-18").add("MainButtons")
		
		For $pane, $style in {"left":"cGreen", "right":"cBlue"}
		{
			this.Gui()._setFont( "s8", $style  )
			this._gui.Controls.Text()
					.options(" w268 h40 top " ($i==1?"y-10":"")  )
					.add("TEXT_pane_" $pane )
		}
								
		this.Gui()._resetFont()
	} 

	/*---------------------------------------
		MAIN CONTROLS BELLOW TABS
	-----------------------------------------
	*/
	/** 
	 */
	_addMainButtons()
	{
		this._gui.Controls
			.section()
			;.GroupBox().layout("row").add("MainButtons")
				.Button()
					.callback( this._Parent ".loadTabs" )
					.options("h48 w440")
					.submit("Load")
				.Button()
					.callback( this._Parent ".loadTabs" )
					.options("w96 h48")
					.exit("Exit")
					
				;.Button()
					;.callback( &this "._BTN_TEST" )
					;;.options("w96 h48")
					;.add("TEST")		
	}

	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/** Add styled groupbox
	 */
	_GroupBox( $name, $label:="", $layout:="row")
	{
		MsgBox,262144,, AddControls._GroupBox(),2 
		;this._setFont()
		;
		;$options := this._tab.name=="_Tabs"	? ($name=="TabsGroup" ? "y+64 " : "") "x+64" : ""	
		;
		;$GroupBox	:= this._tabControls()
		;			 .GroupBox( $label ? $label : $name )
		;				.layout($layout)
		;				.options( $options )
		;				.add("GB_" $name)
		;
		;this._resetFont()
		;
		;return $GroupBox
	}
	/**
	 */
	_addDropdown( $name, $items:="Add|Rename|Remove", $options:="x+78" )
	{
		MsgBox,262144,, AddControls._addDropdown(),2 
		;return % this._tabControls()
		;				.Dropdown( $items )
		;					;.options("x+78 y-24 w72 " $options)
		;					.options("y-24 w72 " $options)							
		;					;.options($options)							
		;					.callback( &this "._DD_Changed", $name ) 
		;					.add("DD_" $name)
	}
	/**
	 */
	_tabControls()
	{
		return this._Tabs.Tabs[this._tab.index].Controls
	} 



}


