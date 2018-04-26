
/** Class Parent
*/
Class Parent Extends Accessors
{
	static _Parent := {}

	/** DELETE THIS
	 * @return object parent class
	*/
	Parent($Parent:="")
	{
		MsgBox,262144,, Parent.Parent(),2 
		if($Parent)
			this._Parent	:= &$Parent
		return % $Parent ? this : Object(this._Parent)
	}

	/** set\get parent class
	 * @return object parent class
	*/
	TabsManager($TabsManager:="")
	{
		;MsgBox,262144,, TabsManager,2 
		if($TabsManager)
			this._Parent.TabsManager	:= isObject($TabsManager) ? &$TabsManager : $TabsManager
		return % $TabsManager ? this : Object(this._Parent.TabsManager)
	}
	
}



