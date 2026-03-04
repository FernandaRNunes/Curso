-- =======
--	3FN
-- ======

CREATE TABLE categoria (
    id_categoria        INTEGER PRIMARY KEY,
    nome_categoria      VARCHAR(80),
    descricao_categoria TEXT
);

CREATE TABLE produto (
    id_produto     INTEGER PRIMARY KEY,
    nome_produto   VARCHAR(100),
    id_categoria   INTEGER,
    valor_unitario NUMERIC(10,2),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE pedido_produto (
    id_pedido   INTEGER,
    id_produto  INTEGER,
    quantidade  INTEGER,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
); 
