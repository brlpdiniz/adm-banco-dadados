use abd_aula;
go
alter procedure listaCidadesSaida @uf as int, @total as int output
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
	set @total = 0
	-- lè o cursor a primeira vez. a primeira linha
	fetch lecidades into @id, @nome
	set @total = @total + 1
	while @@FETCH_STATUS = 0
	begin
		print @id
		print @nome
		-- lè o cursor
		fetch lecidades into @id, @nome
		set @total = @total + 1
		-- fetch next from lecidades into @id, @nome
	end
	-- fechar o cursor
	close lecidades
	-- Dessalocar o cursor
	deallocate lecidades
end

begin
	declare @t as int
	exec listaCidadesSaida 1, @t output
	print 'total: ' + cast(@t as varchar(20))
end