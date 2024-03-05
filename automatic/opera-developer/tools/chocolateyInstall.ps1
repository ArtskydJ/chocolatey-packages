﻿$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera-developer/109.0.5097.0/win/Opera_Developer_109.0.5097.0_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera-developer/109.0.5097.0/win/Opera_Developer_109.0.5097.0_Setup_x64.exe'
  checksum       = '7227c1153fab4470ba10b2a41dd03463f2b167ae4d0878f7498a9790b2333295'
  checksum64     = 'b26f307e6afdd4a7a078791f56c8cb4d99adaff02d1f0dc866589a060f449c7c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '109.0.5097.0'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
