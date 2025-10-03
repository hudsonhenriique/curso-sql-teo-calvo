-- Clientes mais antigos, tem mais frequ^qncia de transações?

SELECT t1.IdCliente,
       julianday('now') - julianday(substr(t1.DtCriacao, 1,19)) AS DiasDesdeCriacao,
       count(t2.IdTransacao) AS TotalTransacoes

FROM clientes AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente

GROUP BY t1.IdCliente,
         DiasDesdeCriacao