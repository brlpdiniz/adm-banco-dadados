/*
Fun��o que retorne todas as cidades de um determinado estado. A sigla do estado ser� informada como par�metro.
Ex.: Listar as cidades do Paran�. O usu�rio ir� chamar a fun��o informando a sigla PR e a fun��o retornar� todas as
cidades do estado do Paran�.
Usu�rio: nomedaFun��o(�PR�)
Resultado: Curitiba
Londrina
Maring�
......*/create function CidadesPorEstado2(@value char(2))returns tableasreturn (	select cid_Nome	from Cidade	inner join Estado on Cidade.est_id = Estado.est_id	where est_Sigla = @value);select *from dbo.CidadesPorEstado2('ES')select *from dbo.CidadesPorEstado2('PR')/*		TAMB�M FUNCIONA	select cid_Nome from Cidade c	inner join Estado e	on c.est_id = e.est_id	where est_Sigla = 'PR'*/