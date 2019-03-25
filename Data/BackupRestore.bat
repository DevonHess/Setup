@net session >nul 2>&1 || powershell -Command "Start-Process \"%0\" -Verb RunAs" && exit
@echo off
choice /cs /c brBR /m "Backup or Restore"
set reg=reg.txt
set data=data.txt
:run
if %errorlevel% equ 1 goto :backup
if %errorlevel% equ 3 goto :backup
if %errorlevel% equ 2 goto :restore
if %errorlevel% equ 3 goto :restore
:backup
	for /F "tokens=*" %%G in (%~dp0%reg%) do (
		md "%~dp0reg\%%G"
		del "%~dp0reg\%%G\%%~nG.reg"
		reg export "%%G" "%~dp0reg\%%G\%%~nG.reg"
	)
	for /F "tokens=*" %%G in (%~dp0%data%) do (
		robocopy "%%~dpG\" "%~dp0data%%~pG\" "%%~nxG" /s
	)
goto :end
:restore
	for /F "tokens=*" %%G in (%~dp0%reg%) do (
		reg import "%~dp0reg\%%G\%%~nG.reg"
	)
	for /F "tokens=*" %%G in (%~dp0%data%) do (
		robocopy "%~dp0data%%~pG\" "%%~dpG\" "%%~nxG" /s
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
