-- Active: 1779383307242@@127.0.0.1@5432@projetodb_jm_leh
-- Calcula o total de dinheiro economizado pelos alunos através de trocas/vendas concluídas

CREATE OR REPLACE VIEW vw_metrica_economia_comunidade AS
SELECT
    COUNT(*) AS total_itens_negociados,
    COALESCE(SUM(preco), 0.00) AS total_economia_gerada
FROM produtos
WHERE
    status = 'Trocado/Vendido';