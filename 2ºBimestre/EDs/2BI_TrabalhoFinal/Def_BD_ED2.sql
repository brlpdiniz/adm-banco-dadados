-- Criacao do banco Data Warehouse
/*
	use master
	go
	IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'DW_food')
	begin
		drop database DW_food;
	end
	IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'DW_food')
	begin
		create database DW_food;
	end
	go
	use DW_food;
	go
*/

-- dimensão: Categoria
create table dim_categoria (
	cat_id int primary key,
	cat_descricao varchar(100)
);

-- dimensão: Tempo
create table dim_tempo (
	tempo_id int primary key identity(1,1),	-- id começa em 1 e aumenta conforme o número de linhas


)