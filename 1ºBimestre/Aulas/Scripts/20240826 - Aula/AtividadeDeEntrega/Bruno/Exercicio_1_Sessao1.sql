use BD_2017208552
go

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN Ex_t1
insert into produto (pro_descricao, pro_preco, cat_id, loj_id) values ('Camar�o ao fughi', 90.00, 7, 3);

-- commit
-- rollback

/*
O SELECT da SESS�O 2 s� ser� realizado quando a transa��o da SESS�O 1 for finalizada com um COMMIT ou ROLLBACK.
A transa��o � bloqueada na SESS�O 1 para blindar o valor, at� que haja o COMMIT ou ROLLBACK.
Quando a SESS�O 2 tenta realizar uma consulta, ela entra em espera e ser� realizada ao final da transa��o na SESS�O 1.
*/