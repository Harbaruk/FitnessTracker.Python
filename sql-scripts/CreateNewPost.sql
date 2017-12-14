USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[CreateNewPost]    Script Date: 28.11.2017 12:20:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[CreateNewPost]
	@Title VARCHAR(100),
	@Description VARCHAR(2500),
	@Email VARCHAR(50),
	@Phone VARCHAR(20),
	@OwnerId INT
	
AS
BEGIN

	INSERT INTO WorkIT.dbo.Posts(Title, Description, Email, Phone, OwnerId, CreationData, Counter) VALUES(@Title, @Description, @Email, @Phone, @OwnerId, CURRENT_TIMESTAMP, 0);

END
