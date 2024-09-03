use BD_2017208552
go

/*
Utilizando o seu banco de dados, desenvolva as questões abaixo:
	1. Realize um backup full.
*/
backup database BD_2017208552 to disk = '\\10.10.0.15\sql\BD_2017208552.bak'


/*	2. Crie o login com os seguintes requisitos: 
		Nome do login: será o seu nome mais o termo “BD”. Exemplo: joseMariaBD; 
		senha: 123; 
		Desabilite as políticas de senha (requisitos mínimos e expiração); 
		Atribua como banco de dados default o seu banco de dados.
*/
create login brunoDinizBD with password = '123', default_database = [BD_2017208552], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;


--	3. Crie o usuário com o mesmo nome do login e atrelado ao login criado.
create user [brunoDinizBD] for login [brunoDinizBD];


--	4. Atribua a permissão de “db_owner” do banco de dados para o usuário criado. 
exec sp_addrolemember N'db_owner', N'brunoDinizBD'

-- 5. Faça um novo backup diferencial na sua base de dados. 
backup database BD_2017208552 to disk = '\\10.10.0.15\sql\BD_2017208552.bak' with differential;

-- 6. Faça o login com o usuário criado. Deu tudo certo? 
	-- Deu tudo certo!

-- 7. Feche a conexão do seu banco de dados e conecte-se novamente com o seu usuário padrão no banco de dados. 


-- 8. Faça um backup de log. 
backup log BD_2017208552 to disk = '\\10.10.0.15\sql\BD_2017208552.bak';

-- 9. Faça um novo backup diferencial. 
backup database BD_2017208552 to disk = '\\10.10.0.15\sql\BD_2017208552.bak' with differential;

-- 10. Verifique se o seu arquivo de backup está ok. Se contém todos os backups que você realizou até o momento. 


/*  11. Neste momento, o banco de dados apresentou um problema. Você deverá restaurar o banco de dados. Para isso, você deverá utilizar os backups realizados. Responda o seguinte: 
    a. Quais seriam os backups que você recuperaria? 
    b. Qual a ordem de recuperação dos backups?
*/