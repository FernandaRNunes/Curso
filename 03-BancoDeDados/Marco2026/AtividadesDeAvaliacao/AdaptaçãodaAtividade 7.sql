-- SISTEMA DE PAGAMENTO INTELIGENTE - STREAMING

DROP TABLE IF EXISTS logs_sistema CASCADE;
DROP TABLE IF EXISTS historico_assinaturas CASCADE;
DROP TABLE IF EXISTS tentativas_pagamento CASCADE;
DROP TABLE IF EXISTS pagamentos CASCADE;
DROP TABLE IF EXISTS assinaturas CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;
DROP TABLE IF EXISTS planos CASCADE;
DROP TABLE IF EXISTS formas_pagamento CASCADE;

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'financeiro') THEN
        REASSIGN OWNED BY financeiro TO postgres;
        DROP OWNED BY financeiro;
        DROP ROLE financeiro;
    END IF;

    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'suporte') THEN
        REASSIGN OWNED BY suporte TO postgres;
        DROP OWNED BY suporte;
        DROP ROLE suporte;
    END IF;
END
$$;

CREATE TABLE planos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    valor NUMERIC(10,2) NOT NULL CHECK (valor > 0),
    limite_telas INTEGER NOT NULL CHECK (limite_telas > 0)
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_cadastro DATE NOT NULL DEFAULT CURRENT_DATE,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE assinaturas (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    plano_id INTEGER NOT NULL,
    data_inicio DATE NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('ATIVA','INADIMPLENTE','CANCELADA')),
    tentativas_falha INTEGER NOT NULL DEFAULT 0 CHECK (tentativas_falha >= 0),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (plano_id) REFERENCES planos(id)
);

CREATE TABLE formas_pagamento (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE pagamentos (
    id SERIAL PRIMARY KEY,
    assinatura_id INTEGER NOT NULL,
    forma_pagamento_id INTEGER NOT NULL,
    valor NUMERIC(10,2) NOT NULL CHECK (valor > 0),
    data_pagamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL CHECK (status IN ('APROVADO','FALHOU')),
    FOREIGN KEY (assinatura_id) REFERENCES assinaturas(id),
    FOREIGN KEY (forma_pagamento_id) REFERENCES formas_pagamento(id)
);

CREATE TABLE tentativas_pagamento (
    id SERIAL PRIMARY KEY,
    assinatura_id INTEGER NOT NULL,
    data_tentativa TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL CHECK (status IN ('APROVADO','FALHOU')),
    descricao_erro TEXT,
    FOREIGN KEY (assinatura_id) REFERENCES assinaturas(id)
);

CREATE TABLE historico_assinaturas (
    id SERIAL PRIMARY KEY,
    assinatura_id INTEGER NOT NULL,
    status_anterior VARCHAR(20),
    status_novo VARCHAR(20),
    data_alteracao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assinatura_id) REFERENCES assinaturas(id)
);

