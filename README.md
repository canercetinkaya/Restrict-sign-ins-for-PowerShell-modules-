PowerShell, yöneticilerin yapılandırmayı komut satırından yönetmesine olanak tanır, ancak tüm kullanıcılar, izinlerine bağlı olarak belirli komutlarla PowerShell'i kullanarak Exchange Online ve Microsoft Entra'ya bağlanabilir. Bu komutlarla kullanıcılar, kendi posta kutusu yapılandırmalarını yönetebilir ve çeşitli özellikleri görüntüleyerek keşif yapabilirler. 
PowerShell modülleri için oturum açma işlemlerini nasıl kısıtlayabilirsiniz?

Entra ID’de Powershell Modülüyle 5 grup oluşturulmaktadır. Bu gruplara, Powershell’e erişim izni vereceğiniz kullanıcıları eklemelisiniz.

PowerShell allows administrators to manage configuration from the command line, but all users can connect to Exchange Online and Microsoft Entra using PowerShell with specific commands depending on their permissions. With these commands, users can manage their own mailbox configuration and explore by viewing various features. 
How can you restrict logins for PowerShell modules?

In Entra ID, 5 groups are created with the Powershell Module. In these groups, you must add users to whom you will grant access to Powershell.

  *AAD-PowerShell-Allowed
  *EXO-PowerShell-Allowed
  *Teams-PowerShell-Allowed
  *SharePoint-PowerShell-Allowed
  *PowerPlatform-PowerShell-Allowed

Powershel aynı zamanda modüllere bağlanan kullanıcıların audit logunu da göstermektedir.

Powershel also shows the audit log of users connecting to the modules.
