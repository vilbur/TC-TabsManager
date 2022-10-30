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


#Include %A_LineFile%\..\Lib\TabsManager.ahk

$tabset	= %1%
$tabsgroup	= %2%
$tabfile	= %3% 

$TabsManager 	:= new TabsManager()


if( $tabset && $tabsgroup && $tabfile )
	$TabsManager.loadTabs( $tabset, $tabsgroup, $tabfile )
	
else
	$TabsManager.createGui()
	
	
