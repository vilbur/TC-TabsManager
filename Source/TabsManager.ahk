#SingleInstance force
;#NoTrayIcon

#Include %A_LineFile%\..\Lib\TabsManager.ahk

$tabset	= %1%
$tabsgroup	= %2%
$tabfile	= %3% 

$TabsManager 	:= new TabsManager()


if( $tabset && $tabsgroup && $tabfile )
	$TabsManager.loadTabs( $tabset, $tabsgroup, $tabfile )
	
else
	$TabsManager.createGui()