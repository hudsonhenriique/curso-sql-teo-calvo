-- Selecione todos os clientes com mais de 500 pontos
SELECT IdCliente,
       QtdePontos
FROM clientes 
WHERE QtdePontos >= 500
LIMIT 10;