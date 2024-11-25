/*
		----- DEBUG -----

	select * from dim_categoria
	select * from dim_tempo order by data DESC
	select * from dim_loja
	select * from fato_vendas
	declare @data_corte date = '2024-12-10'

    select * from food.dbo.Pedido
    select * from food.dbo.PedidoProduto
    select * from food.dbo.Produto
    select * from food.dbo.Loja
    select * from food.dbo.CategoriaProduto

	insert into food.dbo.Pedido (ped_data, sit_id, loj_id, cli_id, Fun_id, Ent_id, fpg_id, tip_id)
	values
	('2026-12-11', 1, 2, 1, 1, 1, 1, 1),
	('2026-12-12', 2, 3, 2, 2, 2, 2, 2),
	('2026-12-13', 3, 4, 3, 3, 3, 3, 3);

	exec sp_CargaInicial
	go

	declare @data_corte date = '2024-12-10'
	exec sp_CargaIncremental @data_corte
	go

*/

-- Criacao do banco Data Warehouse
/*
	use master
	go
	IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'DW_food')
	begin
		drop database DW_food;
	end
	IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'DW_food')
	begin
		create database DW_food;
	end
	go
	use DW_food;
	go
*/

-- Dimensao: Categoria
create table dim_categoria (
	cat_id int primary key,
	cat_descricao varchar(100)
);

-- Dimensao: Tempo
create table dim_tempo (
    tempo_id int primary key identity(1,1), -- id comeca em 1 e aumenta conforme o numero de linhas
    data date not null,
    dia_semana varchar(15),
    dia int,
    mes int,
    ano int,
    bimestre int,
    trimestre int
);

-- Dimensao: Loja
create table dim_loja (
    loja_id int primary key,
    loja_nome varchar(100),
    cidade varchar(150),
    estado varchar(80),
    regiao varchar(50)
);

-- Fato: Vendas
create table fato_vendas (
	primary key (data_id, loja_id, categoria_id),
    data_id int not null foreign key references dim_tempo(tempo_id),
    loja_id int not null foreign key references dim_loja(loja_id),
    categoria_id int not null foreign key references dim_categoria(cat_id),
    valor_total decimal(15, 2) not null
);

/*
	Carga Inicial -> Populando as tabelas do DW (dim e fato)
*/
go
create procedure sp_CargaInicial
as
begin

-- Categoria
insert into dim_categoria (cat_id, cat_descricao)
select distinct cat_id, cat_descricao
from food.dbo.categoriaProduto;

-- Tempo
insert into dim_tempo (data, dia_semana, dia, mes, bimestre, trimestre, ano)
select 
    ped_data as data,
    datename(weekday, ped_data) as dia_semana,
    day(ped_data) as dia,
    month(ped_data) as mes,
    (month(ped_data) - 1) / 2 + 1 as bimestre,
    datepart(quarter, ped_data) as trimestre,
    year(ped_data) as ano
from food.dbo.pedido;

-- Loja
insert into dim_loja (loja_id, loja_nome, cidade, estado, regiao)
select 
    l.loj_id, l.loj_nome, c.cid_nome, e.est_nome, r.reg_nome
from 
    food.dbo.loja l
join food.dbo.endereco ed on l.end_id = ed.end_id
join food.dbo.bairro b on ed.bai_id = b.bai_id
join food.dbo.cidade c on b.cid_id = c.cid_id
join food.dbo.estado e on c.est_id = e.est_id
join food.dbo.regiao r on e.reg_id = r.reg_id;

-- Fato Vendas
insert into fato_vendas (data_id, loja_id, categoria_id, valor_total)
select 
    isnull(t.tempo_id, 0) as data_id,
    isnull(l.loja_id, 0) as loja_id,
    c.cat_id,
    coalesce(sum(pp.pdd_preco * pp.pdd_quantidade), 0) as valor_total
from food.dbo.produto p
left join food.dbo.pedidoProduto pp on pp.pro_id = p.pro_id
left join food.dbo.pedido ped on ped.ped_id = pp.ped_id
left join dim_tempo t on t.data = ped.ped_data
left join dim_loja l on l.loja_id = ped.loj_id
right join dim_categoria c on c.cat_id = p.cat_id
where t.tempo_id is not null -- Garante que o tempo existe
  and l.loja_id is not null -- Garante que a loja existe
group by 
    t.tempo_id, l.loja_id, c.cat_id;
end;
go

/*
	Existem categorias sem produto registrado no banco food, valor_total = 0...
	Por isso, algumas categorias não aparecem nos gráficos (fiquei 3h me batendo com isso rsrs)
	Para mostrá-las no DW_food, o professor pode executar o código abaixo e assim, será possível vê-las no gráfico do BI (mesmo que zeradas)
	Motivo:
		"Mostrar o Top 10 das categorias de prato mais vendidas"
	Caso não precise aparecer as categorias zeradas, não precisa rodar o código abaixo:
*/

/*
	insert into fato_vendas (data_id, loja_id, categoria_id, valor_total)
	select 
		t.tempo_id,
		l.loja_id,
		c.cat_id,
		0 as valor_total
	from dim_tempo t
	cross join dim_loja l
	cross join dim_categoria c
	where not exists (
		select 1
		from fato_vendas fv
		where fv.data_id = t.tempo_id
		  and fv.loja_id = l.loja_id
		  and fv.categoria_id = c.cat_id
	);
*/

------------------------------------------------------------------------

/*
	Carga Incremental -> Atualizando as tabelas do DW (dim e fato)
*/

create procedure sp_CargaIncremental
    @data_corte DATE
as
begin

-- Tempo
insert into dim_tempo (data, dia_semana, dia, mes, bimestre, trimestre, ano)
select 
    ped_data as data,
    datename(weekday, ped_data) as dia_semana,
    day(ped_data) as dia,
    month(ped_data) as mes,
    (month(ped_data) - 1) / 2 + 1 as bimestre,
    datepart(quarter, ped_data) as trimestre,
    year(ped_data) as ano
from food.dbo.pedido
where ped_data > @data_corte
    and not exists (
        select 1
        from dim_tempo dt
        where dt.data = ped_data
    );

-- Fato Vendas
insert into fato_vendas (data_id, loja_id, categoria_id, valor_total)
select 
    t.tempo_id,
    l.loja_id,
    p.cat_id,
    sum(pp.pdd_preco * pp.pdd_quantidade) as valor_total
from 
    food.dbo.pedido ped
join food.dbo.pedidoProduto pp on ped.ped_id = pp.ped_id
join food.dbo.produto p on pp.pro_id = p.pro_id
join dim_tempo t on t.data = ped.ped_data
join dim_loja l on l.loja_id = ped.loj_id
where 
    ped.ped_data > @data_corte  -- Após 2024-12-10
    and not exists (
        select 1
        from fato_vendas fv
        where 
            fv.data_id = t.tempo_id
            and fv.loja_id = l.loja_id
            and fv.categoria_id = p.cat_id
    )
group by 
    t.tempo_id, l.loja_id, p.cat_id;
end;
go

exec sp_CargaInicial
go

declare @data_corte date = '2024-12-10'
exec sp_CargaIncremental @data_corte
go