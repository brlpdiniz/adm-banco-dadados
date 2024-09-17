create procedure atualiza_cliente
as
	declare CursorCliente cursor for
	select	substring(registro, 1,1) as tipo_reg,
			substring(registro, 2,1) as tipo_ope,
			substring(registro, 3,5) as cli_id,
			substring(registro, 8,1) as genero,
			substring(registro, 9,50) as cli_nome,
			substring(registro, 59,8) as data_nascimento,
			substring(registro, 67,5) as cidade
			from clienteTXT
			where	substring(registro, 1,1) != '0'
			and		substring(registro, 1,1) != '9';

	open CursorCliente;
 
	declare @tipo_reg char(1);
	declare @tipo_ope char(1);
	declare @cli_id int; 
	declare @gen_id char(1); 
	declare @cli_nome varchar(80);
	declare @cli_nascimento date;
	declare @end_id int;

	fetch CursorCliente into @tipo_reg, @tipo_ope, @cli_id, @gen_id, @cli_nome, @cli_nascimento, @end_id;
	while @@FETCH_STATUS = 0
	begin
		if @tipo_ope = 'I'
		begin
			if not exists (select * from cliente where cli_id = @cli_id )
			begin
				insert into cliente values (@cli_id, @cli_nome, @cli_nascimento, null, null, gen_id, 1, @end_id);
			end
		end
		else
			if @tipo_ope = 'A'
			begin
				update cliente
					set cli_nome = @cli_nome,
						gen_id = @gen_id,
						cli_nascimento = @cli_nascimento
					where cli_id = @cli_id;
			end
			else
				if @tipo_ope = 'E'
				begin
					if exists (select * from cliente where cli_id = @cli_id )
					BEGIN
						DELETE FROM CLIENTE WHERE CLI_ID = @cli_id;
					END
				end
		fetch CursorCliente into @tipo_reg, @tipo_ope, @cli_id, @gen_id, @cli_nome, @cli_nascimento, @end_id;
	end;
	close CursorCliente;
	deallocate CursorCliente;
