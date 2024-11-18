-- Imagine que o banco abaixo foi criado e populado, tenha ele como base as próximas atividades:
create database food;
go
use food;
go

create table Continente (
	Con_id 			int not null,
	Con_Nome 		varchar(50) not null,
	Con_Sigla  		varchar(05) not null,
	constraint		PK_Continente primary key(Con_id)
);

create table Pais (
	Pais_id 		int not null,
	Pais_Nome 		varchar(100),
	Pais_Oficial	varchar(100),
	Pais_Sigla1 	varchar(10),
	Pais_Sigla2 	varchar(10),
	Con_id 			int not null,
	constraint  	FK_Pais_Continente foreign key (Con_id) references Continente(Con_id),
	constraint		PK_Pais primary key(Pais_id)
);

create table Regiao (
	Reg_id 			int not null,
	Reg_Nome 		varchar(50) not null,
	Reg_Sigla  		varchar(10) not null,
	Pais_id 		int not null,
	constraint  	FK_Regiao_Pais foreign key (Pais_id) references Pais(Pais_id),
	constraint		PK_Regiao primary key(Reg_id)
);

create table Estado (
	est_id 			int not null,
	est_Nome 		varchar(80) not null,
	est_Sigla  		varchar(02) not null,
	Pais_id 		int not null,
	Reg_id 			int not null,
	constraint  	FK_Estado_Regiao  foreign key (Reg_id)  references Regiao(Reg_id), 
	constraint  	FK_Estado_Pais	  foreign key (Pais_id) references Pais(Pais_id),
	constraint		PK_Estado primary key(est_id)
);

create table CidadeTipo(
	ctp_id			int not null,
	ctp_Descricao	varchar(50) not null,
	constraint		PK_TipoCidade primary key(ctp_id)
);

create table Cidade (
	cid_id			int not null,
	cid_Nome		varchar(150) not null,
	ctp_id  		int,
	est_id  		int not null,
	cid_ddd			int,
	constraint  	FK_Cidade_CidadeTipo foreign key (ctp_id) references CidadeTipo(ctp_id), 
	constraint  	FK_Cidade_Estado foreign key (est_id) references Estado(est_id),
	constraint		PK_Cidade primary key(cid_id)
);

create table Bairro (
	bai_id  		int not null identity(1,1),
	bai_Descricao 	varchar(100),
	cid_id  		int,
	constraint 		fk_Bairro_Cidade foreign key (cid_id) references cidade(cid_id),
	constraint		PK_Bairro primary key(bai_id)	
);

create table Endereco (
	end_id			int not null identity(1,1),
	end_cep			char(09),
	end_descricao	varchar(100),
	bai_id  		int not null,
	constraint  	FK_Endereco_bairro foreign key (bai_id) references Bairro(bai_id),
	constraint		PK_Endereco primary key(end_id)
);

create table EstadoCivil (
	eci_id 			int not null identity(1,1),
	eci_nome 		varchar(100),
	constraint		PK_EstadoCivil primary key(eci_id)	
);

create table Genero (
	gen_id			int not null,
	gen_descricao	varchar(30) not null, 
	constraint		PK_Genero primary key(gen_id)
);

create table Funcionario (
	Fun_id 			int not null,
	Fun_nome		varchar(100) not null,
	Fun_nascimento 	date not null,
	Fun_admissao	date,
	Fun_celular		varchar(12),
	Fun_email		varchar(100),
	Gen_id 			int not null,
	Eci_id			int not null,
	End_id			int not null,
	constraint 		FK_Funcionario_genero foreign key(gen_id) references Genero(gen_id),
	constraint 		fk_Funcionario_estadoCivil foreign key (eci_id) references estadoCivil(eci_id),
	constraint 		fk_Funcionario_endereco foreign key (end_id) references Endereco(end_id),
	constraint		PK_Funcionario primary key(fun_id)
);

create table Cliente (
	Cli_id 			int not null,
	Cli_nome		varchar(100) not null,
	Cli_nascimento 	date not null,
	Cli_celular		varchar(12),
	Cli_email		varchar(100),
	gen_id 			int not null,
	eci_id			int not null,
	end_id			int not null,
	constraint 		FK_Cliente_genero foreign key(gen_id) references Genero(gen_id),
	constraint 		fk_Cliente_estadoCivil foreign key (eci_id) references estadoCivil(eci_id),
	constraint 		fk_Cliente_endereco foreign key (end_id) references Endereco(end_id),
	constraint		PK_Cliente primary key(Cli_id)
);

