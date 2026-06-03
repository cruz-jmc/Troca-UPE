-- Trigger para bloquear mensagens em chats de produtos que já foram vendidos ou trocados

CREATE OR REPLACE FUNCTION fn_bloquear_mensagem_produto_vendido()
RETURNS TRIGGER AS $$
DECLARE
    v_status_produto VARCHAR; -- Variável para guardar o status temporariamente
BEGIN
    -- Buscamos o status do produto subindo o relacionamento: Mensagem -> Chat -> Produto
    SELECT p.status INTO v_status_produto
    FROM chats ch
    JOIN produtos p ON ch.id_produto = p.id
    WHERE ch.id = NEW.id_chat; -- NEW.id_chat pega o ID do chat onde a mensagem tenta entrar.

    -- Se o produto já foi vendido ou trocado, interrompe-se a operação e lança uma exceção.
    IF v_status_produto = 'Trocado/Vendido' THEN
        RAISE EXCEPTION 'Operação Bloqueada: Não é possível enviar mensagens em um chat de produto já negociado!';
    END IF;

    -- Se estiver tudo certo ('Disponivel'), a mensagem passa normalmente
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_bloqueia_mensagem_produto_vendido
BEFORE INSERT ON mensagens
FOR EACH ROW
EXECUTE FUNCTION fn_bloquear_mensagem_produto_vendido();