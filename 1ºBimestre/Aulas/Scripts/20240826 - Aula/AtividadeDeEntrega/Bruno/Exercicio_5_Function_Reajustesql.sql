/*
Desenvolva uma fun��o que reajuste o pre�o de venda do produto. Este reajuste poder� ser para mais (+) ou para menos
(-). A fun��o dever� retornar o novo valor. A fun��o n�o reajustar� o pre�o na tabela. Simplesmente retornar� o novo valor.
Ex.: Pre�o R$ 10,00, reajuste de 10% par amais. = resultado R$ 11,00
Pre�o R$ 10,00, reajuste de 10% para menos. = resultado R$ 9,00
*/

use BD_2017208552
go

-- select * from Produto
-- drop function dbo.produtoReajustado


create function produtoReajustado(@operador varchar(1), @pro_id int, @reajuste decimal(5,2))
returns varchar(1)
returns decimal(10,2)
as
begin
    declare @precoAtual decimal(10, 2);
    declare @novoPreco decimal(10, 2);

    -- pre�o atual do produto
    set @precoAtual = (
      select pro_preco
      from Produto
      where pro_id = @pro_id
    );

    -- novo pre�o
    if (@operador = '+')
      set @novoPreco = @precoAtual * (1 + @reajuste / 100.0);
    else
      set @novoPreco = @precoAtual * (1 - @reajuste / 100.0);
	return @novoPreco;
end;
go

SELECT dbo.produtoReajustado('+', 1, 10.00) AS NovoPreco;
SELECT dbo.produtoReajustado('-', 2, 20.00) AS NovoPreco;
