; ### Function Map ###
; _LoadCfg(), load config file that contain full path of cheatconfig file
; _FileOpen(), open cheatconfig file if not specified on config file
; _MinToTray(), hide $Form and make an icon tray
; _ShowMain(), show $Form when user click on tray icon and then remove the icon from tray 
; _CheckAllTreeView1(), (un)check all subitem under $TreeView1
; _CheckAllTreeView3(), (un)check all subitem under $TreeView3
; _StaticCheatsTreeItem(), loop to create checkbox using text from $StaticCheats with each 0 index of the array
; _SetComboData($a), loop to fill combobox data with either $Tools $Items or $Fridge with each 1 index of the array
; _CheckTreeView2(), (un)hide $Form0
; _CheckTreeView3(), (un)hide $Form5
; _CheckTreeView4_1(), (un)hide $Form1
; _CheckTreeView4_2(), (un)hide $Form2
; _CheckTreeView5_1(), (un)hide $Form3
; _CheckTreeView5_2(), (un)hide $Form4
; _EvalAllForm(), run each form evaluator with result cheat code in $Msg
; _AddCheats(), run _EvalAllForm() and write generated $Msg to cheatconfig file
; _PreviewCheatCodes(), run _EvalAllForm() and run $Msg as parameter for _PreviewCheatCodeForm()
; _About(), show $About text
; _Help(), show $Help text
; _Reset(), empty config file and uncheck selection in all form and main $TreeView subitem
; Close(), exit script
; Form0(), build $Form0
; _ToogleCheckboxForm0(), enable/disable combobox next to each checkbox in $Form0
; _ResetForm0(), uncheck all checkbox in $Form0
; _HideForm0(), hide $Form0 and enable then activate $Form
; _ShowForm0(), disable $Form and unhide $Form0
; _EvalForm0(), evaluate which checkbox is is checked in $Form0 then generate respective cheatcode to fill $Msg
; Form1(), build $Form1
; _ToogleCheckboxForm1(), enable/disable combobox and input next to each checkbox in form1
; _ResetForm1(), uncheck all checkbox in $Form1
; _HideForm1(), hide $Form1 and enable then activate $Form
; _ShowForm1(), disable $Form and unhide $Form1
; _EvalForm1(), evaluate which checkbox is is checked in $Form1 then generate respective cheatcode to fill $Msg
; Form2()
; _ToogleCheckboxForm2()
; _ResetForm2()
; _HideForm2()
; _ShowForm2()
; _EvalForm2()
; Form3()
; _ToogleCheckboxForm3()
; _ResetForm3()
; _HideForm3()
; _ShowForm3()
; _EvalForm3()
; Form4()
; _ToogleCheckboxForm4()
; _ResetForm4()
; _HideForm4()
; _ShowForm4()
; _EvalForm4()
; Form5()
; _ResetForm5()
; _HideForm5()
; _ShowForm5()
; _EvalForm5()
; _PreviewCheatCodeForm($Message)
; _ExitPreview()
; Main Functions
Func _LoadCfg()
	If FileExists($CfgFile)=1 Then
		If FileReadLine($CfgFile)="" Then
			MsgBox(0, "Error", "Config file empty. Choose cheatfile in next dialogue.", 0, $Form)
			_FileOpen()
		ElseIf FileExists(FileReadLine($CfgFile))=0 Then
			MsgBox(0, "Error", "File pointed by config file not found. Choose cheatfile in next dialogue.", 0, $Form)
			_FileOpen()
		Else
			Global $File=FileReadLine($CfgFile)
		EndIf
	Else
		MsgBox(64, "HM:HoLV CWcheat Cheatfile Editor", "For first time run, select cheatconfig file to open in the next dialog, usually something like emupath\memstick\PSP\Cheats\ULUS10458.ini. That file will be remembered in hm-holv.cfg. So unless you want to asked again, keep that file unchanged.")
		_FileOpen()
	EndIf
EndFunc
Func _FileOpen()
	Global $File=FileOpenDialog("Select CWcheat Cheatfile To open", @ProgramFilesDir&"\PPSSPP\memstick\PSP\Cheats", "(*.ini;*.db)", 1)
	If $File == "" Then
		$AskFile=MsgBox(5, "", "Click retry To Select CWcheat Cheatfile"&@CRLF&"or hit cancel To abort and exit", 0, $Form)
		If $AskFile == 2 Then
			Exit
		Else
			_FileOpen()
		EndIf
	EndIf
	FileWriteLine(FileOpen($CfgFile, 2), $File)
