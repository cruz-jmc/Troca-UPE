-- Active: 1779383307242@@127.0.0.1@5432@db_troca_upe
CREATE OR REPLACE FUNCTION fn_fecha_chats_produto_vendido()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o produto mudou para vendido
    IF OLD.status <> 'Trocado/Vendido' AND NEW.status = 'Trocado/Vendido' THEN
       
       -- Atualiza os chats abertos daquele produto específico
       UPDATE chats
       SET status = 'Fechado'
       WHERE id_produto = NEW.id AND status = 'Aberto';
       
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_fecha_chats_automatico
AFTER UPDATE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_fecha_chats_produto_vendido();