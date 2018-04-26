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
	Tabset($tabset_name)
	{
		return % this.Tabsets().getTabset($tabset_name)
	}
	/**
	 */
	TabsGroup($tabset_name, $tabsgroup_name)
	{
		return % this.Tabset($tabset_name).getTabsGroup($tabsgroup_name)
	}
	/**
	 */
	Tabfile($tabset_name, $tabsgroup_name, $tabfile_name)
	{		
		return % this.TabsGroup($tabset_name, $tabsgroup_name).getTabFile($tabfile_name)
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
