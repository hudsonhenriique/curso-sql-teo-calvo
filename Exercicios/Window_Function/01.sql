-- Quantidade de transações acumuladas ao longo do tempo(diário)?
-- Quando atingimos 100 mil transações?

WITH tb_diario AS (
    SELECT substr(DtCriacao,1,10) AS dtDia,
        count(DISTINCT IdTransacao) AS QtdeTransacao

    FROM transacoes

    GROUP BY dtDia
    ORDER BY dtDia
),

tb_acumulado AS (
    SELECT *,
        sum(QtdeTransacao) OVER (ORDER BY dtDia) as QtdeTransacoesAcumuladas

    FROM tb_diario
)

SELECT *
FROM tb_acumulado
WHERE QtdeTransacoesAcumuladas >= 100000
ORDER BY QtdeTransacoesAcumuladas 
LIMIT 1
;