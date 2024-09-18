/*
    Utilize o banco de dados Restaurante (Food) para responder as questões.
    Data de entrega: 23/09/2024
    Revisão dos comandos (Select, update, insert, update, alter, entre outros)
*/

-- 1. Selecione o nome, a cidade de residência e a data de nascimento de todos os clientes por ordem de data de nascimento do mais jovem ao mais velho. Mostrando a data de nascimento no formato DD/MM/AAAA.


-- 2.Mostre o total de produtos por categoria. Exiba o nome da categoria e o total de produtos.


-- 3.Mostre o total de clientes por ano de nascimento. Ordenar o resultado por ordem crescente do ano de nascimento.


-- 4.Mostre o nome do cliente mais velho.


-- 5.Mostre o nome dos funcionários que contenham “Silva” em qualquer parte do nome.


-- 6.Realize um backup completo da base de dados.


-- 7.Adicione a coluna tempo de serviço (fun_tempoServico), do tipo inteiro, na tabela funcionario deixando como valor default o zero (0).


-- 8. Verifique que na coluna fun_tempoServico, da tabela funcionario, os valores ficaram como ‘null’, então altere o conteúdo deste campo para zero (0).


-- 9. Vamos atualizar o atributo tempo de servico de cada funcionario. Para isso usaremos a seguinte fórmula: Ano atual menos o ano de nascimento do funcionário menos 30. Exemplo: Funcionário Paulo Soares: Ano atual 2024 – 1985 (ano de nascimento) – 30. O resultado seria 9. Este será o tempo de serviço do funcionário Paulo Soares.


-- 10. Realize um backup somente com as alterações ocorridas no banco de dados deste o último backup completo. Salve esse backup no mesmo arquivo do backup completo. Preservando todos os bakcups no arquivo.


-- 11. Verifique se a atualização do tempo de serviço funcionou corretamente. 

/*
    Visões, cursores, tabelas temporárias entre outros
*/

-- 12. Crie uma view que contenha o nome da Loja, endereço, bairro, nome da cidade, nome do estado e região.
-- 13. Mostre, utilizando a view criada anteriormente, todas as lojas da região sudeste.
-- 14. Crie um cursor que contenha a data de nascimento e o nome do cliente. A partir desse cursor criar uma tabela temporária onde conste: a data de nascimento, o nome do cliente e a faixa etária do cliente. As faixas etárias serão as seguintes:
    -- “Acima dos 50”. Clientes com mais de 50 anos de idade.
    -- “Entre 35 e 50”. Clientes com idade entre 35 anos até 50 anos.
    -- “Abaixo dos 35”. Clientes com menos de 35 anos de idade.

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
    Procedures e Triggers
*/

-- 16. Escreva uma procedure que reajustará o preço do produto de acordo com a categoria informada pelo usuário. O usuário informará a categoria a ser alterada e o percentual de reajuste do preço. A procedure deverá verificar se a categoria informada existe. Além disso, a procedure deverá usar o controle de transação.


-- 17. Desenvolva uma trigger que impeça, não permita, que um produto seja excluído da tabela de produtos.

