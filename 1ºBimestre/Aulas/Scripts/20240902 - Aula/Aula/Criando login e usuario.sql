USE [master]
GO
CREATE LOGIN [teste] WITH PASSWORD=N'123', 
DEFAULT_DATABASE=[ABD_Aula], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [ABD_Aula]
GO
CREATE USER [teste] FOR LOGIN [teste]
GO
USE [ABD_Aula]
GO
EXEC sp_addrolemember N'db_owner', N'teste'
GO
