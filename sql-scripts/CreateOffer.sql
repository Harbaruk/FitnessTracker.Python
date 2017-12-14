USE [WorkIT]
GO
/****** Object:  StoredProcedure [dbo].[CreatePost]    Script Date: 13.12.2017 13:29:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateOffer] 
	@userId INT,
	@token VARCHAR(50),
	@jobseekerId INT,
	@subject VARCHAR(100),
	@message VARCHAR(1000),
	@postId INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @status INT, @userType INT
	SELECT @status = 0;
	IF (exists(SELECT * FROM WorkIT.dbo.Tokens WHERE UserId = @UserId AND Token = @Token))
	BEGIN		
		SELECT @userType = userType FROM WorkIT.dbo.Users WHERE Id = @jobseekerId;
		IF (@userType = 0)
		BEGIN
			INSERT INTO WorkIT.dbo.Offers(RecruiterId, JobseekerId, Subject, Message, PostId, Date, Status) VALUES(@userId, @jobseekerId, @subject, @message, @postId , CURRENT_TIMESTAMP, 0);
			SELECT @status = 1;
		END;
	END

	SELECT @status;
END
