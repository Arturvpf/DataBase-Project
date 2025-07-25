--Creating tables

CREATE TABLE UNIVERSIDADE (
    id_universidade INT PRIMARY KEY,
    nome VARCHAR(255),
    sigla VARCHAR(20),
    endereco_CEP VARCHAR(10),
    endereco_logradouro VARCHAR(255)
);
CREATE TABLE CADEIRA (
    id_cadeira INT,
    fk_universidade INT,
    nome VARCHAR(255) NOT NULL,
    carga_horaria INT NOT NULL,
    PRIMARY KEY (id_cadeira, fk_universidade),
    FOREIGN KEY (fk_universidade) REFERENCES UNIVERSIDADE(id_universidade)
);
CREATE TABLE CADEIRA_ELETIVA (
    fk_universidade INT,
    fk_cadeira INT,
    esta_ofertada BOOLEAN NOT NULL,
    PRIMARY KEY (fk_universidade, fk_cadeira),
    FOREIGN KEY (fk_universidade, fk_cadeira) REFERENCES CADEIRA(fk_universidade, id_cadeira)
);
CREATE TABLE CADEIRA_OBRIGATORIA (
    fk_universidade INT,
    fk_cadeira INT,
    tem_monitor BOOLEAN NOT NULL,
    id_monitor INT unique,
    nome_monitor VARCHAR(255),
    PRIMARY KEY (fk_universidade, fk_cadeira),
    FOREIGN KEY (fk_universidade, fk_cadeira) REFERENCES CADEIRA(fk_universidade, id_cadeira)
);
CREATE TABLE PRE_REQUISITO (
    fk_universidade_tem INT,
    fk_cadeira_tem INT,
    fk_universidade_eh INT,
    fk_cadeira_eh INT,
    PRIMARY KEY (fk_universidade_tem, fk_cadeira_tem, fk_universidade_eh, fk_cadeira_eh),
    FOREIGN KEY (fk_universidade_tem, fk_cadeira_tem) REFERENCES CADEIRA(fk_universidade, id_cadeira),
    FOREIGN KEY (fk_universidade_eh, fk_cadeira_eh) REFERENCES CADEIRA(fk_universidade, id_cadeira)
);
CREATE TABLE PROFESSOR (
    id_professor INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    nota_media DECIMAL(3,2)
);
CREATE TABLE CONTATOS (
    id_contato INT PRIMARY KEY,
    contato VARCHAR(255),
    fk_professor INT,
    fk_monitor INT,
    FOREIGN KEY (fk_professor) REFERENCES PROFESSOR(id_professor),
    FOREIGN KEY (fk_monitor) REFERENCES CADEIRA_OBRIGATORIA(id_monitor)
    CONSTRAINT chk_professor_monitor CHECK (
        (fk_professor IS NOT NULL AND fk_monitor IS NULL) OR 
        (fk_professor IS NULL AND fk_monitor IS NOT NULL)
    )
);

CREATE TABLE ALUNO (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(255)
);
CREATE TABLE AVALIA (
    fk_professor INT,
    fk_universidade INT,
    fk_cadeira INT,
    fk_aluno INT,
    data DATE,
    nota DECIMAL(3,2) NOT NULL,
    PRIMARY KEY (fk_professor, fk_universidade, fk_cadeira, fk_aluno, data),
    FOREIGN KEY (fk_professor) REFERENCES PROFESSOR(id_professor),
    FOREIGN KEY (fk_aluno) REFERENCES ALUNO(id_aluno),
    FOREIGN KEY (fk_universidade, fk_cadeira) REFERENCES CADEIRA(fk_universidade, id_cadeira)
);
CREATE TABLE COMENTARIO (
    id_comentario INT PRIMARY KEY,
    fk_professor INT NOT NULL,
    fk_universidade INT NOT NULL,
    fk_cadeira INT NOT NULL,
    fk_aluno INT NOT NULL,
    data DATE NOT NULL,
    texto TEXT NOT NULL,
    FOREIGN KEY (fk_professor, fk_universidade, fk_cadeira, fk_aluno, data)
        REFERENCES AVALIA(fk_professor, fk_universidade, fk_cadeira, fk_aluno, data)
);

