use abd_aula;
go

alter table pedido
add ped_total decimal(10,2);

create trigger somaTotalPedido on pedidoProduto
after insert
as 
begin
	declare @total decimal(10,2)
	set @total = (select pdd_quantidade * pdd_preco 
	from inserted)
	update pedido
	set ped_total = ped_total + @total
	where ped_id = (select ped_id from inserted)
end


INSERT INTO [dbo].[PedidoProduto]
           ([ped_id]
           ,[pro_id]
           ,[pdd_quantidade]
           ,[pdd_preco]
           ,[pdd_observacoes])
     VALUES
           (1, 2, 1, 30, 'sem sal')


select * from pedido where ped_id = 1
