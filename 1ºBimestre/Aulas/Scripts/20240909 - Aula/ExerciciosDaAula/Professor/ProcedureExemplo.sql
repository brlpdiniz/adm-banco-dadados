use abd_aula;
go
create procedure listaCidades @uf as int
as
begin
	declare leCidades cursor
	for
		select cid_id, cid_nome from cidade 
		where est_id = @uf
		order by cid_nome;

	declare @id int
	declare @nome varchar(100)
	-- abre o cursor
	open leCidades
	-- lè o cursor a primeira vez. a primeira linha
	fetch lecidades into @id, @nome
	while @@FETCH_STATUS = 0
	begin
		print @id
		print @nome
		-- lè o cursor
		fetch lecidades into @id, @nome
		-- fetch next from lecidades into @id, @nome
	end
	-- fechar o cursor
	close lecidades
	-- Dessalocar o cursor
	deallocate lecidades
end

exec listaCidades 1