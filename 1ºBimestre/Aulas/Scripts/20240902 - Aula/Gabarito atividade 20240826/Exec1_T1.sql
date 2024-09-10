use abd_aula;
go

sET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN Ex_t1
	insert into produto (pro_descricao, pro_preco, cat_id, loj_id) values ('Camarão ao fughi', 90.00, 7, 3);
