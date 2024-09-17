-- Lista os funcionarios aniversariantes
use Food;
go
DECLARE aniversariantes SCROLL CURSOR
	FOR SELECT cli_nome, day(cli_nascimento), datename(mm, cli_nascimento)
		from Cliente
		where month(cli_nascimento) = month(getdate());

	DECLARE @nome CHAR(100);
	declare @dia int;
	declare @mes varchar(12);

	OPEN aniversariantes

	FETCH NEXT FROM aniversariantes INTO @nome, @dia, @mes
	WHILE @@FETCH_STATUS = 0
	BEGIN
		print 'Parabéns ' + LTRIM(@nome) + 'no dia ' 
					+ cast(@dia as varchar(02)) + ' de ' + @mes 
					+ ', você completa mais um ano de vida.'
		FETCH NEXT FROM aniversariantes INTO @nome, @dia, @mes
	END
close aniversariantes
DEALLOCATE aniversariantes

