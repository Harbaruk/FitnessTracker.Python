USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[CheckAuth]    Script Date: 23.11.2017 11:09:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[CheckAuth]
	@UserId INT,
	@Token VARCHAR(250)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @status INT, @userType INT
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN
		SELECT @status = 1;
		
		SELECT @userType = userType FROM WorkIT.dbo.Users WHERE Id = @UserId;
	END
	ELSE
	BEGIN
		SELECT @status = 0;
		SELECT @userType = 0;
	END; 
	SELECT @status, @userType;
END
