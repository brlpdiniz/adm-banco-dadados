use abd_aula;
go
sp_help 'cidade'

create trigger insereCidadeTrigger on cidade
instead of insert
as 
begin
	declare @id int
	set @id = (select max(cid_id) from cidade)
	set @id = @id + 1
	insert into cidade (cid_id, cid_nome, ctp_id, est_id, cid_ddd)
		select @id, cid_nome, ctp_id, est_id, cid_ddd
		from inserted
end

select * from cidade

cid_id, cid_nome, ctp_id, est_id, cid_ddd

insert into cidade (cid_nome, ctp_id, est_id, cid_ddd) 
values ('Curitiba City', 1, 1, 41)

select * from cidade where cid_nome = 'Curitiba City'
