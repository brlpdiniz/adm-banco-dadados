use Food;
go

create trigger calculaIDFuncionario on Funcionario
instead of insert
as 
begin
	declare @fun_id int
	set @fun_id = (select max(fun_id) from funcionario)
	set @fun_id = @fun_id + 1
	insert into funcionario (Fun_id, Fun_nome, Fun_nascimento, Fun_admissao, Fun_celular, Fun_email, Gen_id, Eci_id, End_id)
		select @fun_id, Fun_nome, Fun_nascimento, Fun_admissao, Fun_celular, Fun_email, Gen_id, Eci_id, End_id 
		from inserted
end

