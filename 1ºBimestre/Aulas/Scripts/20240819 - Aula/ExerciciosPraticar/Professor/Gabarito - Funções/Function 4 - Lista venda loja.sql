use abd_aula;
go
create function ListaVendas(@loja integer, @data date)
returns table
as
	return (
		select loj_nome, ped_data, sum([pdd_preco] * [pdd_quantidade]) as total
		from produto p
		inner join loja l
		on p.loj_id = l.loj_id
		inner join CategoriaProduto cp
		on p.cat_id = cp.cat_id
		inner join pedido 
		on pedido.loj_id = l.loj_id
		inner join funcionario f
		on f.Fun_id = pedido.Fun_id
		inner join Situacao s
		on pedido.sit_id = s.sit_id
		inner join PedidoProduto pp
		on pp.ped_id = pedido.ped_id
		where l.loj_id = @loja
		and pedido.ped_data = @data
		group by pro_descricao, cat_descricao, loj_nome, fun_nome, sit_descricao, ped_data, pedido.ped_id)

	select * from dbo.ListaprodutoCategoria('Lanche')
