-- Como foi a curva de CHURN do Curso de SQL?

-- SELECT substr(DtCriacao, 1, 10) AS Dia,
--        count(DISTINCT IdCliente) AS QtdClientes    
-- FROM transacoes
-- WHERE DtCriacao >= '2025-08-25 '
-- AND DtCriacao < '2025-08-30'
-- GROUP BY Dia

-- Total de clientes no primeiro dia (2025-08-25)
WITH tb_clientes_d1 AS (
    SELECT DISTINCT IdCliente

    FROM transacoes

    WHERE DtCriacao >= '2025-08-25 '
    AND DtCriacao < '2025-08-26'
),

tb_join AS(

SELECT substr(t2.DtCriacao, 1, 10) AS Dia,
-- Total de clientes que deram CHURN nesse dia
       count(DISTINCT t1.IdCliente) AS QtdClientes_Churn,
-- Total de clientes que deram CHURN por dia
       1. * count(DISTINCT t1.IdCliente) / (SELECT count(*) FROM tb_clientes_d1) AS Taxa_Churn

FROM tb_clientes_d1 AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente

WHERE t2.DtCriacao >= '2025-08-25'
AND t2.DtCriacao < '2025-08-30'

GROUP BY Dia
)

SELECT *
FROM tb_join