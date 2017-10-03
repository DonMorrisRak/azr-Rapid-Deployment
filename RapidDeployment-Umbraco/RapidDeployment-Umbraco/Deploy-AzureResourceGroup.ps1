### UMBRACO Rapid Deployment Template
### Customer Name

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId ""

### Define and create Reosurce Groups
$loc = 'North Europe'
$ALLRGname = 'NEU-UMBR-RSG-ALL-PRD'
$PRDRGname = 'NEU-UMBR-RSG-CST-PRD'

$rsgnames = @($ALLRGname, $PRDRGname)
foreach ($rsg in $rsgnames){
   if ((Get-AzureRmResourceGroup $rsg -ErrorAction SilentlyContinue) -eq $null) {
       New-AzureRmResourceGroup -Name $rsg -Location $loc
   }
}

#Web App
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-UMBRACO-WEBAPP' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-Umbraco\RapidDeployment-Umbraco\UMBR_WebApp.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-Umbraco\RapidDeployment-Umbraco\UMBR_WebApp.parameters.json'`
   -Force -Verbose

#Redis Cache
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-UMBRACO-REDIS' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-Umbraco\RapidDeployment-Umbraco\UMBR_Redis.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-Umbraco\RapidDeployment-Umbraco\UMBR_Redis.parameters.json'`
   -Force -Verbose

#Paas SQL - Elastic Pool
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-UMBRACO-SQL' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-Umbraco\RapidDeployment-Umbraco\UMBR_SQLpaas.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-Umbraco\RapidDeployment-Umbraco\UMBR_SQLpaas.parameters.json'`
   -Force -Verbose

#Storage Account
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-UMBRACO-STORAGE' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-Umbraco\RapidDeployment-Umbraco\UMBR_Storage.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-Umbraco\RapidDeployment-Umbraco\UMBR_Storage.parameters.json'`
   -Force -Verbose

#CDN
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-UMBRACO-CDN' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-Umbraco\RapidDeployment-Umbraco\UMBR_CDN.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-Umbraco\RapidDeployment-Umbraco\UMBR_CDN.parameters.json'`
   -Force -Verbose