@NET SESSION > NUL 2> NUL || PowerShell -Command "Start-Process \"%0\" -Verb RunAs" && EXIT
@ECHO OFF
FOR /F %%G IN ('WMIC USERACCOUNT WHERE name^=^"%username%^" GET SID ^| FIND ^"S-^"') DO (
	ECHO Importing to %%G
	REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\%%G" /F /V OptOut /T REG_DWORD /D 00000001
)
EXIT /B
