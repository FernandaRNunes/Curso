--Restaurante


--Pratos
--Clientes
--Endereco
--Funcionarios
--Entregas
--Pedidos

CREATE TABLE pratos(
	id_prato serial PRIMARY KEY,
	 nome varchar(50) NOT NULL UNIQUE, 
	 preco numeric(7, 2) NOT NULL CHECK (preco <= 1000),
	 descricao text DEFAULT 'Sem informações'
);

CREATE TABLE clientes(
	id_cliente serial PRIMARY KEY,
	 nome varchar(80) NOT NULL, 
	 cpf char(11) UNIQUE,
	endereco int REFERENCES enderecos(id_endereco)
);

CREATE TABLE enderecos(
	id_endereco serial PRIMARY KEY, 
	 rua varchar(100)NOT NULL DEFAULT 'Sem nome',
	 numero varchar(20) NOT NULL DEFAULT 'S/N',
	 bairro varchar(50) NOT NULL,
	 cidade varchar(50) NOT null,
	 estado char(2) NOT null,
	 cep varchar(9),
	 complemento varchar(80)
);

CREATE TYPE cargos AS enum ('Garçom', 'Gerente', 'Chefe de Cozinha', 'Coziheiro', 'Recepcionista', 'Entregador')

CREATE TABLE funcionarios(
	id_funcionario serial PRIMARY KEY,
	 endereco int REFERENCES enderecos(id_endereco),
	 nome varchar(50) NOT NULL,
	 cargo cargos NOT NULL,
	 ativo bool NOT null
);

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
	comanda int NOT null
);
	
CREATE TABLE entregas(
	id_entrega serial PRIMARY KEY,
	comanda int NOT null, 
	fk_endereco int REFERENCES enderecos(id_endereco),
	entregue bool DEFAULT false
);


--Inserções

insert into pratos(nome, preco, descricao)
values ('Batata frita', 35.00, 'Porção de batata'), ('Tábua mista', 180.00, 'Carne, Frango, Peixe');


insert into pratos( nome, preco)
values ('Brioche', 7.00);

insert into clientes (nome)
values ('Fulaninho'),('Bezinho'), ('Cezinho'), ('Dezinho');

insert into funcionarios (nome, cargo, ativo)
values ('Garçom 1', 'Garçom', true);

insert  into mesas (lugares)
values (4);

insert into pedidos(fk_cliente, fk_prato, mesa, comanda)
values (1, 2, 1, 001);



select * from clientes;


select nome from clientes;
































































































