-- Quantos produtos são de rpg?

-- SELECT COUNT(*)
-- FROM produtos
-- WHERE DescCateogriaProduto = 'rpg';

SELECT DescCateogriaProduto,
       COUNT(*) AS TotalProdutos

FROM produtos

GROUP BY DescCateogriaProduto;