create view mostraFuncionario
as
	select fun_nome as nome,
	fun_nascimento as nascimento, 
	fun_celular as celular, 
	eci_nome as 'estado Civil'
	from Funcionario f
	inner join EstadoCivil e
	on f.Eci_id = e.eci_id


select * from mostraFuncionario