-- Função Multistament table
create function TotalvendaPorData(@data date)
returns @dados table (data date, total decimal(10,2)) 
as
begin
	Declare @total decimal(10,2)
	set @total = (
	select sum([pdd_preco] * [pdd_quantidade])
	from [dbo].[PedidoProduto] pp
	inner join [dbo].[Pedido] p
	on p.ped_id = pp.ped_id
	and p.ped_data = @data)
	insert into @dados values (@data, @total)
	return
end




