-- Active: 1779383307242@@127.0.0.1@5432@db_troca_upe
CREATE OR REPLACE PROCEDURE proc_limpar_anuncios_antigos()
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE produtos
    SET status = 'inativo'
    WHERE status = 'Disponivel' AND data_criacao < CURRENT_TIMESTAMP - INTERVAL '180 days';
END;
$$;