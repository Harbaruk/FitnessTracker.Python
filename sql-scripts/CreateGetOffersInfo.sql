USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[GetSkillsInfo]    Script Date: 14.12.2017 12:03:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOffersInfo] 
	@jobseekerId INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Id, Subject, Date, Status FROM [WorkIT].[dbo].[Offers] WHERE JobseekerId = @jobseekerId;
END
