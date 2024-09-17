use BD_2017208552
go

-- 1. Execute o c�digo abaixo.
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

-- 2. A tabela criada no exerc�cio anterior � uma tabela Heap? Justifique a sua resposta. 
/*
	Sim, � uma tabela Heap, pois n�o � definido um �ndice na cria��o da tabela, os dados ficar�o na ordem em que s�o inseridos.
*/

-- 3. Realize um backup full.
backup database BD_2017208552 to disk= '\\10.10.0.15\sql\BD_2017208552.bak'


-- 4. Fa�a uma consulta na tabela tabNumeros buscando o n�mero 1000000. Verifique se foi usado algum �ndice.
		-- N�o foi utilizado �ndice, foi feita uma table scan (busca completa)
select * from TabNumeros where numero =  1000000;


-- 5. Crie um �ndice para melhorar o desempenho da consulta anterior. 
create clustered index IndiceMelhora on TabNumeros(numero);


-- 6. Realize novamente a consulta na tabela buscando o n�mero 1000000. Verifique se foi usado o �ndice para essa consulta.
		-- Foi utilizado �ndice, foi feito um Clustered Index Scan
select * from TabNumeros where numero =  1000000;


-- 7. Insira 2 registros na tabela cidade. 
select * from Cidade

declare @id int
set @id = (select max(cid_id) from Cidade)
set @id = @id + 1

insert into Cidade(cid_id, cid_Nome, ctp_id, est_id, cid_ddd) values  (@id, 'Cidade Bruno', 3, 8, 27)

set @id = @id + 1
insert into Cidade(cid_id, cid_Nome, ctp_id, est_id, cid_ddd) values  (@id, 'Bruno` City', 3, 8, 27)


-- 8. Fa�a um backup de LOG.
backup log BD_2017208552 to disk = '\\10.10.0.15\sql\BD_2017208552.bak'


-- 9. Insira 1 registro na tabela Categoria de Produtos.
select * from CategoriaProduto
insert into CategoriaProduto(cat_descricao) values ('Comida Italiana')


-- 10. Fa�a um backup diferencial.
backup database BD_2017208552 to disk= '\\10.10.0.15\sql\BD_2017208552.bak' with differential


-- 11. Adicionar na tabela cliente a coluna Cli_TotalCompras. Nesta coluna ser� armazenado o valor total de compras do cliente no restaurante. Atualize o valor da coluna para Zero (0), para todos os clientes
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

-- 13. Criar uma procedure para reajustar os pre�os dos produtos conforme o percentual e a categoria do produto informados. 
select * from Produto

create procedure ReajustePreco (@percent float, @categ int)
as
begin
	if @percent < 0
		begin
			print 'percentual inv�lido'
			return
		end

	update Produto
	set pro_preco = pro_preco * (1 + @percent/100)
	where cat_id = @categ
end
go

-- 14. Fa�a um backup diferencial. 
backup database BD_2017208552 to disk= '\\10.10.0.15\sql\BD_2017208552.bak' with differential


-- 15. Neste momento, o banco de dados apresentou um problema. Voc� dever� restaurar o banco de dados. Para isso, voc� dever� utilizar os backups realizados. Responda o seguinte:
    -- a. Quais seriam os backups que voc� recuperaria?
	/*
		Recuperaria o �ltimo backup full e o �ltimo backup diferencial
	*/
    
    -- b. Qual a ordem de recupera��o dos backups
	/*
		Primeiro o backup full e por �ltimo, o backup diferencial
	*/