------------------------------------------------------------------------------
-- Trigger para calcular fecha_termino al hacer INSERT en prestacion_emp
CREATE OR REPLACE TRIGGER trigger_prestacion_emp
    BEFORE INSERT
    ON prestacion_emp
    FOR EACH ROW
    EXECUTE PROCEDURE insert_prestacion_emp();

CREATE OR REPLACE FUNCTION insert_prestacion_emp()
    RETURNS trigger AS
    $$
    DECLARE duracion INTEGER;
    BEGIN
            SELECT duracion_dias INTO duracion 
                FROM prestacion WHERE id_prestacion = NEW.prestacion_id - 1 ;
            NEW.fecha_termino := NEW.fecha_inicio + duracion;
        RETURN NEW;
    END;
    $$
    LANGUAGE 'plpgsql';