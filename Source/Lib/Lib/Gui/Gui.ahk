/** Create Gui
 *
 */
Class Gui Extends AddControls
{
	_gui	:= new VilGUI("TC Tabs Manager")
	_MsgBox 	:= new MsgBox()
	;_options	:= {}

	/*---------------------------------------
		CREATE GUI
	-----------------------------------------
	*/
	;/**
	; */
	;options( ByRef $options )
	;{
	;	if( $options )
	;		this._options	:= $options
	;	
	;	return this
	;} 
	/** createGui
	 */
	createGui()
	{
		this._addControls()
		
		this._setMargin()
		this._addMenus()
		
		this._bindEvents()
		
		this._setGuiShowPosition()
		
		;this._gui.alwaysOnTop()
			
		this._gui.create()

		this._setFocusOnListbox("LB_TabsGroup")
		this._setFocusOnListbox("LB_FoldersList")
		this._setFocusOnListbox("LB_Tabfile")				
		
		this._TEXT_update()
		
		this._initLastStateStore()
		
		this._LB_focusOnInit()
		
		;sleep, 300 ; wait then TcPaneWatcher is initialized, it handles win onTop state
		if( this._getOption("on_top") )
			this._gui.alwaysOnTop()
			
		;WinSet, AlwaysOnTop, On

		;WinHide, % this._gui.ahkId()
		;WinShow, % this._gui.ahkId()
	}
	/**
	 */
	_setMargin()
	{
		this._gui.Margin.x(5).y(10) ; set margin for all - UI, CONTAINERS & CONTROLS
	}  
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
	_addMenus()
	{
		;this._gui.Menus.Main
				;.menu("Window")
				;.item("Center window", &this "._centerWindow")
				
		this._gui.Menus.Tray
				.icon("\TabsManager.ico")	; file in working dir subdir
				.item("Center window", &this "._centerWindow")
				.item("Exit")
				;.defaults()
				.show()
	}
	/**
	 */
	_setGuiShowPosition()
	{		
		;this._gui.autosize()
		
		if(  this._getOption("center_window") )
			this._gui.center("window")
		
		else
			this._gui.position( this._getWindowIniPosition("x"), this._getWindowIniPosition("y") )

	}
	
	/**
	 */
	_getGuiData()
	{
		$tab	:= this._getActiveTab()
		$Controls	:= $tab.Controls
		$form_data	:= {"tabset":	$tab.name()
			   ,"tabsgroup":	"_shared"}
		
		For $control_name, $value in $Controls.values()
			if( $value && ! InStr($control_name, "DD_" ) )
				 $form_data[RegExReplace( $control_name, "^[^_]+_", "" )] :=  $value
		
		return $form_data
		;return %	{"tabset":	$tab.name()
		;	,"tabsetroot":	$Controls.get("LB_TabssetRoot").value()
		;	,"tabsgroup":	$Controls.get("LB_TabsGroup").value()			
		;	,"replace":	$Controls.get("R_replace").value()
		;	,"folder":	$Controls.get("LB_FoldersList").value()			
		;	,"tabfile":	$Controls.get("LB_Tabfile").value()}
	}
	/**
	 */
	saveWindowPosition($Event, $params*)
	{
		;$Event.message()
		if( ! $Event.x )
			return 
		
		IniWrite, % $Event.x, %$ini_path%, window, x
		IniWrite, % $Event.y, %$ini_path%, window, y
		
		IniWrite, % $Event.width, 	%$ini_path%, window, width
		IniWrite, % $Event.height,	%$ini_path%, window, height						
		
	}
	/**
	 */
	_getWindowIniPosition($xy)
	{
		IniRead, $value, %$ini_path%, %$xy%, x, 0
		
		return $value 
	}
	/*---------------------------------------
		EVENTS
	-----------------------------------------
	*/
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
	/*---------------------------------------
		OPTIONS
	-----------------------------------------
	*/
	/**
	 */
	_getOption( $options, $default:=0 )
	{
		IniRead, $value, %$ini_path%, options, %$options%, %$default%
		
		return $value
	}
	     
	/*---------------------------------------
		FONT
	-----------------------------------------
	*/
	/**
	 */
	_setFont( $size:="s8", $color:="cBlue bold" )
	{
		this._gui.gui("Font",  $size " " $color )
	}
	/**
	 */
	_resetFont()
	{
		;MsgBox,262144,, _resetFont,2 
		this._gui.gui("Font")
	}
}


