-- Active: 1780006598427@@localhost@5432@projetodb_jm_leh
CREATE TYPE tipo_status_conta AS ENUM ('Ativo', 'Inativo', 'Bloqueado');
-- Primeiro execute essa linha para criar o tipo ENUM, depois execute a criação da tabela que irá utilizar esse tipo.

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email_institucional VARCHAR(150) NOT NULL UNIQUE,
    telefone VARCHAR(50) NOT NULL UNIQUE,
    periodo_atual INTEGER NOT NULL,
    status_conta tipo_status_conta NOT NULL DEFAULT 'Ativo', -- Aqui pode parecer um pouco confuso mas ele apenas chama o tipo que defini lá em cima, depois fala que ele não pode ser null, e define um falor default(base).
    id_curso INTEGER NOT NULL,
    id_campus INTEGER NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES cursos (id),
    FOREIGN KEY (id_campus) REFERENCES campus (id)
);