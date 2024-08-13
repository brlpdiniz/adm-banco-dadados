USE exemplo;
SET TRANSACTION ISOLATION LEVEL READ uncommitted;
BEGIN transaction T1
	SELECT pro_estoque FROM produto WHERE pro_Id = 10;
	-- Executar a T2
	-- WaitFor Delay '00:00:12'

	UPDATE produto SET pro_estoque = pro_estoque - 2 WHERE pro_Id = 10
	-- Escolher fazer o commit na T1 ou na T2 e na outra fazer o rollback
	-- Commit
	-- Rollback


-- Transa��o T2
USE exemplo;
SET TRANSACTION ISOLATION LEVEL READ committed;

BEGIN transaction T2
	SELECT pro_estoque FROM produto WHERE pro_Id = 1;
	-- WaitFor Delay '00:00:3'
	-- Executar o update da T1

	UPDATE produto SET pro_estoque = pro_estoque - 5 WHERE pro_Id = 10
	-- Escolher fazer o commit na T1 ou na T2 e na outra fazer o rollback
	-- Commit
	-- Rollback

-- T2 solução para o problema de lost update
use Exemplo;
go
set transaction isolation level repeatable read
BEGIN TRANSACTION T2
  DECLARE @quantidade int
  SELECT @quantidade = quantidade FROM produtos WHERE Id=100

  SET @quantidade = @quantidade - 3

  UPDATE produtos SET quantidade = @quantidade  WHERE Id=100
  Print @quantidade

COMMIT TRANSACTION T2