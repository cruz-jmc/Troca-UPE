DELETE FROM mensagens;

ALTER SEQUENCE mensagens_id_seq RESTART WITH 1;

INSERT INTO
    mensagens (id_chat, id_remetente, texto)
VALUES (
        1,
        (
            SELECT id
            FROM usuarios
            WHERE
                email_institucional = 'leticia.abreu@upe.br'
            LIMIT 1
        ),
        'Oi João, tudo bem? O livro de Cálculo ainda está disponível?'
    ),
    (
        1,
        (
            SELECT id
            FROM usuarios
            WHERE
                email_institucional = 'joao.cruz@upe.br'
            LIMIT 1
        ),
        'Opa Letícia! Está sim, posso levar amanhã para o bloco de Engenharia.'
    );