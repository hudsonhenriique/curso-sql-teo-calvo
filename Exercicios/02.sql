-- Lista de pedidos realizados no fim de semana
SELECT IdTransacao,
       DtCriacao,
       strftime('%w',datetime(substr(DtCriacao,1,10))) AS DiaSemana
FROM transacoes
WHERE strftime('%w',datetime(substr(DtCriacao,1,10))) IN ('6', '0')
LIMIT 10;


