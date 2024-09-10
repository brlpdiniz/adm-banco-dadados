use abd_aula
-- declara o cursor
declare leCidades cursor scroll
for
	select cid_id, cid_nome from cidade order by cid_nome;

declare @id int
declare @nome varchar(100)
-- abre o cursor
open leCidades
-- lè o cursor a primeira vez. a primeira linha
fetch next from lecidades into @id, @nome
print 'next:' + cast(@id  as varchar(10)) + ' - ' + @nome
fetch last from lecidades into @id, @nome
print 'last:' + cast(@id  as varchar(10)) + ' - ' + @nome
fetch prior from lecidades into @id, @nome
print 'prior:' + cast(@id  as varchar(10)) + ' - ' + @nome
fetch first from lecidades into @id, @nome
print 'first:' + cast(@id  as varchar(10)) + ' - ' + @nome
fetch absolute 10 from lecidades into @id, @nome
print 'absolute 10:' + cast(@id  as varchar(10)) + ' - ' + @nome
fetch relative 30 from lecidades into @id, @nome
print 'relative 30:' + cast(@id  as varchar(10)) + ' - ' + @nome
-- fechar o cursor
close lecidades
-- Dessalocar o cursor
deallocate lecidades


--	select cid_id, cid_nome from cidade where cid_nome = 'Curitiba'
	
