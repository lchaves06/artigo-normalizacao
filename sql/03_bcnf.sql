-- Cenário 2: Escola de Idiomas (BCNF e Validação via Trigger no PostgreSQL 16)

CREATE TABLE aula_3fn (
    aluno VARCHAR(40),
    disciplina VARCHAR(40),
    professor VARCHAR(40),
    PRIMARY KEY (aluno, disciplina)
);

INSERT INTO aula_3fn VALUES
    ('Carla', 'Inglês', 'Marcos'),
    ('Diego', 'Inglês', 'Marcos'),
    ('Carla', 'Espanhol', 'Lúcia'),
    ('Eva', 'Espanhol', 'Lúcia');

-- Decomposição BCNF
CREATE TABLE professor_disciplina (
    professor VARCHAR(40) PRIMARY KEY,
    disciplina VARCHAR(40) NOT NULL
);

CREATE TABLE matricula (
    aluno VARCHAR(40),
    professor VARCHAR(40) REFERENCES professor_disciplina (professor),
    PRIMARY KEY (aluno, professor)
);

INSERT INTO professor_disciplina
SELECT DISTINCT professor, disciplina FROM aula_3fn;

INSERT INTO matricula
SELECT aluno, professor FROM aula_3fn;

-- Função e Trigger para preservar a regra "um professor por disciplina para cada aluno"
CREATE OR REPLACE FUNCTION valida_professor_unico() RETURNS trigger AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM matricula m
        JOIN professor_disciplina atual ON atual.professor = m.professor
        JOIN professor_disciplina novo ON novo.professor = NEW.professor
        WHERE m.aluno = NEW.aluno
          AND atual.disciplina = novo.disciplina
          AND m.professor <> NEW.professor
    ) THEN
        RAISE EXCEPTION 'O aluno % já possui professor cadastrado nessa disciplina.', NEW.aluno;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_professor_unico
BEFORE INSERT ON matricula
FOR EACH ROW EXECUTE FUNCTION valida_professor_unico();

INSERT INTO professor_disciplina VALUES ('Paulo', 'Inglês');

-- NOTA: A linha abaixo deve FALHAR de propósito para demonstrar o funcionamento da trigger
-- INSERT INTO matricula VALUES ('Diego', 'Paulo');