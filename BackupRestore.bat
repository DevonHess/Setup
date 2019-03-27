@net session >nul 2>&1 || powershell -Command "Start-Process \"%0\" -Verb RunAs" && exit
@ECHO OFF
CD /D "%~dp0\Data\"

SET reg=reg.txt
SET data=data.txt

CHOICE /CS /C brBR /M "Backup or Restore"
ECHO:

:run
IF %ERRORLEVEL% EQU 1 GOTO :backup
IF %ERRORLEVEL% EQU 3 GOTO :backup
IF %ERRORLEVEL% EQU 2 GOTO :restore
IF %ERRORLEVEL% EQU 3 GOTO :restore
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
		CALL :color [33m
		ROBOCOPY "%%~dpG\" "data%%~pG\" "%%~nxG" /S /NJH /NJS
		CALL :color [0m
	)
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
		CALL :color [33m
		ROBOCOPY "data%%~pG\" "%%~dpG\" "%%~nxG" /S /NJH /NJS
		CALL :color [0m
	)
:end
IF %ERRORLEVEL% GEQ 3 (
	IF [%data%]==[data.txt] (
		SET data=big.txt
		SET /A ERRORLEVEL=%ERRORLEVEL%-2
		GOTO :run
	)
)
PAUSE

:color
ECHO %1
EXIT /B
