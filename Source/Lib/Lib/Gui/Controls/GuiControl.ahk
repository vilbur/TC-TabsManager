/** Control controls in Gui
 *
 */
Class GuiControl Extends GuiCallback
{
	_last_selected_folders	:= {}
	_last_listbox	:= {root_tabset:"", folder_tabfile:""} ; last focused control

	/*---------------------------------------
		TAB
	-----------------------------------------
	*/
	/**
	 */
	_getActiveTab()
	{
		;MsgBox,262144,, GuiControl._getActiveTab(),2 
		return % this._gui.Tabs_Tabsets.getActive()
	}
	/*---------------------------------------
		LISTBOX
	-----------------------------------------
	*/
	/** Focus first listbox with items
	 */
	_LB_focusOnInit()
	{
		;MsgBox,262144,, GuiControl._LB_focusOnInit(),2 
		For $i, $lisbox in ["LB_Folder", "LB_Tabfile", "LB_TabsGroup", "LB_TabsetRoot" ]
		{
			$LB := this._getControl($lisbox)
			if( $LB.GetCount() )
				break
		}
		$LB.focus()
	}
	
	/*---------------------------------------
		DROPDOWN
	-----------------------------------------
	*/
	
	/**
	 */
	_DD_Changed($Event, $control_name)
	{		
		this["_" $control_name $Event.value](this._getGuiData())
	}

	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/** get control object from current tab
	 */
	_getControl( $control_name )
	{
		;MsgBox,262144,, GuiControl._getControl(),2 
		return % this._getActiveTab().Controls.get($control_name)
	} 
	
	/** get type of listbox for toogling by keyboard
	 */
	_getListBoxType( $listbox_name )
	{
		return % $listbox_name=="LB_TabsetRoot" || $listbox_name=="LB_TabsGroup" ? "root_tabset" : "folder_tabfile"
	} 	
	
	
	/*---------------------------------------
		LISTBOX
	-----------------------------------------
	*/
	/**
	 */
	_LB_focus( $listbox_name, $select:="" )
	{
		$listbox := this._getControl($listbox_name)
		
		$listbox.focus()
		
		if( $select )
			$listbox.select($select)

		this._last_listbox[this._getListBoxType( $listbox_name )] := $listbox_name	
	}	
	
	
	
	
	
	
	
	
	
	
	
	/*---------------------------------------
		RADIO
	-----------------------------------------
	*/
	/**
	 */
	_R_replaceUnselect( )
	{
		MsgBox,262144,, GuiControl._R_replaceUnselect(),2 
		$Radios := this._getControl("R_replace")
		
		For $name, $addr in $Radios._buttons
			$Radios.get($name).edit(0)
	}
	
	/*---------------------------------------
		LISTBOX OLD
	-----------------------------------------
	*/
	_LB_set( $listbox_name, $data:="", $select:=0 )
	{
		MsgBox,262144,, GuiControl._LB_set(),2 
	}
	/**
	 */
	_LB_add( $listbox_name, $data:="", $select:=0 )
	{
		MsgBox,262144,, GuiControl._LB_add(),2 
	}


	/**
	 */
	_LB_unselect($listbox_name )
	{
		MsgBox,262144,, GuiControl._LB_unselect(),2 
	}
	
	
	
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/**
	 */
	_getControlValue($control_name)
	{
		MsgBox,262144,, GuiControl._getControlValue(),2 
	}



	/*---------------------------------------
		UNUSED
	-----------------------------------------
	*/
	/**
	 */
	;;_setDropdownItems($control_name, $items, $selected:="")
	;;{
	;;	this._gui.Controls.get($control_name)
	;;						.clear()
	;;						.edit($items)
	;;}
	
	

}