EndFunc
Func _MinToTray()
	GUISetState(@SW_HIDE, $Form)
	Opt("TrayMenuMode", 3)
	TraySetIcon(@ScriptDir&"\hm-holv.ico")
	TrayTip("HM:HoLV CWcheat Cheatfile Editor", "The main window is here, just click to restore it.", "", 1)
	TraySetToolTip("HM:HoLV CWcheat Cheatfile Editor")
	TraySetOnEvent(-7, "_ShowMain")
EndFunc
Func _ShowMain()
	GUISetState(@SW_SHOW, $Form)
	Opt("TrayIconHide", 1)
EndFunc
Func _CheckAllTreeView1()
	For $a = $TreeView1+1 To $TreeView2-1
		If BitAND(GUICtrlRead($TreeView1), $GUI_CHECKED) Then
			GUICtrlSetState($a, 257)
		Else
			GUICtrlSetState($a, 4)
		EndIf
	Next
EndFunc
Func _CheckAllTreeView3()
	For $a = $TreeView3+1 To $TreeView4-1
		If BitAND(GUICtrlRead($TreeView3), $GUI_CHECKED) Then
			GUICtrlSetState($a, 257)
			_CheckTreeView3()
		Else
			GUICtrlSetState($a, 4)
		EndIf
	Next
EndFunc
Func _StaticCheatsTreeItem()
	For $a = 0 To UBound($StaticCheats)-3
		GUICtrlCreateTreeViewItem($StaticCheats[$a][0], $TreeView1)
	Next
EndFunc
Func _SetComboData($a)
	For $b = 0 to Ubound($a)-1
		GUICtrlSetData(-1, $a[$b][1])
	Next
EndFunc
Func _CheckTreeView2()
	If GUICtrlRead($TreeView2) = 257 Then
		_ShowForm0()
	EndIf
EndFunc
Func _CheckTreeView3()
	If GUICtrlRead($TreeView3+3) = 257 Then
		_ShowForm5()
	EndIf
EndFunc
Func _CheckTreeView4_1()
	If GUICtrlRead($TreeView4+1) = 257 Then
		_ShowForm1()
	EndIf
EndFunc
Func _CheckTreeView4_2()
	If GUICtrlRead($TreeView4+2) = 257 Then
		_ShowForm2()
	EndIf
EndFunc
Func _CheckTreeView5_1()
	If GUICtrlRead($TreeView5+1) = 257 Then
		_ShowForm3()
	EndIf
EndFunc
Func _CheckTreeView5_2()
	If GUICtrlRead($TreeView5+2) = 257 Then
		_ShowForm4()
	EndIf
EndFunc
Func _EvalAllForm()
	For $a = 1 To 9
		If BitAND(GUICtrlRead($TreeView1+$a), $GUI_CHECKED) Then
			$Msg &= "_C1 "&$StaticCheats[$a-1][0]&@CRLF
			$Msg &= $StaticCheats[$a-1][1]&@CRLF
		EndIf
	Next
	For $a = 1 To 2
		If BitAND(GUICtrlRead($TreeView3+$a), $GUI_CHECKED) Then
			$Msg &= "_C1 "&$StaticCheats[$a+8][0]&@CRLF
			$Msg &= $StaticCheats[$a+8][1]&@CRLF
		EndIf
	Next
	If BitAND(GUICtrlRead($TreeView2), $GUI_CHECKED) Then
		_EvalForm0()
	EndIf
	If BitAND(GUICtrlRead($TreeView3+3), $GUI_CHECKED) Then
		_EvalForm5()
	EndIf
	If BitAND(GUICtrlRead($TreeView4+1), $GUI_CHECKED) Then
		_EvalForm1()
	EndIf
	If BitAND(GUICtrlRead($TreeView4+2), $GUI_CHECKED) Then
		_EvalForm2()
	EndIf
	If BitAND(GUICtrlRead($TreeView5+1), $GUI_CHECKED) Then
		_EvalForm3()
	EndIf
	If BitAND(GUICtrlRead($TreeView5+2), $GUI_CHECKED) Then
		_EvalForm4()
	EndIf
