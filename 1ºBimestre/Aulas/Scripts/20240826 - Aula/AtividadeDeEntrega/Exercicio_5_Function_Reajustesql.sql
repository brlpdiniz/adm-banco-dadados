/*
Desenvolva uma função que reajuste o preço de venda do produto. Este reajuste poderá ser para mais (+) ou para menos
(-). A função deverá retornar o novo valor. A função não reajustará o preço na tabela. Simplesmente retornará o novo valor.
Ex.: Preço R$ 10,00, reajuste de 10% par amais. = resultado R$ 11,00
Preço R$ 10,00, reajuste de 10% para menos. = resultado R$ 9,00
*/

use BD_2017208552
go

-- select * from Produto
-- drop function dbo.produtoReajustado


create function produtoReajustado(@pro_id int, @reajuste decimal(5,2))
returns decimal(10,2)
as
begin
    declare @precoAtual decimal(10, 2);
    declare @novoPreco decimal(10, 2);

    -- preço atual do produto
    select
		@precoAtual = pro_preco
    from
		Produto
    where
		pro_id = @pro_id;

    -- novo preço
    set @novoPreco = @precoAtual * (1 + @reajuste / 100.0);
	
	return @novoPreco;
end;
go

SELECT dbo.produtoReajustado(1, 10.00) AS NovoPreco;