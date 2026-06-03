-- Active: 1779383307242@@127.0.0.1@5432@projetodb_jm_leh
CREATE VIEW vw_usuarios_bloqueados AS
SELECT
    id,
    nome,
    email_institucional,
    telefone
FROM usuarios
WHERE
    status_conta = 'Bloqueado';