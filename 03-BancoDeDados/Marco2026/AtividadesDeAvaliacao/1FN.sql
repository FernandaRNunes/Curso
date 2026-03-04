-- =======
--	1FN
-- ======
CREATE TABLE cliente (
    cpf_cliente        VARCHAR(14) PRIMARY KEY,
    nome_cliente       VARCHAR(100),
    rua                VARCHAR(100),
    numero             VARCHAR(20),
    bairro             VARCHAR(80),
    cidade             VARCHAR(80),
    estado             VARCHAR(2)
);

CREATE TABLE cliente_telefone (
    cpf_cliente     VARCHAR(14),
    telefone        VARCHAR(20),
    PRIMARY KEY (cpf_cliente, telefone),
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf_cliente)
);

CREATE TABLE pedido (
    id_pedido       INTEGER PRIMARY KEY,
    data_pedido     TIMESTAMP,
    cpf_cliente     VARCHAR(14),
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf_cliente)
);

CREATE TABLE pedido_produto (
    id_pedido         INTEGER,
    id_produto        INTEGER,
    nome_produto      VARCHAR(100),
    categoria_produto VARCHAR(80),
    id_categoria      INTEGER,
    descricao_categoria TEXT,
    quantidade        INTEGER,
    valor_unitario    NUMERIC(10,2),
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);