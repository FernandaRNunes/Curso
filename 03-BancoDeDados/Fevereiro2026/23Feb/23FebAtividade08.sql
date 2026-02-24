

CREATE TABLE Endereco (
    id_endereco SERIAL PRIMARY KEY,
    rua VARCHAR(100),
    numero VARCHAR(10),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado CHAR(2)
);

CREATE TABLE Setor (
    id_setor SERIAL PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE Funcionarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    matricula VARCHAR(20),
    fk_endereco INT REFERENCES Endereco(id_endereco),
    fk_setor INT REFERENCES Setor(id_setor)
);

-- =====================================================
-- 2. INSERÇÃO DE DADOS
-- =====================================================

INSERT INTO Endereco (rua, numero, bairro, cidade, estado)
VALUES ('Rua do Trabalhador', '23h,' 'Cansadino', 'Novo Imperio', 'RJ');

INSERT INTO Setor (nome)
VALUES ('Tecnologia');

INSERT INTO Funcionarios (nome, matricula, fk_endereco, fk_setor)
VALUES ('Ana Almeida', 'MAT001', 1, 1);



-- =====================================================
-- 3. VIEW relatorio_funcionarios
-- Nome do funcionário, bairro onde mora e setor onde trabalha
-- =====================================================

CREATE VIEW relatorio_funcionarios AS
SELECT 
    f.nome AS funcionario,
    e.bairro,
    s.nome AS setor
FROM Funcionarios f
JOIN Endereco e ON f.fk_endereco = e.id_endereco
JOIN Setor s ON f.fk_setor = s.id_setor;




-- =====================================================
-- 4. VIEW setor_funcionarios
-- Nome do funcionário e setor onde trabalha
-- =====================================================

CREATE VIEW setor_funcionarios AS
SELECT 
    f.nome AS funcionario,
    s.nome AS setor
FROM Funcionarios f
JOIN Setor s ON f.fk_setor = s.id_setor;




-- =====================================================
-- 5. CRIAÇÃO DOS USUÁRIOS E PERMISSÕES
-- =====================================================

CREATE USER estagiario WITH PASSWORD 'e123';
CREATE USER gerente WITH PASSWORD 'g123';

-- Permissões do estagiario
GRANT SELECT ON setor_funcionarios TO estagiario;

-- Permissões do gerente
GRANT SELECT, UPDATE ON Funcionarios TO gerente;




-- =====================================================
-- 6. SIMULAÇÃO DAS CONEXÕES
-- =====================================================

-- Conexão 1: estagiario
\c nome_do_banco estagiario

-- 7. AÇÕES DO ESTAGIARIO

-- Deve funcionar
SELECT * FROM setor_funcionarios;

-- Deve dar erro (sem permissão)
SELECT * FROM Funcionarios;


-- =====================================================

-- Conexão 2: gerente
\c nome_do_banco gerente

-- 8. AÇÕES DO GERENTE

-- Pode dar erro se não for concedido SELECT na view
SELECT * FROM setor_funcionarios;

-- Deve funcionar
SELECT * FROM Funcionarios;

-- Deve funcionar
UPDATE Funcionarios
SET nome = 'Carlos Souza'
WHERE id = 1;

-- Deve dar erro (sem permissão de CREATE)
CREATE TABLE teste (
    id SERIAL PRIMARY KEY
);