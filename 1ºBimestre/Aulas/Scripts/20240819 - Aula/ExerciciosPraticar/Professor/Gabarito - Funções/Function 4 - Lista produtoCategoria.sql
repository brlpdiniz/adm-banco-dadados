use abd_aula
go
-- Função Inline table
create function ListaprodutoCategoria(@categoria varchar(100))
returns table
as
	return (
	select pro_descricao, cat_descricao from produto p
	inner join categoriaProduto c 
	on c.cat_id = p.cat_id
	and c.cat_descricao = @categoria)

	select * from dbo.ListaprodutoCategoria('Lanche')
