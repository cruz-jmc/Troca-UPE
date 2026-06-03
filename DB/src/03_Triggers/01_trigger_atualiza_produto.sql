-- Primeiro temos que criar a função que define a ação de atualizar a data.
CREATE OR REPLACE FUNCTION fn_atualizar_data_alteracao_produto()
RETURNS TRIGGER AS $$
BEGIN
    -- O NEW representa a linha que está sendo atualizada com os novos dados.
    NEW.data_atualizacao = CURRENT_TIMESTAMP;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Agora criamos a Trigger que dispara a função sempre que houver um update na tabela produtos.
CREATE TRIGGER tg_atualiza_data_produto
BEFORE UPDATE ON produtos -- Esse BEFORE UPDATE indica que a Trigger será executada antes da atualização dos dados.
FOR EACH ROW -- Esse FOR EACH ROW indica que a Trigger será executada para cada linha que for atualizada.
EXECUTE FUNCTION fn_atualizar_data_alteracao_produto();