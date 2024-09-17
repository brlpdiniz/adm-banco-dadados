create procedure insereFuncionario
@fun_id int,
@fun_nome varchar(100),
@fun_nascimento date,
@Fun_admissao date,
@fun_celular varchar(12),
@fun_email varchar(100),
@gen_id int,
@eci_id int,
@end_id int,
@retorno varchar(200) output
as
begin
	set @retorno = '';
	if @fun_nome is null or @fun_nome = ''
	begin
		set @retorno = 'Nome est� vazio,' + char(13)
	end

	if not exists (select * from genero 
	where gen_id = @gen_id)
	begin
		set @retorno = @retorno + 'Genero n�o cadastrado,' + char(13)
	end

	if not exists (select * from EstadoCivil 
	where eci_id = @eci_id)
	begin
		set @retorno = @retorno + 'Estado civil n�o cadastrado,' + char(13)
	end

	if not exists (select * from Endereco 
	where end_id = @end_id)
	begin
		set @retorno = @retorno + 'Endereco n�o cadastrado,'
	end
	if @retorno = ''
	begin
		insert into funcionario 
		(Fun_id, Fun_nome, Fun_nascimento, Fun_admissao, Fun_celular, Fun_email, Gen_id, Eci_id, End_id)
		values
		(@fun_id, @fun_nome, @fun_nascimento, @Fun_admissao, @Fun_celular, @Fun_email, @gen_id, @eci_id,@end_id)
	end
end

-- Executar a procedure
begin
	declare @retorno varchar(200);
	exec insereFuncionario 
	
	@retorno output
	print @retorno
end
