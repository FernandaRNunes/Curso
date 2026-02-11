-- Restaurante


CREATE TABLE Pratos(
	id_prato serial PRIMARY KEY,
	 nome varchar(50) NOT NULL UNIQUE,
	 preco numeric(7, 2) NOT null CHECK (preco <= 10000),
	 descricao text DEFAULT 'Sem informações' 
);

CREATE TABLE enderecos(
	id_endereco serial PRIMARY KEY,
	rua varchar(100) NOT NULL DEFAULT 'Sem nome',
	numero varchar(20) NOT NULL DEFAULT 'S/N',
	bairro varchar(50) NOT null,
	cidade varchar(50) NOT null,
	estado char(2) NOT NULL,
	cep varchar(9),
	complemento varchar(80)
);

CREATE TABLE Clientes(
	id_cliente serial PRIMARY KEY,
	nome varchar(80) NOT NULL,
	cpf char(11) UNIQUE,
	endereco int REFERENCES enderecos(id_endereco)
);

drop type if exists cargos;
create type cargos AS enum ('Garçom', 'Gerente', 'Chefe Cozinha', 'Cozinheiro', 'Recepcionista', 'Entregador');

CREATE TABLE funcionarios(
	id_funcionario serial PRIMARY KEY,
	endereco int REFERENCES enderecos(id_endereco),
	nome varchar(50) NOT NULL,
	cargo cargos NOT NULL,
	ativo bool NOT NULL
);

--drop table mesas cascade;
CREATE TABLE mesas(
	id_mesa serial PRIMARY KEY,
	lugares int
);

CREATE TABLE pedidos(
	id_pedido serial PRIMARY KEY,
	fk_cliente int REFERENCES clientes(id_cliente),
	fk_prato int REFERENCES pratos(id_prato),
	mesa int REFERENCES mesas(id_mesa),
	data_pedido timestamp DEFAULT now(),
	comanda int NOT NULL
);

CREATE TABLE entregas(
	id_entrega serial PRIMARY KEY,
	comanda int NOT NULL,
	fk_endereco int REFERENCES enderecos(id_endereco),
	entregue bool DEFAULT false
);



-- inserções

INSERT INTO enderecos (rua, numero, bairro, cidade, estado, cep, complemento) VALUES
('Rua das Flores', '120', 'Centro', 'São Paulo', 'SP', '01001-000', 'Apto 12'),
('Av. Paulista', '1578', 'Bela Vista', 'São Paulo', 'SP', '01310-200', 'Sala 45'),
('Rua Bahia', '55', 'Funcionários', 'Belo Horizonte', 'MG', '30160-010', NULL),
('Rua XV de Novembro', '890', 'Centro', 'Curitiba', 'PR', '80020-310', 'Fundos'),
('Av. Atlântica', '2200', 'Copacabana', 'Rio de Janeiro', 'RJ', '22041-001', NULL),
('Rua das Acácias', '45', 'Jardim Europa', 'Porto Alegre', 'RS', '90450-010', NULL),
('Rua do Comércio', '300', 'Centro', 'Campinas', 'SP', '13010-110', 'Loja 2'),
('Av. Brasil', '1500', 'Jardim América', 'Goiânia', 'GO', '74230-010', NULL),
('Rua Amazonas', '999', 'Centro', 'Manaus', 'AM', '69010-060', NULL),
('Rua São João', '77', 'Centro', 'Florianópolis', 'SC', '88010-250', 'Casa');


INSERT INTO pratos (nome, preco, descricao) VALUES
('Feijoada Completa', 45.90, 'Feijoada tradicional com acompanhamentos'),
('Filé à Parmegiana', 52.00, 'Filé empanado com molho e queijo'),
('Lasanha Bolonhesa', 39.50, 'Massa fresca com molho bolonhesa'),
('Moqueca de Peixe', 68.00, 'Peixe cozido com leite de coco'),
('Hambúrguer Artesanal', 32.90, 'Carne artesanal e pão brioche'),
('Pizza Margherita', 42.00, 'Molho de tomate, mussarela e manjericão'),
('Risoto de Cogumelos', 47.80, 'Risoto cremoso com cogumelos frescos'),
('Strogonoff de Frango', 36.00, 'Acompanha arroz e batata palha'),
('Salmão Grelhado', 74.90, 'Salmão com legumes salteados'),
('Espaguete Carbonara', 44.00, 'Clássico italiano');

insert into pratos(nome, preco)
values ('Brioche', 7.00);

INSERT INTO clientes (nome, cpf, endereco) VALUES
('João Silva', '12345678901', 1),
('Maria Oliveira', '23456789012', 2),
('Carlos Pereira', '34567890123', 3),
('Ana Souza', '45678901234', 4),
('Lucas Lima', '56789012345', 5),
('Fernanda Rocha', '67890123456', 6),
('Rafael Martins', '78901234567', 7),
('Juliana Costa', '89012345678', 8),
('Bruno Azevedo', '90123456789', 9),
('Patrícia Gomes', '01234567890', 10);

