use DW_2017208552;
go

insert into fato (data, idCidade, idFaixa, quantidade)
	select p.ped_data as data,
	c.cid_id as cidadeLoja,
	dbo.calculaFaixaEtaria(cl.cli_nascimento) as FAixaEtaria,
	count(p.cli_id)
	from BD_2017208552.dbo.pedido p
	inner join BD_2017208552.dbo.loja l 
	on p.loj_id = l.loj_id
	inner join BD_2017208552.dbo.endereco e
	on l.end_id = e.end_id
	inner join BD_2017208552.dbo.bairro b
	on e.bai_id = b.bai_id
	inner join BD_2017208552.dbo.cidade c
	on b.cid_id = c.cid_id
	inner join BD_2017208552.dbo.cliente cl 
	on p.cli_id = cl.cli_id
	group by p.ped_data, c.cid_id,
	dbo.calculaFaixaEtaria(cl.cli_nascimento)


