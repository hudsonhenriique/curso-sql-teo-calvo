SELECT round(avg(QtdePontos),2) AS Media_Carteira,
       min(QtdePontos) AS Min_Carteira,
       max(QtdePontos) AS Max_Carteira,
       sum(FlTwitch) AS Total_Twitch,
       sum(FlEmail) AS Total_Email

FROM clientes