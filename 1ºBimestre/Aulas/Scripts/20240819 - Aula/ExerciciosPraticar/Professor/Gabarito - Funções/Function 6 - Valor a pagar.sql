use abd_aula;
go
create function ValorPagar (@datapgto date, @datavenc date, 
@valor real, @taxa_mes real)
returns real
begin
	declare @val_apagar real
	declare @taxa_dia real
	declare @num_dia int
	if (@datapgto > @datavenc)
	begin
		set @num_dia = datediff(dd, @datavenc, @datapgto)
		set @taxa_dia = (@taxa_mes / 30) * @num_dia 
		set @val_apagar = @valor + (@valor * @taxa_dia) / 100
	end
	else
		set @val_apagar = @valor	

    return @val_apagar
End

-- select dbo.ValorPagar('2024/08/31','2024/08/01', 1000.00, 30)

