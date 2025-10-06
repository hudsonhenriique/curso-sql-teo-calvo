-- Acumulado de transações de pessoas por dia durante o curso
WITH tb_transacoes AS (
    SELECT IdCliente,
        substr(DtCriacao,1,10) as dtDia,
        count(DISTINCT IdTransacao) as QtdeTransacoes

    FROM transacoes

    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'

    GROUP BY IdCliente,dtDia
),

tab_lag AS (

    SELECT *,
        sum(QtdeTransacoes) OVER (PARTITION BY IdCliente ORDER BY dtDia) as QtdeTransacoesAcumuladas,
        lag(QtdeTransacoes) OVER (PARTITION BY IdCliente ORDER BY dtDia) as Legenda


    FROM tb_transacoes
)

SELECT *,
       1. * QtdeTransacoes / Legenda AS Engajamento

FROM tab_lag