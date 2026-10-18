-- Cenário 1: Casa do Café — Decomposição em 3FN e Migração de Dados (PostgreSQL 16)

CREATE TABLE categoria (
    id_categoria SERIAL PRIMARY KEY,
    nome VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    cidade VARCHAR(60) NOT NULL
);

CREATE TABLE produto (
    cod_produto CHAR(4) PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    id_categoria INT NOT NULL REFERENCES categoria (id_categoria),
    preco_atual NUMERIC(8,2) NOT NULL CHECK (preco_atual >= 0)
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    id_cliente INT NOT NULL REFERENCES cliente (id_cliente)
);

CREATE TABLE item_pedido (
    id_pedido INT REFERENCES pedido (id_pedido),
    cod_produto CHAR(4) REFERENCES produto (cod_produto),
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario NUMERIC(8,2) NOT NULL CHECK (preco_unitario >= 0),
    PRIMARY KEY (id_pedido, cod_produto)
);

-- Migração dos dados respeitando a integridade referencial
INSERT INTO categoria (nome)
SELECT DISTINCT nome_categoria FROM pedido_plano;

INSERT INTO cliente (nome, email, cidade)
SELECT DISTINCT nome_cliente, email_cliente, cidade_cliente FROM pedido_plano;

INSERT INTO produto (cod_produto, nome, id_categoria, preco_atual)
SELECT DISTINCT p.cod_produto, p.nome_produto, c.id_categoria, p.preco_unitario
FROM pedido_plano p
JOIN categoria c ON c.nome = p.nome_categoria;

INSERT INTO pedido (id_pedido, data_pedido, id_cliente)
SELECT DISTINCT p.id_pedido, p.data_pedido, c.id_cliente
FROM pedido_plano p
JOIN cliente c ON c.email = p.email_cliente;

INSERT INTO item_pedido (id_pedido, cod_produto, quantidade, preco_unitario)
SELECT id_pedido, cod_produto, quantidade, preco_unitario FROM pedido_plano;

-- Atualização de e-mail na estrutura normalizada (altera apenas 1 linha)
UPDATE cliente SET email = 'ana.souza@novo.com' WHERE nome = 'Ana Souza';

-- Consulta de verificação de vendas por cliente
SELECT c.nome, SUM(i.quantidade * i.preco_unitario) AS total_gasto
FROM cliente c
JOIN pedido p ON p.id_cliente = c.id_cliente
JOIN item_pedido i ON i.id_pedido = p.id_pedido
GROUP BY c.nome
ORDER BY total_gasto DESC;