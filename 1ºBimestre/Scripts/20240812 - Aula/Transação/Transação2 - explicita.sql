use master 
go
-- Mesmo com o inicio da transação e fim.
-- Ocorre erro, mas os registros corretos são inseridos.
-- Porque não houve comando para desfazer.
CREATE TABLE #exemplo (ID INT, nome VARCHAR(20) NOT NULL);
begin transaction
	INSERT INTO #exemplo VALUES (1, 'Jose');
	INSERT INTO #exemplo VALUES (2, null);
	INSERT INTO #exemplo VALUES (3, 'Maria');
commit;

select * from #exemplo;