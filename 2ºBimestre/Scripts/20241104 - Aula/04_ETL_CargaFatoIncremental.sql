create procedure etl_fato @data date
as
begin
insert into fato (data, idCidade, idFaixa, quantidade)
	select p.ped_data as data,
	c.cid_id as cidadeLoja,
	dbo.calculaFaixaEtaria(cl.cli_nascimento) as FAixaEtaria,
	count(p.cli_id)
	from abd_aula.dbo.pedido p
	inner join abd_aula.dbo.loja l 
	on p.loj_id = l.loj_id
	inner join abd_aula.dbo.endereco e
	on l.end_id = e.end_id
	inner join abd_aula.dbo.bairro b
	on e.bai_id = b.bai_id
	inner join abd_aula.dbo.cidade c
	on b.cid_id = c.cid_id
	inner join abd_aula.dbo.cliente cl 
	on p.cli_id = cl.cli_id
	where p.ped_data = @data 
	group by p.ped_data, c.cid_id,
	dbo.calculaFaixaEtaria(cl.cli_nascimento)
end
