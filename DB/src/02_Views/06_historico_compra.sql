-- Active: 1780006598427@@localhost@5432@projetodb_jm_leh
CREATE OR REPLACE VIEW vw_historico_conversa AS
SELECT 
     chats.id, 
     produtos.nome, 
     usuarios.nome AS mome_vendedor, 
     comprador.nome AS nome_comprador
FROM produtos
INNER JOIN chats ON produtos.id = chats.id_produto
INNER JOIN usuarios ON produtos.id_anunciante = usuarios.id
INNER JOIN usuarios comprador ON chats.id_interessado = usuarios.id;

