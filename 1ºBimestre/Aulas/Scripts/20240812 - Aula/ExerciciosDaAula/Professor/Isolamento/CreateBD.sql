create database Exemplo;
go
USE Exemplo;
go
CREATE TABLE produto (
	pro_Id INT PRIMARY KEY,
	pro_descricao VARCHAR(50),
	pro_categoria VARCHAR(20),
	pro_estoque INT,
	pro_preco decimal(10,2) );

INSERT into produto VALUES 
(10, 'notebook', 'tecnologia', 10, 2000),
(20, 'smartphone xpto', 'celulates', 15, 1500),
(30, 'Tablet 7 pol', 'celulates', 20, 1000),
(400, 'Refrigerador 500 litros', 'Refrigerador', 20, 2850),
(500, 'Fogão 5 bocas a gas', 'Fogao', 20, 570),
(100, 'Smartphone', 'celular', 10, null),
(120, 'Tablet', 'celular',  20, null),
(130, 'Notebook', 'computador', 30, null),
(140, 'PC Desktop i5', 'computador', 10, null);

select * from produto;

