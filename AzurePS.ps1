
Connect-AzAccount 

##Set-AzContext - switch between azure subscriptions

##Close your powershell and open a new one, or use Clear-AzContext, not Clear-AzureProfile. Then use Connect-AzAccount -Tenant xxxxx -Subscription xxxxx, it should work.


New-AzResourceGroup -Name MorningLab -Location centralus
$Subnet1 = New-AzVirtualNetworkSubnetConfig -Name Subnet1 -AddressPrefix "10.0.1.0/24"
$Subnet2  = New-AzVirtualNetworkSubnetConfig -Name Subnet2  -AddressPrefix "10.0.2.0/24"
New-AzVirtualNetwork -Name MyVirtualNetwork -ResourceGroupName labrg1 -Location centralus -AddressPrefix "10.0.0.0/16" -Subnet $Subnet1,$Subnet2


##Migration - Bulk import of users.
$invitations = import-csv c:\bulkinvite\invitations.csv

$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo

$messageInfo.customizedMessageBody = "Hello. You are invited to the Contoso organization."

foreach ($email in $invitations)
   {New-AzureADMSInvitation `
      -InvitedUserEmailAddress $email.InvitedUserEmailAddress `
      -InvitedUserDisplayName $email.Name `
      -InviteRedirectUrl https://myapps.microsoft.com `
      -InvitedUserMessageInfo $messageInfo `
      -SendInvitationMessage $true
   }

##KEYVAULT (Azure Cli)

az keyvault create --resource-group MorningLab --location centralus --name MyMorningCoffeeVault

##creates a secret in the new keyvault and assigns it a value. 

az keyvault secret set --name AppSecretWord --value Legendary --vault-name MyMorningCoffeeVault

##Assign your app a managed identity so that it can be referenced in the policy and be given access to the vault. 
##Make sure to copy the mananged identity principal id 

az webapp identity assign \
    --resource-group MorningLab \
    --name <App-name>

az keyvault set-policy \
    --secret-permissions get list \
    --name MyMorningCoffeeVault \
    --object-id <your-managed-identity-principleid>
