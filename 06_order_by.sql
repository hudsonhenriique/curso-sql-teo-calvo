SELECT * 
FROM clientes
ORDER BY QtdePontos DESC
LiMIT 10;

SELECT *
FROM clientes
WHERE FlTwitch = 1
ORDER BY DtCriacao ASC, QtdePontos DESC
LIMIT 10;