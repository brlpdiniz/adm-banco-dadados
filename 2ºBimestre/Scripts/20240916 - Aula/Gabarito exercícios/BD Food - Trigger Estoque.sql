use food;
go

alter table produto
    add pro_estoque decimal(10);

update Produto 
set pro_estoque = 50;

select pro_id, pro_estoque from Produto;

create trigger AtualizaEstoque on PedidoProduto
after insert
as
	declare @pro_id int;
	declare @quantidade int;
	set @quantidade = (select pdd_quantidade from inserted)
	update Produto 
		set pro_estoque = pro_estoque - @quantidade
		where pro_id = @pro_id;
go
