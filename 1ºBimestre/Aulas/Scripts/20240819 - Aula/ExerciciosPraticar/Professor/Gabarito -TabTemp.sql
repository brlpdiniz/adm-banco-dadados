use abd_aula;
go

-- 1. Abra uma sessão (sessão 1) no SQL Server Management Studio.


-- 2. Crie uma tabela temporária global com os seguintes dados: 
-- Nome do cliente, data de nascimento, dia de nascimento, mês de nascimento e idade
select cli_nome, cli_nascimento, 
day(cli_nascimento) as dia, month(cli_nascimento) as mes,
datediff(yyyy, cli_nascimento, getdate()) as idade 
into ##clientes
from cliente

-- 3. Liste o conteúdo da tabela temporária.
select * from ##clientes;
-- 4. Verifique se a tabela foi criada.
-- OK
-- 5. Encerre a sua sessão no SQL Server.
-- OK
-- 6. Abra novamente a sessão.
-- OK
-- 7. Verifique se a tabela temporária ainda existe
-- A tabela não existe mais, pois a tabela temporária foi excluída ao fechar a sessão.
