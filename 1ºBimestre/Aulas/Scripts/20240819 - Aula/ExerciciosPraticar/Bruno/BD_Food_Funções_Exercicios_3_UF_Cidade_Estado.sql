/*
Função que retorne todas as cidades de um determinado estado. A sigla do estado será informada como parâmetro.
Ex.: Listar as cidades do Paraná. O usuário irá chamar a função informando a sigla PR e a função retornará todas as
cidades do estado do Paraná.
Usuário: nomedaFunção(‘PR’)
Resultado: Curitiba
Londrina
Maringá
......*/create function CidadesPorEstado2(@value char(2))returns tableasreturn (	select cid_Nome	from Cidade	inner join Estado on Cidade.est_id = Estado.est_id	where est_Sigla = @value);select *from dbo.CidadesPorEstado2('ES')select *from dbo.CidadesPorEstado2('PR')/*		TAMBÉM FUNCIONA	select cid_Nome from Cidade c	inner join Estado e	on c.est_id = e.est_id	where est_Sigla = 'PR'*/