EndFunc
Func _AddCheats()
	_EvalAllForm()
	If $Msg <> "" Then
		$Cheatfile = FileOpen($File, 2)
		FileWrite($Cheatfile, $Msg)
		FileClose($Cheatfile)
		MsgBox(0, "", "Cheatfile successfully updated")
	Else
		MsgBox(0, "yawn... :0", "Nothing to do :|")
	EndIf
	Global $Msg = ""
EndFunc
Func _PreviewCheatCodes()
	_EvalAllForm()
	If $Msg <> "" Then
		_PreviewCheatCodeForm($Msg)
	Else
		MsgBox(0, "yawn... :0", "Nothing to do :|")
	EndIf
	Global $Msg = ""
EndFunc
Func _About()
	MsgBox(0, "About", $About, 0, $Form)
EndFunc
Func _Help()
	MsgBox(0, "Help", $Help, 0, $Form)
EndFunc
Func _Reset()
	$AskReset = MsgBox(36, "Reset", "Are you sure you want to reset all selected"&@CRLF&"cheat and empty the cheatconfig file?", "", $Form)
	If $AskReset = 6 Then
		FileDelete($File)
		FileWrite($File, "")
		_ResetForm0()
		_ResetForm1()
		_ResetForm2()
		_ResetForm3()
		_ResetForm4()
		_ResetForm5()
		For $a = $TreeView+1 to $TreeView5+2
			GUICtrlSetState($a, 4)
		Next
		MsgBox(64, "Reset complete", "Reset complete. No cheat selected and cheatconfig file is empty.")
	EndIf
EndFunc
Func Close()
	Exit
