/*
Criar um cursor que mostre uma mensagem de felicitações para os clientes. A mensagem será a seguinte:
	Parabéns, "nome do cliente", no dia "??" de "nome do mês", você completa mais um ano de vida.

Utilizando o cursor do exercício anterior, faça a leitura das seguintes linhas do cursor:
	a. Na última posição do cursor;
	b. Na quarta posição do cursor;
	c. Duas posições a frente da posição atual;
	d. Na primeira posição.
*/
use food;
go

declare aniversariante cursor scroll
for
    select Cli_nome, Cli_nascimento from Cliente;

declare @nome varchar(50);
declare @data datetime;
declare @dia int;
declare @mes varchar(20);

open aniversariante;

-- a. Ler a última posição do cursor
fetch last from aniversariante into @nome, @data;
if @@fetch_status = 0
begin
    set @dia = day(@data);
    set @mes = datename(month, @data);
    print 'Última posição: Parabéns, ' + @nome + ', no dia ' + cast(@dia as varchar) + ' de ' + @mes + ', você completa mais um ano de vida.';
end
else
    print 'Não há última posição no cursor.';

-- b. Ler a quarta posição do cursor
fetch absolute 4 from aniversariante into @nome, @data;
if @@fetch_status = 0
begin
    set @dia = day(@data);
    set @mes = datename(month, @data);
    print 'Quarta posição: Parabéns, ' + @nome + ', no dia ' + cast(@dia as varchar) + ' de ' + @mes + ', você completa mais um ano de vida.';
end
else
    print 'Não há quarta posição no cursor.';

-- c. Ler duas posições à frente da posição atual
fetch relative 2 from aniversariante into @nome, @data;
if @@fetch_status = 0
begin
    set @dia = day(@data);
    set @mes = datename(month, @data);
    print 'Duas posições à frente: Parabéns, ' + @nome + ', no dia ' + cast(@dia as varchar) + ' de ' + @mes + ', você completa mais um ano de vida.';
end
else
    print 'Não há duas posições à frente no cursor.';

-- d. Ler a primeira posição do cursor
fetch first from aniversariante into @nome, @data;
if @@fetch_status = 0
begin
    set @dia = day(@data);
    set @mes = datename(month, @data);
    print 'Primeira posição: Parabéns, ' + @nome + ', no dia ' + cast(@dia as varchar) + ' de ' + @mes + ', você completa mais um ano de vida.';
end
else
    print 'Não há primeira posição no cursor.';

-- Fechar e desalocar o cursor
close aniversariante;
deallocate aniversariante;
