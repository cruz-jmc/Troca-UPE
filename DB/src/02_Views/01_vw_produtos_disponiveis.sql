-- Active: 1779383307242@@127.0.0.1@5432@projetodb_jm_leh
-- Facilita a listagem na tela inicial do app, trazendo os dados do anunciante e local de uma vez

CREATE OR REPLACE VIEW vw_produtos_disponiveis AS
SELECT
    p.id AS produto_id,
    p.nome AS produto_nome,
    p.descricao AS produto_descricao,
    p.preco AS produto_preco,
    p.categoria AS produto_categoria,
    p.condicao AS produto_condicao,
    p.data_criacao AS produto_data_criacao,
    u.nome AS anunciante_nome,
    c.nome AS campus_nome,
    cur.nome AS curso_nome
FROM
    produtos p
    JOIN usuarios u ON p.id_anunciante = u.id
    JOIN campus c ON u.id_campus = c.id
    JOIN cursos cur ON u.id_curso = cur.id
WHERE
    p.status = 'Disponivel';