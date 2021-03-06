/** Class MouseEvents_vgui
   OnMose Messages : https://msdn.microsoft.com/en-us/library/windows/desktop/ms645607(v=vs.85).aspx
*/
Class MouseEvents_vgui extends EventBind_vgui
{
	/* https://autohotkey.com/docs/misc/SendMessageList.htm
	*/
	_messages := 	{"enter":	0x200
		,"move":	0x200
		,"leftClick":	0x201
		,"leftClickUp":	0x202
		,"leftDoubleclick":	0x203
		,"rightClick":	0x204
		,"rightClickUp":	0x205
		,"rightDoubleclick":	0x206
		,"middleClick":	0x207
		,"middleClickUp":	0x208
		,"middleDoubleclick":	0x209
		,"mouseWheel":	0x20A
		,"mouseWheelHorizontal":	0x20E}
	
	/**
	  * @param string|array $key name of key or array with modifiers E.G.: "space" OR ["control", "alt", "space"]
	 */
	on( $event, $callback, $params* )
	{
		if( this._messages.hasKey($event) )
		{
			OnMessage(this._messages[$event], "onMouseMainCallback")
			this._bindCallback( $event, $callback, $params* )	
		}
		return this
	}
	/**
	 */
	call($message)
	{
		this._call( this._findEvent($message) )
	}
	
	/** Call function on mouse wheel event
		Allow scrolling
	*/
	bindWheel()
	{
		WM_MOUSEHWHEEL := 0x020A
		OnMessage(WM_MOUSEHWHEEL, "onWheelOrScrollMessage")
		return this
	}

	/** When user scroll with scrollbar
	*/
	bindScroll()
	{
		WM_VSCROLL := 0x0115
		OnMessage(WM_VSCROLL, "onWheelOrScrollMessage")
		return this
	}
	
	/**
	 */
	_findEvent( $message )
	{
		for $key, $value in this._messages
			if ($value = $message)
				return $key
		;MsgBox,262144,key, %$key%,3 
		return false
	} 

}

/*-----------------------------------------
	CALLBACKS
-----------------------------------------
*/
/** onWheelOrScrollMessage
*/
onMouseMainCallback(wParam, lParam, msg, hwnd)
{
	$GUI := $_GUI[hwnd]
	;dump($GUI)
	if( $GUI )
		$GUI.Events.Mouse.call(msg)
}

/** onWheelOrScrollMessage
*/
onWheelOrScrollMessage(wParam, lParam, msg, hwnd)
{
	;MsgBox,262144,, %hwnd%,2
	hwnd := WinExist("A")
	
	if(wParam==7864320) ; mouse wheel down
		OnScroll(0, lParam, 0x115, hwnd )
	else if(wParam==-7864320)  ; mouse wheel up
		OnScroll(1, lParam, 0x115, hwnd )

	else ; on scrollbar drag
		OnScroll(wParam,lParam, 0x115, hwnd )

	;;; call custom callback on control
	;$_GUI[lParam].List.get(H, "hwnd" ).Event.mouse.call(wParam, L, M, H)

}