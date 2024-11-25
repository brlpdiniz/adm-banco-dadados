-- Carga das tabelas dimens�es
use dw_aula;
go

-- ETL Dimens�es
-- Carga da faixa et�ria.
	insert into dim_FaixaEtaria 
	values (1, 'at� 20 anos'),
	(2, '21 anos a 30 anos'),
	(3, '31 anos a 50 anos'),
	(4, '51 anos a 70 anos'),
	(5, 'mais de 70 anos')

-- carga da tabela tempo

insert into dim_tempo
	select distinct ped_data as data,
	day(ped_data) as dia,
	month(ped_data) as mes,
	year(ped_data) as ano,
	DATEPART(dw, ped_data) as DiaSemana
	from abd_aula.dbo.pedido 
	where ped_data not in (select data from dim_tempo)


-- carga das cidades dos resturantes
insert into dim_cidade
	select distinct c.cid_id, c.cid_nome 
	from abd_aula.dbo.loja l 
	inner join abd_aula.dbo.endereco e
	on l.end_id = e.end_id
	inner join abd_aula.dbo.bairro b
	on e.bai_id = b.bai_id
	inner join abd_aula.dbo.cidade c
	on b.cid_id = c.cid_id
	where c.cid_id not in (select idCidade from dim_cidade)




