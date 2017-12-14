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
ALTER PROCEDURE CreatePost 
	@userId INT,
	@token VARCHAR(50),
	@title VARCHAR(100),
	@description VARCHAR(2500),
	@email VARCHAR(50),
	@phone VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @status INT, @userType INT
	SELECT @status = 0;
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN		
		SELECT @userType = userType FROM WorkIT.dbo.Users WHERE Id = @UserId;
		IF (@userType = 1)
		BEGIN
			INSERT INTO WorkIT.dbo.Posts(Title, Description, Email, Phone, OwnerId, CreationData, Counter) VALUES(@title, @description, @email, @phone, @userId, CURRENT_TIMESTAMP, 0);
			SELECT @status = 1;
		END;
	END

	SELECT @status;
END
GO
