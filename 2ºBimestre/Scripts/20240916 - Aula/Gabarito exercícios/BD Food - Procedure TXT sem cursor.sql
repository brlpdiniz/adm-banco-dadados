create procedure atualiza_cliente2
as
	insert into cliente 
		select substring(registro, 3,5) as cli_id,
			   substring(registro, 9,50) as cli_nome,
			substring(registro, 59,8) as cli_nascimento,
			null as cli_celular,
			null as cli_email,
			case substring(registro, 8,1) 
				when 'F' then 1
				when 'M' then 2 
			end as gen_id,
			1 as eci_id,
			substring(registro, 67,5) as end_id
			from clienteTXT
			where	substring(registro, 1,1) != '0'
			and		substring(registro, 1,1) != '9'
			and		substring(registro, 2,1) != 'E'
			and		substring(registro, 2,1) = 'I'
			and		substring(registro, 3,5) not in (select distinct cli_id from cliente); -- insere registros que não existam no Cliente

	UPDATE cliente
		SET cliente.cli_nome = substring(clienteTXT.registro, 9,50),
			cliente.gen_id = case substring(registro, 8,1) 
								when 'F' then 1
								when 'M' then 2 
							end, 
			cliente.cli_nascimento = substring(clienteTXT.registro, 59,8)
		FROM cliente INNER JOIN clienteTXT
		ON
			cliente.cli_id = cast(substring(clienteTXT.registro, 3,5) as int)
			and		substring(registro, 1,1) = '1'
			and		substring(registro, 2,1) = 'A'
			and		substring(registro, 3,5) in (select distinct cli_id from cliente); -- altera registros que existam no Cliente

	DELETE FROM cliente 
	where cli_id in (select cast(substring(registro,3,5) as int) from clienteTXT 
							where	substring(registro, 1,1) = '1'
							and		substring(registro, 2,1) = 'E'
							and		substring(registro, 3,5) in (select distinct cli_id from cliente)); -- exclui registros que existam no Cliente
