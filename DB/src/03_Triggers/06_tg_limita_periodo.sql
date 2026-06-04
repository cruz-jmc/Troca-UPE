DROP TRIGGER IF EXISTS tg_valida_periodo ON usuarios;
CREATE OR REPLACE FUNCTION fn_valida_periodo_upe()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.periodo_atual < 1 OR NEW.periodo_atual > 12 THEN
        RAISE EXCEPTION 'O período atual deve estar entre 1 e 12.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_valida_periodo_upe
BEFORE INSERT OR UPDATE ON usuarios
FOR EACH ROW
EXECUTE FUNCTION fn_valida_periodo_upe();