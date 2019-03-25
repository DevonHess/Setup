@net session >nul 2>&1 || powershell -Command "Start-Process \"%0\" -Verb RunAs" && exit
@CD /d "%~dp0"
@ECHO OFF
SETLOCAL EnableDelayedExpansion

CHOICE /m "Install all?"
SET all=%ERRORLEVEL%
CLS

FOR /r %%i in (*.reg) DO (
	IF %all%==1 (
		SET choice=1
	) else (
		CALL :color %%i
		CHOICE /m "Install "%%~nxi"?"
		SET choice=!ERRORLEVEL!
		CLS
	)
	IF !choice! EQU 1 (
		REG IMPORT %%i
	)
)
PAUSE
EXIT

:color
ECHO [36m
TYPE %1
ECHO [0m
EXIT /B
