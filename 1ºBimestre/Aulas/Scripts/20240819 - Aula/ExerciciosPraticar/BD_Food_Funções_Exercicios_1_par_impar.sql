/* Crie uma função que indique se um número é par um ímpar. A função receberá um número como parâmetro de entrada 
	e deverá retornar se ele é ímpar ou par.
*/

create function identifParImpar(@value int)
returns char(5)
as
begin
	declare @response char(5)
	if (@value % 2) = 0
		set @response = 'par'
	else
		set @response = 'impar'
	return @response
end

go

select dbo.identifParImpar(10)