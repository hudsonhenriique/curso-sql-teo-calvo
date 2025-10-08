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

        sum(QtdePontos) AS saldoPontos,

        min(diffDate) AS diasUltimaInteração,

        sum(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS saldoPontosPositivo,
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 56 THEN QtdePontos ELSE 0 END) AS QtdePontosPos56,
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 28 THEN QtdePontos ELSE 0 END) AS QtdePontosPos28,
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 14 THEN QtdePontos ELSE 0 END) AS QtdePontosPos14,
        sum(CASE WHEN QtdePontos > 0 AND diffDate <=  7 THEN QtdePontos ELSE 0 END) AS QtdePontosPos7,

        sum(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS saldoPontosNegativo,
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 56 THEN QtdePontos ELSE 0 END) AS QtdePontosNeg56,
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 28 THEN QtdePontos ELSE 0 END) AS QtdePontosNeg28,
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 14 THEN QtdePontos ELSE 0 END) AS QtdePontosNeg14,
        sum(CASE WHEN QtdePontos < 0 AND diffDate <=  7 THEN QtdePontos ELSE 0 END) AS QtdePontosNeg7

    FROM tb_transacoes
    GROUP BY IdCliente
),

tb_transacao_produto AS (
    SELECT t1.*,
        t3.DescProduto,
        t3.DescCateogriaProduto

    FROM tb_transacoes AS t1

    LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao

    LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto
),

tb_cliente_produto AS (
    SELECT IdCliente,
        DescProduto,
        count(*) AS qtdeVida,
        count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS qtde56,
        count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS qtde28,
        count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS qtde14,
        count(CASE WHEN diffDate <=  7 THEN IdTransacao END) AS qtde7

    FROM tb_transacao_produto
    GROUP BY IdCliente, DescProduto
),

tb_cliente_produto_rn AS (
    SELECT *,
           row_number() OVER (PARTITION BY IdCliente ORDER BY qtdeVida DESC) AS rnVida,
           row_number() OVER (PARTITION BY IdCliente ORDER BY qtde56 DESC) AS rn56,
           row_number() OVER (PARTITION BY IdCliente ORDER BY qtde28 DESC) AS rn28,
           row_number() OVER (PARTITION BY IdCliente ORDER BY qtde14 DESC) AS rn14,
           row_number() OVER (PARTITION BY IdCliente ORDER BY qtde7 DESC) AS rn7
    FROM tb_cliente_produto
),

tb_join AS (
    SELECT t1.*,
           t2.idadeBase,
           t3.DescProduto AS produtoMaisUsadoVida,
           t4.DescProduto AS produtoMaisUsado56,
           t5.DescProduto AS produtoMaisUsado28,
           t6.DescProduto AS produtoMaisUsado14,
           t7.DescProduto AS produtoMaisUsado7

    FROM tb_sumario_transacoes AS t1

    LEFT JOIN tb_clientes AS t2
    ON t1.IdCliente = t2.IdCliente

    LEFT JOIN tb_cliente_produto_rn AS t3
    ON t1.IdCliente = t3.IdCliente
    AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn AS t4
    ON t1.IdCliente = t3.IdCliente
    AND t4.rn56 = 1

    LEFT JOIN tb_cliente_produto_rn AS t5
    ON t1.IdCliente = t3.IdCliente
    AND t5.rn28 = 1

    LEFT JOIN tb_cliente_produto_rn AS t6
    ON t1.IdCliente = t3.IdCliente
    AND t6.rn14 = 1

    LEFT JOIN tb_cliente_produto_rn AS t7
    ON t1.IdCliente = t3.IdCliente
    AND t7.rn7 = 1
),

tb_cliente_dia AS (
    SELECT IdCliente,
        strftime('%w',DtCriacao) AS dtDia,
        count(*) AS qtdeTransacoes
    FROM tb_transacoes
    WHERE diffDate <= 28
    GROUP BY IdCliente,dtDia
),

tb_cliente_dia_rn AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtdeTransacoes DESC) AS rnDia

    FROM tb_cliente_dia
)

