-- Cenário 3: Cursos, Livros e Docentes (Quarta Forma Normal - 4FN)

CREATE TABLE curso_livro_docente (
    curso VARCHAR(40),
    livro VARCHAR(80),
    docente VARCHAR(40),
    PRIMARY KEY (curso, livro, docente)
);

INSERT INTO curso_livro_docente VALUES
    ('Banco de Dados', 'Fundamentos de SQL', 'Helena'),
    ('Banco de Dados', 'Fundamentos de SQL', 'Rui'),
    ('Banco de Dados', 'Modelagem Relacional Prática', 'Helena'),
    ('Banco de Dados', 'Modelagem Relacional Prática', 'Rui'),
    ('Redes', 'Redes de Computadores', 'Marta'),
    ('Redes', 'Segurança Básica', 'Marta');

-- Decomposição em 4FN
CREATE TABLE curso_livro (
    curso VARCHAR(40),
    livro VARCHAR(80),
    PRIMARY KEY (curso, livro)
);

CREATE TABLE curso_docente (
    curso VARCHAR(40),
    docente VARCHAR(40),
    PRIMARY KEY (curso, docente)
);

INSERT INTO curso_livro SELECT DISTINCT curso, livro FROM curso_livro_docente;
INSERT INTO curso_docente SELECT DISTINCT curso, docente FROM curso_livro_docente;

-- Inserção de novo livro sem causar produto cartesiano manual
INSERT INTO curso_livro VALUES ('Banco de Dados', 'Índices na Prática');

-- Consulta de reconstrução
SELECT cl.curso, cl.livro, cd.docente
FROM curso_livro cl
JOIN curso_docente cd ON cd.curso = cl.curso
ORDER BY cl.curso, cl.livro, cd.docente;