# Import modules not available by default in Function Apps

$ModulePath = 'D:\home\lib\PSModules'

# Add to PSModulePath
$env:PSModulePath += ";$ModulePath"

# We can list available modules starting with Az
#Get-Module -ListAvailable Az*

# Import specific modules from Az - these take around 3 seconds on a consumption plan, and 2 on a production S1
Import-Module Az.Accounts
Import-Module Az.Resources