EndFunc
; Form0 Functions, original file : form0.au3
Func Form0()
	$Form0 = GUICreate("Date and time", 253, 216, -1, -1, $WS_MINIMIZEBOX, "", $Form)
	$DummyForm0 = GUICtrlCreateDummy()
	For $a = 0 to UBound($TimeCheats)-1
		GUICtrlCreateCheckbox($TimeCheats[$a][0], 2, 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm0")
		If UBound($TimeCheats[$a][2]) <> 0 Then
			GUICtrlCreateCombo(" ", 100, 2+(23*$a), 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
			_SetComboData($TimeCheats[$a][2])
			GUICtrlSetState(-1, 128)
		Else
			GUICtrlCreateDummy()
		EndIf
	Next
	GUICtrlCreateButton("OK", 99, 162, 73)
	GUICtrlSetOnEvent(-1, "_HideForm0")
	GUICtrlCreateButton("Reset", 172, 162, 74)
	GUICtrlSetOnEvent(-1, "_ResetForm0")
	GUISetState(@SW_HIDE, $Form0)
EndFunc
Func _ToogleCheckboxForm0()
	For $a = 0 To UBound($TimeCheats)-1
		If BitAND(GUICtrlRead($DummyForm0+1+(2*$a)), $GUI_CHECKED) Then
			GUICtrlSetState($DummyForm0+2+(2*$a), 64)
		Else
			GUICtrlSetData($DummyForm0+2+(2*$a), " ")
			GUICtrlSetState($DummyForm0+2+(2*$a), 128)
		EndIf
	Next
EndFunc
Func _ResetForm0()
	For $a = 0 To UBound($TimeCheats)-1
		GUICtrlSetState($DummyForm0+1+(2*$a), 4)
		GUICtrlSetData($DummyForm0+2+(2*$a), " ")
		GUICtrlSetState($DummyForm0+2+(2*$a), 128)
	Next
EndFunc
Func _HideForm0()
	GUISetState(@SW_ENABLE, $Form)
	GUISetState(@SW_HIDE, $Form0)
	WinActivate($Form)
EndFunc
Func _ShowForm0()
	GUISetState(@SW_DISABLE, $Form)
	GUISetState(@SW_SHOW, $Form0)
	WinActivate($Form0)
EndFunc
Func _EvalForm0()
	Global $Msg
	If BitAND(GUICtrlRead($DummyForm0+1), $GUI_CHECKED) Then
		$Msg &= "_C1 "&$TimeCheats[0][0]&@CRLF&$TimeCheats[0][1]
	EndIf
	For $a = 1 To UBound($TimeCheats)-1
		If BitAND(GUICtrlRead($DummyForm0+1+($a*2)), $GUI_CHECKED) Then
			$CodeExt = $TimeCheats[$a][2]
			$Msg &= "_C1 "&$TimeCheats[$a][0]&" ["&GUICtrlRead($DummyForm0+2+($a*2))&"]"&@CRLF&$TimeCheats[$a][1]&$TimeCheats[$a][2]&$CodeExt[_ArraySearch($TimeCheats[$a][2], GUICtrlRead($DummyForm0+2+($a*2)))][0]&@CRLF
		EndIf
	Next
EndFunc
; Form1 Functions, original file : form1.au3
Func Form1()
	$Form1 = GUICreate("Tools in backpack", 476, 400, -1, -1, $WS_MINIMIZEBOX)
	$DummyForm1 = GUICtrlCreateDummy()
	For $a = 0 to 14
		GUICtrlCreateCheckbox("Slot #"&($a*2)+1, 2, 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm1")
		GUICtrlCreateCombo(" ", 62, 2+(23*$a), 145, 25, BitOR($CBS_SORT,$CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
		_SetComboData($Tools)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateInput("1", 209, 2+(23*$a), 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateCheckbox("Slot #"&($a*2)+2, 236, 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm1")
		GUICtrlCreateCombo(" ", 296, 2+(23*$a), 145, 25, BitOR($CBS_SORT,$CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
		_SetComboData($Tools)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateInput("1", 443, 2+(23*$a), 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetState(-1, 128)
	Next
	GUICtrlCreateButton("OK", 295, 346, 87)
	GUICtrlSetOnEvent(-1, "_HideForm1")
	GUICtrlCreateButton("Reset", 382, 346, 87)
	GUICtrlSetOnEvent(-1, "_ResetForm1")
	GUISetState(@SW_HIDE, $Form1)
EndFunc
Func _ToogleCheckboxForm1()
	For $a = 0 To 29
		If BitAND(GUICtrlRead($DummyForm1+1+(3*$a)), $GUI_CHECKED) Then
			GUICtrlSetState($DummyForm1+2+(3*$a), 64)
			GUICtrlSetState($DummyForm1+3+(3*$a), 64)
		Else
			GUICtrlSetData($DummyForm1+2+(3*$a), " ")
			GUICtrlSetState($DummyForm1+2+(3*$a), 128)
			GUICtrlSetData($DummyForm1+3+(3*$a), "1")
			GUICtrlSetState($DummyForm1+3+(3*$a), 128)
		EndIf
	Next
EndFunc
Func _ResetForm1()
	For $a = 0 To 29
		GUICtrlSetState($DummyForm1+1+(3*$a), 4)
		GUICtrlSetData($DummyForm1+2+(3*$a), " ")
		GUICtrlSetState($DummyForm1+2+(3*$a), 128)
		GUICtrlSetData($DummyForm1+3+(3*$a), "1")
		GUICtrlSetState($DummyForm1+3+(3*$a), 128)
	Next
EndFunc
Func _HideForm1()
	GUISetState(@SW_ENABLE, $Form)
	GUISetState(@SW_HIDE, $Form1)
	WinActivate($Form)
EndFunc
Func _ShowForm1()
	GUISetState(@SW_DISABLE, $Form)
	GUISetState(@SW_SHOW, $Form1)
	WinActivate($Form1)
EndFunc
Func _EvalForm1()
	Global $Msg
	For $a = 0 To 29
		If BitAND(GUICtrlRead($DummyForm1+1+(3*$a)), $GUI_CHECKED) Then
			$CodeAddr1="_L 0x104D3"&Hex(Int(Dec("26C")+($a)*4), 3)
			$CodeAddr2="_L 0x104D3"&Hex(Int(Dec("26E")+($a)*4), 3)
			$CodeExt1=" 0x00000"&$Tools[_ArraySearch($Tools, GUICtrlRead($DummyForm1+2+(3*$a)))][0]
			$CodeExt2=" 0x"&Hex(GUICtrlRead($DummyForm1+3+(3*$a)))
			$Msg &= "_C1 Backpack Tool "&GUICtrlRead($DummyForm1+1+(3*$a), 1)&", "&GUICtrlRead($DummyForm1+2+(3*$a))&" "&GUICtrlRead($DummyForm1+3+(3*$a))&"pcs"&@CRLF
			$Msg &= $CodeAddr1&$CodeExt1&@CRLF
			$Msg &= $CodeAddr2&$CodeExt2&@CRLF
		EndIf
	Next
EndFunc
; Form2 Functions, original file : form2.au3
Func Form2()
	$Form2 = GUICreate("Item in backpack", 476, 400, -1, -1, $WS_MINIMIZEBOX, "", $Form)
	$DummyForm2 = GUICtrlCreateDummy()
	For $a = 0 to 14
		GUICtrlCreateCheckbox("Slot #"&($a*2)+1, 2, 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm2")
		GUICtrlCreateCombo(" ", 62, 2+(23*$a), 145, 25, BitOR($CBS_SORT,$CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
		_SetComboData($Items)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateInput("1", 209, 2+(23*$a), 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateCheckbox("Slot #"&($a*2)+2, 236, 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm2")
		GUICtrlCreateCombo(" ", 296, 2+(23*$a), 145, 25, BitOR($CBS_SORT,$CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
		_SetComboData($Items)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateInput("1", 443, 2+(23*$a), 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetState(-1, 128)
	Next
	GUICtrlCreateButton("OK", 295, 346, 87)
	GUICtrlSetOnEvent(-1, "_HideForm2")
	GUICtrlCreateButton("Reset", 382, 346, 87)
	GUICtrlSetOnEvent(-1, "_ResetForm2")
	GUISetState(@SW_HIDE, $Form2)
EndFunc
Func _ToogleCheckboxForm2()
	For $a = 0 To 29
		If BitAND(GUICtrlRead($DummyForm2+1+(3*$a)), $GUI_CHECKED) Then
			GUICtrlSetState($DummyForm2+2+(3*$a), 64)
			GUICtrlSetState($DummyForm2+3+(3*$a), 64)
		Else
			GUICtrlSetData($DummyForm2+2+(3*$a), " ")
			GUICtrlSetState($DummyForm2+2+(3*$a), 128)
			GUICtrlSetData($DummyForm2+3+(3*$a), "1")
			GUICtrlSetState($DummyForm2+3+(3*$a), 128)
		EndIf
	Next
EndFunc
Func _ResetForm2()
	For $a = 0 To 29
		GUICtrlSetState($DummyForm2+1+(3*$a), 4)
		GUICtrlSetData($DummyForm2+2+(3*$a), " ")
		GUICtrlSetState($DummyForm2+2+(3*$a), 128)
		GUICtrlSetData($DummyForm2+3+(3*$a), "1")
		GUICtrlSetState($DummyForm2+3+(3*$a), 128)
	Next
EndFunc
Func _HideForm2()
	GUISetState(@SW_ENABLE, $Form)
	GUISetState(@SW_HIDE, $Form2)
	WinActivate($Form)
EndFunc
Func _ShowForm2()
	GUISetState(@SW_DISABLE, $Form)
	GUISetState(@SW_SHOW, $Form2)
	WinActivate($Form2)
EndFunc
Func _EvalForm2()
	Global $Msg
	For $a = 0 To 29
		If BitAND(GUICtrlRead($DummyForm2+1+(3*$a)), $GUI_CHECKED) Then
			$CodeAddr1="_L 0x104D3"&Hex(Int(Dec("36C")+($a)*4), 3)
			$CodeAddr2="_L 0x104D3"&Hex(Int(Dec("36E")+($a)*4), 3)
			$CodeExt1=" 0x00000"&$Items[_ArraySearch($Items, GUICtrlRead($DummyForm2+2+(3*$a)))][0]
			$CodeExt2=" 0x"&Hex(GUICtrlRead($DummyForm2+3+(3*$a)))
			$Msg &= "_C1 Backpack Item "&GUICtrlRead($DummyForm2+1+(3*$a), 1)&", "&GUICtrlRead($DummyForm2+2+(3*$a))&" "&GUICtrlRead($DummyForm2+3+(3*$a))&"pcs"&@CRLF
			$Msg &= $CodeAddr1&$CodeExt1&@CRLF
			$Msg &= $CodeAddr2&$CodeExt2&@CRLF
		EndIf
	Next
EndFunc
; Form3 Functions, original file : form3.au3
Func Form3()
	$Form3 = GUICreate("Tool in toolbox", 710, 515, -1, -1, $WS_MINIMIZEBOX, "", $Form)
	$DummyForm3 = GUICtrlCreateDummy()
	For $a = 0 to 19
		;
		GUICtrlCreateCheckbox("Slot #"&($a*3)+1, 2, 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm3")
		GUICtrlCreateCombo(" ", 62, 2+(23*$a), 145, 25, BitOR($CBS_SORT,$CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
		_SetComboData($Tools)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateInput("1", 209, 2+(23*$a), 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetState(-1, 128)
		;
		GUICtrlCreateCheckbox("Slot #"&($a*3)+2, 2+(234*1), 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm3")
		GUICtrlCreateCombo(" ", 62+(234*1), 2+(23*$a), 145, 25, BitOR($CBS_SORT,$CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
		_SetComboData($Tools)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateInput("1", 209+(234*1), 2+(23*$a), 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetState(-1, 128)
		;
		GUICtrlCreateCheckbox("Slot #"&($a*3)+3, 2+(234*2), 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm3")
		GUICtrlCreateCombo(" ", 62+(234*2), 2+(23*$a), 145, 25, BitOR($CBS_SORT,$CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
		_SetComboData($Tools)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateInput("1", 209+(234*2), 2+(23*$a), 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetState(-1, 128)
	Next
	GUICtrlCreateButton("OK", 529, 461, 87)
	GUICtrlSetOnEvent(-1, "_HideForm3")
	GUICtrlCreateButton("Reset", 616, 461, 87)
	GUICtrlSetOnEvent(-1, "_ResetForm3")
	GUISetState(@SW_HIDE, $Form3)
EndFunc
Func _ToogleCheckboxForm3()
	For $a = 0 To 59
		If BitAND(GUICtrlRead($DummyForm3+1+(3*$a)), $GUI_CHECKED) Then
			GUICtrlSetState($DummyForm3+2+(3*$a), 64)
			GUICtrlSetState($DummyForm3+3+(3*$a), 64)
		Else
			GUICtrlSetData($DummyForm3+2+(3*$a), " ")
			GUICtrlSetState($DummyForm3+2+(3*$a), 128)
			GUICtrlSetData($DummyForm3+3+(3*$a), "1")
			GUICtrlSetState($DummyForm3+3+(3*$a), 128)
		EndIf
	Next
EndFunc
Func _ResetForm3()
	For $a = 0 To 59
		GUICtrlSetState($DummyForm3+1+(3*$a), 4)
		GUICtrlSetData($DummyForm3+2+(3*$a), " ")
		GUICtrlSetState($DummyForm3+2+(3*$a), 128)
		GUICtrlSetData($DummyForm3+3+(3*$a), "1")
		GUICtrlSetState($DummyForm3+3+(3*$a), 128)
	Next
EndFunc
Func _HideForm3()
	GUISetState(@SW_ENABLE, $Form)
	GUISetState(@SW_HIDE, $Form3)
	WinActivate($Form)
EndFunc
Func _ShowForm3()
	GUISetState(@SW_DISABLE, $Form)
	GUISetState(@SW_SHOW, $Form3)
	WinActivate($Form3)
EndFunc
Func _EvalForm3()
	Global $Msg
	For $a = 0 To 59
		If BitAND(GUICtrlRead($DummyForm3+1+(3*$a)), $GUI_CHECKED) Then
			$CodeAddr1="_L 0x104D3"&Hex(Int(Dec("66C")+($a)*4), 3)
			$CodeAddr2="_L 0x104D3"&Hex(Int(Dec("66E")+($a)*4), 3)
			$CodeExt1=" 0x00000"&$Tools[_ArraySearch($Tools, GUICtrlRead($DummyForm3+2+(3*$a)))][0]
			$CodeExt2=" 0x"&Hex(GUICtrlRead($DummyForm3+3+(3*$a)))
			$Msg &= "_C1 Toolbox "&GUICtrlRead($DummyForm3+1+(3*$a), 1)&", "&GUICtrlRead($DummyForm3+2+(3*$a))&" "&GUICtrlRead($DummyForm3+3+(3*$a))&"pcs"&@CRLF
			$Msg &= $CodeAddr1&$CodeExt1&@CRLF
			$Msg &= $CodeAddr2&$CodeExt2&@CRLF
		EndIf
	Next
EndFunc
; Form4 Functions, original file : form4.au3
Func Form4()
	$Form4 = GUICreate("Item in fridge", 710, 515, -1, -1, $WS_MINIMIZEBOX, "", $Form)
	$DummyForm4 = GUICtrlCreateDummy()
	For $a = 0 to 19
		;
		GUICtrlCreateCheckbox("Slot #"&($a*3)+1, 2, 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm4")
		GUICtrlCreateCombo(" ", 62, 2+(23*$a), 145, 25, BitOR($CBS_SORT,$CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
		_SetComboData($Fridge)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateInput("1", 209, 2+(23*$a), 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetState(-1, 128)
		;
		GUICtrlCreateCheckbox("Slot #"&($a*3)+2, 2+(234*1), 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm4")
		GUICtrlCreateCombo(" ", 62+(234*1), 2+(23*$a), 145, 25, BitOR($CBS_SORT,$CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
		_SetComboData($Fridge)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateInput("1", 209+(234*1), 2+(23*$a), 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetState(-1, 128)
		;
		GUICtrlCreateCheckbox("Slot #"&($a*3)+3, 2+(234*2), 2+(23*$a))
		GUICtrlSetOnEvent(-1, "_ToogleCheckboxForm4")
		GUICtrlCreateCombo(" ", 62+(234*2), 2+(23*$a), 145, 25, BitOR($CBS_SORT,$CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_DISABLENOSCROLL,$WS_VSCROLL))
		_SetComboData($Fridge)
		GUICtrlSetState(-1, 128)
		GUICtrlCreateInput("1", 209+(234*2), 2+(23*$a), 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetState(-1, 128)
	Next
	GUICtrlCreateButton("OK", 529, 461, 87)
	GUICtrlSetOnEvent(-1, "_HideForm4")
	GUICtrlCreateButton("Reset", 616, 461, 87)
	GUICtrlSetOnEvent(-1, "_ResetForm4")
	GUISetState(@SW_HIDE, $Form4)
EndFunc
Func _ToogleCheckboxForm4()
	For $a = 0 To 59
		If BitAND(GUICtrlRead($DummyForm4+1+(3*$a)), $GUI_CHECKED) Then
			GUICtrlSetState($DummyForm4+2+(3*$a), 64)
			GUICtrlSetState($DummyForm4+3+(3*$a), 64)
		Else
			GUICtrlSetData($DummyForm4+2+(3*$a), " ")
			GUICtrlSetState($DummyForm4+2+(3*$a), 128)
			GUICtrlSetData($DummyForm4+3+(3*$a), "1")
			GUICtrlSetState($DummyForm4+3+(3*$a), 128)
		EndIf
	Next
EndFunc
Func _ResetForm4()
	For $a = 0 To 59
		GUICtrlSetState($DummyForm4+1+(3*$a), 4)
		GUICtrlSetData($DummyForm4+2+(3*$a), " ")
		GUICtrlSetState($DummyForm4+2+(3*$a), 128)
		GUICtrlSetData($DummyForm4+3+(3*$a), "1")
		GUICtrlSetState($DummyForm4+3+(3*$a), 128)
	Next
EndFunc
Func _HideForm4()
	GUISetState(@SW_ENABLE, $Form)
	GUISetState(@SW_HIDE, $Form4)
	WinActivate($Form)
EndFunc
Func _ShowForm4()
	GUISetState(@SW_DISABLE, $Form)
	GUISetState(@SW_SHOW, $Form4)
	WinActivate($Form4)
EndFunc
Func _EvalForm4()
	Global $Msg
	For $a = 0 To 59
		If BitAND(GUICtrlRead($DummyForm4+1+(3*$a)), $GUI_CHECKED) Then
			$CodeAddr1="_L 0x104D3"&Hex(Int(Dec("76C")+($a)*4), 3)
			$CodeAddr2="_L 0x104D3"&Hex(Int(Dec("76E")+($a)*4), 3)
			$CodeExt1=" 0x00000"&$Fridge[_ArraySearch($Fridge, GUICtrlRead($DummyForm4+2+(3*$a)))][0]
			$CodeExt2=" 0x"&Hex(GUICtrlRead($DummyForm4+3+(3*$a)))
			$Msg &= "_C1 Fridge "&GUICtrlRead($DummyForm4+1+(3*$a), 1)&", "&GUICtrlRead($DummyForm4+2+(3*$a))&" "&GUICtrlRead($DummyForm4+3+(3*$a))&"pcs"&@CRLF
			$Msg &= $CodeAddr1&$CodeExt1&@CRLF
			$Msg &= $CodeAddr2&$CodeExt2&@CRLF
		EndIf
	Next
EndFunc
; Form5 Functions, original file : form5.au3
Func Form5()
	$Form5 = GUICreate("Max affection with villagers", 207, 263, -1, -1, $WS_MINIMIZEBOX, "", $Form)
	$DummyForm5 = GUICtrlCreateDummy()
	GUICtrlCreateCheckbox($Peoples[0][2], 4, 2)
	GUICtrlCreateCheckbox($Peoples[1][2], 68, 2)
	GUICtrlCreateCheckbox($Peoples[2][2], 136, 2)
	GUICtrlCreateCheckbox($Peoples[3][2], 4, 25)
	GUICtrlCreateCheckbox($Peoples[4][2], 68, 25)
	GUICtrlCreateCheckbox($Peoples[5][2], 136, 25)
	GUICtrlCreateCheckbox($Peoples[6][2], 4, 48)
	GUICtrlCreateCheckbox($Peoples[7][2], 68, 48)
	GUICtrlCreateCheckbox($Peoples[8][2], 4, 71)
	GUICtrlCreateCheckbox($Peoples[9][2], 68, 71)
	GUICtrlCreateCheckbox($Peoples[10][2], 136, 71)
	GUICtrlCreateCheckbox($Peoples[11][2], 4, 94)
	GUICtrlCreateCheckbox($Peoples[12][2], 68, 94)
	GUICtrlCreateCheckbox($Peoples[13][2], 136, 94)
	GUICtrlCreateCheckbox($Peoples[14][2], 4, 117)
	GUICtrlCreateCheckbox($Peoples[15][2], 68, 117)
	GUICtrlCreateCheckbox($Peoples[16][2], 136, 117)
	GUICtrlCreateCheckbox($Peoples[17][2], 4, 140)
	GUICtrlCreateCheckbox($Peoples[18][2], 68, 140)
	GUICtrlCreateCheckbox($Peoples[19][2], 136, 140)
	GUICtrlCreateCheckbox($Peoples[20][2], 4, 163)
	GUICtrlCreateCheckbox($Peoples[21][2], 68, 163)
	GUICtrlCreateCheckbox($Peoples[22][2], 136, 163)
	GUICtrlCreateCheckbox($Peoples[23][2], 4, 186)
	GUICtrlCreateCheckbox($Peoples[24][2], 68, 186)
	GUICtrlCreateCheckbox($Peoples[25][2], 136, 186)
	GUICtrlCreateButton("OK", 3, 207, 96)
	GUICtrlSetOnEvent(-1, "_HideForm5")
	GUICtrlCreateButton("Reset", 101, 207, 97)
	GUICtrlSetOnEvent(-1, "_ResetForm5")
	GUISetState(@SW_HIDE, $Form5)
EndFunc
Func _ResetForm5()
	For $a = 0 To UBound($Peoples)-1
		GUICtrlSetState($DummyForm5+1+$a, 4)
	Next
EndFunc
Func _HideForm5()
	GUISetState(@SW_ENABLE, $Form)
	GUISetState(@SW_HIDE, $Form5)
	WinActivate($Form)
EndFunc
Func _ShowForm5()
	GUISetState(@SW_DISABLE, $Form)
	GUISetState(@SW_SHOW, $Form5)
	WinActivate($Form5)
EndFunc
Func _EvalForm5()
	Global $Msg
	For $a = 0 To UBound($Peoples)-1
		If BitAND(GUICtrlRead($DummyForm5+1+$a), $GUI_CHECKED) Then
			$Msg &= "_C1 Max affection ["&$Peoples[$a][2]&"]"&@CRLF
			$Msg &= "_L 0x104F3"&$Peoples[$a][0]&" "
			$Msg &= "0x00000"&$Peoples[$a][1]&@CRLF
		EndIf
	Next
EndFunc
; _PreviewCheatCodeForm function, original file : preview-form.au3
Func _PreviewCheatCodeForm($Message)
	GUISetState(@SW_DISABLE, $Form)
	Global $PreviewForm = GUICreate("Cheat code(s) preview - Press Esc to exit", 261, 283, -1, -1, $WS_MINIMIZEBOX, "", $Form)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_ExitPreview")
	GUICtrlCreateEdit($Message, 0, 0, 256, 256, BitOR($ES_WANTRETURN,$WS_VSCROLL,$WS_HSCROLL))
	GUICtrlSetFont(-1, 9, 400, 0, "Lucida Console")
	GUISetState(@SW_SHOW)
	While 1
		If BitAND(WinGetState($PreviewForm), 8) Then
			HotKeySet("{esc}", "_ExitPreview")
		Else
			HotKeySet("{esc}")
			ExitLoop
		EndIf
	WEnd
EndFunc
Func _ExitPreview()
	GUIDelete($PreviewForm)
	GUISetState(@SW_ENABLE, $Form)
	Sleep(1)
	WinActivate($Form)
EndFunc