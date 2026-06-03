-- 1. Criamos a função que define a ação de atualizar a data
CREATE OR REPLACE FUNCTION fn_atualizar_data_alteracao_produto()
RETURNS TRIGGER AS $$
BEGIN
    -- NEW representa a linha que está sendo atualizada com os novos dados
    NEW.data_atualizacao = CURRENT_TIMESTAMP;
    
    -- Retorna a linha modificada para o banco prosseguir com o salvamento
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Criamos o gatilho que dispara a função SEMPRE que houver um UPDATE
CREATE TRIGGER tg_atualiza_data_produto
BEFORE UPDATE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_data_alteracao_produto();