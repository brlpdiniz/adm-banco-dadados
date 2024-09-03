/*
Será necessário a disponibilização das informações do funcionário. Tais como: Nome, data de nascimento, celular e estado
civil (descrição). Sendo que as demais informações não devem ficar disponíveis. Utilizando algum recurso do banco de
dados, crie uma alternativa para a consulta das informações solicitadas. 
*/

use BD_2017208552
go

create view consultaFuncionario as
	select
		Fun_nome as Nome,
		Fun_nascimento as [Data de Nascimento],
		Fun_celular as Celular,
		EstadoCivil.eci_nome as [Estado Civil]
	from
		Funcionario
	inner join
		EstadoCivil
	on Funcionario.Eci_id = EstadoCivil.eci_id
go

-- select * from EstadoCivil
-- select * from Funcionario

select * from dbo.consultaFuncionario