INSERT INTO funcionarios (nome, cargo, endereco, ativo) VALUES
('Marcos Almeida', 'Gerente', 1, true),
('Pedro Santos', 'Garçom', 2, true),
('Luciana Freitas', 'Recepcionista', 3, true),
('André Costa', 'Chefe Cozinha', 4, true),
('Roberto Nunes', 'Cozinheiro', 5, true),
('Camila Pires', 'Garçom', 6, true),
('Daniel Rocha', 'Entregador', 7, true),
('Paula Mendes', 'Garçom', 8, false),
('Fábio Teixeira', 'Cozinheiro', 9, true),
('Renata Lopes', 'Entregador', 10, true);

INSERT INTO mesas (lugares) VALUES
(2), (4), (4), (6), (2),
(8), (4), (6), (2), (10);


INSERT INTO pedidos (fk_cliente, fk_prato, mesa, comanda) VALUES
(1, 1, 1, 1001),
(2, 3, 2, 1002),
(3, 5, 3, 1003),
(4, 2, 4, 1004),
(5, 6, 5, 1005),
(6, 4, 6, 1006),
(7, 7, 7, 1007),
(8, 8, 8, 1008),
(9, 9, 9, 1009),
(10, 10, 10, 1010),
(1, 4, 2, 1011),
(2, 7, 3, 1012),
(3, 2, 1, 1013),
(4, 9, 5, 1014),
(5, 1, 4, 1015),
(6, 10, 6, 1016),
(7, 6, 7, 1017),
(8, 3, 8, 1018),
(9, 8, 9, 1019),
(10, 5, 10, 1020);

INSERT INTO entregas (comanda, fk_endereco, entregue) VALUES
(1001, 1, true),
(1002, 2, true),
(1003, 3, false),
(1004, 4, true),
(1005, 5, false),
(1006, 6, true),
(1007, 7, false),
(1008, 8, true),
(1009, 9, false),
(1010, 10, true);



select nome from clientes;


select nome, bairro from clientes 
join enderecos on endereco = id_endereco
join entregas on fk_endereco = endereco 
;





select * from pedidos
join mesas on fk_prato = id_mesa 
;

/*select clientes.nome, data_pedido, comanda, pratos.nome, preco from clientes
join pedidos on fk_cliente	 = id_cliente 
join pratos on id_prato = fk_prato
where preco between 30 and 60
;
*/ 

select clientes.nome, data_pedido, comanda, pratos.nome, preco from clientes
join pedidos on fk_cliente	 = id_cliente 
join pratos on id_prato = fk_prato
where preco >= 50
;



/*select clientes.nome, data_pedido, comanda, pratos.nome, preco from clientes
join pedidos on fk_cliente	 = id_cliente 
join pratos on id_prato = fk_prato
where preco not in (32, 52, 42)
;
*/ 


/*select clientes.nome, data_pedido, comanda, pratos.nome, preco from clientes
join pedidos on fk_cliente	 = id_cliente 
join pratos on id_prato = fk_prato
where clientes.nome like 'carlos%'
;
*/ 




--Faturamento total 
select * from pedidos
join pratos on id_prato = fk_prato
;


/*Faturamento total 
select sum(preco) pedidos
join pratos on id_prato = fk_prato
;*/



/*
--Quantidade de pedidos por clientes
select nome, count(nome) from clientes
join pedidos on id_cliente = fk_cliente
group by nome
--group by nome
order by nome 
;
*/


/*
--Quantidade de pedidos por clientes
select nome, fk_prato from clientes
join pedidos on id_cliente = fk_cliente
group by nome 
order by nome 
;

*/

--Quantidade de pedidos por clientes
select nome, count(fk_prato) from clientes
join pedidos on id_cliente = fk_cliente
group by nome 
order by nome 
;


--Media de todos os pedidos:
/*
select avg(preco) pedidos
join pratos on id_prato = fk_prato
;
*/

select clientes.nome, sum(pratos.preco) as Total_Gasto from clientes
join pedidos on id_cliente = fk_cliente
join pratos on fk_prato = id_prato 
group by clientes.nome
order by Total_Gasto desc 
;



select 
clientes.nome as Nome_cliente,
sum(pratos.preco) as "Total Gasto",
concat('R$ ', sum(pratos.preco)) 
from clientes 
join pedidos on id_cliente = fk_cliente
join pratos on fk_prato = id_prato
group by Nome_cliente
;

/*
--Pratos mais vendidos:
select nome, preco from pratos
join pedidos on fk_prato = id_prato 
group by nome, preco
order by nome
;
*/

/*
--Pratos mais vendidos:
select nome, count(preco) from pratos
join pedidos on fk_prato = id_prato 
group by nome, preco
order by nome
;
*/

 --Pratos mais vendidos:
 
create view vw_pratos_mais_vendidos as 
select nome, count(preco) from pratos
join pedidos on fk_prato = id_prato 
group by nome
order by nome
;

select * from vw_pratos_mais_vendidos;

















