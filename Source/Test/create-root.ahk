#SingleInstance force



$test_path := "c:\GoogleDrive\TotalComander\_TC-commands\tabs\TabsManager\Test\testRoot\Project_A\subfolder"
$test_path := "c:\wamp64\www\laravel-fresh"

$test_path := "c:\GoogleDrive"
$test_path = %USERPROFILE%\..\

Run, % A_LineFile "\..\..\TabsManager.ahk " $test_path


		
		