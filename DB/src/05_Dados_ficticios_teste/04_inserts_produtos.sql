-- Limpa a tabela de produtos e reseta o ID SERIAL
DELETE FROM produtos;
ALTER SEQUENCE produtos_id_seq RESTART WITH 1;

INSERT INTO produtos (nome, descricao, preco, categoria, condicao, status, id_anunciante) VALUES
('Livro Cálculo 1 - Guidorizzi', 'Livro em ótimo estado, poucas rasuras nas margens.', 50.00, 'Livros', 'Usado (Otimo Estado)', 'Disponivel', 2),
('Vade Mecum Direito 2026', 'Anual de Direito para as matérias deste ano, capa dura.', 140.00, 'Material Escolar', 'Novo', 'Disponivel', 1),
('Mini Frigobar Midea 45L', 'Perfeito para o quarto do alojamento estudantil. 220v.', 400.00, 'Eletrodomesticos', 'Semi-novo', 'Disponivel', 3),
('Escrivaninha de Madeira', 'Marcas normais de copo na mesa, mas super firme.', 90.00, 'Moveis', 'Usado (Marcas de Uso)', 'Trocado/Vendido', 2),
('Estetoscópio Littmann', 'Usado apenas no ciclo básico de medicina, impecável.', 350.00, 'Outros', 'Usado (Otimo Estado)', 'Disponivel', 4);