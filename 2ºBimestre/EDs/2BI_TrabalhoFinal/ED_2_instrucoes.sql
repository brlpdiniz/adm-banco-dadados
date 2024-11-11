/*
1. Tabelas Fato e Dimensões:
    Fato Vendas:
        Uma tabela central que armazenará os dados das vendas diárias.
    Dimensões:
        Categoria dos Pratos: Permite a segmentação das vendas por tipo de prato.
        Data: Contém informações de granularidade temporal, incluindo dia da semana, dia, mês, bimestre, trimestre e ano.
        Loja: Identifica cada loja, com detalhes de localização.
        Localização: Esta dimensão armazenará Estado, Cidade e Região da loja, conforme a visão solicitada.

2. Modelo Dimensional:
    O modelo ideal para esse caso seria uma estrutura em estrela, onde a tabela de fatos central (Fato Vendas) está ligada diretamente às tabelas de dimensões, permitindo consultas rápidas e otimizadas para relatórios de dashboard.
*/


-- 1) Desenhe um modelo dimensional estrela ou floco de neve para um Data Mart (DM), que atenda às necessidades gerenciais descritas anteriormente;

/*
    Para representar o modelo dimensional em estrela para o Data Mart de vendas diárias da rede de restaurantes, a estrutura se concentrará em uma Tabela Fato central (FatoVendas) e várias Tabelas de Dimensão conectadas diretamente. Esse modelo em estrela facilitará as consultas necessárias para as análises do dashboard.
*/

-- Modelo Dimensional em Estrela

1. Tabela Fato: FatoVendas
    Descrição:
        Armazena os dados de vendas diárias.
    Colunas:
        venda_id: Identificador único para o registro de venda.
        data_id: Chave estrangeira para a dimensão DimData.
        loja_id: Chave estrangeira para a dimensão DimLoja.
        categoria_id: Chave estrangeira para a dimensão DimCategoria.
        valor_venda: Valor total da venda.

2. Dimensão DimData
    Descrição:
        Contém informações detalhadas de tempo para permitir consultas em diferentes granularidades.
    Colunas:
        data_id: Identificador único da data (formato yyyymmdd).
        data: Data completa.
        dia_semana: Nome do dia da semana.
        dia: Dia do mês.
        mes: Número do mês.
        nome_mes: Nome do mês.
        bimestre: Número do bimestre.
        trimestre: Número do trimestre.
        ano: Ano.

3. Dimensão DimLoja
    Descrição:
        Identifica cada loja, incluindo a localização geográfica.
    Colunas:
        loja_id: Identificador único da loja.
        nome_loja: Nome da loja.
        cidade: Cidade onde a loja está localizada.
        estado: Estado onde a loja está localizada.
        regiao: Região onde a loja está localizada.

4. Dimensão DimCategoria
    Descrição:
        Classificação dos pratos vendidos.
    Colunas:
        categoria_id: Identificador único da categoria do prato.
        nome_categoria: Nome da categoria do prato.


--  Diagrama do Modelo Dimensional (Estrela)
/*
    A FatoVendas no centro e as dimensões DimData, DimLoja, e DimCategoria em torno dela.
               DimData
                  |
                  |
DimCategoria -- FatoVendas -- DimLoja
*/

/*
    Explicação
    FatoVendas serve como a tabela central, armazenando o valor total das vendas por data, loja e categoria de prato.
    DimData permite consultas por períodos, como dias da semana, meses, trimestres, e anos.
    DimLoja armazena informações de localização de cada loja, essenciais para análises por cidade, estado e região.
    DimCategoria facilita a segmentação das vendas por tipo de prato.
*/


-- 2) Crie a base de dados conforme o modelo desenvolvido;
-- Criar a base de dados
create database DataMartRestaurante;
go

use DataMartRestaurante;
go

-- Criar a tabela DimData
create table DimData (
    data_id int primary key,  -- Ex: 20240101 para 1 de Janeiro de 2024
    data date not null,
    dia_semana varchar(20) not null,
    dia int not null,
    mes int not null,
    nome_mes varchar(20) not null,
    bimestre int not null,
    trimestre int not null,
    ano int not null
);
go

-- Criar a tabela DimLoja
create table DimLoja (
    loja_id int primary key,
    nome_loja varchar(100) not null,
    cidade varchar(50) not null,
    estado varchar(50) not null,
    regiao varchar(50) not null
);
go

-- Criar a tabela DimCategoria
create table DimCategoria (
    categoria_id int primary key,
    nome_categoria varchar(100) not null
);
go

-- Criar a tabela FatoVendas
create table FatoVendas (
    venda_id int identity(1,1) primary key,  -- Identificador único para cada registro de venda
    data_id int not null,                    -- FK para DimData
    loja_id int not null,                    -- FK para DimLoja
    categoria_id int not null,               -- FK para DimCategoria
    valor_venda decimal(18, 2) not null,     -- Valor total da venda
    
    -- Definir as chaves estrangeiras
    foreign key (data_id) references DimData(data_id),
    foreign key (loja_id) references DimLoja(loja_id),
    foreign key (categoria_id) references DimCategoria(categoria_id)
);
go

/*
    Explicação
    DimData: Armazena informações detalhadas sobre a data, permitindo consultas por granularidade temporal.
    DimLoja: Armazena dados da loja, incluindo cidade, estado e região.
    DimCategoria: Define as categorias de pratos.
    FatoVendas: Tabela de fatos que armazena o valor total das vendas diárias, com chaves estrangeiras para as dimensões.
    Agora a base de dados DataMartRestaurante está criada e pronta para ser populada.
*/