-- Cenário 1: Casa do Café (PostgreSQL 16)
-- Ponto de partida: Tabela plana da loja e demonstração da anomalia de atualização.

CREATE TABLE pedido_plano (
    id_pedido INT,
    data_pedido DATE,
    nome_cliente VARCHAR(80),
    email_cliente VARCHAR(100),
    cidade_cliente VARCHAR(60),
    cod_produto CHAR(4),
    nome_produto VARCHAR(80),
    nome_categoria VARCHAR(40),
    preco_unitario NUMERIC(8,2),
    quantidade INT,
    PRIMARY KEY (id_pedido, cod_produto)
);

INSERT INTO pedido_plano (id_pedido, data_pedido, nome_cliente, email_cliente, cidade_cliente, cod_produto, nome_produto, nome_categoria, preco_unitario, quantidade) 
VALUES
    (1001, '2026-03-02', 'Ana Souza', 'ana@email.com', 'Campinas', 'CF01', 'Café Especial 250g', 'Cafés', 32.90, 2),
    (1001, '2026-03-02', 'Ana Souza', 'ana@email.com', 'Campinas', 'FP01', 'Filtro de Papel 103', 'Acessórios', 9.50, 1),
    (1002, '2026-03-05', 'Bruno Lima', 'bruno@email.com', 'Santos', 'CF01', 'Café Especial 250g', 'Cafés', 32.90, 1),
    (1003, '2026-03-09', 'Ana Souza', 'ana@email.com', 'Campinas', 'M001', 'Moedor Manual', 'Acessórios', 149.00, 1);

-- Anomalia de atualização: alterar o e-mail da cliente exige modificar 3 linhas
UPDATE pedido_plano
SET email_cliente = 'ana.souza@email.com'
WHERE nome_cliente = 'Ana Souza';