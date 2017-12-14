-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE CreateResume
	@userId INT,
	@token VARCHAR(50),
	@title VARCHAR(50),
	@url VARCHAR(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @status INT, @userType INT
	SELECT @status = 0;
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @userId AND Token = @Token))
	BEGIN		
		SELECT @userType = userType FROM WorkIT.dbo.Users WHERE Id = @userId;
		IF (@userType = 0)
		BEGIN
			INSERT INTO WorkIT.dbo.Resumes(userId, Title, URL) VALUES(@userId, @title, @url);
			SELECT @status = 1;
		END;
	END

	SELECT @status;
END
GO
