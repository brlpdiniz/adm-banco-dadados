-- Criar tabela tempor�ria
	-- S� existe na se��o onde foi criada (se fechar a Query, ela some)

create table #exemplo(
	id int,
	nome varchar(100)
)

-- Criar tabela tempor�ria
	-- Existe fora da se��o onde foi criada (pode ser acessada de outra se��o)

create table ##exemplo(
	id int,
	nome varchar(100)
)

insert into ##exemplo values(1, 'teste')