/** Control controls in Gui
 *
 */
Class TabControlMethods Extends TabControlCallback
{
	_last_selected_folders	:= {}
	_last_focused_listbox	:= {root_tabset:"", folder_tabfile:""}

	/*---------------------------------------
		TAB
	-----------------------------------------
	*/
	/**
	 */
	_getActiveTab()
	{
		MsgBox,262144,, TabControlMethods._getActiveTab(),2 
		return % this._gui.Tabs_Tabsets.getActive()		
	}
	/*---------------------------------------
		RADIO
	-----------------------------------------
	*/
	/**
	 */
	_R_replaceUnselect( )
	{
		$Radios := this._getControl("R_replace")
		
		For $name, $addr in $Radios._buttons
			$Radios.get($name).edit(0)
	}
	
	/*---------------------------------------
		LISTBOX
	-----------------------------------------
	*/
	_LB_set( $listbox_name, $data:="", $select:=0 )
	{
		$listbox := this._getControl( $listbox_name )
		
		$listbox.clear()
		
		if( $data )
			$listbox.edit( $data )
			
		if( $select )
			$listbox.select( $select )
	}
	/**
	 */
	_LB_add( $listbox_name, $data:="", $select:=0 )
	{
		$listbox := this._getControl( $listbox_name )
				
		if( $data )
			$listbox.edit( $data )
			
		;if( $select )
		;	$listbox.select( $select )
	}
	/**
	 */
	_LB_focus( $listbox_name, $select:="" )
	{
		$listbox := this._getControl($listbox_name)
		
		$listbox.focus()
		
		if( $select )
			$listbox.select($select)

		this._last_focused_listbox[this._getListBoxType( $listbox_name )] := $listbox_name	
	}
	/** Focus first listbox with items
	 */
	_LB_focusOnInit()
	{
		For $i, $lisbox in ["LB_Folder", "LB_Tabfile", "LB_TabsGroup", "LB_TabsetRoot" ]
		{
			$LB := this._getControl($lisbox)
			if( $LB.GetCount() )
				break
		}
		$LB.focus()
	}
	/**
	 */
	_LB_unselect($listbox_name )
	{
		this._Tab.Controls.get($listbox_name).select(0)	
	}
	
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/** get control object from current tab
	 */
	_getControl( $control_name )
	{
		return % this._Tab.Controls.get($control_name)
	} 
	/**
	 */
	_getControlValue($control_name)
	{
		MsgBox,262144,, TabControlMethods._getControlValue(),2 
		return % this._getControl($control_name).value()
	}

	/** get type of listbox for toogling by keyboard
	 */
	_getListBoxType( $listbox_name )
	{
		return % $listbox_name=="LB_TabsetRoot" || $listbox_name=="LB_TabsGroup" ? "root_tabset" : "folder_tabfile"
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

