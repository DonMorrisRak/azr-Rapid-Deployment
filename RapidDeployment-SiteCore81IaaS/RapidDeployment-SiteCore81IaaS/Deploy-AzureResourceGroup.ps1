### Sitecore 8.1 IaaS Rapid Deployment Template
### Customer Name

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId ""

### Define and create Reosurce Groups
$loc = 'North Europe'
$ALLRGname = 'NEU-STCR-RSG-ALL-PRD'
$PRDRGname = 'NEU-STCR-RSG-CST-PRD'
$DEVRGname = 'NEU-STCR-RSG-CST-DEV'
$QARGname = 'NEU-STCR-RSG-CST-QA'

$rsgnames = @($ALLRGname, $PRDRGname, $DEVRGname, $QARGname)
foreach ($rsg in $rsgnames){
   if ((Get-AzureRmResourceGroup $rsg -ErrorAction SilentlyContinue) -eq $null) {
       New-AzureRmResourceGroup -Name $rsg -Location $loc
   }
}

#Shared
##VNET
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-VNET' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $ALLRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VNET.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VNET.parameters.json'`
   -Force -Verbose
##OMS
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-OMS' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $ALLRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\OMS.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\OMS.parameters.json'`
   -Force -Verbose
##ADDS
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-ADDS' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\Domain_Services_multi.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\Domain_Services_multi.parameters.json'`
   -Force -Verbose

#PRD
##CBT
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-CBT-PRD' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi_PRD_CBT.parameters.json'`
   -Force -Verbose
##CD
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-CD-PRD' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi_PRD_CD.parameters.json'`
   -Force -Verbose
##CMS
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-CMS-PRD' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi_PRD_CMS.parameters.json'`
   -Force -Verbose
##SOLR
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-SOLR-PRD' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi_PRD_SOLR.parameters.json'`
   -Force -Verbose
##SQL Witness
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-WIT-PRD' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi_PRD_WIT.parameters.json'`
   -Force -Verbose
##SQL 1
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-SQL1-PRD' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_SQL_single.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_SQL_single_PRD_SQL1.parameters.json'`
   -Force -Verbose
##SQL 2
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-SQL2-PRD' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_SQL_single.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_SQL_single_PRD_SQL2.parameters.json'`
   -Force -Verbose
##Application Gateway PRD
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-AGW-PRD' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $PRDRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\AGW.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\AGW_PRD.parameters.json'`
   -Force -Verbose

#QA
##CD
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-CD-QA' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $QARGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi_QA_CD.parameters.json'`
   -Force -Verbose
##CMS
   New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-CMS-QA' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $QARGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi_QA_CMS.parameters.json'`
   -Force -Verbose
##SOLR
   New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-SOLR-QA' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $QARGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi_QA_SOLR.parameters.json'`
   -Force -Verbose
##SQL
   New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-SQL-QA' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $QARGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_SQL_single.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_SQL_single_QA_SQL1.parameters.json'`
   -Force -Verbose
##Application Gateway QA
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-AGW-QA' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $QARGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\AGW.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\AGW_QA.parameters.json'`
   -Force -Verbose

#Dev
##CDCMS
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-CDCMS-DEV' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $DEVRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_multi_DEV_CDCMS.parameters.json'`
   -Force -Verbose
##SQL
New-AzureRmResourceGroupDeployment -Mode Incremental -Name ('NEU-STCR-SQL-DEV' + '-' + ((Get-Date).ToUniversalTime()).ToString('yyyyMMdd-HHmm')) `
   -ResourceGroupName $DEVRGname `
   -TemplateFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_SQL_single.json' `
   -TemplateParameterFile 'H:\VisualStudio\RapidDeployment-SiteCore81IaaS\RapidDeployment-SiteCore81IaaS\VM_SQL_single_DEV_SQL1.parameters.json'`
   -Force -Verbose