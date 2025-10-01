-- Listar todas as transações adicionanso ma coluna nova sinalizando
--"alto", "médio" e "baixo" para a quantidade de pontos [<10;<500;>=500]
SELECT
       IdTransacao,
       QtdePontos,

       CASE
            WHEN QtdePontos < 10 THEN 'Baixo'
            WHEN QtdePontos < 500 THEN 'Médio'
            ELSE 'Alto'
       END AS FlQtdePontos 

FROM transacoes

ORDER BY QtdePontos DESC