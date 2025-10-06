-- Transações acumuladas por dia


WITH sumario_dias AS (
  
SELECT substr(DtCriacao, 1,10) AS DataCriacao,
       count(DISTINCT IdTransacao) AS QtdeTransacao

FROM transacoes

WHERE DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-30'

GROUP BY DataCriacao
)

SELECT *,
       sum(QtdeTransacao) OVER (ORDER BY DataCriacao) AS QtdeTransacaoAcumulada
FROM sumario_dias