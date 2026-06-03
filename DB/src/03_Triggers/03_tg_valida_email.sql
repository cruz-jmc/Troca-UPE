CREATE OR REPLACE FUNCTION fn_valida_email_institucional()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.email_institucional NOT LIKE '%@upe.br' THEN
        RAISE EXCEPTION 'Email inválido. Por favor, utilize um email institucional.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_valida_email_institucional
BEFORE INSERT OR UPDATE ON usuarios
FOR EACH ROW
EXECUTE FUNCTION fn_valida_email_institucional();