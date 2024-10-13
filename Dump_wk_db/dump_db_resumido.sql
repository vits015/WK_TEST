DROP DATABASE WK_DB;
CREATE DATABASE WK_DB;

USE WK_DB;
-- Tabela de Clientes
CREATE TABLE clientes (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    uf CHAR(2)
);
-- Tabela de Produtos
CREATE TABLE produtos (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    preco_venda DECIMAL(10, 2) NOT NULL
);
-- Tabela de Pedidos (Dados Gerais)
CREATE TABLE pedidos (
    numero_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_emissao DATE NOT NULL,
    codigo_cliente INT,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (codigo_cliente) REFERENCES clientes(codigo)
);
-- Tabela de Produtos do Pedido
CREATE TABLE produtos_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_pedido INT,
    codigo_produto INT,
    quantidade INT,
    valor_unitario DECIMAL(10, 2),
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (numero_pedido) REFERENCES pedidos(numero_pedido),
    FOREIGN KEY (codigo_produto) REFERENCES produtos(codigo)
);
-- Índices
CREATE INDEX idx_pedidos_codigo_cliente ON pedidos(codigo_cliente);
CREATE INDEX idx_produtos_pedido_numero_pedido ON produtos_pedido(numero_pedido);
CREATE INDEX idx_produtos_pedido_codigo_produto ON produtos_pedido(codigo_produto);


-- Populando os Dados de Teste --

-- Clientes
INSERT INTO clientes (nome, cidade, uf) VALUES
('Cliente 1', 'Rio de Janeiro', 'RJ'),
('Cliente 2', 'São Paulo', 'SP'),
('Cliente 3', 'Belo Horizonte', 'MG'),
('Cliente 4', 'Salvador', 'BA'),
('Cliente 5', 'Curitiba', 'PR'),
('Cliente 6', 'Fortaleza', 'CE'),
('Cliente 7', 'Recife', 'PE'),
('Cliente 8', 'Porto Alegre', 'RS'),
('Cliente 9', 'Florianópolis', 'SC'),
('Cliente 10', 'Goiânia', 'GO'),
('Cliente 11', 'Vitória', 'ES'),
('Cliente 12', 'Manaus', 'AM'),
('Cliente 13', 'Campo Grande', 'MS'),
('Cliente 14', 'Belém', 'PA'),
('Cliente 15', 'João Pessoa', 'PB'),
('Cliente 16', 'Aracaju', 'SE'),
('Cliente 17', 'Maceió', 'AL'),
('Cliente 18', 'São Luís', 'MA'),
('Cliente 19', 'Natal', 'RN'),
('Cliente 20', 'Teresina', 'PI');


-- Produtos
INSERT INTO produtos (descricao, preco_venda) VALUES
('Produto 1', 10.00),
('Produto 2', 15.50),
('Produto 3', 25.00),
('Produto 4', 8.75),
('Produto 5', 13.60),
('Produto 6', 20.00),
('Produto 7', 9.50),
('Produto 8', 30.00),
('Produto 9', 50.00),
('Produto 10', 5.00),
('Produto 11', 12.00),
('Produto 12', 22.00),
('Produto 13', 60.00),
('Produto 14', 70.00),
('Produto 15', 80.00),
('Produto 16', 100.00),
('Produto 17', 110.00),
('Produto 18', 120.00),
('Produto 19', 15.00),
('Produto 20', 17.00);
