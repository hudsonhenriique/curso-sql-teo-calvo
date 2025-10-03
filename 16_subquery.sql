-- Exibe as primeiras 10 transações criadas entre 1º de janeiro de 2025 e 1º de julho de 2025 usando subquery

SELECT *

FROM (

    SELECT *

    FROM transacoes AS t1

    WHERE DtCriacao >= '2025-01-01'
)

WHERE DtCriacao < '2025-07-01'

LIMIT 10;