-- 1) Faça uma listagem do cardápio ordenada por nome;
select * from cardapio order by nome ASC;

-- 2) Apresente todas as comandas (código, data, mesa e nome do cliente) e os itens da comanda (código comanda, nome do café, descricão, quantidade, preço unitário e preço total do café) destas ordenados data e código da comanda e, também o nome do café;
SELECT ca.nome AS nome_do_cafe,  ca.descricao, ca.preco_unitario,
 ic.quantidade,
 co.data_comanda,
 co.numero_mesa,
 co.nome_cliente,
 co.codigo AS codigo_comanda
 FROM cardapio ca
 INNER JOIN item_comanda ic
 ON ca.codigo = ic.codigo_cardapio
 INNER JOIN comanda co
 ON ic.codigo_comanda = co.codigo
 ORDER BY
 co.data_comanda,
 codigo_comanda,
 nome_do_cafe;

-- 3) Liste todas as comandas (código, data, mesa e nome do cliente) mais uma coluna com o valor total da comanda. Ordene por data esta listagem;
SELECT co.codigo as codigo_comanda, co.data_comanda, co.numero_mesa, co.nome_cliente, sum(ca.preco_unitario * ic.quantidade) as total
 FROM cardapio ca
 INNER JOIN item_comanda ic
 ON ca.codigo = ic.codigo_cardapio
 INNER JOIN comanda co
 ON ic.codigo_comanda = co.codigo
 GROUP BY
 co.codigo
 ORDER BY
 co.data_comanda;

-- 4) Faça a mesma listagem das comandas da questão anterior (6), mas traga apenas as comandas que possuem mais do que um tipo de café na comanda;
SELECT
    co.codigo AS codigo_comanda,
    co.nome_cliente,
    co.numero_mesa,
    co.data_comanda
FROM comanda co
JOIN item_comanda ic 
    ON ic.codigo_comanda = co.codigo
JOIN cardapio ca
    ON ca.codigo = ic.codigo_cardapio
GROUP BY
    co.codigo,
    co.nome_cliente,
    co.numero_mesa,
    co.data_comanda
HAVING COUNT(DISTINCT ca.nome) > 1;

-- 5) Qual o total de faturamento por data? ordene por data esta consulta.
SELECT
    co.data_comanda,
    SUM(ca.preco_unitario * ic.quantidade) AS faturamento
FROM cardapio ca
INNER JOIN item_comanda ic
    ON ca.codigo = ic.codigo_cardapio
INNER JOIN comanda co
    ON ic.codigo_comanda = co.codigo
GROUP BY                  
    co.data_comanda
ORDER BY
    co.data_comanda;
