DELETE FROM chats;

ALTER SEQUENCE chats_id_seq RESTART WITH 1;

INSERT INTO
    chats (id_produto, id_interessado)
VALUES (
        (
            SELECT id
            FROM produtos
            WHERE
                nome = 'Livro Cálculo 1 - Guidorizzi'
            LIMIT 1
        ),
        (
            SELECT id
            FROM usuarios
            WHERE
                email_institucional = 'leticia.abreu@upe.br'
            LIMIT 1
        )
    );