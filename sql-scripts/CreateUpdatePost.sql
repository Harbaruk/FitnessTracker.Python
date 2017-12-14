USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[UpdateResume]    Script Date: 13.12.2017 12:24:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdatePost] 
	@userId INT,
	@token VARCHAR(50),
	@postId INT,
	@title VARCHAR(100),
	@description VARCHAR(2500),
	@email VARCHAR(50),
	@phone VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @status INT
	SELECT @status = 0
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN
		IF (exists(SELECT * FROM [WorkIT].[dbo].[Posts]  WHERE Id=@postId AND OwnerId=@userId))
		BEGIN
			SELECT @status = 1;
			UPDATE [WorkIT].[dbo].[Posts] SET Title = @title, Description = @description, Phone = @phone, Email = @email WHERE Id=@postId AND OwnerId=@userId;
		END;
	END

	SELECT @status;
END
