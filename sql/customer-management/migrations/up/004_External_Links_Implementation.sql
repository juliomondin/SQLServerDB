CREATE TABLE [ExternalLink] (
    [ExternalLinkID] int NOT NULL IDENTITY,
    [ExternalLinkName] nvarchar(50) NOT NULL,
    [ExternalLinkUrl] nvarchar(250) NOT NULL,
    CONSTRAINT [PK_ExternalLink] PRIMARY KEY ([ExternalLinkID]),
);
GO


CREATE TABLE [CustomerExternalLink] (
    [CustomerExternalLinkID] int NOT NULL IDENTITY,
    [CustomerId] int NOT NULL,
    [ExternalLinkId] int NOT NULL,
    [ExternalCode] varchar(12) NOT NULL,
    CONSTRAINT [PK_CustomerExternalLink] PRIMARY KEY ([CustomerExternalLinkID]),
    CONSTRAINT [FK_CustomerExternalLink_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerID]) ON UPDATE CASCADE,
    CONSTRAINT [FK_CustomerExternalLink_ExternalLink_ExternalLinkId] FOREIGN KEY ([ExternalLinkId]) REFERENCES [ExternalLink] ([ExternalLinkID]) ON UPDATE CASCADE
);
GO

BEGIN
    CREATE UNIQUE INDEX [IX_CustomerProxyProvider_CustomerId_ExternalLinkId] ON [CustomerExternalLink] ([CustomerId], [ExternalLinkId]);
END;

BEGIN
    CREATE UNIQUE INDEX [IX_ExternalLink_ExternalLinkName_ExternalLinkUrl] ON [ExternalLink] ([ExternalLinkName], [ExternalLinkUrl]);
END;
GO