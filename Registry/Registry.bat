@net session >nul 2>&1 || powershell -Command "Start-Process \"%0\" -Verb RunAs" && exit
@CD /D "%~dp0"
@ECHO OFF
SETLOCAL EnableDelayedExpansion

FOR /F %%G IN ('DIR /B *.reg ^| FIND /C /V ""') DO CHOICE /M "Install all "%%G" files?"
SET all=%ERRORLEVEL%
CLS

FOR /R %%G IN (*.reg) DO (
	IF %all%==1 (
		SET choice=1
	) else (
		CALL :color %%G
		CHOICE /M "Install "%%~nxG"?"
		SET choice=!ERRORLEVEL!
		CLS
	)
	IF !choice! EQU 1 (
		ECHO Installing %%~nxG
		REG IMPORT %%G
		ECHO:
	)
)
PAUSE
EXIT

:color
ECHO [36m
TYPE %1
ECHO [0m
EXIT /B
