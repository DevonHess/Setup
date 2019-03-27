@net session >nul 2>&1 || powershell -Command "Start-Process \"%0\" -Verb RunAs" && exit
@CD /D "%~dp0\Registry\"
@ECHO OFF
SETLOCAL EnableDelayedExpansion

FOR /F %%G IN ('DIR /B * ^| FIND /C /V ""') DO CHOICE /M "Install all "%%G" files?"
SET all=%ERRORLEVEL%
CLS

FOR /R %%G IN (*) DO (
	IF %all%==1 (
		SET choice=1
	) ELSE (
		CALL :color "%%G"
		CHOICE /M "Install "%%~nxG"?"
		SET choice=!ERRORLEVEL!
		CLS
	)
	IF !choice! EQU 1 (
		IF %%~xG==.reg (
			ECHO Installing %%~nxG
			REG IMPORT "%%G"
			ECHO:
		) ELSE (
			ECHO Running %%~nxG
			CALL "%%G"
			ECHO:
		)
	)
)
PAUSE
EXIT

:color
ECHO [36m
TYPE %1
ECHO [0m
EXIT /B
