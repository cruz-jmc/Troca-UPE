-- Limpa a tabela de chats e reseta o ID SERIAL
DELETE FROM chats;
ALTER SEQUENCE chats_id_seq RESTART WITH 1;

INSERT INTO chats (id_produto, id_interessado) VALUES
(1, 1), -- Letícia (ID 1) interessada no Livro do João (Produto 1)
(3, 2), -- João (ID 2) interessado no Frigobar do Lucas (Produto 3)
(5, 1); -- Letícia (ID 1) interessada no Estetoscópio da Mariana (Produto 5)