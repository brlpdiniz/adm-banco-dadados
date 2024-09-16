/*
Criar um cursor que mostre uma mensagem de felicita��es para os clientes. A mensagem ser� a seguinte:
	Parab�ns, "nome do cliente", no dia "??" de "nome do m�s", voc� completa mais um ano de vida.

Utilizando o cursor do exerc�cio anterior, fa�a a leitura das seguintes linhas do cursor:
	a. Na �ltima posi��o do cursor;
	b. Na quarta posi��o do cursor;
	c. Duas posi��es a frente da posi��o atual;
	d. Na primeira posi��o.
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

-- a. Ler a �ltima posi��o do cursor
fetch last from aniversariante into @nome, @data;
if @@fetch_status = 0
begin
    set @dia = day(@data);
    set @mes = datename(month, @data);
    print '�ltima posi��o: Parab�ns, ' + @nome + ', no dia ' + cast(@dia as varchar) + ' de ' + @mes + ', voc� completa mais um ano de vida.';
end
else
    print 'N�o h� �ltima posi��o no cursor.';

-- b. Ler a quarta posi��o do cursor
fetch absolute 4 from aniversariante into @nome, @data;
if @@fetch_status = 0
begin
    set @dia = day(@data);
    set @mes = datename(month, @data);
    print 'Quarta posi��o: Parab�ns, ' + @nome + ', no dia ' + cast(@dia as varchar) + ' de ' + @mes + ', voc� completa mais um ano de vida.';
end
else
    print 'N�o h� quarta posi��o no cursor.';

-- c. Ler duas posi��es � frente da posi��o atual
fetch relative 2 from aniversariante into @nome, @data;
if @@fetch_status = 0
begin
    set @dia = day(@data);
    set @mes = datename(month, @data);
    print 'Duas posi��es � frente: Parab�ns, ' + @nome + ', no dia ' + cast(@dia as varchar) + ' de ' + @mes + ', voc� completa mais um ano de vida.';
end
else
    print 'N�o h� duas posi��es � frente no cursor.';

-- d. Ler a primeira posi��o do cursor
fetch first from aniversariante into @nome, @data;
if @@fetch_status = 0
begin
    set @dia = day(@data);
    set @mes = datename(month, @data);
    print 'Primeira posi��o: Parab�ns, ' + @nome + ', no dia ' + cast(@dia as varchar) + ' de ' + @mes + ', voc� completa mais um ano de vida.';
end
else
    print 'N�o h� primeira posi��o no cursor.';

-- Fechar e desalocar o cursor
close aniversariante;
deallocate aniversariante;
