IF OBJECT_ID(N'[wwi].[Product]', N'U') IS NOT NULL   
DROP TABLE [wwi].[Product]

CREATE TABLE [wwi].[Product]
(
    ProductId SMALLINT NOT NULL,
    Seasonality TINYINT NOT NULL,
    Price DECIMAL(6,2),
    Profit DECIMAL(6,2)
)
WITH
(
    DISTRIBUTION = REPLICATE
)

IF OBJECT_ID(N'[wwi].[Date]', N'U') IS NOT NULL   
DROP TABLE [wwi].[Date]

CREATE TABLE [wwi].[Date]
(
	DateId int not null,
	Day tinyint not null,
	Month tinyint not null,
	Quarter tinyint not null,
	Year smallint not null
)
WITH
(
    DISTRIBUTION = REPLICATE
)

IF OBJECT_ID(N'[wwi].[Sale]', N'U') IS NOT NULL   
DROP TABLE [wwi].[Sale]

CREATE TABLE [wwi].[Sale]
( 
	[TransactionId] [uniqueidentifier]  NOT NULL,
	[CustomerId] [int]  NOT NULL,
	[ProductId] [smallint]  NOT NULL,
	[Quantity] [tinyint]  NOT NULL,
	[Price] [decimal](9,2)  NOT NULL,
	[TotalAmount] [decimal](9,2)  NOT NULL,
	[TransactionDateId] [int]  NOT NULL,
	[ProfitAmount] [decimal](9,2)  NOT NULL,
	[Hour] [tinyint]  NOT NULL,
	[Minute] [tinyint]  NOT NULL,
	[StoreId] [smallint]  NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [CustomerId] ),
	CLUSTERED COLUMNSTORE INDEX,
	PARTITION
	(
		[TransactionDateId] RANGE RIGHT FOR VALUES ( 
			20190101, 20190201, 20190301, 20190401, 20190501, 20190601, 20190701, 20190801, 20190901, 20191001, 20191101, 20191201)
	)
)