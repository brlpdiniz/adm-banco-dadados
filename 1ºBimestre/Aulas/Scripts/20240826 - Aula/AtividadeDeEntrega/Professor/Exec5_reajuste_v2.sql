create function reajustePreco2(@op as char(1), 
@perc as decimal(10,2), @nome as varchar(100))
returns decimal(10,2)
as
begin
	declare @novoPreco as decimal(10,2)
	declare @precoAtual as decimal(10,2)
	set @novoPreco = 0
	set @precoAtual = (select pro_preco
						from produto
						where pro_descricao = @nome)
	if @op = '+' 
		set @novoPreco = @precoAtual + ((@precoAtual * @perc) / 100)
	if @op = '-' 
		set @novoPreco = @precoAtual - ((@precoAtual * @perc) / 100)
	return @novoPreco
end

select dbo.reajustePreco2('+', 10, 'Hamburguer picanha')
select dbo.reajustePreco2('-', 10, 'Hamburguer picanha')

select * from produto