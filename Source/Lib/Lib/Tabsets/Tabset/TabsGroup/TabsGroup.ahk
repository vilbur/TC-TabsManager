/** Class TabsGroup
*/
Class TabsGroup
{
	_path_tabs_folder	:= ""
	_tabfiles	:= {}		

	/* 
		@param string $path to folder with *.tab files
	 */
	__New($path){
		this._path_tabs_folder	:= $path
	}
	/** create new Tabfiles
	 */
	create()
	{
		FileCreateDir, % this._path_tabs_folder
		return this
	}
	/** create new Tabfiles
	 */
	delete()
	{
		FileRemoveDir, % this._path_tabs_folder
		return this
	}
	/** get *.tab files in folder
	 */
	getTabFiles()
	{
		loop, % this._path_tabs_folder "\*.tab", 0
			this.setTabFile( A_LoopFileName, A_LoopFileFullPath )
			;this._tabfiles[this._getTabFileName(A_LoopFileName)] := new Tabfile(A_LoopFileFullPath).getTabFiles()
		return this
	}
	/**
	 */
	setTabFile( $tabfile_name, $tabfile_path )
	{
		this._tabfiles[this._getTabFileName($tabfile_name)] := new Tabfile($tabfile_path).getTabFiles()
	} 
	
	/**
	  * @return object Tabfile 
	 */
	getTabFile($tabfile_name)
	{
		return % this._tabfiles[$tabfile_name]
	}
	
	/** Get path to tab file
	 */
	getTabFilePath( $tabfile_name )
	{
		$folder	:= this._path_tabs_folder
		$path	= %$folder%\%$tabfile_name%.tab
		
		return $path
	}
	
	/** get filenames of *.tab files
	 */
	getTabFilenames()
	{
		return % getObjectKeys(this._tabfiles)
	}

	/**
	 */
	_getTabFileName($tabs_filename)
	{
		SplitPath, $tabs_filename,,,, $file_noext
		return %$file_noext%
	}

	/**
	 */
	Test( )
	{
		MsgBox,262144,TabsGroup, Test,2 
	}

	
}

