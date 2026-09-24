1.

DELIMITER $$ 

CREATE FUNCTION dobro(numero INT)
RETURNS INT 
BEGIN
RETURN numero * 2; 
END $$ 
DELIMITER $$ 
Select dobro(10) 


2.

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

3.

CREATE TABLE aluno( 
NOME VARCHAR(20) NOT NULL, 
IDADE NOT NULL
); 

INSERT INTO ALUNO(NOME, IDADE) VALUES 
('Laura da Silva', 18), 
('Tiago Pereira', 18); 

DELIMITER $$ 

CREATE PROCEDURE buscar_alunos_por_idade(IN idade_minima INT)
BEGIN 
SELECT * 
FROM alunos 
WHERE idade >= idade_minima; 
END $$ 

DELIMITER ; 

CALL buscar_alunos_por_idade(18);

4.

CREATE TABLE aluno ( 
ID INT AUTO_INCREMENT PRIMARY KEY, 
NOME VARCHAR(100) NOT NULL, 
NOTA DECIMAL(4,2) DEFAULT 0 
); 

INSERT INTO alunos (nome, nota) VALUES ('Sophia da Rosa', 7.50); 
INSERT INTO alunos (nome, nota) VALUES ('Rodrigo da Souza', 6); 
INSERT INTO alunos (nome, nota) VALUES ('Paulo Gonçalvez', 8.25); 
INSERT INTO alunos (nome, nota) VALUES ('Yasmin Lima', 5.50); 
INSERT INTO alunos (nome, nota) VALUES ('Joaquim da Silva', 9);

 DELIMITER $$ 

CREATE PROCEDURE aumentar_nota(
IN p_aluno_id INT, 
IN p_aumento DECIMAL(4,2)
)
BEGIN 
UPDATE alunos 
SET nota = nota + p_aumento 
WHERE id = p_aluno_id; 
END$$ 

DELIMITER ; 

CALL aumentar_nota (5, 1); 


SELECT * FROM alunos; 

5.

CREATE TABLE aluno ( 
ID INT PRIMARY KEY AUTO_INCREMENT, 
nome VARCHAR(100) NOT NULL, 
nota1 DECIMAL(5,2), 
nota2 DECIMAL(5,2) 

);

INSERT INTO alunos (nome, nota1, nota2) VALUES ('João', 8.0, 7.0), 
('Laura', 9.0, 8.0), 
('Rodrigo', 5.0, 4.0), 
(‘Sophia', 3.0, 2.0),
('Carlos', 6.0, 7.0); 

DELIMITER $$ 

CREATE FUNCTION calcular_media( 
nota1 DECIMAL(5,2), 
nota2 DECIMAL(5,2) 
) 
RETURNS DECIMAL(5,2)
BEGIN RETURN (nota1 + nota2) / 2; 
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
WHEN calcular_media(nota1, nota2) >= 6 THEN 'Aprovado' 
WHEN calcular_media(nota1, nota2) >= 4 THEN 'Recuperação' 
ELSE 'Reprovado' 
   END AS situacao 
FROM alunos 
WHERE id = id_aluno; 
END $$ 

DELIMITER ; CALL mostrar_situacao(5); 

select * from alunos 
