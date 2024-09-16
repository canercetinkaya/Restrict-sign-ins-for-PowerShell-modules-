#Micorosft Graph Entra kurulumunu yapın ve bağlanın. Bağlanmak için Global Administrator hesabını kullanın.
#Install and connect to Micorosft Graph Entra. Use the Global Administrator account to connect.
Install-Module Microsoft.Graph -Scope CurrentUser
 Install-Module Microsoft.Graph.Entra -AllowPrerelease -Repository PSGallery -Force
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Connect-MgGraph -Scopes Directory.ReadWrite.All, Group.ReadWrite.All, Application.ReadWrite.All, AuditLog.Read.All


# Powershell modüllerinin Service PrinpialName bilgileri aşağıdaki gibidir.
# Service PrinpialName information of Powershell modules is as follows.

# EXO: fb78d390-0c51-40cd-8e17-fdbfab77341b
# AAD: 1b730954-1685-4b74-9bfd-dac224a7b894
# Teams: 12128f48-ec9e-42f0-b203-ea49fb6af367
# SharePoint Online: bc3ab49-b65d-410a-85ad-de819febfddc
# Power Platform : 1950a258-227b-4e31-a9cf-717495945fc2




# Exchange Online Powershell'e bağlanan hesapları görüntüle / View accounts connecting to Exchange Online Powershell

$AuditRecordsExo = Get-MgAuditLogSignIn -Top 5000 -Sort "createdDateTime DESC" -Filter "AppId eq 'fb78d390-0c51-40cd-8e17-fdbfab77341b'"
$AuditRecordsExo | Group-Object UserPrincipalName, ResourceDisplayName -NoElement | Sort-Object Count -Descending| Select-Object Name, Count
# Entra Powershell'e bağlanan hesapları görüntüle / View accounts connecting to Entra Powershell
$AuditRecordsAAD = Get-MgAuditLogSignIn -Top 5000 -Sort "createdDateTime DESC" -Filter "AppId eq '1b730954-1685-4b74-9bfd-dac224a7b894'"
$AuditRecordsAAD | Group-Object UserPrincipalName, ResourceDisplayName -NoElement | Sort-Object Count -Descending| Select-Object Name, Count
# Teams Online Powershell'e bağlanan hesapları görüntüle / View accounts connecting to Teams Powershell
$AuditRecordsTeams = Get-MgAuditLogSignIn -Top 5000 -Sort "createdDateTime DESC" -Filter "AppId eq '12128f48-ec9e-42f0-b203-ea49fb6af367'"
$AuditRecordsTeams | Group-Object UserPrincipalName, ResourceDisplayName -NoElement | Sort-Object Count -Descending| Select-Object Name, Count
# SharePoint Powershell'e bağlanan hesapları görüntüle / View accounts connecting to SharePoint Online Powershell
$AuditRecordsSharePoint = Get-MgAuditLogSignIn -Top 5000 -Sort "createdDateTime DESC" -Filter "AppId eq 'bc3ab49-b65d-410a-85ad-de819febfddc'"
$AuditRecordsSharePoint | Group-Object UserPrincipalName, ResourceDisplayName -NoElement | Sort-Object Count -Descending| Select-Object Name, Count
# Power Platform Powershell'e bağlanan hesapları görüntüle / View accounts connecting to Power Platform Powershell
$AuditRecordsPowerPlatform = Get-MgAuditLogSignIn -Top 5000 -Sort "createdDateTime DESC" -Filter "AppId eq '1950a258-227b-4e31-a9cf-717495945fc2'"
$AuditRecordsPowerPlatform | Group-Object UserPrincipalName, ResourceDisplayName -NoElement | Sort-Object Count -Descending| Select-Object Name, Count

# Powershell ile bağlanacak izinli grupları oluşturur.
# !! ÖNEMLİ !!
    # !! ÖNEMLİ !! 
#!! ÖNEMLİ !!  
# Grup oluşturulduktan sonra Entra Admin portala gidip, erişim yapacak olan kullanıcıları "manuel" olarak eklemelisiniz. 
#!! ÖNEMLİ !! 

# Creates authorised groups to connect with Powershell.
# !!! IMPORTANT !!!
# !!! IMPORTANT !!! 
#!!! IMPORTANT !!! 
# After the group is created, you should go to the Entra Admin portal and add the users who will access ‘manually’. 
#!!! IMPORTANT !!!


$Group = New-MgGroup -DisplayName "AAD-PowerShell-Allowed" -MailEnabled:$False -SecurityEnabled:$True -MailNickName 'AAD-PowerShell-Allowed'
$Group = New-MgGroup -DisplayName "EXO-PowerShell-Allowed" -MailEnabled:$False -SecurityEnabled:$True -MailNickName 'EXO-PowerShell-Allowed'
$Group = New-MgGroup -DisplayName "Teams-PowerShell-Allowed" -MailEnabled:$False -SecurityEnabled:$True -MailNickName 'Teams-PowerShell-Allowed'
$Group = New-MgGroup -DisplayName "SharePoint-PowerShell-Allowed" -MailEnabled:$False -SecurityEnabled:$True -MailNickName 'SharePoint-PowerShell-Allowed'
$Group = New-MgGroup -DisplayName "PowerPlatform-PowerShell-Allowed" -MailEnabled:$False -SecurityEnabled:$True -MailNickName 'PowerPlatform-PowerShell-Allowed'

