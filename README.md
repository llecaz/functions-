#  Exercícios de SQL

>  Repositório criado para apresentar exercícios práticos de SQL utilizando funções, procedures, tabelas, inserção, atualização e consultas de dados.

Este projeto reúne exercícios desenvolvidos em **MySQL**, com o objetivo de praticar conceitos importantes de banco de dados, como criação de tabelas, funções, procedures, estruturas condicionais, inserção e atualização de registros.

```sql
--  1. Função para dobrar um número

DELIMITER $$

CREATE FUNCTION dobro(numero INT)
RETURNS INT
BEGIN
    RETURN numero * 2;
END $$

DELIMITER ;

SELECT dobro(10);


-- 🎓 2. Função para verificar a situação do aluno

DELIMITER $$

CREATE FUNCTION situacao_aluno(
    media DECIMAL(5,2)
)
RETURNS VARCHAR(20)
BEGIN
    IF media >= 6 THEN
        RETURN 'Aprovado';
    ELSEIF media >= 4 THEN
        RETURN 'Recuperação';
    ELSE
        RETURN 'Reprovado';
    END IF;
END $$

DELIMITER ;

SELECT situacao_aluno(8);


--  3. Buscar alunos por idade

CREATE TABLE aluno(
    NOME VARCHAR(20) NOT NULL,
    IDADE INT NOT NULL
);

INSERT INTO aluno(NOME, IDADE) VALUES
('Laura da Silva', 18),
('Tiago Pereira', 18);

DELIMITER $$

CREATE PROCEDURE buscar_alunos_por_idade(IN idade_minima INT)
BEGIN
    SELECT *
    FROM aluno
    WHERE idade >= idade_minima;
END $$

DELIMITER ;

CALL buscar_alunos_por_idade(18);


--  4. Aumentar a nota de um aluno

CREATE TABLE aluno (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    NOTA DECIMAL(4,2) DEFAULT 0
);

INSERT INTO aluno (nome, nota) VALUES
('Sophia da Rosa', 7.50),
('Rodrigo da Souza', 6),
('Paulo Gonçalvez', 8.25),
('Yasmin Lima', 5.50),
('Joaquim da Silva', 9);

DELIMITER $$

CREATE PROCEDURE aumentar_nota(
    IN p_aluno_id INT,
    IN p_aumento DECIMAL(4,2)
)
BEGIN
    UPDATE aluno
    SET nota = nota + p_aumento
    WHERE id = p_aluno_id;
END $$

DELIMITER ;

CALL aumentar_nota(5, 1);

SELECT * FROM aluno;


--  5. Calcular média e mostrar situação

CREATE TABLE aluno (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    nota1 DECIMAL(5,2),
    nota2 DECIMAL(5,2)
);

INSERT INTO aluno (nome, nota1, nota2) VALUES
('João', 8.0, 7.0),
('Laura', 9.0, 8.0),
('Rodrigo', 5.0, 4.0),
('Sophia', 3.0, 2.0),
('Carlos', 6.0, 7.0);

DELIMITER $$

CREATE FUNCTION calcular_media(
    nota1 DECIMAL(5,2),
    nota2 DECIMAL(5,2)
)
RETURNS DECIMAL(5,2)
BEGIN
    RETURN (nota1 + nota2) / 2;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE mostrar_situacao(IN id_aluno INT)
BEGIN
    SELECT
        nome,
        nota1,
        nota2,
        calcular_media(nota1, nota2) AS media,
        CASE
            WHEN calcular_media(nota1, nota2) >= 6
                THEN 'Aprovado'
            WHEN calcular_media(nota1, nota2) >= 4
                THEN 'Recuperação'
            ELSE 'Reprovado'
        END AS situacao
    FROM aluno
    WHERE id = id_aluno;
END $$

DELIMITER ;

CALL mostrar_situacao(5);

SELECT * FROM aluno;
