-- Limpa a tabela de mensagens e reseta o ID SERIAL
DELETE FROM mensagens;
ALTER SEQUENCE mensagens_id_seq RESTART WITH 1;

INSERT INTO mensagens (id_chat, id_remetente, texto) VALUES
(1, 1, 'Oi João, tudo bem? O livro de Cálculo ainda está disponível?'),
(1, 2, 'Opa Letícia! Está sim, posso levar amanhã para o bloco de Engenharia.'),
(1, 1, 'Perfeito! Me encontra na hora do intervalo do almoço?'),
(2, 2, 'Olá Lucas, aceita 350 no frigobar? busco aí no alojamento.'),
(2, 3, 'Fala João! Se venir buscar hoje à noite, eu fecho por 350 sim!');