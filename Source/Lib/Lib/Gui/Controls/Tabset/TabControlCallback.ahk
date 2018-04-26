/** TabControlCallback
 *
 */
Class TabControlCallback extends TabControlCallbackMethod
{
	/**
	 */
	_LB_Changed( $Event, $listbox_name )
	{	
		if( $Event.type=="DoubleClick")
			this.TabsManager().loadTabs()
			
		else
			this["_LB_" $listbox_name "Changed"]( $Event )
	}
	/**
	 */
	_LB_TabsetRootChanged( $Event )
	{
		;MsgBox,262144,, _LB_TabsetRootChanged,2
		$data	:= this.Gui()._getGuiData()
		
		if( $data.tabsgroup=="_shared" )
			this._updateFolderList( $data )
		
		this._saveLastTabsRoot( $data )	
	}
	/**
	 */
	_LB_FolderChanged( $Event )
	{
		if( $Event.type=="LeftClick" )
			this._folderChanged($Event)
	}
	/**
	 */
	_LB_TabsGroupChanged( $Event )
	{
		$data	:= this.Gui()._getGuiData()
		
		if( $data.tabsgroup!="_shared" )
			this._tabsGroupUpdateGui( $data )
			
		this.Gui()._TEXT_update()
	}
	/**
	 */
	_LB_TabfileChanged( $Event )
	{
		$control_key	:= GetKeyState("control", "P")
		
		;if( $Event.type=="DoubleClick" ){
		;	if( $control_key )
		;		this.TabsManager().openTabs()			
		;	else
		;		this.TabsManager().loadTabs()
		;}

		this._tabfileSelected($Event)
		
	}
	/*---------------------------------------
		DROPDOWN
	-----------------------------------------
	*/
	
	/**
	 */
	_DD_Changed($Event, $control_name)
	{
		;MsgBox,262144,, % "_" $control_name $Event.value
		this["_" $control_name $Event.value]($Event, this.Gui()._getGuiData())
	}

	/*---------------------------------------
		RADIO
	-----------------------------------------
	*/
	/**
	 */
	_R_replaceChanged( $Event )
	{
		$data	:= this.Gui()._getGuiData()

		if(  $data.tabsgroup!="_shared" ) ; do not update if switching between radio buttons
			this._tabsGroupUnselect($data)
		
		this.Gui()._TEXT_update()
	}
}