# Import all module Powershell scripts
Import-Module $env:SyncroModule
Get-ChildItem $PSScriptRoot\*.ps1 -Recurse | % { . $_.FullName }