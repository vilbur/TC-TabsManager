/** Methods called by callbacks
 *
 * Orchestrate controls for current state of gui
 */
Class GuiCallbackMethods Extends Parent
{
	_last_state := {}
	
	/**
	 */
	_initLastStateStore()
	{
		For $i, $tabset in this.Tabsets()._getTabfilesNames()
			this._last_state[$tabset] := {}
	} 
	/*---------------------------------------
		TEXT
	-----------------------------------------
	*/
	/**
	 */
	_guiFocused()
	{	
		this._TEXT_update()
	}  
	/**
	 */
	_TEXT_update()
	{
		$data	:= this._getGuiData()
		$Tabfile	:= this.Tabfile($data)

		if( $Tabfile )
		{
			$active_pane	:= this.TotalCmd().activePane()
			$tabs	:= $Tabfile.getTabsCaptions()
			
			this._gui.Controls.get("TEXT_pane_" $active_pane).edit( $tabs.activetabs )
			this._gui.Controls.get("TEXT_pane_" ($active_pane	== "right" ? "left" : "right")).edit( $tabs.inactivetabs )
		}
	}
	
	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/

	/**
	 */
	_askPathToRoot()
	{
		$path := this._MsgBox.Input("ADD NEW ROOT FOLDER", "Set path to new root" , {"w":720, "default": this.TotalCmd()._TcPane.getSourcePath()})
		
		if( InStr( FileExist($path), "D" )==0 ) ; get dir path, if path to file 
			SplitPath, $path,, $path
		
		return % FileExist($path) ? $path : false
	} 

	/**
	 */
	_getLastFolder( $data )
	{
		return % this.Tabset($data.tabset).getLastFolder($data.tabsetroot)
	}
	
	
	
	
}

