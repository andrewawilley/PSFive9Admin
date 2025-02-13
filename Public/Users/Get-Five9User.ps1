function Get-Five9User
{
    <#
    .SYNOPSIS
    
        Function used to return Five9 user(s)

    .EXAMPLE
    
        Get-Five9User
    
        # Returns all Users
    
    .EXAMPLE
    
        Get-Five9User -NamePattern "jdoe@domain.com"
    
        # Returns user who matches the string "jdoe@domain.com"

    .EXAMPLE
    
        Get-Five9User -OutputPath 'C:\files\five9-users.csv'
    
        # Exports all users to a specified CSV location

    #>
    [CmdletBinding(PositionalBinding=$false)]
    param
    (
        # Optional regex parameter. If used, function will return only users matching regex string
        [Parameter(Mandatory=$false, Position=0)][string]$NamePattern = '.*',

        # Optional parameter. If used, users will be exported to specified location as a CSV file
        [Parameter(Mandatory=$false)][string]$OutputPath
    )

    try
    {
        Test-Five9Connection -ErrorAction: Stop

        Write-Progress -Activity "Fetching User(s) from Five9 Server" -ErrorAction Ignore

        Write-Verbose "$($MyInvocation.MyCommand.Name): Returning user(s) matching pattern '$($NamePattern)'"
        $response = $global:DefaultFive9AdminClient.getUsersInfo($NamePattern)

        Write-Progress -Activity "Complete" -Completed -ErrorAction Ignore

        $userList = @()


        $count = $response.Count
        $i = $count
        $j = 0

        foreach ($user in $response)
        {
            try
            {
                Write-Progress -Activity "Processing Users: $($user.generalInfo.userName)" -Status "$i Users Remaining.."  -PercentComplete (($j / $count) * 100) -ErrorAction Ignore
                $i--
                $j++
            }
            catch
            {

            }

            $user.generalinfo | Add-Member -MemberType NoteProperty -Name agentGroups -Value $user.agentGroups -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name cannedReports -Value $user.cannedReports -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name roles -Value $user.roles -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name skills -Value $user.skills -Force

            $user.generalinfo | Add-Member -MemberType NoteProperty -Name admin -Value $false -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name agent -Value $false -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name reporting -Value $false -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name supervisor -Value $false -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name crmManager -Value $false -Force

            # to be used when exporting to csv
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name rolesString -Value $null -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name skillsString -Value $null -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name agentGroupsString -Value $null -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name cannedReportsString -Value $null -Force
            $user.generalinfo | Add-Member -MemberType NoteProperty -Name mediaTypeConfigString -Value $null -Force


            $newRolesObj = New-Object -TypeName psobject -Property @{
                admin = New-Object -TypeName psobject
                agent = New-Object -TypeName psobject
                reporting = New-Object -TypeName psobject
                supervisor = New-Object -TypeName psobject
                crmManager = New-Object -TypeName psobject
            }

            if ($user.roles.admin -ne $null)
            {
                $user.generalinfo.admin = $true

                foreach ($oldAdminPermission in $user.roles.admin)
                {
                    $newRolesObj.admin | Add-Member -MemberType NoteProperty -Name $oldAdminPermission.type -Value $oldAdminPermission.value -Force
                }

            }

            if ($user.roles.agent -ne $null)
            {
                $user.generalinfo.agent = $true

                # permissions at root level
                $rootAgentPermissions = ($user.roles.agent | Get-Member -MemberType Properties).name | ? {$_ -ne 'permissions'}

                foreach ($rootAgentPermission in $rootAgentPermissions)
                {
                    $newRolesObj.agent | Add-Member -MemberType NoteProperty -Name $rootAgentPermission -Value $user.roles.agent.$rootAgentPermission -Force
                }

                # permissions in permissions object
                foreach ($oldAgentPermission in $user.roles.agent.permissions)
                {
                    $newRolesObj.agent | Add-Member -MemberType NoteProperty -Name $oldAgentPermission.type -Value $oldAgentPermission.value -Force
                }

            }

            if ($user.roles.reporting -ne $null)
            {
                $user.generalinfo.reporting = $true

                foreach ($oldReportingPermission in $user.roles.reporting)
                {
                    $newRolesObj.reporting | Add-Member -MemberType NoteProperty -Name $oldReportingPermission.type -Value $oldReportingPermission.value -Force
                }

            }

            if ($user.roles.supervisor -ne $null)
            {
                $user.generalinfo.supervisor = $true

                foreach ($oldSupervisorPermission in $user.roles.supervisor)
                {
                    $newRolesObj.supervisor | Add-Member -MemberType NoteProperty -Name $oldSupervisorPermission.type -Value $oldSupervisorPermission.value -Force
                }

            }

            if ($user.roles.crmManager -ne $null)
            {
                $user.generalinfo.crmManager = $true

                foreach ($oldCrmManagerPermission in $user.roles.crmManager)
                {
                    $newRolesObj.crmManager | Add-Member -MemberType NoteProperty -Name $oldCrmManagerPermission.type -Value $oldCrmManagerPermission.value -Force
                }

            }


            # replace old role format with pscustomobject
            $user.generalInfo | Add-Member -MemberType: NoteProperty -Name roles -Value $newRolesObj -Force


            # skill export string
            $user.generalInfo.skillsString = $user.generalInfo.skills | select * -ExcludeProperty 'idSpecified' | ConvertTo-Json -Compress

            if ($user.generalInfo.skillsString -notmatch '^\[')
            {
                $user.generalInfo.skillsString = "[" + $user.generalInfo.skillsString + "]"
            }


            # agent group export string
            $user.generalInfo.agentGroupsString = @($user.generalInfo.agentGroups) | ConvertTo-Json -Compress

            if ($user.generalInfo.agentGroupsString -notmatch '^\[')
            {
                $user.generalInfo.agentGroupsString = "[" + $user.generalInfo.agentGroupsString + "]"
            }

            # canned reports export string
            $user.generalInfo.cannedReportsString = $user.generalInfo.cannedReports | select * -ExcludeProperty 'indexSpecified' | ConvertTo-Json -Compress

            if ($user.generalInfo.cannedReportsString -notmatch '^\[')
            {
                $user.generalInfo.cannedReportsString = "[" + $user.generalInfo.cannedReportsString + "]"
            }

            # roles export string
            $user.generalInfo.rolesString = $newRolesObj | ConvertTo-Json -Compress
            
            $mediaTypeProps = ($user.generalInfo.mediaTypeConfig | Get-Member -MemberType Properties | ? {$_.Name -notmatch 'Specified'}).name
            $user.generalInfo.mediaTypeConfigString = $user.generalInfo.mediaTypeConfig | select $mediaTypeProps | ConvertTo-Json -Compress


            # add obj to return list
            $userList += $user.generalinfo

        }
       
        
        if ($PSBoundParameters.Keys -contains 'OutputPath')
        {
            try
            {

                 $userList | select @(
                    'id'
                    'active'
                    'extension'
                    'fullName'
                    'userName'
                    'EMail'
                    'userProfileName'
                    'admin'
                    'agent'
                    'supervisor'
                    'reporting'
                    'firstName'
                    'lastName'
                    'federationId'
                    'canChangePassword'
                    'mustChangePassword'
                    'locale'
                    @{n='agentGroups';e={$_.agentGroupsString}}
                    @{n='skills';e={$_.skillsString}}
                    @{n='roles';e={$_.rolesString}}
                    @{n='cannedReports';e={$_.cannedReportsString}}
                    @{n='mediaTypeConfig';e={$_.mediaTypeConfigString}}
                    'startDate'
                ) | sort fullName | Export-Csv $OutputPath -NoTypeInformation

            }
            catch
            {
                throw "Error exporting to CSV. $($_.Exception.Message)"
            }

        }

        return $userList | sort fullName
    }
    catch
    {
        $_ | Write-PSFive9AdminError
		$_ | Write-Error
    }

}