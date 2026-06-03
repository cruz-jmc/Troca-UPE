-- Gera dados estatísticos de quantos anúncios ativos existem por Campus da UPE

CREATE OR REPLACE VIEW vw_ranking_campi_ativos AS
SELECT
    c.nome AS campus_nome,
    c.cidade AS campus_cidade,
    COUNT(p.id) AS total_anuncios_ativos
FROM
    campus c
    JOIN usuarios u ON u.id_campus = c.id
    JOIN produtos p ON p.id_anunciante = u.id
WHERE
    p.status = 'Disponivel'
GROUP BY
    c.id,
    c.nome,
    c.cidade
ORDER BY total_anuncios_ativos DESC;