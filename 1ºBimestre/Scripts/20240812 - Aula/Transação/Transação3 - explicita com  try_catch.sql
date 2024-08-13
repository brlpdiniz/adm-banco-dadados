use master 
go
CREATE TABLE #exemplo (codigo int, genero char(01) check (genero in ('M','F')) );

BEGIN TRANSACTION t1
	BEGIN TRY
		INSERT INTO #exemplo VALUES (1, 'M');
		INSERT INTO #exemplo VALUES (2, 'F');
		INSERT INTO #exemplo VALUES (3, 'X'); -- genero inválido
		COMMIT TRANSACTION -- Efetivando alterações na base
	END TRY
	BEGIN CATCH
		PRINT 'Erro ao inserir o genero'
		ROLLBACK TRANSACTION
	END CATCH