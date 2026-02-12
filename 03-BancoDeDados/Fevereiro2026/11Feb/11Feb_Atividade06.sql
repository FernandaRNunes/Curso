drop table if exists itens_pedido;
drop table if exists pedidos;
drop table if exists clientes;
drop table if exists produtos;

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(50),
    estado CHAR(2)
);

CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(50),
    preco NUMERIC(10, 2)
);

CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    data_pedido DATE
);

CREATE TABLE itens_pedido (
    id_item SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES pedidos(id_pedido),
    id_produto INT REFERENCES produtos(id_produto),
    quantidade INT
);


INSERT INTO clientes (nome, cidade, estado) VALUES
('João Silva', 'São Paulo', 'SP'),
('Maria Oliveira', 'Rio de Janeiro', 'RJ'),
('Carlos Souza', 'Belo Horizonte', 'MG'),
('Ana Pereira', 'Curitiba', 'PR'),
('Pedro Santos', 'São Paulo', 'SP'),
('Bruno Lima', 'Salvador', 'BA'),
('Fernanda Costa', 'Recife', 'PE'),
('Roberto Alves', 'Porto Alegre', 'RS'),
('Juliana Martins', 'Campinas', 'SP'),
('Marcos Rocha', 'Manaus', 'AM'),
('Patrícia Gomes', 'Fortaleza', 'CE'),
('Lucas Mendes', 'São Paulo', 'SP'),
('Sofia Ribeiro', 'Rio de Janeiro', 'RJ'),
('André Neves', 'Belo Horizonte', 'MG'),
('Larissa Dias', 'Curitiba', 'PR'),
('CLIENTE SEM COMPRA 1', 'Osasco', 'SP'),
('CLIENTE SEM COMPRA 2', 'Niterói', 'RJ'),
('CLIENTE FANTASMA', 'Vitória', 'ES');

INSERT INTO produtos (nome_produto, categoria, preco) VALUES
('Notebook Dell', 'Informática', 3500.00),
('Mouse Gamer', 'Acessórios', 150.00),
('Teclado Mecânico', 'Acessórios', 300.00),
('Monitor 24pol', 'Informática', 1200.00),
('Cadeira Gamer', 'Móveis', 800.00),
('Headset RGB', 'Acessórios', 250.00),
('Smartphone Samsung', 'Telefonia', 2000.00),
('iPhone 13', 'Telefonia', 5000.00),
('Tablet Galaxy', 'Informática', 1500.00),
('Carregador Portátil', 'Acessórios', 100.00),
('Webcam HD', 'Informática', 250.00),
('Impressora Laser', 'Escritório', 1200.00),
('Papel A4', 'Escritório', 25.00),
('Caixa de Som JBL', 'Áudio', 400.00),
('PRODUTO NUNCA VENDIDO (Drone)', 'Eletrônicos', 4500.00),
('PRODUTO TESTE (Cabo Velho)', 'Acessórios', 10.00);

INSERT INTO pedidos (id_cliente, data_pedido) VALUES
(1, '2023-10-01'),
(2, '2023-10-02'),
(1, '2023-10-05'),
(3, '2023-10-06'),
(4, '2023-10-10'),
(6, '2023-11-01'),
(7, '2023-11-02'),
(8, '2023-11-03'),
(6, '2023-11-05'),
(9, '2023-11-06'),
(10, '2023-11-08'),
(6, '2023-11-10'),
(11, '2023-11-12'),
(12, '2023-11-15'),
(NULL, '2023-11-20'); 

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 4, 2),
(3, 2, 1),
(3, 6, 1),
(4, 5, 1),
(5, 1, 1),
(5, 3, 1),
(6, 7, 1),
(6, 10, 2),
(7, 8, 1),
(8, 14, 1),
(9, 7, 1),
(10, 13, 10),
(11, 12, 1),
(12, 9, 1),
(13, 11, 1),
(14, 7, 1),
(15, 10, 1);


--1 
select * from produtos	
where preco <= 500
;

--2
select sum(preco) as total_estoque from produtos;

--3
select categoria, count(*) as qnt_produtos
from produtos
group by categoria;

--4
select clientes.nome, pedidos.data_pedido
from clientes 
join pedidos on clientes.id_cliente = pedidos.id_cliente;

--5
select clientes.nome from clientes
left join pedidos ON clientes.id_cliente = pedidos.id_cliente
where pedidos.id_pedido is null;

--6
select produtos.categoria,
	sum(itens_pedido.quantidade) as quantidade_ventidada,
	sum(itens_pedido.quantidade * produtos.preco) as valor_total_vendido
from itens_pedido
join produtos on itens_pedido.id_produto = produtos.id_produto
group by produtos.categoria
order by valor_total_vendido desc
;

--7 
SELECT 
    clientes.nome,
    SUM(itens_pedido.quantidade * produtos.preco) AS total_gasto
FROM clientes
JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
JOIN itens_pedido ON pedidos.id_pedido = itens_pedido.id_pedido
JOIN produtos ON itens_pedido.id_produto = produtos.id_produto
GROUP BY clientes.nome
ORDER BY total_gasto DESC;

