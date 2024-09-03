use master;
go
-- Mostrando a pasta com as base
SELECT * FROM SYS.database_files

-- 1º momento - fazendo backup full e restaurando o backup

-- realizando backup full
Backup database ABD_Aula to disk = '\\10.10.0.15\sql\ABD_Aula.bak'

-- recuperar a base
use master
drop database ABD_Aula

-- Recuperar o BD. 
RESTORE DATABASE ABD_Aula FROM DISK = '\\10.10.0.15\sql\ABD_Aula.bak' WITH RECOVERY

---------------------------------------------------------------------------------
-- 2º momento - fazendo backup full, differential e depois restaurando os backups
-- realizando backup full
Backup database ABD_Aula to disk = '\\10.10.0.15\sql\ABD_Aula.bak' with init

-- inserir um registro
insert into ABD_Aula.dbo.categoriaProduto (cat_descricao) values ('comida do mediterrâneo');

-- fazer um backup diferencial
Backup database ABD_Aula to disk = '\\10.10.0.15\sql\ABD_Aula.bak' 
with differential

-- verificar se há os arquivos de bakcup no arquivo f�sico
--	Colunas mais importantes:
--	Backup Type: (1-Inicial, 2-Log, 5-Diferencial)
--	Position: Ordem do Backup
restore headeronly from disk = '\\10.10.0.15\sql\ABD_Aula.bak'

-- recuperar a base
-- Recuparar o backup full
-- recuperar o backup diferencial
alter database ABD_Aula set single_user with rollback immediate 
use master;
drop database ABD_Aula
RESTORE DATABASE ABD_Aula FROM DISK = '\\10.10.0.15\sql\ABD_Aula.bak' with file = 1, norecovery
RESTORE DATABASE ABD_Aula FROM DISK = '\\10.10.0.15\sql\ABD_Aula.bak' with FILE = 2, recovery

select * from ABD_Aula.dbo.categoriaProduto 

---------------------------------------------------------------------------------
-- 3º momento - fazendo uma politica de backup

-- Para fazer backup de log deve-se alterar o modelo de recuperação
select name, recovery_model_desc from sys.databases  where name = 'ABD_Aula';  
alter database ABD_Aula set recovery full

-- Exemplo de política de backup:
-- 04:00hs -- BACKUP FULL INICIAL
backup database ABD_Aula to disk = '\\10.10.0.15\sql\ABD_Aula.bak' with init

-- 06:00hs - BACKUP LOG
backup log ABD_Aula to disk = '\\10.10.0.15\sql\ABD_Aula.bak' with noinit

-- 08:00hs - BACKUP LOG
backup log ABD_Aula to disk = '\\10.10.0.15\sql\ABD_Aula.bak' with noinit

-- 10:00hs - BACKUP DIFERENCIAL
backup database ABD_Aula to disk = '\\10.10.0.15\sql\ABD_Aula.bak' with differential

-- 14:00hs - BACKUP LOG
backup log ABD_Aula to disk = '\\10.10.0.15\sql\ABD_Aula.bak' with noinit

-- 16:00hs - BACKUP DIFERENCIAL
backup database ABD_Aula to disk = '\\10.10.0.15\sql\ABD_Aula.bak' with differential

-- 17:00hs - BACKUP LOG
backup log ABD_Aula to disk = '\\10.10.0.15\sql\ABD_Aula.bak' with noinit

-- AS 18:00, verificou-se que houve um problema na base.

--	Verificando os arquivos contidos no arquivo ABD_Aula.bak
restore headeronly from disk = '\\10.10.0.15\sql\ABD_Aula.bak'

--	Colunas mais importantes:
--	Backup Type: (1-Inicial, 2-Log, 5-Diferencial)
--	Position: Ordem do Backup
--	BackupStartDate: Data inicial do backup
--	BackupFinishDate: Data final do backup

-- recuperando o backup full inicial -- 02:00
use master 
drop database ABD_Aula 

restore database ABD_Aula from disk = '\\10.10.0.15\sql\ABD_Aula.bak' with file = 1, norecovery

-- recuperando o bakcup diferencial -- 16:00hs
restore database ABD_Aula from disk = '\\10.10.0.15\sql\ABD_Aula.bak' with file = 6, norecovery

-- recuperando o bakcup de log -- 17:00hs
restore database ABD_Aula from disk = '\\10.10.0.15\sql\ABD_Aula.bak' with file = 7, recovery

USE ABD_Aula
SELECT * FROM categoriaProduto