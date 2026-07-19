#SingleInstance force
;#NoTrayIcon

/*
	1) Start Gui without parameters
	
	2) Open Tabs if parameters defined
		@param1	string	$tabset	name of tabset
		@param2	string	$tabsgroup	name of tabsgroup
		@param3	string	$tabfile	name of tabfile

	E.G.: TabsManager.exe "_TC-tools" "TC-TabsManager" "Setup"
	
	
	IMPORTANT NOTICE:
		TcTabsLoader can load .*tab file into commander
		It`s done via workaround with custom command
  
		1) Extended command "em_TcTabsLoader_load-tabs" is created in "usercmd.ini"
		2) Ctrl+Shift+Alt+F9 is associated with this command 
		3) Keyboard shortcut is send to Total Commander and tab file is loaded

*/ 



$tabset	= %1%
$tabsgroup	= %2%
$tabfile	= %3% 

$startCommander	= %4% 

if( $startCommander )
{
	;Run totalcmd.exe
	Run *RunAs TOTALCMD64.exe
	
	sleep 1000
	
	
	WinActivate, ahk_exe TOTALCMD64.exe; Use the window found by WinExist.

}

#Include %A_LineFile%\..\Lib\TabsManager.ahk


	
$TabsManager 	:= new TabsManager()



if( $tabset && $tabsgroup && $tabfile )
{
	
	$TabsManager.loadTabs( $tabset, $tabsgroup, $tabfile )
}
	
else
	$TabsManager.createGui()
	
	

