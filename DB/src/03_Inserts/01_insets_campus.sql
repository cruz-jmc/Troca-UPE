
DELETE FROM cursos;

ALTER SEQUENCE cursos_id_seq RESTART WITH 1;

INSERT INTO cursos (nome, id_campus) VALUES
('Engenharia da Computação', (SELECT id FROM campus WHERE nome = 'UPE - Campus Benfica' LIMIT 1)), -- ID 1
('Sistemas de Informação', (SELECT id FROM campus WHERE nome = 'UPE - Campus Benfica' LIMIT 1)),   -- ID 2
('Direito', (SELECT id FROM campus WHERE nome = 'UPE - Campus Benfica' LIMIT 1)),                  -- ID 3
('Administração', (SELECT id FROM campus WHERE nome = 'UPE - Campus Benfica' LIMIT 1)),            -- ID 4
('Medicina', (SELECT id FROM campus WHERE nome = 'UPE - Campus Petrolina' LIMIT 1)),               -- ID 5
('Odontologia', (SELECT id FROM campus WHERE nome = 'UPE - Campus Camaragibe' LIMIT 1));           -- ID 6