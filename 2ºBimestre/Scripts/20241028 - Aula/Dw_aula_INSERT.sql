use BD_2017208552;

/* Debug */
-- select ped_data from BD_2017208552.dbo.pedido
-- select distinct ped_data from BD_2017208552.dbo.pedido

-- carga na tabela tempo
create table dim_tempo (
data date primary key,
dia integer,
mes integer,
ano integer,
diaDaSemana integer)

insert into dim_tempo
	select distinct ped_data as datra,
	day(ped_data) as dia,
	month(ped_data) as mes,
	year(ped_data) as ano,
	datepart(dw, ped_data) as DiaSemana
	from BD_2017208552.dbo.pedido order by ped_data


/* Debug */
-- select * from BD_2017208552.dbo.Loja

-- carga na tabela cidade
create table dim_cidade (
idCidade integer primary key,
nomeCidade varchar(200));

insert into dim_cidade
	select distinct  from BD_2017208552.dbo.loja l 
	inner join BD_2017208552.dbo.endereco e
	on l.end_id = e.end_id
	inner join BD_2017208552.dbo.bairro b
	on e.bai_id = b.bai_id
	inner join BD_2017208552.dbo.cidade c
	on b.cid_id = c.cid_id

create Table dim_FaixaEtaria (
idFaixa  integer primary key,
nomeCidade varchar(200));

create table fato (
	data date,
	idCidade integer,
	idFaixa integer,
	quantidade integer,
	constraint fk_data foreign key (data) references dim_tempo(data),
	constraint fk_cidade foreign key (idCidade) references dim_cidade(idCidade),
	constraint fk_faixa foreign key (idFaixa) references dim_FaixaEtaria(idFaixa)
);

-- ETL Dimensões
-- Carga da faixa etária

insert into dim_FaixaEtaria (descricao)
values (1, '0-20 anos'),
	(2, '21 anos a 30 anos'),
	(3, '31 anos a 50 anos'),
	(4, '51 anos a 70 anos'),
	(5, 'mais de 70 anos')

select * from dim_FaixaEtaria