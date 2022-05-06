﻿$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera-beta/87.0.4390.17/win/Opera_beta_87.0.4390.17_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera-beta/87.0.4390.17/win/Opera_beta_87.0.4390.17_Setup_x64.exe'
  checksum       = 'afc05a0a48160d51735bea7bd6b1264f14b3107eecb47df67990ca8ea24d0c6a'
  checksum64     = '11bc49ff0b2c68935df88b69141ec2927234ddec4853746993af8eb1eb4d427f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '87.0.4390.17'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
