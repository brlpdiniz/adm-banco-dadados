-- Carga das tabelas dimensoes
use DW_2017208552;
go

-- ETL Dimensoes
-- Carga da faixa etaria.
	insert into dim_FaixaEtaria 
	values (1, 'ate 20 anos'),
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
	from BD_2017208552.dbo.pedido order by ped_data

-- carga das cidades dos resturantes
insert into dim_cidade
	select distinct c.cid_id, c.cid_nome 
	from BD_2017208552.dbo.loja l 
	inner join BD_2017208552.dbo.endereco e
	on l.end_id = e.end_id
	inner join BD_2017208552.dbo.bairro b
	on e.bai_id = b.bai_id
	inner join BD_2017208552.dbo.cidade c
	on b.cid_id = c.cid_id;

	select * from dim_FaixaEtaria
	select * from dim_tempo
	select * from dim_cidade