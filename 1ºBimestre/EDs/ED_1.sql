/*
    Utilize o banco de dados Restaurante (Food) para responder as questões.
    Data de entrega: 23/09/2024
    Revisão dos comandos (Select, update, insert, update, alter, entre outros)
*/

use food
go

-- 1. Selecione o nome, a cidade de residência e a data de nascimento de todos os clientes por ordem de data de nascimento do mais jovem ao mais velho. Mostrando a data de nascimento no formato DD/MM/AAAA.
-- select * from Cliente
-- select * from Cidade

select
    Cli_nome as nome,
    Cidade.cid_Nome as cidadeResid,
    FORMAT(Cli_nascimento, 'dd/MM/yyyy') as dataNascim
from
    Cliente
join 
    Endereco on Cliente.end_id = Endereco.end_id
join 
    Bairro on Endereco.bai_id = Bairro.bai_id
join 
    Cidade on Bairro.cid_id = Cidade.cid_id
order by
    Cli_nascimento desc;


-- 2.Mostre o total de produtos por categoria. Exiba o nome da categoria e o total de produtos.
	-- select * from CategoriaProduto
	-- select * from Produto

select
	cat_descricao as Categoria,
	count(P.pro_id) as TotalProd
from 
	CategoriaProduto CP
inner join
	Produto P
on
	CP.cat_id = P.cat_id
group by 
	cp.cat_descricao


-- 3.Mostre o total de clientes por ano de nascimento. Ordenar o resultado por ordem crescente do ano de nascimento.
-- select * from Cliente
select 
	year(Cli_nascimento) as anoNasc,
	count(Cli_id) as totalCli
from
	Cliente
group by
	year(Cli_nascimento)
order by
	anoNasc asc


-- 4.Mostre o nome do cliente mais velho.
-- select * from Cliente
select 
	Cli_nome as nomeCliente
from
	Cliente
where 
	Cli_nascimento = (select min(Cli_nascimento) from cliente)

-- 5.Mostre o nome dos funcionários que contenham “Silva” em qualquer parte do nome.
-- select * from Funcionario
select
	Fun_nome as nomeFuncionario
from
	Funcionario
where
	Fun_nome like '%Silva%'


-- 6.Realize um backup completo da base de dados.
backup database food to disk = 'C:\Users\Bruno Diniz\Documents\code\git\adm-banco-dados\1ºBimestre\EDs\food.bak'


-- 7.Adicione a coluna tempo de serviço (fun_tempoServico), do tipo inteiro, na tabela funcionario deixando como valor default o zero (0).
-- select * from Funcionario
alter table Funcionario
	add fun_tempoServico int default 0

-- 8. Verifique que na coluna fun_tempoServico, da tabela funcionario, os valores ficaram como ‘null’, então altere o conteúdo deste campo para zero (0).
update Funcionario
	set fun_tempoServico = 0
	where fun_tempoServico is null

-- 9. Vamos atualizar o atributo tempo de servico de cada funcionario. Para isso usaremos a seguinte fórmula: Ano atual menos o ano de nascimento do funcionário menos 30. Exemplo: Funcionário Paulo Soares: Ano atual 2024 – 1985 (ano de nascimento) – 30. O resultado seria 9. Este será o tempo de serviço do funcionário Paulo Soares.
update Funcionario
	set fun_tempoServico = year(getdate()) - year(Fun_nascimento) - 30

-- 10. Realize um backup somente com as alterações ocorridas no banco de dados deste o último backup completo. Salve esse backup no mesmo arquivo do backup completo. Preservando todos os backups no arquivo.
backup database food to disk = 'C:\Users\Bruno Diniz\Documents\code\git\adm-banco-dados\1ºBimestre\EDs\food.bak' with differential, noinit, noformat 

-- 11. Verifique se a atualização do tempo de serviço funcionou corretamente.
	-- Embora existam funcionários com o tempo negativo, funcionou
select 
	Fun_nome as nomeFuncionario,
	fun_tempoServico as tempoServiçoFuncionario	
from
	Funcionario


/*
    Visões, cursores, tabelas temporárias entre outros
*/

-- 12. Crie uma view que contenha o nome da Loja, endereço, bairro, nome da cidade, nome do estado e região.
 -- select * from loja
 -- select * from endereco
 -- select * from bairro
 -- select * from cidade
 -- select * from estado
 -- select * from regiao

 -- drop view DescriLoja
 -- select * from DescriLoja

