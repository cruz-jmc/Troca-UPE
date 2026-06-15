DELETE FROM campus;

ALTER SEQUENCE campus_id_seq RESTART WITH 1;

INSERT INTO
    campus (nome, cidade)
VALUES (
        'UPE - Benfica (POLI / FCAP)',
        'Recife'
    ),
    ('UPE - Santo Amaro', 'Recife'),
    ('UPE - Caruaru', 'Caruaru'),
    (
        'UPE - Garanhuns',
        'Garanhuns'
    ),
    (
        'UPE - Campus Petrolina',
        'Petrolina'
    );