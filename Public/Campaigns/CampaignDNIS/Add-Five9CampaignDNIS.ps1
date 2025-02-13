function Add-Five9CampaignDNIS
{
    <#
    .SYNOPSIS
    
        Function to add a single 10 digit DNIS, or multiple DNISes to a Five9 inbound campaign

    .EXAMPLE
    
        Add-Five9CampaignDNIS -Name 'Hot-Leads' -DNIS '5991230001'

        # adds a single DNIS to a campaign

    .EXAMPLE

        $dnisToBeAdded = @('5991230001', '5991230002', '5991230003')
        Add-Five9CampaignDNIS -Name 'Hot-Leads' -DNIS $dnisToBeAdded
    
        # adds multiple DNISes to a campaign
    
    #>

    [CmdletBinding(PositionalBinding=$true)]
    param
    ( 
        # Inbound campaign name that a single 10 digit DNIS, or multiple DNISes will be added to
        [Parameter(Mandatory=$true)][string]$Name,

        # Single 10 digit DNIS, or array of multiple DNISes to be added to an inbound campaign
        [Parameter(Mandatory=$true)][ValidatePattern('^\+?[0-9]{10,20}$')][string[]]$DNIS
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop

        Write-Verbose "$($MyInvocation.MyCommand.Name): Adding DNIS to campaign '$Name'." 
        return $global:DefaultFive9AdminClient.addDNISToCampaign($Name, $DNIS)

    }
    catch
    {
        $_ | Write-PSFive9AdminError		$_ | Write-Error
    }
}
