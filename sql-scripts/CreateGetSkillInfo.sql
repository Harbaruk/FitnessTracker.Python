USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[GetSkillsInfo]    Script Date: 04.12.2017 11:53:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSkillInfo] 
	@userId INT,
	@token VARCHAR(50),
	@skillId INT
AS
BEGIN
	SET NOCOUNT ON;
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN		
		SELECT Id, Title, Level FROM [WorkIT].[dbo].[Skills] WHERE UserId = @userId AND Id = @skillId
	END
	ELSE
	BEGIN
		SELECT Id, Title, Level FROM [WorkIT].[dbo].[Skills] WHERE UserId = -1;
	END;
END
