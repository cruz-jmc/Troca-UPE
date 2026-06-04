CREATE OR REPLACE PROCEDURE proc_concluir_negociacao(
    p_id_produto INT
)
LANGUAGE plpgsql AS $$
BEGIN
    -- Aqui ele atualiza o status do produto para tirá-lo do catálogo ativo
    UPDATE produtos 
    SET status = 'Trocado/Vendido' 
    WHERE id = p_id_produto;

    -- Se o produto não existir ou já tiver sido alterado, emitimos um aviso
    IF NOT FOUND THEN
        RAISE NOTICE 'Produto com ID % não foi encontrado ou já foi atualizado.', p_id_produto;
    END IF;

    -- Como é uma Procedure, nós confirmamos as alterações na transação de forma explícita
    COMMIT;
END;
$$;