CREATE TABLE logs_sistema (
    id SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL,
    data_log TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO planos (nome, valor, limite_telas) VALUES
('Basico',39.90,1),
('Padrao',59.90,2),
('Premium',79.90,4),
('Familia',89.90,5),
('Ultra',99.90,6),
('Estudante',29.90,1),
('Corporativo',149.90,10),
('Anual Basico',399.90,1),
('Anual Premium',799.90,4),
('Infantil',19.90,1),
('Esporte',49.90,2),
('Cinema',69.90,3),
('Plus',54.90,2),
('Gold',119.90,5),
('Platinum',159.90,8);


INSERT INTO formas_pagamento (tipo) VALUES
('CARTAO_CREDITO'),
('CARTAO_DEBITO'),
('PIX'),
('BOLETO'),
('PAYPAL'),
('TRANSFERENCIA'),
('APPLE_PAY'),
('GOOGLE_PAY'),
('PICPAY'),
('MERCADO_PAGO'),
('CRYPTO'),
('DEBITO_AUTOMATICO'),
('CREDITO_VIRTUAL'),
('VALE_PRESENTE'),
('OUTROS');


INSERT INTO usuarios (nome,email) VALUES
('Usuario1','u1@email.com'),
('Usuario2','u2@email.com'),
('Usuario3','u3@email.com'),
('Usuario4','u4@email.com'),
('Usuario5','u5@email.com'),
('Usuario6','u6@email.com'),
('Usuario7','u7@email.com'),
('Usuario8','u8@email.com'),
('Usuario9','u9@email.com'),
('Usuario10','u10@email.com'),
('Usuario11','u11@email.com'),
('Usuario12','u12@email.com'),
('Usuario13','u13@email.com'),
('Usuario14','u14@email.com'),
('Usuario15','u15@email.com');


INSERT INTO assinaturas (usuario_id, plano_id, data_inicio, status, tentativas_falha) VALUES
(1,1,'2024-01-01','ATIVA',0),
(2,2,'2024-01-02','INADIMPLENTE',3),
(3,3,'2024-01-03','CANCELADA',4),
(4,4,'2024-01-04','ATIVA',1),
(5,5,'2024-01-05','INADIMPLENTE',3),
(6,6,'2024-01-06','ATIVA',0),
(7,7,'2024-01-07','CANCELADA',5),
(8,8,'2024-01-08','ATIVA',0),
(9,9,'2024-01-09','INADIMPLENTE',3),
(10,10,'2024-01-10','ATIVA',0),
(11,11,'2024-01-11','ATIVA',2),
(12,12,'2024-01-12','CANCELADA',6),
(13,13,'2024-01-13','ATIVA',0),
(14,14,'2024-01-14','INADIMPLENTE',3),
(15,15,'2024-01-15','ATIVA',1);

INSERT INTO pagamentos (assinatura_id,forma_pagamento_id,valor,status) VALUES
(1,1,39.90,'APROVADO'),
(2,2,59.90,'FALHOU'),
(3,3,79.90,'FALHOU'),
(4,4,39.90,'APROVADO'),
(5,5,59.90,'FALHOU'),
(6,6,79.90,'APROVADO'),
(7,7,39.90,'FALHOU'),
(8,8,59.90,'APROVADO'),
(9,9,79.90,'FALHOU'),
(10,10,39.90,'APROVADO'),
(11,11,59.90,'FALHOU'),
(12,12,79.90,'APROVADO'),
(13,13,39.90,'APROVADO'),
(14,14,59.90,'FALHOU'),
(15,15,79.90,'APROVADO');

INSERT INTO tentativas_pagamento (assinatura_id,status,descricao_erro) VALUES
(2,'FALHOU','Saldo insuficiente'),
(2,'FALHOU','Cartao recusado'),
(2,'FALHOU','Limite excedido'),
(5,'FALHOU','Erro PIX'),
(5,'FALHOU','Banco offline'),
(5,'FALHOU','Timeout'),
(9,'FALHOU','Conta bloqueada'),
(9,'FALHOU','Saldo insuficiente'),
(9,'FALHOU','Erro interno'),
(14,'FALHOU','Cartao vencido'),
(14,'FALHOU','Dados invalidos'),
(14,'FALHOU','Banco indisponivel'),
(3,'FALHOU','Falha sistema'),
(7,'FALHOU','Cartao recusado'),
(12,'FALHOU','Erro desconhecido');

INSERT INTO historico_assinaturas (assinatura_id,status_anterior,status_novo) VALUES
(1,'ATIVA','CANCELADA'),
(2,'INADIMPLENTE','ATIVA'),
(3,'CANCELADA','ATIVA'),
(4,'ATIVA','INADIMPLENTE'),
(5,'INADIMPLENTE','CANCELADA'),
(6,'ATIVA','CANCELADA'),
(7,'CANCELADA','ATIVA'),
(8,'ATIVA','ATIVA'),
(9,'INADIMPLENTE','ATIVA'),
(10,'ATIVA','CANCELADA'),
(11,'ATIVA','INADIMPLENTE'),
(12,'CANCELADA','ATIVA'),
(13,'ATIVA','ATIVA'),
(14,'INADIMPLENTE','CANCELADA'),
(15,'ATIVA','INADIMPLENTE');

INSERT INTO logs_sistema (descricao) VALUES
('Sistema iniciado'),
('Carga inicial concluida'),
('Teste pagamento'),
('Falha detectada'),
('Assinatura alterada'),
('Usuario bloqueado'),
('Reativacao automatica'),
('Relatorio gerado'),
('Backup realizado'),
('Erro comunicacao'),
('Tentativa excedida'),
('Pagamento aprovado'),
('Atualizacao plano'),
('Cancelamento automatico'),
('Monitoramento ativo');


CREATE OR REPLACE FUNCTION controlar_pagamento()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'FALHOU' THEN
        UPDATE assinaturas
        SET tentativas_falha = tentativas_falha + 1
        WHERE id = NEW.assinatura_id;

        UPDATE assinaturas
        SET status = 'INADIMPLENTE'
        WHERE id = NEW.assinatura_id
        AND tentativas_falha >= 3;
    END IF;

    IF NEW.status = 'APROVADO' THEN
        UPDATE assinaturas
        SET status = 'ATIVA',
            tentativas_falha = 0
        WHERE id = NEW.assinatura_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_controlar_pagamento
AFTER INSERT ON pagamentos
FOR EACH ROW
EXECUTE FUNCTION controlar_pagamento();

CREATE OR REPLACE FUNCTION registrar_historico()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status <> OLD.status THEN
        INSERT INTO historico_assinaturas
        (assinatura_id,status_anterior,status_novo)
        VALUES
        (OLD.id,OLD.status,NEW.status);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_historico
AFTER UPDATE ON assinaturas
FOR EACH ROW
EXECUTE FUNCTION registrar_historico();

-- VIEWS

CREATE VIEW vw_dashboard_financeiro AS
SELECT u.nome,
       p.nome AS plano,
       a.status,
       a.tentativas_falha
FROM usuarios u
JOIN assinaturas a ON u.id = a.usuario_id
JOIN planos p ON p.id = a.plano_id;

CREATE VIEW vw_pagamentos_detalhados AS
SELECT u.nome,
       f.tipo,
       pg.valor,
       pg.status,
       pg.data_pagamento
FROM pagamentos pg
JOIN assinaturas a ON a.id = pg.assinatura_id
JOIN usuarios u ON u.id = a.usuario_id
JOIN formas_pagamento f ON f.id = pg.forma_pagamento_id;

-- CONSULTAS COM JOIN
SELECT u.nome, a.status, p.nome AS plano
FROM usuarios u
JOIN assinaturas a ON u.id = a.usuario_id
JOIN planos p ON p.id = a.plano_id;

SELECT u.nome, pg.valor, pg.status
FROM usuarios u
JOIN assinaturas a ON u.id = a.usuario_id
JOIN pagamentos pg ON pg.assinatura_id = a.id;

-- CONSULTAS COM AGRUPAMENTO
SELECT plano_id, COUNT(*) AS total_assinaturas
FROM assinaturas
GROUP BY plano_id;

SELECT status, SUM(valor) AS total_receita
FROM pagamentos
GROUP BY status;

-- USUÁRIOS
CREATE USER financeiro WITH PASSWORD '123';
CREATE USER suporte WITH PASSWORD '123';

GRANT SELECT, INSERT, UPDATE ON pagamentos TO financeiro;
GRANT SELECT ON vw_dashboard_financeiro TO suporte;