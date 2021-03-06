USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[GetPostsShortInfo]    Script Date: 02.12.2017 11:04:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetPostsShortInfo]
	@userId INT
AS
BEGIN

	SET NOCOUNT ON;
	
	IF (@userId = 0)
	BEGIN
		SELECT Id, Title FROM [WorkIT].[dbo].[Posts] ORDER BY CreationData DESC;
	END
	ELSE
	BEGIN
		SELECT Id, Title FROM [WorkIT].[dbo].[Posts] WHERE OwnerId=@userId ORDER BY CreationData DESC;
	END;
	
END
