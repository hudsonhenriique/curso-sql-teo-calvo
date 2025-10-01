-- Qual produto mais transacionado?
SELECT IdProduto,
    --    COUNT(*) AS TotalTransacoes
       sum(QtdeProduto) AS TotalTransacoes

FROM transacao_produto  

GROUP BY IdProduto
ORDER BY TotalTransacoes DESC
LIMIT 1; 

