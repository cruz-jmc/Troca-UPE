-- Active: 1780006598427@@localhost@5432@projetodb_jm_leh
CREATE TYPE tipo_categoria_produto AS ENUM ('Livros', 'Eletrodomesticos', 'Moveis', 'Material Escolar', 'Outros');

CREATE TYPE tipo_condicao_produto AS ENUM ('Novo', 'Semi-novo', 'Usado (Otimo Estado)', 'Usado (Marcas de Uso)');

CREATE TYPE tipo_status_produto AS ENUM ('Disponivel', 'Reservado', 'Trocado/Vendido', 'inativo');
-- Esses tipos ENUM foram criados para garantir a integridade dos dados e facilitar a manutenção do banco de dados. (igual eu fiz no status_conta de usuarios)

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    categoria tipo_categoria_produto NOT NULL,
    condicao tipo_condicao_produto NOT NULL,
    status tipo_status_produto NOT NULL DEFAULT 'Disponivel',
    data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Essas funções diferenciadas servem para garantir que a data de criação seja registrada apenas no momento da inserção do produto, enquanto a data de atualização seja atualizada automaticamente sempre que o produto for modificado.
    id_anunciante INTEGER NOT NULL,
    FOREIGN KEY (id_anunciante) REFERENCES usuarios (id) ON DELETE CASCADE -- Esse "ON DELETE CASCADE" garante que, se um usuário for deletado, todos os produtos associados a ele também serão deletados automaticamente, mantendo a integridade referencial do banco de dados.
);
-- Faço essas anotações apenas nessas funções mais incomuns para explicar o motivo de cada escolha, mas em geral, a estrutura da tabela é bastante direta e segue as melhores práticas de design de banco de dados.