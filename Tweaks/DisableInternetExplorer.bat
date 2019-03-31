@NET SESSION > NUL 2> NUL || PowerShell -Command "Start-Process \"%0\" -Verb RunAs" && EXIT
@ECHO OFF
DISM /Online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64 /NoRestart
EXIT /B
