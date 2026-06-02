-- Limpa os usuários antigos antes de inserir
DELETE FROM usuarios;
ALTER SEQUENCE usuarios_id_seq RESTART WITH 1;

INSERT INTO usuarios (nome, email_institucional, telefone, periodo_atual, status_conta, id_curso, id_campus) VALUES
('Letícia Abreu', 'leticia.abreu@upe.br', '81999991111', 4, 'Ativo', 1, (SELECT id FROM campus WHERE nome = 'UPE - Campus Benfica' LIMIT 1)),
('João Marcelo', 'joao.cruz@upe.br', '81999992222', 4, 'Ativo', 1, (SELECT id FROM campus WHERE nome = 'UPE - Campus Benfica' LIMIT 1)),
('Lucas Silva', 'lucas.silva@upe.br', '81999993333', 2, 'Ativo', 2, (SELECT id FROM campus WHERE nome = 'UPE - Campus Benfica' LIMIT 1)),
('Mariana Costa', 'mariana.costa@upe.br', '87988885555', 6, 'Ativo', 5, (SELECT id FROM campus WHERE nome = 'UPE - Campus Petrolina' LIMIT 1)),
('Aluno Spam', 'spam.aluno@upe.br', '81999994444', 1, 'Bloqueado', 3, (SELECT id FROM campus WHERE nome = 'UPE - Campus Benfica' LIMIT 1));