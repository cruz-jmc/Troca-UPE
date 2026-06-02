-- Active: 1780006598427@@localhost@5432@projetodb_jm_leh
CREATE TABLE campus (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    cidade VARCHAR(50) NOT NULL
);