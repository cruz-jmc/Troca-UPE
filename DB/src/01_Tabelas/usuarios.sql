-- Active: 1779383307242@@127.0.0.1@5432@projetodb_jm_leh
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email_institucional VARCHAR(150) NOT NULL UNIQUE,
    telefone VARCHAR(50) NOT NULL UNIQUE,
    periodo_atual VARCHAR(50)
);