USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[DeleteSkill]    Script Date: 04.12.2017 9:59:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteResume] 
	@userId INT,
	@token VARCHAR(50),
	@resumeId INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @status INT, @userType INT
	SELECT @status = 0;
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN
		IF (exists(SELECT * FROM WorkIT.dbo.Resumes WHERE Id = @resumeId AND userId = @userId))
		BEGIN
			DELETE FROM WorkIT.dbo.Resumes WHERE Id = @resumeId AND userId = @userId;
			SELECT @status = 1;
		END;
	END

	SELECT @status
END
