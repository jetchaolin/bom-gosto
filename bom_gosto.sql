-- ==================================================
-- ESTRUTURA DAS TABELAS - CAFETERIA BOMGOSTO
-- PostgreSQL
-- ==================================================

-- Tabela Cardápio
CREATE TABLE cardapio (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    preco_unitario NUMERIC(10, 2) NOT NULL
);

-- Tabela Comanda
CREATE TABLE comanda (
    codigo SERIAL PRIMARY KEY,
    data_comanda DATE NOT NULL,
    numero_mesa INTEGER NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL
);

-- Tabela Item Comanda
CREATE TABLE item_comanda (
    codigo_comanda INTEGER,
    codigo_cardapio INTEGER,
    quantidade INTEGER NOT NULL,
    PRIMARY KEY (codigo_comanda, codigo_cardapio),
    FOREIGN KEY (codigo_comanda) REFERENCES comanda(codigo),
    FOREIGN KEY (codigo_cardapio) REFERENCES cardapio(codigo)
);

-- ==================================================
-- DADOS DE EXEMPLO
-- ==================================================

-- Inserindo dados no cardápio
INSERT INTO cardapio (nome, descricao, preco_unitario) VALUES
('Espresso', 'Café expresso tradicional italiano', 3.50),
('Cappuccino', 'Café com leite vaporizado e espuma', 5.50),
('Latte', 'Café com muito leite vaporizado', 6.00),
('Americano', 'Café expresso com água quente', 4.00),
('Mocha', 'Café com chocolate e chantilly', 7.50),
('Macchiato', 'Café expresso com uma colher de leite vaporizado', 4.50),
('Frappé', 'Café gelado batido com gelo', 8.00);

-- Inserindo comandas
INSERT INTO comanda (data_comanda, numero_mesa, nome_cliente) VALUES
('2025-01-15', 1, 'João Silva'),
('2025-01-15', 2, 'Maria Santos'),
('2025-01-16', 3, 'Pedro Costa'),
('2025-01-16', 1, 'Ana Lima'),
('2025-01-17', 4, 'Carlos Mendes'),
('2025-01-17', 2, 'Julia Ferreira');

-- Inserindo itens das comandas
INSERT INTO item_comanda (codigo_comanda, codigo_cardapio, quantidade) VALUES
-- Comanda 1 (João Silva)
(1, 1, 2), -- 2 Espressos
(1, 2, 1), -- 1 Cappuccino
-- Comanda 2 (Maria Santos)
(2, 3, 1), -- 1 Latte
-- Comanda 3 (Pedro Costa)
(3, 1, 1), -- 1 Espresso
(3, 4, 2), -- 2 Americanos
(3, 5, 1), -- 1 Mocha
-- Comanda 4 (Ana Lima)
(4, 2, 2), -- 2 Cappuccinos
-- Comanda 5 (Carlos Mendes)
(5, 6, 1), -- 1 Macchiato
(5, 7, 1), -- 1 Frappé
-- Comanda 6 (Julia Ferreira)
(6, 5, 2), -- 2 Mochas
(6, 1, 1); -- 1 Espresso

-- ==================================================
-- QUESTÕES SOLICITADAS
-- ==================================================

-- 1) Faça uma listagem do cardápio ordenada por nome
SELECT
    codigo,
    nome,
    descricao,
    preco_unitario
FROM cardapio
ORDER BY nome;

-- ==================================================

-- 2) Apresente todas as comandas e os itens da comanda ordenados por data, código da comanda e nome do café
SELECT
    c.codigo AS codigo_comanda,
    c.data_comanda,
    c.numero_mesa,
    c.nome_cliente,
    card.nome AS nome_cafe,
    card.descricao,
    ic.quantidade,
    card.preco_unitario,
    (ic.quantidade * card.preco_unitario) AS preco_total_cafe
FROM comanda c
INNER JOIN item_comanda ic ON c.codigo = ic.codigo_comanda
INNER JOIN cardapio card ON ic.codigo_cardapio = card.codigo
ORDER BY c.data_comanda, c.codigo, card.nome;

-- ==================================================

-- 3) Liste todas as comandas com o valor total da comanda, ordenado por data
SELECT
    c.codigo,
    c.data_comanda,
    c.numero_mesa,
    c.nome_cliente,
    SUM(ic.quantidade * card.preco_unitario) AS valor_total_comanda
FROM comanda c
INNER JOIN item_comanda ic ON c.codigo = ic.codigo_comanda
INNER JOIN cardapio card ON ic.codigo_cardapio = card.codigo
GROUP BY c.codigo, c.data_comanda, c.numero_mesa, c.nome_cliente
ORDER BY c.data_comanda;

-- ==================================================

-- 4) Comandas que possuem mais de um tipo de café na comanda
SELECT 
    c.codigo,
    c.data_comanda,
    c.numero_mesa,
    c.nome_cliente,
    SUM(ic.quantidade * card.preco_unitario) AS valor_total_comanda,
    COUNT(ic.codigo_cardapio) AS tipos_de_cafe
FROM comanda c
INNER JOIN item_comanda ic ON c.codigo = ic.codigo_comanda
INNER JOIN cardapio card ON ic.codigo_cardapio = card.codigo
GROUP BY c.codigo, c.data_comanda, c.numero_mesa, c.nome_cliente
HAVING COUNT(ic.codigo_cardapio) > 1
ORDER BY c.data_comanda;

-- ==================================================

-- 5) Total de faturamento por data, ordenado por data
SELECT 
    c.data_comanda,
    SUM(ic.quantidade * card.preco_unitario) AS faturamento_total
FROM comanda c
INNER JOIN item_comanda ic ON c.codigo = ic.codigo_comanda
INNER JOIN cardapio card ON ic.codigo_cardapio = card.codigo
GROUP BY c.data_comanda
ORDER BY c.data_comanda;

-- ==================================================
-- CONSULTAS ADICIONAIS ÚTEIS
-- ==================================================

-- Café mais vendido (por quantidade)
SELECT 
    card.nome,
    SUM(ic.quantidade) AS total_vendido
FROM cardapio card
INNER JOIN item_comanda ic ON card.codigo = ic.codigo_cardapio
GROUP BY card.codigo, card.nome
ORDER BY total_vendido DESC;

-- Faturamento por café
SELECT 
    card.nome,
    SUM(ic.quantidade * card.preco_unitario) AS faturamento_cafe
FROM cardapio card
INNER JOIN item_comanda ic ON card.codigo = ic.codigo_cardapio
GROUP BY card.codigo, card.nome
ORDER BY faturamento_cafe DESC;

-- Cliente que mais gastou
SELECT 
    c.nome_cliente,
    SUM(ic.quantidade * card.preco_unitario) AS total_gasto
FROM comanda c
INNER JOIN item_comanda ic ON c.codigo = ic.codigo_comanda
INNER JOIN cardapio card ON ic.codigo_cardapio = card.codigo
GROUP BY c.nome_cliente
ORDER BY total_gasto DESC;

-- Ver sequências (auto increment)
SELECT * FROM pg_sequences;

-- Resetar sequência se necessário
-- ALTER SEQUENCE cardapio_codigo_seq RESTART WITH 1;

-- Ver estrutura das tabelas
\d cardapio
\d comanda
\d item_comanda

-- Exportar resultado para CSV
\copy (SELECT * FROM cardapio) TO '/tmp/cardapio.csv' CSV HEADER;

-- Ver todas as tabelas do banco
\dt

-- Ver informações de performance
EXPLAIN ANALYZE SELECT * FROM comanda;
