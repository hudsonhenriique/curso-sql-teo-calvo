-- Qual o produto com mais pontos transacionado?

SELECT IdProduto,
       sum(VlProduto * QtdeProduto) as TotalPontos,
       sum(QtdeProduto) AS QtdeVendas

FROM transacao_produto

GROUP BY IdProduto
ORDER BY sum(VlProduto) DESC
