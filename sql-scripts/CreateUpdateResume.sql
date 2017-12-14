USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[UpdateSkill]    Script Date: 08.12.2017 10:56:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateResume] 
	@userId INT,
	@token VARCHAR(50),
	@resumeId INT,
	@title VARCHAR(50),
	@url VARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @status INT
	SELECT @status = 0
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN
		IF (exists(SELECT * FROM [WorkIT].[dbo].[Resumes] WHERE userId = @userId AND Id = @resumeId))
		BEGIN
			SELECT @status = 1;
			UPDATE [WorkIT].[dbo].[Resumes] SET Title = @title, URL = @url WHERE UserId = @userId AND Id = @resumeId;
		END;
	END

	SELECT @status;
END