-- Inserting data
-- UNIVERSIDADES
INSERT INTO UNIVERSIDADE (id_universidade, nome, sigla, endereco_CEP, endereco_logradouro) VALUES
(1, 'Universidade Federal de Tecnologia', 'UFT', '70040-000', 'Av. das Ciências, 1000'),
(2, 'Instituto de Estudos Avançados', 'IEA', '04567-123', 'Rua do Conhecimento, 500');

-- CADEIRAS
INSERT INTO CADEIRA (id_cadeira, fk_universidade, nome, carga_horaria) VALUES
(101, 1, 'Algoritmos e Estruturas de Dados', 60),
(102, 1, 'Banco de Dados', 60),
(103, 1, 'Inteligência Artificial', 60),
(201, 2, 'História da Arte', 45),
(202, 2, 'Filosofia Contemporânea', 60);

-- CADEIRA_ELETIVA
INSERT INTO CADEIRA_ELETIVA (fk_universidade, fk_cadeira, esta_ofertada) VALUES
(1, 103, TRUE),
(2, 202, TRUE);

-- CADEIRA_OBRIGATORIA
INSERT INTO CADEIRA_OBRIGATORIA (fk_universidade, fk_cadeira, tem_monitor, id_monitor, nome_monitor) VALUES
(1, 101, TRUE, 1, 'Carlos Monitor'),
(1, 102, FALSE, NULL, NULL),
(2, 201, TRUE, 2, 'Marina Monitor');

-- PRE_REQUISITO
INSERT INTO PRE_REQUISITO (fk_universidade_tem, fk_cadeira_tem, fk_universidade_eh, fk_cadeira_eh) VALUES
(1, 103, 1, 101), -- Inteligência Artificial requer Algoritmos
(1, 103, 1, 102), -- Inteligência Artificial requer Banco de Dados
(2, 202, 2, 201); -- Filosofia Contemporânea requer História da Arte

-- PROFESSORES
INSERT INTO PROFESSOR (id_professor, nome, nota_media) VALUES
(1, 'Prof. Ana Silva', 4.75),
(2, 'Prof. João Mendes', 4.50),
(3, 'Prof. Laura Costa', 4.20);

-- CONTATOS
INSERT INTO CONTATOS (id_contato, contato, fk_professor, fk_monitor) VALUES
(1, 'ana.silva@uft.edu',      1,    NULL),
(2, 'joao.mendes@uft.edu',    2,    NULL),
(3, 'laura.costa@iea.edu',    3,    NULL),
(4, 'carlos.monitor@uft.edu', NULL, 1   ),
(5, 'marina.monitor@iea.edu', NULL, 2   ),
(6, '(11) 91234-5678',        1,    NULL);

-- ALUNOS
INSERT INTO ALUNO (id_aluno, nome) VALUES
(1, 'Pedro Santos'  ),
(2, 'Julia Ferreira'),
(3, 'Lucas Rocha'   );

-- AVALIA
INSERT INTO AVALIA (fk_professor, fk_universidade, fk_cadeira, fk_aluno, data, nota) VALUES
(1, 1, 101, 1, '2024-03-01', 4.5),
(1, 1, 101, 2, '2024-03-02', 4.0),
(2, 1, 102, 1, '2024-03-05', 3.8),
(3, 2, 201, 3, '2024-03-10', 4.9),
(3, 2, 201, 2, '2024-03-11', 4.7);

