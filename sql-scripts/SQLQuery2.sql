USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[CreateNewUser]    Script Date: 19.11.2017 20:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[CreateNewUser]
	-- Add the parameters for the stored procedure here
	@Email VARCHAR(50),
	@Password VARCHAR(50),
	@Name VARCHAR(25),
	@Surname VARCHAR(25),
	@DateOfBirth DATE,
	@Address VARCHAR(100),
	@Phone VARCHAR(20),
	@userType INT
AS
SET NOCOUNT ON
BEGIN

	IF (exists(select * from WorkIT.dbo.Users where Email = @Email))
	BEGIN
		SELECT 1;
	END
	ELSE
	BEGIN
		INSERT INTO WorkIT.dbo.Users(Name, Surname, DateOfBirth, Email, Password, Address, Phone, userType) VALUES(@Name, @Surname, @DateOfBirth, @Email, @Password, @Address, @Phone, @userType);
		SELECT 0;
	END;
		
END
GO