-- Active: 1779383307242@@127.0.0.1@5432@projetodb_jm_leh
CREATE OR REPLACE VIEW vw_demanda_por_categoria AS
SELECT
    categoria,
    COUNT(categoria) AS qtd_categoria,
    AVG(preco) AS preco_medio
FROM produtos
GROUP BY
    categoria;