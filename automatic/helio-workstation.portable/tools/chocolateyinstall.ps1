﻿$ErrorActionPreference = 'Stop';

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  file          = "$toolsDir\helio-3.7-x32.zip"
  file64        = "$toolsDir\helio-3.7-x64.zip"
}

Install-ChocolateyZipPackage  @packageArgs

