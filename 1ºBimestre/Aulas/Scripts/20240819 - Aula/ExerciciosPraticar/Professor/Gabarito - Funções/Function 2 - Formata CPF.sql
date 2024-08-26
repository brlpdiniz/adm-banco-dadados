use abd_aula
go
create function CPF(@cpf char(11))
returns char(14)
as
begin
	declare @retorno varchar(14)
    set @retorno = substring(@cpf,1,3) + '.' +
    substring(@cpf,4,3) + '.' + 
    substring(@cpf,7,3) + '-' + 
    substring(@cpf,10,2) 
    return @retorno
End

-- select dbo.CPF('12345678900');
