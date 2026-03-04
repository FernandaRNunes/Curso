-- =======
--	2FN
-- ======
CREATE TABLE produto (
    id_produto          INTEGER PRIMARY KEY,
    nome_produto        VARCHAR(100),
    categoria_produto   VARCHAR(80),
    id_categoria        INTEGER,
    descricao_categoria TEXT,
    valor_unitario      NUMERIC(10,2)
);

CREATE TABLE pedido_produto (
    id_pedido      INTEGER,
    id_produto     INTEGER,
    quantidade     INTEGER,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);