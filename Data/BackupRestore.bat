@net session >nul 2>&1 || powershell -Command "Start-Process \"%0\" -Verb RunAs" && exit
@echo off

set reg=reg.txt
set data=data.txt

choice /cs /c brBR /m "Backup or Restore"
ECHO:

:run
if %errorlevel% equ 1 goto :backup
if %errorlevel% equ 3 goto :backup
if %errorlevel% equ 2 goto :restore
if %errorlevel% equ 3 goto :restore
:backup
	for /F "tokens=*" %%G in (%~dp0%reg%) do (
		ECHO Exporting %%~nG.reg
		CALL :color [36m
		md "%~dp0reg\%%G"
		del "%~dp0reg\%%G\%%~nG.reg"
		reg export "%%G" "%~dp0reg\%%G\%%~nG.reg"
		CALL :color [0m
	)
	for /F "tokens=*" %%G in (%~dp0%data%) do (
		ECHO Backing up %%~pnG
		CALL :color [33m
		robocopy "%%~dpG\" "%~dp0data%%~pG\" "%%~nxG" /s
		CALL :color [0m
	)
goto :end
:restore
	for /F "tokens=*" %%G in (%~dp0%reg%) do (
		ECHO Importing %%~nG.reg
		CALL :color [36m
		reg import "%~dp0reg\%%G\%%~nG.reg"
		CALL :color [0m
	)
	for /F "tokens=*" %%G in (%~dp0%data%) do (
		ECHO Restoring %%~pnG
		CALL :color [33m
		robocopy "%~dp0data%%~pG\" "%%~dpG\" "%%~nxG" /s
		CALL :color [0m
	)
:end
if %errorlevel% geq 3 (
	if [%data%]==[data.txt] (
		set data=big.txt
		set /a errorlevel=%errorlevel%-2
		goto :run
	)
)
pause

:color
ECHO %1
EXIT /B
