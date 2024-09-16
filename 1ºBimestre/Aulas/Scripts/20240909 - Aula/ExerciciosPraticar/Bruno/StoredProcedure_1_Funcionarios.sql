use food
go

create procedure carregardadosclientetxt
as
begin
    declare @registro varchar(100),
            @operacao char(1),
            @id_cliente int,
            @genero char(1),
            @nome_cliente varchar(50),
            @nascimento char(8),
            @id_cidade int,
            @data_nascimento date;

    declare @msg varchar(100);

    -- cursor para iterar sobre os registros da tabela clientetxt
    declare cliente_cursor cursor for
    select registro from clientetxt;

    open cliente_cursor;
    fetch next from cliente_cursor into @registro;

    -- loop sobre os registros
    while @@fetch_status = 0
    begin
        -- separar os campos baseados nas posições definidas
        set @operacao = substring(@registro, 2, 1);
        set @id_cliente = cast(substring(@registro, 3, 5) as int);
        set @genero = substring(@registro, 8, 1);
        set @nome_cliente = rtrim(ltrim(substring(@registro, 9, 50)));
        set @nascimento = substring(@registro, 59, 8);
        set @id_cidade = cast(substring(@registro, 67, 5) as int);

        -- converter a data de nascimento para o formato correto
        set @data_nascimento = convert(date, substring(@nascimento, 1, 4) + '-' + substring(@nascimento, 5, 2) + '-' + substring(@nascimento, 7, 2), 120);

        -- verificar o tipo de registro (0, 1, ou 9)
        if substring(@registro, 1, 1) = '0' or substring(@registro, 1, 1) = '9'
        begin
            -- ignorar registros com tipo 0 ou 9
            fetch next from cliente_cursor into @registro;
            continue;
        end

        -- validações
        if @nome_cliente = ''
        begin
            set @msg = 'erro: o campo nome é obrigatório.';
            print @msg;
            fetch next from cliente_cursor into @registro;
            continue;
        end

        if not exists (select 1 from genero where gen_id = @genero)
        begin
            set @msg = 'erro: o gênero informado não existe: ' + @genero;
            print @msg;
            fetch next from cliente_cursor into @registro;
            continue;
        end

        if not exists (select 1 from cidade where cid_id = @id_cidade)
        begin
            set @msg = 'erro: a cidade informada não existe: ' + cast(@id_cidade as varchar);
            print @msg;
            fetch next from cliente_cursor into @registro;
            continue;
        end

        -- executar a operação baseada no tipo
        if @operacao = 'i' -- inclusão
        begin
            if not exists (select 1 from cliente where cli_id = @id_cliente)
            begin
                -- inserir novo cliente
                insert into cliente (cli_id, cli_nome, cli_nascimento, gen_id, eci_id)
                values (@id_cliente, @nome_cliente, @data_nascimento, @genero, @id_cidade);
                
                set @msg = 'cliente incluído com sucesso: ' + @nome_cliente;
                print @msg;
            end
            else
            begin
                set @msg = 'erro: cliente já existente: ' + @nome_cliente;
                print @msg;
            end
        end
        else if @operacao = 'a' -- alteração
        begin
            if exists (select 1 from cliente where cli_id = @id_cliente)
            begin
                -- atualizar cliente
                update cliente
                set cli_nome = @nome_cliente, cli_nascimento = @data_nascimento, gen_id = @genero, eci_id = @id_cidade
                where cli_id = @id_cliente;

                set @msg = 'cliente atualizado com sucesso: ' + @nome_cliente;
                print @msg;
            end
            else
            begin
                set @msg = 'erro: cliente não encontrado para atualização: ' + @nome_cliente;
                print @msg;
            end
        end

        -- buscar o próximo registro
        fetch next from cliente_cursor into @registro;
    end

    -- fechar e desalocar o cursor
    close cliente_cursor;
    deallocate cliente_cursor;
end;
go
