DELETE FROM cursos;

ALTER SEQUENCE cursos_id_seq RESTART WITH 1;

INSERT INTO
    cursos (nome, id_campus)
VALUES (
        'Engenharia de Software',
        (
            SELECT id
            FROM campus
            WHERE
                nome = 'UPE - Benfica (POLI / FCAP)'
            LIMIT 1
        )
    ),
    (
        'Administração',
        (
            SELECT id
            FROM campus
            WHERE
                nome = 'UPE - Benfica (POLI / FCAP)'
            LIMIT 1
        )
    ),
    (
        'Medicina',
        (
            SELECT id
            FROM campus
            WHERE
                nome = 'UPE - Santo Amaro'
            LIMIT 1
        )
    ),
    (
        'Sistemas de Informação',
        (
            SELECT id
            FROM campus
            WHERE
                nome = 'UPE - Caruaru'
            LIMIT 1
        )
    ),
    (
        'Engenharia de Software',
        (
            SELECT id
            FROM campus
            WHERE
                nome = 'UPE - Garanhuns'
            LIMIT 1
        )
    ),
    (
        'Engenharia de Software',
        (
            SELECT id
            FROM campus
            WHERE
                nome = 'UPE - Campus Petrolina'
            LIMIT 1
        )
    );