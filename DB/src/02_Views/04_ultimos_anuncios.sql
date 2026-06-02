-- Active: 1780006598427@@localhost@5432@projetodb_jm_leh
CREATE OR REPLACE VIEW vw_ultimos_anuncios AS
SELECT id, nome, descricao, preco, categoria, condicao, status, data_criacao, data_atualizacao
FROM produtos
WHERE data_criacao >= CURRENT_TIMESTAMP - INTERVAL '24 hours'
    AND status = 'Disponivel';