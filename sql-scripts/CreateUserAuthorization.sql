
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE UserAuthorization
	-- Add the parameters for the stored procedure here
	@Email VARCHAR(50),
	@Password VARCHAR(50),
	@inToken VARCHAR(50)
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @userId INT, @outToken VARCHAR(50)
	IF (exists(SELECT * FROM WorkIT.dbo.Users WHERE Email = @Email AND Password = @Password))
	BEGIN

		SELECT @userId = Id FROM WorkIT.dbo.Users WHERE Email = @Email AND Password = @Password;
		UPDATE WorkIT.dbo.Tokens SET Token = @inToken WHERE userId = @userId;
		SELECT @outToken = @inToken;

	END
	ELSE
	BEGIN
		SELECT @userId = 0;
		SELECT @outToken = '';
	END;
	
	SELECT @userId, @outToken;
END
GO
