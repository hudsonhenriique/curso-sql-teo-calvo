
DELETE FROM relatorio_diario;


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

INSERT INTO relatorio_diario

SELECT *
FROM tb_acumulado;

SELECT *
FROM relatorio_diario;
