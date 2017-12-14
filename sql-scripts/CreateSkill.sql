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
CREATE PROCEDURE [dbo].[CreateSkill] 
	@userId INT,
	@token VARCHAR(50),
	@title VARCHAR(50),
	@level INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @status INT, @userType INT
	SELECT @status = 0;
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN		
		SELECT @userType = userType FROM WorkIT.dbo.Users WHERE Id = @UserId;
		IF (@userType = 0)
		BEGIN
			INSERT INTO WorkIT.dbo.Skills(UserId, Title, Level) VALUES(@UserId, @title, @level);
			SELECT @status = 1;
		END;
	END

	SELECT @status;
END
