DELETE FROM produtos;

ALTER SEQUENCE produtos_id_seq RESTART WITH 1;

INSERT INTO
    produtos (
        nome,
        descricao,
        preco,
        categoria,
        condicao,
        status,
        id_anunciante
    )
VALUES (
        'Livro Cálculo 1 - Guidorizzi',
        'Livro em ótimo estado, poucas rasuras nas margens.',
        50.00,
        'Livros',
        'Usado (Otimo Estado)',
        'Disponivel',
        (
            SELECT id
            FROM usuarios
            WHERE
                email_institucional = 'joao.cruz@upe.br'
        )
    ),
    (
        'Vade Mecum Direito 2026',
        'Anual de Direito para as matérias deste ano, capa dura.',
        140.00,
        'Livros',
        'Novo',
        'Disponivel',
        (
            SELECT id
            FROM usuarios
            WHERE
                email_institucional = 'leticia.abreu@upe.br'
        )
    ),
    (
        'Mini Frigobar Midea 45L',
        'Perfeito para o quarto do alojamento estudantil. 220v.',
        400.00,
        'Eletrodomesticos',
        'Novo',
        'Disponivel', -- Alterado de Eletronicos para Eletrodomesticos
        (
            SELECT id
            FROM usuarios
            WHERE
                email_institucional = 'lucas.silva@upe.br'
        )
    );