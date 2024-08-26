-- 1. Todos os produtos (pratos) da categoria “Frutos do Mar”. 
-- Na relação deve constar: Código, Nome do prato, preço

select pro_id, pro_descricao, pro_preco
from produto
where cat_id = (select cat_id from CategoriaProduto 
				where cat_descricao = 'Frutos do Mar')

-- 2. Todos os pratos que foram pedidos mais de duas vezes nos últimos 6 meses.
select pro_id, pro_descricao 
from Produto
where pro_id in (
	select pro_id from PedidoProduto pp
	inner join pedido p
	on p.ped_id = pp.ped_id
	where DATEDIFF(mm, p.ped_data, getdate()) <= 6
	group by pp.pro_id
	having count(pro_id) > 2)

-- 3. Mostrar o nome das lojas que possuem pedidos realizados.
select loj_id, loj_nome
from loja
where loj_id in (select distinct loj_id from pedido)