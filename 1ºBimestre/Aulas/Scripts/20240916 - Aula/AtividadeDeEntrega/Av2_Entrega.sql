use BD_2017208552
go

-- 1. Execute o código abaixo.
create table TabNumeros (numero varchar(10) NOT NULL); 
	declare @numeroMaximo as int, @contador as int;  
	set @numeroMaximo = 1000000;  
	set @contador = 1;  

insert into TabNumeros values(1);  
while @contador <= @numeroMaximo  
	begin  
		insert into TabNumeros select convert(varchar(10), numero + @contador) from TabNumeros;  
		set @contador = @contador * 2;  
	end

-- 2. A tabela criada no exercício anterior é uma tabela Heap? Justifique a sua resposta. 
/*
	Sim, é uma tabela Heap, pois não é definido um índice na criação da tabela, os dados ficarão na ordem em que são inseridos.
*/

-- 3. Realize um backup full.
backup database BD_2017208552 to disk= '\\10.10.0.15\sql\BD_2017208552.bak'


-- 4. Faça uma consulta na tabela tabNumeros buscando o número 1000000. Verifique se foi usado algum índice.
		-- Não foi utilizado índice, foi feita uma table scan (busca completa)
select * from TabNumeros where numero =  1000000;


-- 5. Crie um índice para melhorar o desempenho da consulta anterior. 
create clustered index IndiceMelhora on TabNumeros(numero);


-- 6. Realize novamente a consulta na tabela buscando o número 1000000. Verifique se foi usado o índice para essa consulta.
		-- Foi utilizado índice, foi feito um Clustered Index Scan
select * from TabNumeros where numero =  1000000;


-- 7. Insira 2 registros na tabela cidade. 
select * from Cidade

declare @id int
set @id = (select max(cid_id) from Cidade)
set @id = @id + 1

insert into Cidade(cid_id, cid_Nome, ctp_id, est_id, cid_ddd) values  (@id, 'Cidade Bruno', 3, 8, 27)

set @id = @id + 1
insert into Cidade(cid_id, cid_Nome, ctp_id, est_id, cid_ddd) values  (@id, 'Bruno` City', 3, 8, 27)


-- 8. Faça um backup de LOG.
backup log BD_2017208552 to disk = '\\10.10.0.15\sql\BD_2017208552.bak'


-- 9. Insira 1 registro na tabela Categoria de Produtos.
select * from CategoriaProduto
insert into CategoriaProduto(cat_descricao) values ('Comida Italiana')


-- 10. Faça um backup diferencial.
backup database BD_2017208552 to disk= '\\10.10.0.15\sql\BD_2017208552.bak' with differential


-- 11. Adicionar na tabela cliente a coluna Cli_TotalCompras. Nesta coluna será armazenado o valor total de compras do cliente no restaurante. Atualize o valor da coluna para Zero (0), para todos os clientes
-- select * from Cliente

alter table Cliente
add Cli_TotalCompras decimal (10, 2)

update Cliente
set Cli_TotalCompras = 0


-- 12. Criar um gatilho que atualize o valor da coluna (Cli_TotalCompras) sempre que o cliente realizar uma nova compra.
-- select * from Pedido
-- select * from PedidoProduto
-- select * from Cliente

create trigger AtualizaCompra on PedidoProduto
after insert
as
begin
declare 
	@value decimal (10,2),
	@id_Pedido int,
	@id_cliente int
	
	select @value = pdd_preco, @id_Pedido = ped_id from inserted
	select @id_cliente = (select Cli_id from Pedido where ped_id = @id_Pedido) from inserted

	update Cliente
	set Cli_TotalCompras = @value
	where Cli_id = @id_cliente
end

-- 13. Criar uma procedure para reajustar os preços dos produtos conforme o percentual e a categoria do produto informados. 
select * from Produto

create procedure ReajustePreco (@percent float, @categ int)
as
begin
	if @percent < 0
		begin
			print 'percentual inválido'
			return
		end

	update Produto
	set pro_preco = pro_preco * (1 + @percent/100)
	where cat_id = @categ
end
go

-- 14. Faça um backup diferencial. 
backup database BD_2017208552 to disk= '\\10.10.0.15\sql\BD_2017208552.bak' with differential


-- 15. Neste momento, o banco de dados apresentou um problema. Você deverá restaurar o banco de dados. Para isso, você deverá utilizar os backups realizados. Responda o seguinte:
    -- a. Quais seriam os backups que você recuperaria?
	/*
		Recuperaria o último backup full e o último backup diferencial
	*/
    
    -- b. Qual a ordem de recuperação dos backups
	/*
		Primeiro o backup full e por último, o backup diferencial
	*/