use abd_aula;
go

-- 1. Abra uma sess�o (sess�o 1) no SQL Server Management Studio.


-- 2. Crie uma tabela tempor�ria global com os seguintes dados: 
-- Nome do cliente, data de nascimento, dia de nascimento, m�s de nascimento e idade
select cli_nome, cli_nascimento, 
day(cli_nascimento) as dia, month(cli_nascimento) as mes,
datediff(yyyy, cli_nascimento, getdate()) as idade 
into ##clientes
from cliente

-- 3. Liste o conte�do da tabela tempor�ria.
select * from ##clientes;
-- 4. Verifique se a tabela foi criada.
-- OK
-- 5. Encerre a sua sess�o no SQL Server.
-- OK
-- 6. Abra novamente a sess�o.
-- OK
-- 7. Verifique se a tabela tempor�ria ainda existe
-- A tabela n�o existe mais, pois a tabela tempor�ria foi exclu�da ao fechar a sess�o.
