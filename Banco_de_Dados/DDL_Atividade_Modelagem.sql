CREATE DATABASE Solucoes_Express;

USE Solucoes_Express;

CREATE TABLE Cliente(
	codigo INT IDENTITY(1,1) PRIMARY KEY
	,tipo_cliente VARCHAR (2) NOT NULL CHECK (tipo_cliente IN  ('PF', 'PJ'))
	,cpf NVARCHAR(11) NULL
	,cnpj NVARCHAR (14) NULL
	,nome NVARCHAR(255) NOT NULL
	,telefone INT NOT NULL
);

CREATE TABLE Categoria (
    codigo INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE Produto(
	codigo INT IDENTITY(1,1) PRIMARY KEY
	,nome NVARCHAR(255) NOT NULL
	,preco DECIMAL (10,2) NOT NULL
	,descricao NVARCHAR(255) NOT NULL
	,categoria NVARCHAR(255) NOT NULL
	,codigo_categoria INT NULL
	FOREIGN KEY (codigo_categoria) REFERENCES Categoria(codigo)

);

CREATE TABLE Pedido(
	codigo INT IDENTITY(1,1) PRIMARY KEY
	,data_pedido DATETIME NOT NULL
	,status_pedido NVARCHAR (20) NOT NULL
	,valor_total DECIMAL (10,2) NOT NULL
	,codigo_cliente INT NOT NULL
	FOREIGN KEY (codigo_cliente) REFERENCES Cliente(codigo)
);

CREATE TABLE Item_Pedido(
	 codigo INT IDENTITY(1,1) PRIMARY KEY
    ,quantidade INT NOT NULL CHECK (quantidade > 0)
    ,preco_compra DECIMAL(10,2) NOT NULL
	,codigo_pedido INT NOT NULL
    ,codigo_produto INT NOT NULL

	FOREIGN KEY (codigo_pedido) REFERENCES Pedido(codigo),
	FOREIGN KEY (codigo_produto) REFERENCES Produto(codigo)
);

CREATE TABLE Entregador(
	codigo INT IDENTITY(1,1) PRIMARY KEY
    ,nome VARCHAR(120) NOT NULL
    ,cpf CHAR(11) NOT NULL UNIQUE
    ,veiculo VARCHAR(50) NOT NULL
    ,placa VARCHAR(10) NOT NULL UNIQUE

);


CREATE TABLE Entrega(
	codigo INT IDENTITY(1,1) PRIMARY KEY
    ,codigo_pedido INT NOT NULL UNIQUE
    ,codigo_entregador INT NOT NULL

	,FOREIGN KEY (codigo_pedido) REFERENCES Pedido(codigo)

	,FOREIGN KEY (codigo_entregador) REFERENCES Entregador(codigo)

);
	

CREATE TABLE Rastreamento(
	codigo INT IDENTITY(1,1) PRIMARY KEY
    ,codigo_pedido INT NOT NULL
    ,status VARCHAR(20) NOT NULL CHECK (status IN ('pendente', 'em_transporte', 'entregue'))
    ,data_hora DATETIME NOT NULL
    ,localizacao VARCHAR(150) NOT NULL

	FOREIGN KEY (codigo_pedido) REFERENCES Pedido(codigo)

);

SELECT * FROM Cliente;
SELECT * FROM Categoria;
SELECT * FROM Produto;
SELECT * FROM Pedido;
SELECT * FROM Item_Pedido;
SELECT * FROM Entregador;
SELECT * FROM Rastreamento;
