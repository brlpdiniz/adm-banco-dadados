use abd_aula
go
-- Função Inline table
create function cidadePorEstado(@uf char(02))
returns table
as
	return (
	select cid_nome from cidade
	inner join estado
	on cidade.est_id = estado.est_id
	and est_Sigla = @uf)

	select * from dbo.cidadePorEstado('PR')
