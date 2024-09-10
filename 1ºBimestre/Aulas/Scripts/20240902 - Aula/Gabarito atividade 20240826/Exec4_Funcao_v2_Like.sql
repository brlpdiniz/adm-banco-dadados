create function comprasCliente(@nome varchar(100))
returns table 
as return (
select cli_nome, pro_descricao, ped_data
from pedido p
inner join cliente c
on p.Cli_id = c.Cli_id
inner join PedidoProduto pp
on p.ped_id = pp.ped_id
inner join produto pt
on pp.pro_id = pt.pro_id
and cli_nome = @nome
);


select * from dbo.comprasCliente('Ricardo Santos')

select * from dbo.comprasCliente('Santos')