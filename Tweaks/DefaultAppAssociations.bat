@NET SESSION > NUL 2> NUL || PowerShell -Command "Start-Process \"%0\" -Verb RunAs" && EXIT
@ECHO OFF
CD /D "%~dp0\..\Extra\"
COPY "defaultassociations.xml" "c:\windows\system32\defaultassociations.xml"
DISM /online /Import-DefaultAppAssociations:"..\Extra\DefaultAppAssociations.xml"
EXIT /B
