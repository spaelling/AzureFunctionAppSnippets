<#
$ModulePath must not already contain the modules or this may fail
#>

$ModulePath = 'D:\home\lib2\PSModules'
New-Item -ItemType Directory -Path $ModulePath -Force | Out-Null

$NuGet = Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue
if($null -eq $NuGet)
{
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser
}

"Saving modules to $ModulePath"
Save-Module Az -Path $ModulePath -Force

"Listing import commands for every module"
Get-ChildItem -Path $ModulePath -Include "*.psd1" -Recurse | ForEach-Object {
    "Import-Module '$($_.FullName)'"
}