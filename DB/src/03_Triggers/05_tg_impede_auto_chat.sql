-- Active: 1780006598427@@localhost@5432@projetodb_jm_leh

CREATE OR REPLACE FUNCTION fn_impede_auto_chat()
RETURNS TRIGGER AS $$
DECLARE
    v_id_anunciante INTEGER;
BEGIN
    SELECT id_anunciante INTO v_id_anunciante
    FROM produtos
    WHERE id = NEW.id_produto;

    IF v_id_anunciante = NEW.id_interessado THEN
        RAISE EXCEPTION 'Usuário não pode iniciar um chat consigo mesmo.';
    
    END IF;
    RETURN NEW;
END; 
$$ LANGUAGE plpgsql;


CREATE TRIGGER tg_impede_auto_chat
BEFORE INSERT ON chats
FOR EACH ROW
EXECUTE FUNCTION fn_impede_auto_chat();
