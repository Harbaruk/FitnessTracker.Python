USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[CreatePost]    Script Date: 03.12.2017 10:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteSkill] 
	@userId INT,
	@token VARCHAR(50),
	@skillId INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @status INT, @userType INT
	SELECT @status = 0;
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN
		IF (exists(SELECT * FROM WorkIT.dbo.Skills WHERE Id = @skillId AND UserId = @userId))
		BEGIN
			DELETE FROM WorkIT.dbo.Skills WHERE Id = @skillId AND UserId = @userId;
			SELECT @status = 1;
		END;
	END

	SELECT @status
END
