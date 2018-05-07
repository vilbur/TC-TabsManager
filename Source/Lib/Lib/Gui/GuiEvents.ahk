/** Create GuiEvents
 *
 */
Class GuiEvents Extends AddControls
{
	/**
	 */
	_bindEvents()
	{
		this._bindKeyEvents()
		this._bindGuiEvents()
		this._bindControlEvents()				
		this._bindWindowEvents()		
	}
	/**
	 */
	_bindKeyEvents()
	{

		this._gui.Events.Key
				.onEscape("exit")
				.onEnter( this._Parent ".loadTabs")
				.on( "number", &this "._TAB_SelectByNumber")
				.on( "space", &this "._LB_FoldersAndTabfile", "LB_Folder")
				.on( ["control", "space"], &this "._LB_ToggleRootsAndTabset", "LB_Folder")
	} 
	/**
	 */
	_bindGuiEvents()
	{
		this._gui.Events.Gui
				;.onClose("exit")
				.onClose( &this ".TestEvent")		
				
		;this._gui.Events.Gui
		;		.onExit( &this ".saveWindowPosition")
	}
	/**
	 */
	TestEvent($Event, $params*)
	{
		MsgBox,262144,, Gui.TestEvent(),2
		ExitApp
	}
	/**
	 */
	_bindControlEvents()
	{
		this._gui.Style.Color
				.focus( 0x00FF00, 0xFF0080)
				.focus( "d0e3f4", "", "listbox")
	} 
	/**
	 */
	_bindWindowEvents()
	{
		this._gui.Events.Window
		    .on("focus",	&this "._guiFocused")			
		    ;;.on("sizedmoved",	&this ".saveWindowPosition")
	} 

}


