-- Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?

-- Usamos a cláusula WITH para criar tabelas temporárias (CTEs - Common Table Expressions).
-- Isso ajuda a organizar e simplificar a consulta principal.

-- Primeira CTE: `alunos_dia01`
-- Objetivo: Identificar todos os alunos únicos que tiveram alguma atividade no primeiro dia do curso (2025-08-25).
WITH alunos_dia01 AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),

-- Segunda CTE: `tb_dia_cliente`
-- Objetivo: Contar o número de interações (transações) de cada aluno (que começou no dia 01) em cada dia do curso.
tb_dia_cliente AS (

    SELECT t1.IdCliente,
           substr(t2.DtCriacao,1,10) AS Presenca_Dia, -- Extrai a data (YYYY-MM-DD) da coluna DtCriacao
           count(*) AS QtdeInterassoes -- Conta o total de linhas (transações) para cada grupo

    FROM alunos_dia01 AS t1

    -- Juntamos com a tabela de transações para obter todas as atividades desses alunos.
    LEFT JOIN transacoes AS t2
    ON t1.IdCliente = t2.IdCliente
    -- Filtramos as transações para incluir apenas o período do curso.
    AND t2.DtCriacao >= '2025-08-25'
    AND t2.DtCriacao <= '2025-08-30'

    -- Agrupamos por aluno e por dia para que a contagem (count(*)) seja feita para cada dia de cada aluno.
    GROUP BY t1.IdCliente, substr(t2.DtCriacao,1,10)

    -- Ordenamos o resultado para melhor visualização (opcional nesta etapa).
    ORDER BY t1.IdCliente, Presenca_Dia
),

-- Terceira CTE: `tb_Ranking`
-- Objetivo: Rankear os dias de maior atividade para cada aluno.
tb_Ranking AS (

SELECT *,
       -- Usamos a função de janela ROW_NUMBER() para criar um ranking.
       -- PARTITION BY IdCliente: Reinicia a contagem do ranking para cada novo aluno.
       -- ORDER BY QtdeInterassoes DESC, Presenca_Dia: Ordena os dias de cada aluno pela quantidade de interações (da maior para a menor).
       -- Em caso de empate na quantidade de interações, o dia mais antigo (Presenca_Dia) vem primeiro.
       row_number() OVER (PARTITION BY IdCliente ORDER BY QtdeInterassoes DESC, Presenca_Dia) AS Ranking
FROM tb_dia_cliente
)

-- Consulta Final: Selecionar o resultado.
-- Filtramos a tabela ranqueada para obter apenas as linhas onde o Ranking é 1.
-- Isso nos dá, para cada aluno, o dia com o maior número de interações.
SELECT *
FROM tb_Ranking
WHERE Ranking = 1;



