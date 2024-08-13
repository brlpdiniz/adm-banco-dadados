use master 
go
-- Ocorre erro, mas os registros corretos são inseridos
CREATE TABLE #exemplo (ID INT, nome VARCHAR(20) NOT NULL);
INSERT INTO #exemplo VALUES (1, 'Jose');
INSERT INTO #exemplo VALUES (2, null);
INSERT INTO #exemplo VALUES (3, 'Maria');

select * from #exemplo;
