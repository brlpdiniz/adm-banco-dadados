use BD_2017208552
go

/*
Utilizando o seu banco de dados, desenvolva as quest�es abaixo:
	1. Realize um backup full.
*/
backup database BD_2017208552 to disk = '\\10.10.0.15\sql\BD_2017208552.bak'


/*	2. Crie o login com os seguintes requisitos: 
		Nome do login: ser� o seu nome mais o termo �BD�. Exemplo: joseMariaBD; 
		senha: 123; 
		Desabilite as pol�ticas de senha (requisitos m�nimos e expira��o); 
		Atribua como banco de dados default o seu banco de dados.
*/
create login brunoDinizBD with password = '123', default_database = [BD_2017208552], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;


--	3. Crie o usu�rio com o mesmo nome do login e atrelado ao login criado.
create user [brunoDinizBD] for login [brunoDinizBD];


--	4. Atribua a permiss�o de �db_owner� do banco de dados para o usu�rio criado. 
exec sp_addrolemember N'db_owner', N'brunoDinizBD'

-- 5. Fa�a um novo backup diferencial na sua base de dados. 
backup database BD_2017208552 to disk = '\\10.10.0.15\sql\BD_2017208552.bak' with differential;

-- 6. Fa�a o login com o usu�rio criado. Deu tudo certo? 
	-- Deu tudo certo!

-- 7. Feche a conex�o do seu banco de dados e conecte-se novamente com o seu usu�rio padr�o no banco de dados. 


-- 8. Fa�a um backup de log. 
backup log BD_2017208552 to disk = '\\10.10.0.15\sql\BD_2017208552.bak';

-- 9. Fa�a um novo backup diferencial. 
backup database BD_2017208552 to disk = '\\10.10.0.15\sql\BD_2017208552.bak' with differential;

-- 10. Verifique se o seu arquivo de backup est� ok. Se cont�m todos os backups que voc� realizou at� o momento. 


/*  11. Neste momento, o banco de dados apresentou um problema. Voc� dever� restaurar o banco de dados. Para isso, voc� dever� utilizar os backups realizados. Responda o seguinte: 
    a. Quais seriam os backups que voc� recuperaria? 
    b. Qual a ordem de recupera��o dos backups?
*/