use abd_aula
go
-- 1
create view mostraProdutos
as
	select pro_descricao, pro_preco, loj_nome, cat_descricao
	from produto p
	inner join loja l
	on p.loj_id = l.loj_id
	inner join CategoriaProduto cp
	on p.cat_id = cp.cat_id

-- 2 Usando a view criada anteriormente. Liste os veículos ordenados pela categoria.
select * from mostraProdutos order by cat_descricao;

-- 3 Criar uma outra exibição que contenha as seguintes colunas: 
-- Nome do produto (prato), nome da categoria, nome da loja, nome do funcionário 
-- que realizou a venda, a descrição do status do pedido (situação) e o total do pedido.

create view mostraVendas
as
	select pro_descricao, cat_descricao, loj_nome, fun_nome, sit_descricao, ped_data,
	sum([pdd_preco] * [pdd_quantidade]) as total
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
	group by pro_descricao, cat_descricao, loj_nome, fun_nome, sit_descricao, ped_data, pedido.ped_id;

-- 4 Faça uma consulta, utilizando a exibição criada, 
-- mostrando os pedidos por ordem de data e loja.
select * from mostraVendas order by ped_data, loj_nome;