create view DescriLoja as
select
	L.loj_nome as nomeLoja,
	E.end_descricao as nomeEndereço,
	B.bai_Descricao as nomeBairro,
	C.cid_Nome as nomeCidade,
	Est.est_Nome as nomeEstado,
	R.Reg_nome as nomeRegiao
from
	Loja L
inner join 
	Endereco E on L.end_id = E.end_id
inner join 
	Bairro B on E.bai_id = B.bai_id
inner join 
	Cidade C on B.cid_id = C.cid_id
inner join 
	Estado Est on C.est_id = Est.est_id
inner join 
	Regiao R on Est.Reg_id = R.Reg_id


-- 13. Mostre, utilizando a view criada anteriormente, todas as lojas da região sudeste.
select * from DescriLoja
where nomeRegiao = 'Sudeste'


-- 14. Crie um cursor que contenha a data de nascimento e o nome do cliente. A partir desse cursor criar uma tabela temporária onde conste: a data de nascimento, o nome do cliente e a faixa etária do cliente. As faixas etárias serão as seguintes:
    -- “Acima dos 50”. Clientes com mais de 50 anos de idade.
    -- “Entre 35 e 50”. Clientes com idade entre 35 anos até 50 anos.
    -- “Abaixo dos 35”. Clientes com menos de 35 anos de idade.

-- select * from Cliente

-- drop table #FaixaEtaria
-- select * from #FaixaEtaria

declare idadeCliente cursor for
select
    cli_nome as nomecliente,
    cli_nascimento as nascimento_cliente
from
	cliente

create table #faixaetaria (
    nomecliente varchar(60),
    nascimento_cliente date,
    faixaetaria varchar(60)
);

declare @nomecliente varchar(60)
declare @nascimento_cliente date

open idadeCliente
fetch next from idadeCliente into @nomecliente, @nascimento_cliente;

while @@fetch_status = 0
begin
    declare @faixaetaria varchar(60);
    declare @idade int = datediff(year, @nascimento_cliente, getdate())

    if @idade > 50
        set @faixaetaria = 'acima dos 50'
    else if @idade >= 35 and @idade <= 50
        set @faixaetaria = 'entre 35 e 50'
    else
        set @faixaetaria = 'abaixo dos 35'

    insert into #faixaetaria (nomecliente, nascimento_cliente, faixaetaria)
    values (@nomecliente, @nascimento_cliente, @faixaetaria)

    fetch next from idadecliente into @nomecliente, @nascimento_cliente
end

close idadecliente
deallocate idadecliente


/*
    Transação, concorrência e nível de isolamento
*/

-- 15. Para a execução deste exercício, será necessário você abrir duas sessões.
    -- a) Na SESSÃO 1, não finalize a transação.
        -- SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        -- BEGIN TRAN
        -- DELETE FROM continente WHERE con_id = 3;
    
    -- b) Na SESSÃO 2, não finalize a transação.
        -- SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
        -- BEGIN TRAN
        -- SELECT * FROM continente WHERE con_id < 6;

    -- Responda: O que aconteceu na sessão 2, em relação ao item que você alterou na sessão 1? Por que isso aconteceu?

    -- c) Finalize a execução das transações anteriores:
        -- a) Na SESSÃO 1: ROLLBACK
        -- b) Na SESSÃO 2: ROLLBACK

	/*
		na sessão 2, ao executar a consulta select * from continente where con_id < 6, você verá os dados do registro com con_id = 3 ainda presentes, mesmo que você tenha executado o comando delete from continente where con_id = 3 na sessão 1 e não tenha finalizado essa transação.
		isso acontece porque na sessão 2, o nível de isolamento de transação está definido como read uncommitted. nesse nível, as tr
	*/


/*
    Procedures e Triggers
*/

-- 16. Escreva uma procedure que reajustará o preço do produto de acordo com a categoria informada pelo usuário. O usuário informará a categoria a ser alterada e o percentual de reajuste do preço. A procedure deverá verificar se a categoria informada existe. Além disso, a procedure deverá usar o controle de transação.


-- 17. Desenvolva uma trigger que impeça, não permita, que um produto seja excluído da tabela de produtos.

