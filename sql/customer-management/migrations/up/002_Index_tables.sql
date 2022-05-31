BEGIN TRANSACTION;
GO

BEGIN
    CREATE INDEX [IX_Contact_ContactTypeID] ON [Contact] ([ContactTypeID]);
END;
GO

BEGIN
    CREATE INDEX [IX_Contact_CustomerId] ON [Contact] ([CustomerId]);
END;
GO

BEGIN
    CREATE INDEX [IX_Customer_ClientServiceManagerId] ON [Customer] ([ClientServiceManagerId]);
END;
GO

BEGIN
    CREATE UNIQUE INDEX [IX_Customer_GlCustomerId] ON [Customer] ([GlCustomerId]);
END;
GO

BEGIN
    CREATE INDEX [IX_Customer_ServiceCountryId] ON [Customer] ([CustomerCountryId]);
END;
GO

BEGIN
    CREATE UNIQUE INDEX [IX_HoldingsConfiguration_CustomerID] ON [HoldingsConfiguration] ([CustomerID]);
END;
GO

BEGIN
    CREATE UNIQUE INDEX [IX_LegacyMapping_CustomerId] ON [LegacyMapping] ([CustomerId]);
END;
GO

BEGIN
    CREATE INDEX [IX_Note_CustomerId] ON [Note] ([CustomerId]);
END;
GO

BEGIN
    CREATE UNIQUE INDEX [IX_PasswordConfiguration_CustomerID] ON [PasswordConfiguration] ([CustomerID]);
END;
GO

BEGIN
    CREATE UNIQUE INDEX [IX_ProxyProvider_ProxyName_ProxyCode] ON [ProxyProvider] ([ProxyName], [ProxyCode]);
END;
GO

BEGIN
    CREATE UNIQUE INDEX [IX_VoteConfiguration_CustomerID] ON [VoteConfiguration] ([CustomerID]);
END;
GO

BEGIN
    CREATE INDEX [IX_Custodian_CustodianName_BallotDistributorKey_CustodianStatus_CustodianCountryId] ON [Custodian] ([CustodianName], [BallotDistributorKey], [CustodianStatus], [CustodianCountryId]);
END;

BEGIN
    CREATE UNIQUE INDEX [IX_CustomerProxyProvider_CustomerId_ProxyProviderId] ON [CustomerProxyProvider] ([CustomerId], [ProxyProviderId]);
END;

COMMIT;
GO