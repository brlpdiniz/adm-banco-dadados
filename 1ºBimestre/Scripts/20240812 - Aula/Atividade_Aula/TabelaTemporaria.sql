-- Criar tabela temporária
	-- Só existe na seção onde foi criada (se fechar a Query, ela some)

create table #exemplo(
	id int,
	nome varchar(100)
)

-- Criar tabela temporária
	-- Existe fora da seção onde foi criada (pode ser acessada de outra seção)

create table ##exemplo(
	id int,
	nome varchar(100)
)

insert into ##exemplo values(1, 'teste')