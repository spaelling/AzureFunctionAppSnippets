# Import modules not available by default in Function Apps

$ModulePath = 'D:\home\lib\PSModules'

# Add to PSModulePath
$env:PSModulePath += ";$ModulePath"

# We can list available modules starting with Az
#Get-Module -ListAvailable Az*

# Import specific modules from Az
Import-Module Az.Accounts
Import-Module Az.Resources