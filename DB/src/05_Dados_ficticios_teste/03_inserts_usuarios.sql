DELETE FROM usuarios;

ALTER SEQUENCE usuarios_id_seq RESTART WITH 1;

INSERT INTO
    usuarios (
        nome,
        email_institucional,
        telefone,
        periodo_atual,
        status_conta,
        id_curso,
        id_campus
    )
VALUES (
        'Letícia Abreu',
        'leticia.abreu@upe.br',
        '81999991111',
        4,
        'Ativo',
        (
            SELECT id
            FROM cursos
            WHERE
                nome = 'Engenharia de Software'
                AND id_campus = (
                    SELECT id
                    FROM campus
                    WHERE
                        nome = 'UPE - Benfica (POLI / FCAP)'
                )
            LIMIT 1
        ),
        (
            SELECT id
            FROM campus
            WHERE
                nome = 'UPE - Benfica (POLI / FCAP)'
        )
    ),
    (
        'João Marcelo',
        'joao.cruz@upe.br',
        '81999992222',
        4,
        'Ativo',
        (
            SELECT id
            FROM cursos
            WHERE
                nome = 'Engenharia de Software'
                AND id_campus = (
                    SELECT id
                    FROM campus
                    WHERE
                        nome = 'UPE - Benfica (POLI / FCAP)'
                )
            LIMIT 1
        ),
        (
            SELECT id
            FROM campus
            WHERE
                nome = 'UPE - Benfica (POLI / FCAP)'
        )
    ),
    (
        'Lucas Silva',
        'lucas.silva@upe.br',
        '81999993333',
        2,
        'Ativo',
        (
            SELECT id
            FROM cursos
            WHERE
                nome = 'Administração'
                AND id_campus = (
                    SELECT id
                    FROM campus
                    WHERE
                        nome = 'UPE - Benfica (POLI / FCAP)'
                )
            LIMIT 1
        ),
        (
            SELECT id
            FROM campus
            WHERE
                nome = 'UPE - Benfica (POLI / FCAP)'
        )
    );