-- COMENTARIO
INSERT INTO COMENTARIO (id_comentario, fk_professor, fk_universidade, fk_cadeira, fk_aluno, data, texto) VALUES
(1, 1, 1, 101, 1, '2024-03-01', 'Ótima explicação, mas as provas são difíceis.'  ),
(2, 1, 1, 101, 2, '2024-03-02', 'Didática excelente, recomendo!'                 ),
(3, 2, 1, 102, 1, '2024-03-05', 'Muito conteúdo em pouco tempo.'                 ),
(4, 3, 2, 201, 3, '2024-03-10', 'Aulas envolventes e conteúdos bem apresentados.'),
(5, 3, 2, 201, 2, '2024-03-11', 'Excelente abordagem prática da teoria.'         );

/*-- Explored scenarios
-- ✅ Two universities with exclusive disciplines
-- ✅ Courses with and without monitors
-- ✅ Mandatory and elective courses (some offered)
-- ✅ Prerequisites from multiple disciplines
-- ✅ Professors with average grades and varied contacts
-- ✅ Students evaluating different professors in different courses
-- ✅ Comments on evaluations with different opinions
*/


--Queries:

-- Group by / Having
-- Average evaluation grades per professor, returning only those with average above 4.0.
SELECT
    p.nome AS professor,
    AVG(a.nota) AS media_notas
FROM AVALIA a
INNER JOIN PROFESSOR p ON a.fk_professor = p.id_professor
GROUP BY p.nome
HAVING AVG(a.nota) > 4.0;


-- Inner join
-- Professors and their mandatory courses where there is a monitor
SELECT
    p.nome AS professor,
    c.nome AS cadeira,
    co.nome_monitor
FROM PROFESSOR p
INNER JOIN AVALIA a ON p.id_professor = a.fk_professor
INNER JOIN CADEIRA_OBRIGATORIA co
    ON a.fk_universidade = co.fk_universidade
    AND a.fk_cadeira = co.fk_cadeira
INNER JOIN CADEIRA c
    ON co.fk_universidade = c.fk_universidade
    AND co.fk_cadeira = c.id_cadeira
WHERE co.tem_monitor = TRUE;


-- Outer join
-- All courses from university 1, and whether or not they are offered as elective.
SELECT
    c.nome AS cadeira,
    ce.esta_ofertada
FROM CADEIRA c
LEFT JOIN CADEIRA_ELETIVA ce
    ON c.fk_universidade = ce.fk_universidade
    AND c.id_cadeira = ce.fk_cadeira
WHERE c.fk_universidade = 1;


-- Semi join
-- Students who have already evaluated at least one professor with a grade higher than 4.5.
SELECT DISTINCT a.nome
FROM ALUNO a
WHERE EXISTS (
    SELECT 1
    FROM AVALIA av
    WHERE av.fk_aluno = a.id_aluno
    AND av.nota > 4.5
);


-- Anti-join
-- Professors who never received an evaluation.
SELECT p.nome
FROM PROFESSOR p
WHERE NOT EXISTS (
    SELECT 1
    FROM AVALIA a
    WHERE a.fk_professor = p.id_professor
);


-- Scalar subquery
-- Find the name of the professor with the highest average grade
SELECT nome
FROM PROFESSOR
WHERE nota_media = (
    SELECT MAX(nota_media)
    FROM PROFESSOR
);


-- Row subquery
-- Returns the name and average grade of the professor with the lowest average.
SELECT nome, nota_media
FROM PROFESSOR
WHERE (nota_media) = (
    SELECT MIN(nota_media)
    FROM PROFESSOR
);



-- Table subquery
-- Professors with average grade higher than the general average of all professors.
SELECT p.*
FROM PROFESSOR p
WHERE p.nota_media > (
    SELECT AVG(nota_media)
    FROM PROFESSOR
);


-- Set operation
-- IDs of students who evaluated professors OR made comments.
SELECT fk_aluno AS id_aluno
FROM AVALIA
UNION
SELECT fk_aluno
FROM COMENTARIO;
