-- Construa uma VIEW que mostre o nome das cidades, o nome do estado ao qual pertence a cidade e a região do país.
USE ABD_aula
GO

-- v.1
create view mostraCidade
as
	select cid_nome, est_nome, reg_nome
	from cidade c
	inner join estado e
	on c.est_id = e.est_id
	inner join regiao r
	on r.reg_id = e.reg_id

-- v.2
CREATE VIEW CidadeEstadoRegiao
AS
SELECT
    c.cid_Nome AS Nome_Cidade,
    e.est_Nome AS Nome_Estado,
    r.reg_Nome AS Nome_Regiao
FROM
    cidade c
JOIN
    estado e ON c.est_id = e.est_id
JOIN
    regiao r ON e.reg_id = r.reg_id;


-- Crie uma tabela temporária local que armazene os dados da tabela pedido
SELECT *
	INTO #dadosPedido
FROM pedido;

SELECT * FROM #dadosPedido