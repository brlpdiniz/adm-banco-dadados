select cli_nome, day(cli_nascimento) as dia
into #aniversariantes
from cliente
where month(getdate()) = month(cli_nascimento)