create table Entregador (
	Ent_id 			int not null,
	Ent_nome		varchar(100) not null,
	Ent_nascimento 	date not null,
	Ent_CNH			varchar(15),
	Ent_CNH_Validade date,
	Ent_celular		varchar(12),
	Ent_email		varchar(100),
	gen_id 			int not null,
	eci_id			int not null,
	end_id			int not null,
	constraint 		FK_Entregador_genero foreign key(gen_id) references Genero(gen_id),
	constraint 		fk_Entregador_estadoCivil foreign key (eci_id) references estadoCivil(eci_id),
	constraint 		fk_Entregador_endereco foreign key (end_id) references Endereco(end_id),
	constraint		PK_Entregador primary key(Ent_id)
);

create table login (
	log_id 			int not null identity(1,1) primary key,
	log_email		varchar(100) not null,
	log_senha		varchar(15)
);

create table Loja (
	loj_id 			int not null identity(1,1),
	loj_nome 		varchar(100),
	end_id 			int,
	constraint 		fk_loja_endereco foreign key (end_id) references endereco(end_id),
	constraint		PK_Loja primary key(loj_id)
);

create table CategoriaProduto (
	cat_id 			int not null identity(1,1),
	cat_descricao 	varchar(100),
	constraint		PK_CategoriaProduto primary key(cat_id)
);

create table Produto (
 	pro_id 			int not null identity(1,1),
	pro_descricao 	varchar(100),
	pro_preco 		decimal(10,2),
	cat_id 			int,
	loj_id 			int,
	constraint 		fk_produto_categoria foreign key (cat_id) references CategoriaProduto(cat_id),
	constraint 		fk_produto_loja foreign key (loj_id) references loja(loj_id),
	constraint		PK_Produto primary key(pro_id)
);

create table FormaPagamento (
	fpg_id 	  		int not null identity(1,1),
	fpg_descricao  	varchar(100),
	constraint		PK_FormaPagamento primary key(fpg_id)
);

-- 1-(Em Processamento), 2-(Em aberto), 3-(Entregue), 4-(Cancelado). 
create table Situacao (
	sit_id			int not null,
	sit_descricao	varchar(50) not null, 
	constraint		PK_Situacao primary key(sit_id)
);

-- 1-(Retirada), 2-(Entrega), 3-(Consumo local). 
create table TipoEntrega (
 	tip_id			int not null,
	tip_descricao	varchar(50) not null, 
	constraint		PK_TipoEntrega primary key(tip_id)
);

create table Pedido (
 	ped_id			int not null identity(1,1),
	ped_data 	    date not null,
	sit_id			int not null, 
	loj_id 			int not null,
	Cli_id 			int not null,	
	Fun_id 			int not null,
	Ent_id 			int not null,
	Fpg_id 			int not null,
	tip_id 			int not null,
	constraint 		fk_pedido_situacao foreign key (sit_id) references Situacao(sit_id),
	constraint 		fk_pedido_loja foreign key (loj_id) references loja(loj_id),
	constraint 		fk_pedido_Funcionario foreign key (Fun_id) references Funcionario(Fun_id),
	constraint 		fk_pedido_Cliente foreign key (Cli_id) references Cliente(Cli_id),
	constraint 		fk_pedido_entregador foreign key (Ent_id) references Entregador(Ent_id),
	constraint 		fk_pedido_tipoEntrega foreign key (tip_id) references TipoEntrega(tip_id),
	constraint 		fk_pedido_FormaPagamento foreign key (fpg_id) references FormaPagamento(fpg_id),
	constraint		PK_Pedido primary key(ped_id)
);

create table PedidoProduto (
	pdd_id 			int not null identity(1,1),
	ped_id 			int not null,
	pro_id 			int not null,
	pdd_quantidade 	int,
	pdd_preco 		decimal(10,2),
	pdd_observacoes varchar(50),
	constraint 		fk_pedidoProduto_pedido foreign key (ped_id) references pedido(ped_id),
	constraint 		fk_pedidoProduto_produto foreign key (pro_id) references produto(pro_id),
	constraint		PK_PedidoProduto primary key(pdd_id)
);

create table Avaliacao (
	ava_id			int not null identity(1,1),
 	ped_id			int not null,
	ava_data 	    date not null,
	ava_nota		int,
	ava_observacoes varchar(150),
	constraint		PK_Avaliacao primary key(ava_id),
	constraint 		fk_Avaliacao_pedido foreign key (ped_id) references Pedido(ped_id)
);
