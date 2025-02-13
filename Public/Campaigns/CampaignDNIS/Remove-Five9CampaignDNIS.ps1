function Remove-Five9CampaignDNIS
{
    <#
    .SYNOPSIS
    
        Function to remove a single 10 digit DNIS, or multiple DNISes from an inbound campaign

    .EXAMPLE
    
        Remove-Five9CampaignDNIS -Name 'Hot-Leads' -DNIS '5991230001'

        # removes a single DNIS from a campaign

    .EXAMPLE

        $dnisToBeRemoved = @('5991230001', '5991230002', '5991230003')
        Remove-Five9CampaignDNIS -Name 'Hot-Leads' -DNIS $dnisToBeRemoved
    
        # removes multiple DNISes from a campaign
    #>

    [CmdletBinding(PositionalBinding=$true)]
    param
    ( 
        # Inbound campaign name that a single 10 digit DNIS, or multiple DNISes will be removed from
        [Parameter(Mandatory=$true)][string]$Name,

        # Single 10 digit DNIS, or array of multiple DNISes to be removed from an inbound campaign
        [Parameter(Mandatory=$true)][ValidatePattern('^\+?[0-9]{10,20}$')][string[]]$DNIS
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop

        Write-Verbose "$($MyInvocation.MyCommand.Name): Removing DNIS from campaign '$Name'." 
        return $global:DefaultFive9AdminClient.removeDNISFromCampaign($Name, $DNIS)

    }
    catch
    {
        $_ | Write-PSFive9AdminError		$_ | Write-Error
    }
}
