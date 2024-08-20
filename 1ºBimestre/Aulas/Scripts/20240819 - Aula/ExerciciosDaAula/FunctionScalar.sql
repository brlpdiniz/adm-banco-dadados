-- Fun��o scalar
/*
Coment�rio
*/
create function parImpar(@numero integer)
returns char(05)
as
begin
	declare @retorno char(05)
	if (@numero % 2) = 0 
		set @retorno = 'par'
	else
		set @retorno =  'impar'
	return @retorno
end