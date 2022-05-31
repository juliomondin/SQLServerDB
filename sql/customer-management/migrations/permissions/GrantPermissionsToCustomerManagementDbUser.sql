
PRINT 'Grant Rights on Tables to User CustomerManagementDbUser'

GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[ContactType] TO [CustomerManagementDbUser]
GO

GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[Customer] TO [CustomerManagementDbUser]
GO


GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[Contact] TO [CustomerManagementDbUser]
GO


GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[HoldingsConfiguration] TO [CustomerManagementDbUser]
GO


GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[LegacyMapping] TO [CustomerManagementDbUser]
GO


GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[Note] TO [CustomerManagementDbUser]
GO

GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[PasswordConfiguration] TO [CustomerManagementDbUser]
GO


GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[ProxyProvider] TO [CustomerManagementDbUser]
GO

GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[VoteConfiguration] TO [CustomerManagementDbUser]
GO

GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[ServiceUser] TO [CustomerManagementDbUser]
GO

GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[Custodian] TO [CustomerManagementDbUser]
GO

GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[ServiceCountry] TO [CustomerManagementDbUser]
GO

GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[CustomerProxyProvider] TO [CustomerManagementDbUser]
GO

GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[ExternalLink] TO [CustomerManagementDbUser]
GO

GRANT SELECT,DELETE,INSERT,UPDATE ON [dbo].[CustomerExternalLink] TO [CustomerManagementDbUser]
GO

