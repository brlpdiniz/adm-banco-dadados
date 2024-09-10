use abd_aula;
go

alter table pedido
add ped_total decimal(10,2);

alter  trigger diminuiTotalPedido on pedidoProduto
after delete
as 
begin
	declare @total decimal(10,2)
	set @total = (select pdd_quantidade * pdd_preco 
	from DELETED)
	update pedido
	set ped_total = ped_total - @total
	where ped_id = (select ped_id from deleted)
end



select * from pedido where ped_id = 1
select * from pedidoProduto where ped_id = 1

delete from PedidoProduto
where pdd_id = 815;