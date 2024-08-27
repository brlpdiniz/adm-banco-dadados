-- [INDEX]

-- O SELECT projeta, o que seleciona é o 'WHERE'

use BD_2017208552;
go

select * from cidade		-- 0,023
where cid_nome = 'Curitiba';

create index indNomeCidade on cidade(cid_nome)

select * from cidade		-- 0,0031
where cid_nome = 'Curitiba';

drop index indNomeCidade on cidade

select * from cidade		-- 0,2312
where cid_nome like 'L%'
order by cid_nome

create index indPedidoDataCli on pedido(ped_data, Cli_id)
select * from pedido
order by ped_data, Cli_id