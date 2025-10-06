-- DROP TABLE IF EXISTS clientes_d28;

CREATE TABLE IF NOT EXISTS clientes_d28 (
    IdCliente varchar(250) PRIMARY KEY,
    QtdeTransacoes INTEGER
);

DELETE FROM clientes_d28;

INSERT INTO clientes_d28
SELECT IdCliente,
       count(DISTINCT IdTransacao) AS QtdeTransacoes
FROM transacoes
WHERE julianday('2025-08-30') - julianday(substr(DtCriacao,1,10)) <= 28
GROUP BY IdCliente;

SELECT * FROM clientes_d28;


