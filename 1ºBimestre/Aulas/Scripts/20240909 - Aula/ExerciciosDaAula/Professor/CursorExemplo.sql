use abd_aula
-- declara o cursor
declare leCidades cursor
for
	select cid_id, cid_nome from cidade order by cid_nome;

declare @id int
declare @nome varchar(100)
-- abre o cursor
open leCidades
-- lè o cursor a primeira vez. a primeira linha
fetch lecidades into @id, @nome
while @@FETCH_STATUS = 0
begin
	if @nome = 'Curitiba' 
	begin
		print @id
		print @nome
	end
	-- lè o cursor
	fetch lecidades into @id, @nome
	-- fetch next from lecidades into @id, @nome
end
-- fechar o cursor
close lecidades
-- Dessalocar o cursor
deallocate lecidades


--	select cid_id, cid_nome from cidade where cid_nome = 'Curitiba'
	
