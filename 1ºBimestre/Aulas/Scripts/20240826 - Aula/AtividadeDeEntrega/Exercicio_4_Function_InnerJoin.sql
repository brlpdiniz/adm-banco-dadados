/*
Crie Função que retorne o nome de todos os produtos comprados por um determinado cliente. A função receberá como
parâmetros de entrada o nome do cliente.
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

create function produtoPorCliente(@nomeCliente VARCHAR(50))
	returns table
	as return (
		select
			P.pro_descricao as NomeProduto
		from
			Produto P
		INNER JOIN 
			PedidoProduto PP ON P.pro_id = PP.pro_id
		INNER JOIN 
			Pedido PD ON PP.ped_id = PD.ped_id
		INNER JOIN 
			Cliente CL ON PD.Cli_id = CL.Cli_id
		WHERE 
			CL.Cli_nome like '%' + @nomeCliente + '%'
);
go

select * from dbo.produtoPorCliente('Bianca')