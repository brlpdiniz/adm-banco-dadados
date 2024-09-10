use bd_2017208552
go

alter table pedido
go

-- criar a trigger insereCidade ligada na tabela Cidade e utilizado instead of (ativar depois do comando anterior) e será ativada pelo comando 'insert' 
create trigger somaTotalPedido on pedidoProduto
after insert
as
begin
	declare @id int
	set @id = (select max(cid_id) from Cidade)
	set @id = @id + 1
	insert into Cidade (cid_id, cid_nome, ctp_id, est_id, cid_ddd)
		select @id, cid_nome, ctp_id, est_id, cid_ddd
		from inserted
end
go

-- inserindo valores 
insert into cidade (cid_nome, ctp_id, est_id, cid_ddd)
	values('Curitiba City', 1, 1, 41)

-- depois de aplicar o insert acima 4x, veja o select abaixo
select * from Cidade
where cid_Nome = 'Curitiba City'