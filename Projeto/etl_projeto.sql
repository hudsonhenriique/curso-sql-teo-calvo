-- Vamos construir uma tabela com o perfil comportamental dos nossos usuários.
-- Quantidade de transações históricas (vida, D7, D14, D28, D56);
-- Dias desde a última transação
-- Idade na base
-- Produto mais usado (vida, D7, D14, D28, D56);
-- Saldo de pontos atual;
-- Pontos acumulados positivos (vida, D7, D14, D28, D56);
-- Pontos acumulados negativos (vida, D7, D14, D28, D56);
-- Dias da semana mais ativos (D28)
-- Período do dia mais ativo (D28)
-- Engajamento em D28 versus Vida

WITH tb_transacoes AS (
    SELECT IdTransacao,
           IdCliente,
           QtdePontos,
           datetime(substr(DtCriacao,1,19)) AS DtCriacao,
           julianday('now') - julianday(substr(DtCriacao,1,10)) AS diffDate
    FROM transacoes
),

tb_clientes AS (
    SELECT IdCliente,
           datetime(substr(DtCriacao,1,19)) AS DtCriacao,
           julianday('now') - julianday(substr(DtCriacao,1,10)) AS idadeBase
    FROM clientes
),

tb_sumario_transacoes AS (
    SELECT IdCliente,
        count(IdTransacao) AS qtdeTransacoesVida,
        count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtdeTransacoes56,
        count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS qtdeTransacoes28,
        count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS qtdeTransacoes14,
        count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS qtdeTransacoes7,
        min(diffDate) AS diasUltimaInteração

    FROM tb_transacoes
    GROUP BY IdCliente
)

SELECT t1.*,
       t2.idadeBase

FROM tb_sumario_transacoes AS t1

LEFT JOIN tb_clientes AS t2
ON t1.IdCliente = t2.IdCliente
