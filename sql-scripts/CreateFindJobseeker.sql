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
CREATE PROCEDURE [dbo].[FindJobseekers]
	@title VARCHAR(50),
	@level INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if (@level = -1)
	BEGIN
		SELECT UserId, Name, Surname, Level FROM [dbo].[Users], [dbo].[Skills] WHERE Users.Id = Skills.UserId AND Skills.Title = @title;
	END
	ELSE
	BEGIN
		SELECT UserId, Name, Surname, Level FROM [dbo].[Users], [dbo].[Skills] WHERE Users.Id = Skills.UserId AND Skills.Title = @title AND Skills.Level = @level;
	END;
END
GO
