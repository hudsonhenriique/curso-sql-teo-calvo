-- Qual categoria tem mais produtos vendidos?

SELECT t2.DescCateogriaProduto,
       count(DISTINCT t1.IdTransacao) AS TotalVendas
       

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

GROUP  BY t2.DescCateogriaProduto
ORDER  BY count(DISTINCT t1.IdTransacao) DESC