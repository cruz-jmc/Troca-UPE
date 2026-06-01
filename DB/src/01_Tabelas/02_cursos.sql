CREATE TABLE cursos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    campus_id INTEGER NOT NULL,
    FOREIGN KEY (campus_id) REFERENCES campus (id),
    CONSTRAINT unico_curso_por_campus UNIQUE (nome, campus_id) -- Essa função garante que não haja dois cursos com o mesmo nome no mesmo campus, mas possibilita o mesmo curso com nomes iguais em campus diferentes. Especifiquei por ser uma função pouco conhecida.
);