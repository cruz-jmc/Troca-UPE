CREATE OR REPLACE PROCEDURE proc_limpar_anuncios_antigos()
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE produtos
    SET status = 'Inativo'
    WHERE status = 'Disponivel' AND data_criacao < CURRENT_TIMESTAMP - INTERVAL '180 days';
END;
$$;