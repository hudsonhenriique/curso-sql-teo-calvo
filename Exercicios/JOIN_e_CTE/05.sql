-- Quem iniciou o curso no primeiro dia, 
-- em média assitiu quantas auals?

--Quem participou do curso no primeiro dia
WITH tb_primeiro_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),

--Quem participou do curso inteiro
tb_dias_curso AS (
    SELECT DISTINCT
           IdCliente,
           substr(DtCriacao,1,10) AS Presenca_Dia
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao <= '2025-08-30'

    ORDER BY IdCliente, Presenca_Dia
),

-- Quantos dias cada cliente participou do curso
tb_cliente_dias AS(

    SELECT t1.idCliente,
        count(DISTINCT t2.Presenca_Dia) AS QtdeDiasCurso

    FROM tb_primeiro_dia AS t1

    LEFT JOIN tb_dias_curso AS t2
    ON t1.IdCliente = t2.IdCliente

    GROUP BY t1.IdCliente
)

-- Média de dias que os clientes que iniciaram o curso no primeiro dia, participaram do curso
SELECT avg(QtdeDiasCurso) AS MediaDiasCurso,
       max(QtdeDiasCurso) AS MaximoDiasCurso,
       min(QtdeDiasCurso) AS MinimoDiasCurso
FROM tb_cliente_dias;

