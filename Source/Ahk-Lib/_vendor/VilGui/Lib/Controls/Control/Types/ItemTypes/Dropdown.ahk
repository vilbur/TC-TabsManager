/** Class Dropdown_vgui
*/
Class Dropdown_vgui extends ControlItems_vgui{
	
	
	/** Add to GUI
	*/
	addItem($name:=""){
		;this.name($name)
		;return % this.Controls().add(this) ; clone added object if user insert one object multiple times
		
		;Gui, Add, DropDownList, % this.hwnd, Item1|Item2|Item3
	}

	/** Select item 
	  * @param	int|string	$item	Item or number of item to select
	 */
	select( $item:=0 )
	{
		if $item is number
			this._selectByIndex($item)
		else
			Control, ChooseString , %$item%,, % "ahk_id " this.hwnd
		
		;Gui, Add, DropDownList, % this.hwnd, Item1|Item2|Item3
	}
	
	/** Select item by index
	  * @param	int	$number	Number of item to select
	  */
	_selectByIndex($number)
	{
		$index := $number -1	
		
		SendMessage, 0x014E, %$index% ,0,, % "ahk_id " this.hwnd		

	} 
	
	
	

}