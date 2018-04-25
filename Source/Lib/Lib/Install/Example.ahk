 /** Create Example tabset in root "C:\Users"
  *		
  */
Class Example Extends Parent
{
	_users_path	:= ""
	_username	:= ""
	_Tabset_name	:= "Users"
		
	__New()
	{
		$users_path	= %USERPROFILE%
		$username	= %USERNAME%

		this._users_path	:= $users_path
		this._username	:= $username
		this._users_path	:= combine_path( this._users_path, "..\\" )
	}
	/**
	 */ 
	createExample()
	{
		this.createTabsets()
		this.createSharedTabFile()
		this.createUserTabFile()
		
		reload
	}
	/**
	 */
	createTabsets()
	{		
		this.Tabsets().createTabset( this._users_path, this._Tabset_name )

		this.Tabset(this._Tabset_name).TabsGroup("_shared")
		this.Tabset(this._Tabset_name).TabsGroup(this._username)		
	}

	/**
	 */
	createSharedTabFile()
	{
		$tabsfile_path := $tabs_path "\\" this._Tabset_name "\\_shared\\Users-Tabs.tab"
		FileDelete, %$tabsfile_path%
		
		$lines :=	["[activetabs]"
			,"0_path=C:\Users\Default"
			,"0_caption=User"
			,"0_options=1|0|0|0|0|2|0"
			,"1_path=C:\Users\Default\Documents"
			,"1_options=1|0|0|0|0|2|0"
			,"2_path=C:\Users\Default\Desktop"
			,"2_options=1|0|0|0|0|2|0"
			,"3_path=C:\Users\Default\Downloads"
			,"3_options=1|0|0|0|0|2|0"
			,"activetab=0"]
		
		FileAppend, % this._joinObject($lines), %$tabsfile_path%

	}
	/**
	 */
	createUserTabFile()
	{
		$tabsfile_path := $tabs_path "\\" this._Tabset_name "\\" this._username "\\" this._username "-Tabs.tab"
		FileDelete, %$tabsfile_path%
		
		$lines :=	["[activetabs]"
			,"0_path=C:\Users\Default\Documents"
			,"0_options=1|0|0|0|0|2|0"
			,"1_path=C:\Users\Default\Downloads"
			,"1_options=1|0|0|0|0|2|0"
			,"activetab=0"]
		
		FileAppend, % this._joinObject($lines), %$tabsfile_path%
		
	}
	
	/** join object
	 */
	_joinObject($object, $delimeter:="`n")
	{
		For $key, $value in $object
			$string .= $value $delimeter
		
		return % SubStr( $string, 1, StrLen($string) - (StrLen($delimeter)) )
	}
	
	
}
 