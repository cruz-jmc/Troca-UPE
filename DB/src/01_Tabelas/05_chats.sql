-- Active: 1780006598427@@localhost@5432@projetodb_jm_leh
CREATE TABLE chats (
    id SERIAL PRIMARY KEY,
    data_abertura TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_produto INTEGER NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos (id) ON DELETE CASCADE,
    id_interessado INTEGER NOT NULL,
    FOREIGN KEY (id_interessado) REFERENCES usuarios (id) ON DELETE CASCADE,
    CONSTRAINT unique_chat UNIQUE (id_produto, id_interessado) -- Garante que um usuário só possa iniciar um chat por produto, isso impede caso um interessado tente iniciar múltiplos chats para o mesmo produto.
);