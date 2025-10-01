-- Qual dia da semana tem mais pedidos em 2025?

SELECT strftime('%w',substr(DtCriacao, 1, 10)) AS DiaSemana,
       count(DISTINCT IdTransacao) AS TotalPedidos,
    -- Formas diferentes de contar registros, porém o resultado é o mesmo
    -- Pois IdTransacao é a chave unica da tabela
       count(IdTransacao) AS TotalPedidos2,
       count(*) AS TotalPedidos3
       

FROM transacoes

WHERE substr(DtCriacao, 1, 4) = '2025'

GROUP BY 1
ORDER BY 2 DESC;