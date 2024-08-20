-- T1
use Exemplo;
go
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION t1
	SELECT * FROM produtos where pro_categoria = 'celular'
	-- Do Some work
	WAITFOR DELAY '00:00:10'
	SELECT * FROM produtos where pro_categoria = 'celular'
COMMIT TRANSACTION


-- T2
use Exemplo;
go
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION t2
	INSERT INTO pro_categoria values (115, 'iphone', `celular`, 4);
COMMIT TRANSACTION

