#
# Module manifest for module 'PSFive9Admin'
#
# Generated by: sqone2
#
# Generated on: 11/6/2019
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSFive9Admin.psm1'

# Version number of this module.
ModuleVersion = '1.0.106'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '90d48a6d-729b-43c4-99af-a25120752ca3'

# Author of this module
Author = 'sqone2'

# Company or vendor of this module
CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = '(c) 2019 sqone2. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Functions for working with the Five9 Admin Web Service API'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.1.0.53'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @('PSFive9Admin.Format.ps1xml')

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @('Connect-Five9AdminWebService','Get-Five9AdminWebService','Add-Five9AgentGroupMember','Get-Five9AgentGroup','Get-Five9AgentGroupMember','New-Five9AgentGroup','Remove-Five9AgentGroup','Remove-Five9AgentGroupMember','Set-Five9AgentGroup','Get-Five9CallVariable','Get-Five9CallVariableGroup','New-Five9CallVariable','New-Five9CallVariableGroup','Remove-Five9CallVariable','Remove-Five9CallVariableGroup','Set-Five9CallVariable','Set-Five9CallVariableGroup','Get-Five9CampaignProfile','New-Five9CampaignProfile','Remove-Five9CampaignProfile','Set-Five9CampaignProfile','Add-Five9CampaignDisposition','Remove-Five9CampaignDisposition','Add-Five9CampaignDNIS','Remove-Five9CampaignDNIS','Add-Five9CampaignList','Get-Five9CampaignList','Remove-Five9CampaignList','Add-Five9CampaignSkill','Remove-Five9CampaignSkill','Reset-Five9Campaign','Reset-Five9CampaignDisposition','Reset-Five9CampaignListPosition','Start-Five9Campaign','Stop-Five9Campaign','Get-Five9Campaign','New-Five9InboundCampaign','New-Five9OutboundCampaign','Remove-Five9Campaign','Set-Five9InboundCampaign','Set-Five9OutboundCampaign','Get-Five9ContactField','New-Five9ContactField','Remove-Five9ContactField','Set-Five9ContactField','Add-Five9ContactRecord','Get-Five9ContactImportResult','Get-Five9ContactRecord','Remove-Five9ContactRecord','Get-Five9Disposition','New-Five9Disposition','Remove-Five9Disposition','Set-Five9Disposition','Add-Five9DNCNumber','Get-Five9DNCNumber','Remove-Five9DNCNumber','Get-Five9DNIS','Get-Five9IVRScript','New-Five9IVRScript','Remove-Five9IVRScript','Set-Five9IVRScript','Add-Five9ListRecord','Get-Five9List','Get-Five9ListImportResult','New-Five9List','Remove-Five9List','Remove-Five9ListRecord','Backup-Five9Prompts','Get-Five9Prompt','New-Five9Prompt','Remove-Five9Prompt','Set-Five9Prompt','Get-Five9AgentState','Get-Five9ReportResult','Start-Five9Report','Add-Five9SkillMember','Get-Five9Skill','Get-Five9SkillMember','New-Five9Skill','Remove-Five9Skill','Remove-Five9SkillMember','Set-Five9Skill','Set-Five9SkillMember','Get-Five9SpeedDialNumber','New-Five9SpeedDialNumber','Remove-Five9SpeedDialNumber','Connect-Five9Statistics','Get-Five9ColumnNames','Get-Five9Statistics','Get-Five9StatisticsUpdate','Add-Five9UserProfileMember','Add-Five9UserProfileSkill','Get-Five9UserProfile','New-Five9UserProfile','Remove-Five9UserProfileMember','Remove-Five9UserProfileSkill','Add-Five9Role','Remove-Five9Role','Set-Five9RoleAdmin','Set-Five9RoleAgent','Set-Five9RoleReporting','Set-Five9RoleSupervisor','Get-Five9User','New-Five9User','Remove-Five9User','Set-Five9MediaType','Set-Five9User','Set-Five9UserVoicemailGreeting')

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
         Tags = @('Five9', 'Five', '9', 'PowerShell', 'PSFive9', 'PSFive9Admin', 'API', 'Admin', 'Web', 'Services', 'SOAP')

        # A URL to the license for this module.
         LicenseUri = 'https://github.com/sqone2/PSFive9Admin/blob/master/LICENSE'

        # A URL to the main website for this project.
         ProjectUri = 'https://github.com/sqone2/PSFive9Admin'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

