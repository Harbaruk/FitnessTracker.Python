USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[GetSkillsInfo]    Script Date: 11.12.2017 14:08:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetSkillsInfo] 
	@userId INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Id, Title, Level FROM [WorkIT].[dbo].[Skills] WHERE UserId = @userId;
	
END
