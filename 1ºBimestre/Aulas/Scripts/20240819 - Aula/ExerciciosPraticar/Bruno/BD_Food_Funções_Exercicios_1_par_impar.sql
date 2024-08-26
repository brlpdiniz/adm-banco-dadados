/* Crie uma fun��o que indique se um n�mero � par um �mpar. A fun��o receber� um n�mero como par�metro de entrada 
	e dever� retornar se ele � �mpar ou par.
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