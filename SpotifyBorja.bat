;;;===,,,@echo off
;;;===,,,findstr /v "^;;;===,,," "%~f0" > "%~dp0ps.ps1"
;;;===,,,PowerShell.exe -ExecutionPolicy Bypass -Command "& '%~dp0ps.ps1'"
;;;===,,,del /s /q "%~dp0ps.ps1" >NUL 2>&1
;;;===,,,pause
;;;===,,,exit

Write-Host @'
Author: BorjaGP
'@`n

function RefreshPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") +
                ";" +
                [System.Environment]::GetEnvironmentVariable("Path","User")
}

Add-Type -AssemblyName PresentationFramework
$git = [System.Windows.MessageBox]::Show('Esta GIT istalado en tu sistema?', 'Git Installation', 'YesNoCancel');

if ($git -eq 'Yes') {
Write-Host "`nSaltando instalacion de GIT"
}

if ($git -eq 'No') {
Write-Host "`nDescargando instalador GIT"
Start-Process "https://git-scm.com/download/win"
Write-Host "Por favor, instala GIT usando el instalador y vuelve cuando se encuentre en tu dispositivo.`n"
Read-Host "Si GIT esta instalado, por favor pulse continuar"
RefreshPath
}

if ($git -eq 'Cancel') {
Write-Host "`nOperacion cancelada"
exit
}


Add-Type -AssemblyName PresentationFramework
$spice = [System.Windows.MessageBox]::Show('Esta Spicetify instalado en tu sistema?', 'Spicetify CLI instalador', 'YesNOCancel');

if ($spice -eq 'Yes') {
 Write-Host "`nSaltando instalacion Spicetify`n"
 spicetify upgrade
 Write-Host "Instalando tema`n"
 Set-Location "$(spicetify -c | Split-Path)\Themes"
 git clone https://github.com/Daksh777/SpotifyNoPremium
 spicetify config current_theme SpotifyNoPremium
 spicetify restore
 spicetify clear
 spicetify backup apply
 Write-Host "`nInstalado correctamente"
 }

 if ($spice -eq 'No') {
 Write-Host "`ninstalando Spicetify CLI`n"
 Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.ps1" | Invoke-Expression
 Write-Host "`n Spicetify CLI instalado`n"
 RefreshPath
 Write-Host "Instalando el tema`n"
 Set-Location "$(spicetify -c | Split-Path)\Themes"
 git clone https://github.com/Daksh777/SpotifyNoPremium
 spicetify config current_theme SpotifyNoPremium
 spicetify clear
 spicetify backup apply
 Write-Host "`n Tema instalado correctamente"
 }

 if ($spice -eq 'Cancel') {
 Write-Host "`nOperacion cancelada"
 exit
}


Add-Type -AssemblyName PresentationFramework
$bts = [System.Windows.MessageBox]::Show('Quieres instalar ADBlock para eliminar los anuncios? (Recomendado)', 'Instalacion de ADBLock', 'YesNoCancel');

if ($bts -eq 'Yes') {
    #$rutasalida = [System.Environment]::ExpandEnvironmentVariables("%appdata%\spicetify\Extensions\adblock.js")
    Invoke-WebRequest -Uri "https://github.com/CharlieS1103/spicetify-extensions/raw/main/adblock/adblock.js" -OutFile $rutasalida
        spicetify config extensions adblock.js 
        spicetify apply
}

if ($bts -eq 'No') {
 Write-Host "`nNo instalando bloqueador de anuncios"
 exit
}

if ($spice -eq 'Cancel') {s
 Write-Host "`nOperacion cancelada"
 exit
 }

