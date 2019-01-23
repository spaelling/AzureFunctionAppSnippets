# Import modules not available by default in Function Apps
# see here on how to install modules
# https://github.com/spaelling/AzureFunctionAppSnippets/blob/master/PowerShell/HT_InstallModule.ps1

# install your custom PS modules here
$ModulePath = 'D:\home\lib\PSModules'

# Add to PSModulePath
$env:PSModulePath += ";$ModulePath"
# remove the path where the older version of AzureRm resides, then we do not need to use -MinimumVersion in Import-Module
$env:PSModulePath = ($env:PSModulePath.Split(';') | Where-Object {$_ -ne 'D:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ResourceManager\AzureResourceManager\'}) -join ';'

# We can list available modules starting with Az
#Get-Module -ListAvailable Az*

# Import specific modules
Import-Module AzureRm.Profile
Import-Module AzureRM.Resources

# remember to put this into enviroment variables
$TenantId = $env:TenantId
# this one is already there
$AccountId = $env:WEBSITE_SITE_NAME

# requires that you have enabled MSI in the "identity" option in the function app
$apiVersion = "2017-09-01"
$resourceURI = "https://management.azure.com/"
$tokenAuthURI = $env:MSI_ENDPOINT + "?resource=$resourceURI&api-version=$apiVersion"
$tokenResponse = Invoke-RestMethod -Method Get -Headers @{"Secret"="$env:MSI_SECRET"} -Uri $tokenAuthURI
$accessToken = $tokenResponse.access_token
$DefaultProfile = Login-AzureRmAccount -Tenant $TenantId -AccountId $AccountId -AccessToken $accessToken -Scope Process

# will use this defaultprofile in all calls to AzureRm cmdlets
$PSDefaultParameterValues.Add("*AzureRm*:DefaultProfile", $DefaultProfile)

(Get-AzureRmResource).Count