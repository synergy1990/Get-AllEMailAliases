function Get-AllEMailAliases {
    [CmdletBinding()]
    param (
        $OutputFolder = "\\srv-file\PowerShell-Scripte\2-Exchange\Get-AllEMailAliases",
        $OutputTextFile = "AllMailboxAliases.txt"
    )
    
    Connect-ExchangeOnline -ShowBanner:$false

    $AllMailboxes = Get-Mailbox -Identity *

    $OutputString = ""
    foreach ($Mailbox in $AllMailboxes) {
        $OutputString += "$($Mailbox.Alias)`n"
        foreach ($Mailalias in $Mailbox.EmailAddresses) {
            if($Mailalias -like "*smtp:*") {
                $OutputString += "$Mailalias`n"
            }
        }

        $OutputString += "---`n"
    }

    Write-Output $OutputString
    $OutputString | Out-File "$OutputFolder\$OutputTextFile"

    Disconnect-ExchangeOnline -Confirm:$false
}

Get-AllEMailAliases
