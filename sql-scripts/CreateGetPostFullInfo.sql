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
CREATE PROCEDURE [dbo].[GetPostFullInfo]
	@postId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ownerId INT
	SELECT @ownerId = OwnerId FROM [dbo].[Posts] WHERE Id = @postId;

	SELECT Title, Description, Posts.Email, Posts.Phone, OwnerId, CreationData, Counter, Name, Surname FROM Users, Posts WHERE Posts.Id = @postId AND Users.Id = @ownerId;
END
GO
