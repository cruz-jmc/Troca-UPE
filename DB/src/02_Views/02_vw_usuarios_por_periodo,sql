-- Permite filtrar rapidamente os alunos do mesmo campus e do mesmo período letivo numérico
CREATE OR REPLACE VIEW vw_usuarios_por_periodo AS
SELECT
    u.id AS usuario_id,
    u.nome AS usuario_nome,
    u.email_institucional AS usuario_email_institucional,
    u.periodo_atual AS usuario_periodo_atual,
    cur.nome AS curso_nome,
    c.nome AS campus_nome
FROM
    usuarios u
    JOIN cursos cur ON u.id_curso = cur.id
    JOIN campus c ON u.id_campus = c.id;