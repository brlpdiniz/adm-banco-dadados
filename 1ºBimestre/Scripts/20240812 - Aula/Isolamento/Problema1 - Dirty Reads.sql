-- t1
use Exemplo;
go
set transaction isolation level read uncommitted 
begin transaction t1
	select quantidade from produtos where id = 120
	update produtos set quantidade = quantidade - 2 where id = 120
	select quantidade from produtos where id = 120
	--commit
	--rollback
end


-- t2
use Exemplo;
go
set transaction isolation level read uncommitted 
begin transaction t2
	select quantidade from produtos where id = 120
	commit
end


-- t2 para resolver o problema de leitura suja, alterar o nível de isolamento

-- t2
use Exemplo;
go
set transaction isolation level read committed 
begin transaction t2
	select quantidade from produtos where id = 120
	commit
end
