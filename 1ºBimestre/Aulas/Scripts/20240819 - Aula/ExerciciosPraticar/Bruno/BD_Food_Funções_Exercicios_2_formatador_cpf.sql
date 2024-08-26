/* 
Crie uma fun��o que formate o CPF. A fun��o receber� o CPF com os 11 caracteres e retornar� 
o CPF formatado: 11.111.111-11.
*/
   					   -- ou @valor int
create function CpfFormatter(@valorCpf char(11))
returns char(14)
as
begin
	declare @formatter char(14)
	
	set @formatter = substring(@valorCpf,1,3) + '.' + substring(@valorCpf,4,3) + '.' + substring(@valorCpf,7,3) + '-' + substring(@valorCpf,10,2)

	return @formatter
end

go

select dbo.CpfFormatter('07674944905')