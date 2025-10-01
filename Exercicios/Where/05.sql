-- Lista de produtos com nome que começa com 'Venda de'
SELECT IdProduto,
       DescProduto
FROM produtos
WHERE DescProduto LIKE 'Venda de%'
LIMIT 10;