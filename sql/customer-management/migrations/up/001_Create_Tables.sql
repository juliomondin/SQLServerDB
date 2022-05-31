BEGIN TRANSACTION;
GO

CREATE TABLE [ContactType] (
    [ContactTypeID] int NOT NULL IDENTITY,
    [CreatedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [LastModifiedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [CreatedBy] nvarchar(50) NULL,
    [LastModifiedBy] nvarchar(50) NULL,
    [IsDeleted] bit NOT NULL,
    [Type] nvarchar(50) NOT NULL,
    CONSTRAINT [PK_ContactType] PRIMARY KEY ([ContactTypeID])
);
GO

CREATE TABLE [ServiceCountry] (
    [ServiceCountryID] int NOT NULL IDENTITY,
    [CountryCode2] nvarchar(2) NULL,
    [CountryCode3] nvarchar(3) NULL,
    [CountryID] int NOT NULL,
    [CountryName] nvarchar(75) NOT NULL,
    [GeographicalRegion] nvarchar(60) NULL,
    CONSTRAINT [PK_ServiceCountry] PRIMARY KEY ([ServiceCountryID])
);
GO

CREATE TABLE [ServiceUser] (
    [ServiceUserID] int NOT NULL IDENTITY,
    [UserId] nvarchar(50) NOT NULL,
    [Name] nvarchar(50) NOT NULL,
    [Email] nvarchar(100) NULL,
    CONSTRAINT [PK_ServiceUser] PRIMARY KEY ([ServiceUserID])
);
GO

CREATE TABLE [Custodian] (
    [CustodianID] int NOT NULL IDENTITY,
    [CreatedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [LastModifiedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [CreatedBy] nvarchar(50) NULL,
    [LastModifiedBy] nvarchar(50) NULL,
    [IsDeleted] bit NOT NULL,
    [BallotDistributor] int NOT NULL,
    [BallotCreation] int NOT NULL,
    [BallotDistributorKey] nvarchar(5) NULL,
    [BallotOrigin] int NOT NULL,
    [CustodianCountryId] int NULL,
    [CustodianName] nvarchar(255) NOT NULL,
    [CustodianStatus] int NOT NULL,
    CONSTRAINT [PK_Custodian] PRIMARY KEY ([CustodianID]),
    CONSTRAINT [FK_Custodian_ServiceCountry_CustodianCountryId] FOREIGN KEY ([CustodianCountryId]) REFERENCES [ServiceCountry] ([ServiceCountryID])
);
GO

CREATE TABLE [Customer] (
    [CustomerID] int NOT NULL IDENTITY,
    [CreatedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [LastModifiedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [CreatedBy] nvarchar(50) NULL,
    [LastModifiedBy] nvarchar(50) NULL,
    [IsDeleted] bit NOT NULL,
    [CustomerName] nvarchar(255) NOT NULL,
    [CustomerType] int NOT NULL,
    [BusinessType] int NOT NULL,
    [Status] int NOT NULL,
    [GlCustomerId] nvarchar(70) NOT NULL,
    [ClientServiceManagerId] int NULL,
    [SupportRegion] int NOT NULL,
    [CustomerCountryId] int NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY ([CustomerID]),
    CONSTRAINT [FK_Customer_ServiceCountry_CustomerCountryId] FOREIGN KEY ([CustomerCountryId]) REFERENCES [ServiceCountry] ([ServiceCountryID]),
    CONSTRAINT [FK_Customer_ServiceUser_ClientServiceManagerId] FOREIGN KEY ([ClientServiceManagerId]) REFERENCES [ServiceUser] ([ServiceUserID])
);
GO

CREATE TABLE [Contact] (
    [ContactID] int NOT NULL IDENTITY,
    [CreatedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [LastModifiedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [CreatedBy] nvarchar(50) NULL,
    [LastModifiedBy] nvarchar(50) NULL,
    [IsDeleted] bit NOT NULL,
    [ContactName] nvarchar(255) NULL,
    [Address1] nvarchar(255) NULL,
    [Address2] nvarchar(255) NULL,
    [City] nvarchar(100) NULL,
    [State] nvarchar(50) NULL,
    [Zip] nvarchar(50) NULL,
    [Email] nvarchar(50) NULL,
    [Phone] nvarchar(50) NULL,
    [Fax] nvarchar(50) NULL,
    [ContactTypeID] int NOT NULL,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Contact] PRIMARY KEY ([ContactID]),
    CONSTRAINT [FK_Contact_ContactType_ContactTypeID] FOREIGN KEY ([ContactTypeID]) REFERENCES [ContactType] ([ContactTypeID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Contact_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerID]) ON DELETE CASCADE
);
GO

CREATE TABLE [HoldingsConfiguration] (
    [HoldingsConfigurationID] int NOT NULL IDENTITY,
    [CustomerID] int NOT NULL,
    [HoldingsDeliveryDay] int NULL,
    [HoldingsDeliveryMethod] int NULL,
    [HoldingsFrequency] int NULL,
    [IsHoldingLiquidatedTNA] bit NULL,
    [SFTPAddress] nvarchar(550) NULL,
    CONSTRAINT [PK_HoldingsConfiguration] PRIMARY KEY ([HoldingsConfigurationID]),
    CONSTRAINT [FK_HoldingsConfiguration_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Customer] ([CustomerID]) ON DELETE CASCADE
);
GO

CREATE TABLE [LegacyMapping] (
    [LegacyMappingID] int NOT NULL IDENTITY,
    [CreatedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [LastModifiedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [CreatedBy] nvarchar(50) NULL,
    [LastModifiedBy] nvarchar(50) NULL,
    [IsDeleted] bit NOT NULL,
    [GLPCustomerId] int NOT NULL,
    [CRMCustomerId] int NOT NULL,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_LegacyMapping] PRIMARY KEY ([LegacyMappingID]),
    CONSTRAINT [FK_LegacyMapping_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerID]) ON DELETE CASCADE
);
GO

CREATE TABLE [Note] (
    [NoteID] int NOT NULL IDENTITY,
    [CreatedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [LastModifiedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [CreatedBy] nvarchar(50) NULL,
    [LastModifiedBy] nvarchar(50) NULL,
    [IsDeleted] bit NOT NULL,
    [Text] nvarchar(300) NOT NULL,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Note] PRIMARY KEY ([NoteID]),
    CONSTRAINT [FK_Note_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerID]) ON DELETE CASCADE
);
GO

CREATE TABLE [PasswordConfiguration] (
    [PasswordConfigurationID] int NOT NULL IDENTITY,
    [CreatedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [LastModifiedDate] datetimeoffset NOT NULL DEFAULT (SYSDATETIMEOFFSET()),
    [CreatedBy] nvarchar(50) NULL,
    [LastModifiedBy] nvarchar(50) NULL,
    [IsDeleted] bit NOT NULL,
    [ExpiryPeriod] int NULL,
    [PasswordAuthenticationLevel] int NULL,
    [MinimumPasswordAge] int NULL,
    [NumberOfSecurityQuestions] int NULL,
    [EnableSecurityQuestions] bit NULL,
    [PasswordNeverExpires] bit NULL,
    [NumberOfPasswordsToBeStored] int NULL,
    [CanAlwaysResetPassword] bit NULL,
    [NumberOfRequiredAnswers] int NULL,
    [CustomerID] int NOT NULL,
    CONSTRAINT [PK_PasswordConfiguration] PRIMARY KEY ([PasswordConfigurationID]),
    CONSTRAINT [FK_PasswordConfiguration_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Customer] ([CustomerID]) ON DELETE CASCADE
);
GO

CREATE TABLE [ProxyProvider] (
    [ProxyProviderID] int NOT NULL IDENTITY,
    [ProxyName] nvarchar(50) NOT NULL,
    [ProxyCode] nvarchar(20) NOT NULL,
    CONSTRAINT [PK_ProxyProvider] PRIMARY KEY ([ProxyProviderID]),
);
GO

CREATE TABLE [CustomerProxyProvider] (
    [CustomerProxyProviderID] int NOT NUll IDENTITY,
    [CustomerId] int NOT NULL,
    [ProxyProviderId] int NOT NULL,
    CONSTRAINT [PK_CustomerProxyProvider] PRIMARY KEY ([CustomerProxyProviderID]),
    CONSTRAINT [FK_CustomerProxyProvider_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerID]) ON UPDATE CASCADE,
    CONSTRAINT [FK_CustomerProxyProvider_ProxyProvider_ProxyProviderId] FOREIGN KEY ([ProxyProviderId]) REFERENCES [ProxyProvider] ([ProxyProviderID]) ON UPDATE CASCADE
);
GO

CREATE TABLE [VoteConfiguration] (
    [VoteConfigurationID] int NOT NULL IDENTITY,
    [ShareMeetingTokensAllowed] bit NULL,
    [VotingMultiplePoliciesWarning] bit NULL,
    [VotingAgainstPolicyWarning] bit NULL,
    [SendRecommendation] bit NULL,
    [ExtractFileCopyAddress] nvarchar(50) NULL,
    [PercentOutstandingShares] decimal(13,7) NULL,
    [PartialVotePercentage] decimal(6,3) NULL,
    [CustomerID] int NOT NULL,
    CONSTRAINT [PK_VoteConfiguration] PRIMARY KEY ([VoteConfigurationID]),
    CONSTRAINT [FK_VoteConfiguration_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Customer] ([CustomerID]) ON DELETE CASCADE
);
GO

INSERT INTO [ContactType] ([CreatedBy], [CreatedDate], [IsDeleted], [LastModifiedBy], [LastModifiedDate], [Type])
VALUES (N'0', '2022-01-20T22:45:36.1130864+00:00', CAST(0 AS bit), NULL, '2022-01-20T22:45:36.1130936+00:00', N'Default');

COMMIT;
GO

