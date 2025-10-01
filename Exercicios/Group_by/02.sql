-- Quantos clientes tem email cadastrado?

-- SELECT count(*)
-- FROM clientes
-- WHERE flEmail = 1;

SELECT sum(flEmail)
FROM clientes
