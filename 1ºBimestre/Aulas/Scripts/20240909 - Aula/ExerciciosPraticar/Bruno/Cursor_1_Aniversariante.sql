/*
Criar um cursor que mostre uma mensagem de felicita��es para os clientes. A mensagem ser� a seguinte:
Parab�ns, "nome do cliente", no dia "??" de "nome do m�s", voc� completa mais um ano de vida.
*/

use food
go

declare aniversariante cursor
for
	select Cli_nome, Cli_nascimento from Cliente;

declare @nome varchar(50)
declare @data datetime
declare @dia int
declare @mes varchar(20)

open aniversariante
-- Buscar o primeiro aniversariante
fetch next from aniversariante into @nome, @data

while @@FETCH_STATUS = 0
begin
	-- extraindo o dia e nome do mes da data de nascimento
	set @dia = DAY(@data)
	set @mes = DATENAME(MONTH, @data)

	-- exibe a mensagem de parab�ns
	print 'Parab�ns, ' + @nome + ', no dia ' + cast(@dia as varchar) + ' de ' + @mes + ', voc� completa mais um ano de vida.'
	
	-- busca o pr�ximo aniversariante
	fetch next from aniversariante into @nome, @data;
end

close aniversariante
deallocate aniversariante