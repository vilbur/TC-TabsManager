/** TabControlCallback
 *
 */
Class TabControlCallback extends TabControlCallbackMethod
{
	/**
	 */
	_LB_TabsetRootChanged( $Event )
	{
		;MsgBox,262144,, _LB_TabsetRootChanged,2
		$data	:= this.Gui()._getGuiData()
		
		if( $data.tabsgroup=="_shared" )
			this._updateFolderList( $data )
		
		if( $Event.type=="DoubleClick")
			this.TabsManager().loadTabs()
	}
	/**
	 */
	_LB_FolderChanged( $Event )
	{
		if( $Event.type=="LeftClick" )
			this._folderChanged($Event)
		
		else if( $Event.type=="DoubleClick")
			this.TabsManager().loadTabs()
	}
	/**
	 */
	_LB_TabsGroupChanged( $Event )
	{
		if( $Event.type=="DoubleClick")
			return % this.TabsManager().loadTabs()
		
		$data	:= this.Gui()._getGuiData()
		
		if( $data.tabsgroup!="_shared" )
			this._tabsGroupUpdateGui( $data )
			
		this._TEXT_update()
	}
	/**
	 */
	_LB_TabfileChanged( $Event )
	{
		$control_key	:= GetKeyState("control", "P")
		
		if( $Event.type=="DoubleClick" ){
			if( $control_key )
				this.TabsManager().openTabs()			
			else
				this.TabsManager().loadTabs()
		}
		else
			this._tabfileSelected($Event)
	}
	
}