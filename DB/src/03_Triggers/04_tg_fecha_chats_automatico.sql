-- Active: 1779383307242@@127.0.0.1@5432@projetodb_jm_leh
CREATE OR REPLACE FUNCTION fn_fecha_chats_produto_vendido()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status <> 'Trocado/Vendido' AND NEW.status = 'Trocado/Vendido' THEN
       UPDATE chats
       SET status = 'Fechado'::status_chat
       WHERE id = NEW.id_produto AND status = 'Aberto' :: status_chat;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_fecha_chats_automatico
AFTER UPDATE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_fecha_chats_produto_vendido();