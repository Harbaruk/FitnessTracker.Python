USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[GetSkillInfo]    Script Date: 08.12.2017 10:13:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetResumeInfo] 
	@userId INT,
	@token VARCHAR(50),
	@resumeId INT
AS
BEGIN
	SET NOCOUNT ON;
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN		
		SELECT Id, Title, URL FROM [WorkIT].[dbo].[Resumes] WHERE userId = @userId AND Id = @resumeId
	END
	ELSE
	BEGIN
		SELECT Id, Title, URL FROM [WorkIT].[dbo].[Resumes] WHERE userId = -1;
	END;
END
