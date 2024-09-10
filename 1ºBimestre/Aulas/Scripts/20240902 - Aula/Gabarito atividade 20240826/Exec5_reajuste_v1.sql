create function reajustePreco(@op as char(1), 
@perc as decimal(10,2))
returns table 
as return (
select pro_descricao, pro_preco,
case @op
when '+' Then
	pro_preco + ((pro_preco * @perc) / 100)
when '-' Then
	pro_preco - ((pro_preco * @perc) / 100)
end as novoPreco
from Produto)

select * from dbo.reajustePreco('+', 10)
select * from dbo.reajustePreco('-', 10)