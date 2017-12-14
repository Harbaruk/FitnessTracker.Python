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
CREATE PROCEDURE [dbo].[UpdateSkill] 
	@userId INT,
	@token VARCHAR(50),
	@skillId INT,
	@title VARCHAR(50),
	@level INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @status INT
	SELECT @status = 0
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN
		IF (exists(SELECT * FROM [WorkIT].[dbo].[Skills] WHERE UserId = @userId AND Id = @skillId))
		BEGIN
			SELECT @status = 1;
			UPDATE [WorkIT].[dbo].[Skills] SET Title = @title, Level = @level WHERE UserId = @userId AND Id = @skillId;
		END;
	END

	SELECT @status;
END
