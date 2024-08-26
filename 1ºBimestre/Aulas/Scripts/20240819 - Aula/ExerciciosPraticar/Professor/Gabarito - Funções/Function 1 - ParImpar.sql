use abd_aula;
go
create function ParImpar (@numero int)
returns char(05)
as
begin
	declare @resultado char(05)
	if @numero % 2 = 0 
		set @resultado = 'par'
	else
		set @resultado = 'Ímpar'
	return @resultado
end

-- select dbo.ParImpar(10)