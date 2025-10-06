-- Qual o dia da semana mais ativo de cada usuário?

WITH tb_cliente_semana AS (
    SELECT IdCliente,
        strftime('%w',substr(DtCriacao,1,10)) AS DiaSemana,
        count(DISTINCT IdTransacao) AS QtdeTransacoes

    FROM transacoes

    GROUP BY IdCliente, DiaSemana
),

tb_Ranking AS (
    SELECT *,
           CASE
           WHEN DiaSemana = '1' THEN 'Segunda-Feira'
           WHEN DiaSemana = '2' THEN 'Terça-Feira'
           WHEN DiaSemana = '3' THEN 'Quarta-Feira'
           WHEN DiaSemana = '4' THEN 'Quinta-Feira'
           WHEN DiaSemana = '5' THEN 'Sexta-Feira'
           WHEN DiaSemana = '6' THEN 'Sábado'
           ELSE 'Domingo'
           END AS DescDiaSemana,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY QtdeTransacoes DESC) AS Ranking
    FROM tb_cliente_semana
)

SELECT *
FROM tb_Ranking
WHERE Ranking = 1

