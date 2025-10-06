
DROP TABLE IF EXISTS relatorio_diario;

CREATE TABLE relatorio_diario AS

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
FROM tb_acumulado;
