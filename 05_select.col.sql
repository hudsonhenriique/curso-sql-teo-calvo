SELECT IdCliente,
       QtdePontos,
       QtdePontos + 10 AS PontosMaisDez,
       QtdePontos * 2 AS PontosDobro,
       DtCriacao,
       substr(DtCriacao,1,10) AS AnoMesCriacao,
       datetime(substr(DtCriacao,1,10)) AS DataCriacaoFormatada,
       strftime('%d',datetime(substr(DtCriacao,1,10))) AS DiaDoMes 
FROM clientes
LIMIT 10;