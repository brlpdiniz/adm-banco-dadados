use abd_aula;
go
select * from cidade
where cid_nome = 'Curitiba'; -- 0,023

create index indNomeCidade on cidade(cid_nome);
select * from cidade
where cid_nome = 'Curitiba'; -- 0,0031

drop index indNomeCidade on cidade;
select * from cidade
where cid_nome like 'L%'
order by cid_nome ; -- 0,02312

create index indNomeCidade on cidade(cid_nome);
select * from cidade
where cid_nome like 'L%'
order by cid_nome ; -- 0,02312


create index indPedidoDataCli on pedido(ped_data, cli_id);
select * from pedido
order by ped_data, Cli_id;

