use BD_2017208552
go

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN Ex_t1
insert into produto (pro_descricao, pro_preco, cat_id, loj_id) values ('Camarão ao fughi', 90.00, 7, 3);

-- commit
-- rollback

/*
O SELECT da SESSÃO 2 só será realizado quando a transação da SESSÃO 1 for finalizada com um COMMIT ou ROLLBACK.
A transação é bloqueada na SESSÃO 1 para blindar o valor, até que haja o COMMIT ou ROLLBACK.
Quando a SESSÃO 2 tenta realizar uma consulta, ela entra em espera e será realizada ao final da transação na SESSÃO 1.
*/