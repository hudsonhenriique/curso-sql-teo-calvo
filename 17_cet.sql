-- CTE: COMMO TABLE EXPRESSION
-- Retenção de clientes no 5º dia após o cadastro
WITH tb_cliente_primeiro_dia AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),

tb_cliente_quinto_dia AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-29'
),

tb_join AS (

    SELECT t1.IdCliente AS Clientes_1_Dia,
           t2.IdCliente AS Clientes_5_Dia

    FROM tb_cliente_primeiro_dia AS t1

    LEFT JOIN tb_cliente_quinto_dia AS t2
    ON t1.IdCliente = t2.IdCliente
)

SELECT count(Clientes_1_Dia),
       count(Clientes_5_Dia),
       1. * count(Clientes_5_Dia) / count(Clientes_1_Dia) AS Retencao_5_Dia
FROM tb_join


