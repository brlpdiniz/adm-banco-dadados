SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRAN Ex_t2
	SELECT * FROM produto WHERE pro_id < 50;;

-- O nivel de isolamento repeatable read bloqueia até o select.
-- Espera as demais transações terminarem.

