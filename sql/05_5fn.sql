-- Cenário 4: Representantes, Empresas e Produtos (Quinta Forma Normal - 5FN)

CREATE TABLE representacao (
    agente VARCHAR(40),
    empresa VARCHAR(40),
    produto VARCHAR(40),
    PRIMARY KEY (agente, empresa, produto)
);

INSERT INTO representacao VALUES
    ('Ana', 'Alfa', 'Caneta'),
    ('Ana', 'Alfa', 'Lápis'),
    ('Ana', 'Beta', 'Caneta'),
    ('Bia', 'Alfa', 'Caneta');

-- Decomposição em 5FN
CREATE TABLE agente_empresa (
    agente VARCHAR(40),
    empresa VARCHAR(40),
    PRIMARY KEY (agente, empresa)
);

CREATE TABLE empresa_produto (
    empresa VARCHAR(40),
    produto VARCHAR(40),
    PRIMARY KEY (empresa, produto)
);

CREATE TABLE agente_produto (
    agente VARCHAR(40),
    produto VARCHAR(40),
    PRIMARY KEY (agente, produto)
);

INSERT INTO agente_empresa SELECT DISTINCT agente, empresa FROM representacao;
INSERT INTO empresa_produto SELECT DISTINCT empresa, produto FROM representacao;
INSERT INTO agente_produto SELECT DISTINCT agente, produto FROM representacao;

-- Teste de junção sem perdas (deve retornar 0 linhas em ambas as consultas)
SELECT ae.agente, ae.empresa, ep.produto
FROM agente_empresa ae
JOIN empresa_produto ep ON ep.empresa = ae.empresa
JOIN agente_produto ap ON ap.agente = ae.agente AND ap.produto = ep.produto
EXCEPT
SELECT agente, empresa, produto FROM representacao;

SELECT agente, empresa, produto FROM representacao
EXCEPT
SELECT ae.agente, ae.empresa, ep.produto
FROM agente_empresa ae
JOIN empresa_produto ep ON ep.empresa = ae.empresa
JOIN agente_produto ap ON ap.agente = ae.agente AND ap.produto = ep.produto;