/** Accessors via Parent class
*/
Class Accessors
{
	/**
	 */
	Gui()
	{
		return % this.TabsManager()._Gui
	}
	/**
	 */
	Tabsets()
	{
		;MsgBox,262144,,Accessors.Tabsets(),2
		;$Parent := this.Parent()
		;Dump($Parent, "Parent", 0)
		;return % $Parent._Tabsets
		return % this.TabsManager()._Tabsets		
	}
	/**
	 */
	Tabset($data)
	{
		$tabset_name := isObject($data) ? $data.tabset : $data
		;MsgBox,262144,tabset_name, %$tabset_name%,3 
		return % this.Tabsets().getTabset($tabset_name)
	}
	/**
	 */
	TabsGroup($data, $tabsgroup_name:="")
	{
		if( $tabsgroup_name )
			MsgBox,262144,,Accessors.TabsGroup() PARAMETER IS NOT OBEJCT,2
		return % this.Tabset($data.tabset).getTabsGroup($data.tabsgroup)
	}
	/**
	 */
	Tabfile($data, $tabsgroup_name:="", $tabfile_name:="")
	{
		if( $tabsgroup_name )
			MsgBox,262144,,Accessors.Tabfile() PARAMETER IS NOT OBEJCT,2
		;MsgBox,262144,, Tabfile,2
		;MsgBox,262144,, % $data.tabfile  ,2 		

		return % this.TabsGroup($data).getTabFile($data.tabfile)
	}
	/**
	 */
	TargetInfo()
	{
		return % this.TabsManager()._TargetInfo 
	}
	/**
	 */
	TotalCmd()
	{
		return % this.TabsManager()._TotalCmd
	}
	

}
