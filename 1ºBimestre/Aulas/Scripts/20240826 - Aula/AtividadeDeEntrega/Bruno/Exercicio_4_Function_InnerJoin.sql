/*
Crie Fun��o que retorne o nome de todos os produtos comprados por um determinado cliente. A fun��o receber� como
par�metros de entrada o nome do cliente.
*/

use BD_2017208552
go

/* DEBUG
select * from PedidoProduto, Produto, Pedido, Cliente
select * from Produto
select * from Pedido
select * from Cliente order by Cli_nome
select * from PedidoProduto
drop function produtoPorCliente
*/

create function comprasCliente(@nome varchar(100))
	returns table
	as return (
		select pro_descricao
		from pedido p
		inner join cliente c
		on p.Cli_id = c.Cli_id
		inner join PedidoProduto pp
		on p.ped_id = pp.ped_id
		inner join produto pt
		on pp.prod_id = pt.pro_id
		and cli_nome = @nome
);
go

select * from dbo.produtoPorCliente('Bianca')