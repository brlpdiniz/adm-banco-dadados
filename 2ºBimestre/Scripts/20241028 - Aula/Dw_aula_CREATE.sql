use BD_2017208552;

create table dim_tempo (
data date primary key,
dia integer,
mes integer,
ano integer,
diaDaSemana integer)

create table dim_cidade (
idCidade integer primary key,
nomeCidade varchar(200));

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