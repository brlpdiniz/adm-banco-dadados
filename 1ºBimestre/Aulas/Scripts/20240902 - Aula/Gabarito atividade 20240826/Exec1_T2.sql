SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRAN Ex_t2
	SELECT * FROM produto WHERE pro_id < 50;;

-- O nivel de isolamento repeatable read bloqueia at� o select.
-- Espera as demais transa��es terminarem.