#Azure AD'ye bağlanın. / Connect to Azure AD.

Connect-AzureAD

# AAD Powershell'e sadece AAD-PowerShell-Allowed grubu üyeleri erişim sağlayabilir. / Only members of the AAD-PowerShell-Allowed group can access the AAD Powershell.


$appId = "1b730954-1685-4b74-9bfd-dac224a7b894" 
if (-not(Get-AzureADServicePrincipal -Filter "appId eq '$appId'")){New-AzureADServicePrincipal -AppId $appID} 
$group = Get-AzureADGroup -SearchString "AAD-PowerShell-Allowed" 
$sp = Get-AzureADServicePrincipal -Filter "appId eq '$appId'" 
Set-AzureADServicePrincipal -ObjectId $sp.ObjectId -AppRoleAssignmentRequired $true 
New-AzureADServiceAppRoleAssignment -ObjectId $sp.ObjectId -ResourceId $sp.ObjectId -Id ([Guid]::Empty.ToString()) -PrincipalId $group.ObjectId

# EXO Powershell'e sadece EXO-PowerShell-Allowed grubu üyeleri erişim sağlayabilir. / Only members of the EXO-PowerShell-Allowed group can access the EXO Powershell.


$appId = "fb78d390-0c51-40cd-8e17-fdbfab77341b" 
if (-not(Get-AzureADServicePrincipal -Filter "appId eq '$appId'")){New-AzureADServicePrincipal -AppId $appID} 
$group = Get-AzureADGroup -SearchString "EXO-PowerShell-Allowed" 
$sp = Get-AzureADServicePrincipal -Filter "appId eq '$appId'" 
Set-AzureADServicePrincipal -ObjectId $sp.ObjectId -AppRoleAssignmentRequired $true 
New-AzureADServiceAppRoleAssignment -ObjectId $sp.ObjectId -ResourceId $sp.ObjectId -Id ([Guid]::Empty.ToString()) -PrincipalId $group.ObjectId

# Teams Powershell'e sadece Teams-PowerShell-Allowed grubu üyeleri erişim sağlayabilir. / Only members of the Teams-PowerShell-Allowed group can access Teams Powershell.


$appId = "12128f48-ec9e-42f0-b203-ea49fb6af367" 
if (-not(Get-AzureADServicePrincipal -Filter "appId eq '$appId'")){New-AzureADServicePrincipal -AppId $appID} 
$group = Get-AzureADGroup -SearchString "Teams-PowerShell-Allowed" 
$sp = Get-AzureADServicePrincipal -Filter "appId eq '$appId'" 
Set-AzureADServicePrincipal -ObjectId $sp.ObjectId -AppRoleAssignmentRequired $true 
New-AzureADServiceAppRoleAssignment -ObjectId $sp.ObjectId -ResourceId $sp.ObjectId -Id ([Guid]::Empty.ToString()) -PrincipalId $group.ObjectId

# SharePoint Online Powershell'e sadece SharePoint-PowerShell-Allowed grubu üyeleri erişim sağlayabilir. / Only members of the SharePoint-PowerShell-Allowed group can access SharePoint Online Powershell.


$appId = "9bc3ab49-b65d-410a-85ad-de819febfddc" 
if (-not(Get-AzureADServicePrincipal -Filter "appId eq '$appId'")){New-AzureADServicePrincipal -AppId $appID} 
$group = Get-AzureADGroup -SearchString "SharePoint-PowerShell-Allowed" 
$sp = Get-AzureADServicePrincipal -Filter "appId eq '$appId'" 
Set-AzureADServicePrincipal -ObjectId $sp.ObjectId -AppRoleAssignmentRequired $true 
New-AzureADServiceAppRoleAssignment -ObjectId $sp.ObjectId -ResourceId $sp.ObjectId -Id ([Guid]::Empty.ToString()) -PrincipalId $group.ObjectId

# Power Platform Powershell'e sadece PowerPlatform-PowerShell-Allowed grubu üyeleri erişim sağlayabilir. / Only members of the PowerPlatform-PowerShell-Allowed group can access Power Platform Powershell.

$appId = "1950a258-227b-4e31-a9cf-717495945fc2" 
if (-not(Get-AzureADServicePrincipal -Filter "appId eq '$appId'")){New-AzureADServicePrincipal -AppId $appID} 
$group = Get-AzureADGroup -SearchString "PowerPlatform-PowerShell-Allowed" 
$sp = Get-AzureADServicePrincipal -Filter "appId eq '$appId'" 
Set-AzureADServicePrincipal -ObjectId $sp.ObjectId -AppRoleAssignmentRequired $true 
New-AzureADServiceAppRoleAssignment -ObjectId $sp.ObjectId -ResourceId $sp.ObjectId -Id ([Guid]::Empty.ToString()) -PrincipalId $group.ObjectId

