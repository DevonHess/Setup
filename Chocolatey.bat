:: Run as administrator
@net session >nul 2>&1 || powershell -Command "Start-Process \"%0\" -Verb RunAs" && exit

:: Install Chocolatey
@where choco > nul 2> nul || @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco upgrade -y chocolatey
choco upgrade -y GoogleChrome
choco upgrade -y IrfanView
choco upgrade -y IrfanViewplugins
choco upgrade -y mpv
choco upgrade -y k-litecodecpackbasic
::choco upgrade -y vlc
::choco upgrade -y foobar2000
choco upgrade -y vim
choco upgrade -y HxD
choco upgrade -y libreoffice
choco upgrade -y sumatrapdf.install
::choco upgrade -y pidgin
choco upgrade -y discord
choco upgrade -y steam
choco upgrade -y qbittorrent
::choco upgrade -y jdownloader
::choco upgrade -y sharex
::choco upgrade -y keepass
choco upgrade -y paint.net
::choco upgrade -y krita
::choco upgrade -y gimp
::choco upgrade -y opentoonz
::choco upgrade -y blender
choco upgrade -y audacity
::choco upgrade -y obs-studio
choco upgrade -y duplicati
choco upgrade -y 7zip
choco upgrade -y winscp
choco upgrade -y wamp-server
choco upgrade -y Cygwin
choco upgrade -y git --params "/NoShellIntegration"
choco upgrade -y nircmd
choco upgrade -y pandoc rsvg-convert python miktex
choco upgrade -y curl
choco upgrade -y Wget
choco upgrade -y youtube-dl
choco upgrade -y autohotkey
choco upgrade -y QTTabBar
::choco upgrade -y displayFusion
choco upgrade -y processhacker
choco upgrade -y vcredist-all
choco upgrade -y directx
::choco upgrade -y flashplayerplugin
choco upgrade -y javaruntime
::choco upgrade -y geforce-game-ready-driver
choco upgrade -y nvidia-display-driver --params "'/HDAudio /NV3DVision'"
::choco upgrade -y winpcap
::choco upgrade -y logitechgaming
