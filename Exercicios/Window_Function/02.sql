-- Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

WITH tb_dia_cliente AS (
    SELECT substr(DtCriacao,1,10) AS dtDia,
        count(DISTINCT IdCliente) AS QtdeCliente

    FROM clientes

    GROUP BY dtDia
),

tb_dia_cliente_acumulado AS (
    SELECT *,
        sum(QtdeCliente) OVER (ORDER BY dtDia) AS QtdeClienteAcumulada

    FROM tb_dia_cliente
)

SELECT *

FROM tb_dia_cliente_acumulado
ORDER BY dtDia