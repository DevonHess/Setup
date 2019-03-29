@NET SESSION > NUL 2> NUL || PowerShell -Command "Start-Process \"%0\" -Verb RunAs" && EXIT
@ECHO OFF
CD /D "%~dp0\..\Data\"

SET reg=reg.txt
SET data=data.txt

SET ERRORLEVEL=%1

ECHO [35m
ECHO Backing Up / Restoring
ECHO:
ECHO [0m

IF [%1]==[] (CHOICE /CS /C brBR /M "Backup or Restore" & ECHO:)

SET choice=%ERRORLEVEL%

:run
IF %choice% EQU 1 GOTO :backup
IF %choice% EQU 3 GOTO :backup
IF %choice% EQU 2 GOTO :restore
IF %choice% EQU 4 GOTO :restore
:backup
	ECHO Backing Up
	ECHO:
	FOR /F "tokens=*" %%G IN (%reg%) DO (
		ECHO Exporting %%~nG.reg
		CALL :color [36m
		md "reg\%%G"
		del "reg\%%G\%%~nG.reg"
		REG EXPORT "%%G" "reg\%%G\%%~nG.reg"
		CALL :color [0m
	)
	FOR /F "tokens=*" %%G IN (%data%) DO (
		ECHO Backing up %%~pnG
		CALL :color [32m
		ROBOCOPY "%%~dpG\" "data%%~pG\" "%%~nxG" /S /NJH /NJS
		CALL :color [0m
	)
	ECHO Backup Complete
GOTO :end
:restore
	ECHO Restoring
	ECHO:
	FOR /F "tokens=*" %%G IN (%reg%) DO (
		ECHO Importing %%~nG.reg
		CALL :color [36m
		REG IMPORT "reg\%%G\%%~nG.reg"
		CALL :color [0m
	)
	FOR /F "tokens=*" %%G IN (%data%) DO (
		ECHO Restoring %%~pnG
		CALL :color [32m
		ROBOCOPY "data%%~pG\" "%%~dpG\" "%%~nxG" /S /NJH /NJS
		CALL :color [0m
	)
	ECHO Restore Complete
:end
IF %choice% GEQ 3 (
	IF [%data%]==[data.txt] (
		SET data=big.txt
		SET /A choice=%choice%-2
		GOTO :run
	)
)
EXIT /B

:color
ECHO %1
EXIT /B
