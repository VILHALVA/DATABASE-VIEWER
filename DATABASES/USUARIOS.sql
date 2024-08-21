-- Cria a tabela 'usuarios'
CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    email VARCHAR(50)
);

-- Insere alguns registros na tabela 'usuarios'
INSERT INTO usuarios (id, nome, email) VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Doe', 'jane@example.com'),
(3, 'Bob Smith', 'bob@example.com');
