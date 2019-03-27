FOR /F "delims=" %%G IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO"') DO (
	ECHO Installing %%~nG
	REG ADD "%%G" /F /V OptOut /T REG_DWORD /D 00000001
)
EXIT /B
