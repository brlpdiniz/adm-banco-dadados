use Food
go

declare aniversariantes SCROLL CURSOR
	FOR select cli_nome, day(cli_nascimento), 
		datename(mm, cli_nascimento)
		from Cliente
		where month(cli_nascimento) = month(getdate());

declare @nome CHAR(100);
declare @dia int;
declare @mes varchar(12);

open aniversariantes

fetch last from aniversariantes INTO @nome, @dia, @mes
print '�ltima: ' + @nome

fetch absolute 4 from aniversariantes INTO @nome, @dia, @mes
print 'Absolute 4: ' + @nome

fetch relative 2 from aniversariantes INTO @nome, @dia, @mes
print 'Relative 2: ' + @nome

fetch first from aniversariantes INTO @nome, @dia, @mes
print 'Primeira: ' + @nome

close aniversariantes 
deallocate aniversariantes