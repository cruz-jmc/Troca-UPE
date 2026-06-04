-- Active: 1779383307242@@127.0.0.1@5432@projetodb_jm_leh
-- Espaço destinado para consultas SQL. Utilize este arquivo para escrever e organizar suas consultas de banco de dados. Certifique-se de testar suas consultas antes de executá-las em um ambiente de produção.
ALTER TYPE tipo_status_produto ADD VALUE 'Inativo';
-- 1. Remove o tipo antigo se ele estiver flutuando no banco
DROP TYPE IF EXISTS status_chat CASCADE;

-- 2. Cria o tipo com as opções corretas do Chat (ajuste os textos se necessário)
CREATE TYPE status_chat AS ENUM ('Aberto', 'Fechado');

-- 3. Adiciona a coluna na tabela de chats usando o tipo novo
ALTER TABLE chats 
ADD COLUMN status status_chat;