-- view -> pr� armazena SELECT
	--> Utilizado para mostrar a tabela funcion�rios, sem mostrar o sal�rio
	--> Restringe o acesso aos dados

create table produto(
	pro_descricao varchar(100),
	pro_preco int
)

create view consultaProduto(
as
	select pro_descricao as descricao,
		pro_preco preco from produto

select * from consultaProduto
order by descricao