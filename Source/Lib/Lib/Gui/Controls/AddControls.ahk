/** Create controls
 *
 */
Class AddControls Extends GuiControl
{
	TabsetTabs := {}

	static _LB_WIDTH := " w164 "
	
	static _LB_HEIGHT	:= " h164 "
	
	_Tooltips	:= {Dropdown:	{active_pane:	"Where active tabs will be loaded.`nOnly if *.tab file has both sides."}
		,Checkbox:	{on_top:	"Set window always on top"
			,center_window:	"Center Tabs manager to Total Commander"
			,title:	"Set tabs name as title of Total Commander"			
			,exit_onload:	"Exit after load"}}	
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
				this._optionCheckbox( "on_top", "On Top", "y-8" )
				this._optionCheckbox( "center_window", "Center" )
			
			.GroupBox( "Loading" ).add("GB_Loading")
				.Dropdown( "Active||left|right" )
					.checked( this._getOption("active_pane") )
					.options( "x-2 y-8 w64" )
					.callback( &this "._setOption", "active_pane" )
					.tooltip(this._Tooltips.Dropdown["active_pane"])
					.add("DD_option_activePane")
					
				this._optionCheckbox( "title", "Title" )
				this._optionCheckbox( "exit_onload", "Exit" )	
	}
	/**
	 */
	_optionCheckbox( $name, $label, $options:="" )
	{
		return % this._gui.controls
			.Checkbox($label)
				.options( "w64 " $options )
				.checked( this._getOption($name) )
				.callback( &this "._setOption", $name )
				.tooltip(this._Tooltips.Checkbox[$name])
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
						
		
		For $i, $Tab in this._Tabs.Tabs
			this.TabsetTabs[$Tab.name()] := new TabControl( $Tab )
													.TabsManager(this.TabsManager())
													.addControls()

		this._selectLastTab()
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
				.Button()
					.callback( this._Parent ".loadTabs" )
					.options("h48 w440")
					.submit("Load")
				.Button()
					.callback( this._Parent ".loadTabs" )
					.options("w96 h48")
					.exit("Exit")
					
				;.Button()
				;	.callback( &this "._TEST" )
				;	.options("w96 h48")
				;	.submit("Test")

	}

	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/

	/**
	 */
	_tabControls()
	{
		return this._Tabs.Tabs[this._tab.index].Controls
	} 
	/**
	 */
	_tooltip( $control_type, $name )
	{
		return % this._Tooltips[$control_type][$name]
	}
	/**
	 */
	_selectLastTab()
	{
		IniRead, $last_tab, %$ini_path%, last, tabs, 1
		
		this._Tabs.select($last_tab)
	} 


}


