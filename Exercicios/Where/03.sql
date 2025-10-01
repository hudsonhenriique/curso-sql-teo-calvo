-- Lista de clientes com 0 pontos
SELECT Idcliente,
       QtdePontos
FROM clientes
WHERE QtdePontos = 0;