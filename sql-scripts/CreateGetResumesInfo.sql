USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[GetSkillsInfo]    Script Date: 04.12.2017 9:47:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetResumesInfo] 
	@userId INT,
	@token VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @status INT, @userType INT
	SELECT @status = 0;
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN		
		SELECT Id, Title FROM [WorkIT].[dbo].[Resumes] WHERE UserId = @userId;
	END
	ELSE
	BEGIN
		SELECT Id, Title FROM [WorkIT].[dbo].[Resumes] WHERE UserId = -1;
	END;
END
