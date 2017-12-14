USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[GetSkillInfo]    Script Date: 11.12.2017 12:47:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserInfo] 
	@userId INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Name, Surname, DateOfBirth, Email, Address, Phone, userType FROM dbo.Users WHERE Id = @userId;
END
