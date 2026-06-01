-- Aqui vamos criar uma tabela para armazenar cada mensagem enviada dentro de um chat. Cada mensagem estará associada a um chat específico, e também terá informações sobre o remetente e o conteúdo da mensagem.

CREATE TABLE mensagens (
    id SERIAL PRIMARY KEY,
    texto TEXT NOT NULL,
    enviado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_chat INT NOT NULL,
    FOREIGN KEY (id_chat) REFERENCES chats (id) ON DELETE CASCADE,
    id_remetente INT NOT NULL,
    FOREIGN KEY (id_remetente) REFERENCES usuarios (id) ON DELETE CASCADE
);