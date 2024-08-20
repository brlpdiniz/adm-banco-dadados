-- Função Inline table
create function vendaPorData(@data date)
returns table
as
	return (
	select [ped_id],[ped_data],[Cli_id],[Fun_id]
	from Pedido
	where [ped_data] = @data)
