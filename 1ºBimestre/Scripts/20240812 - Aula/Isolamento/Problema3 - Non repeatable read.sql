use exemplo;
go
SET TRANSACTION ISOLATION LEVEL UNCOMMITED
-- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

-- Transa��o T1

Begin Transaction
	Select pro_descricao, pro_estoque from produto where pro_id = 1;
	-- Rodar a T2
	Select pro_descricao, pro_estoque from produto where pro_id = 1;

-- Transa��o T2
Begin Transaction
	Select pro_descricao, pro_estoque from produto where pro_id = 1;
	Update produto 
	Set pro_estoque = pro_estoque + 2 Where pro_id = 1	
	COMMIT
	
-- Solução:
-- t2:
use Exemplo;
go
set transaction isolatino level repeatable read
begin transaction t2
	UPDATE produtos SET quantidade = 5 WHERE Id = 100
commit transaction t2