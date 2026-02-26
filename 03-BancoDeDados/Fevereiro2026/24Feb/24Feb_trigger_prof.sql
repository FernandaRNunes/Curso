 --Produtos
   -- id
   -- nome
   -- estoque
   -- preco

-- Vendas
   -- id
   -- data_venda
   -- produto_vendido
   -- quantidade


create table produtos(
	id_produto serial primary key,
	nome varchar(50) not null,
	estoque int not null default 0,
	preco numeric(10,2) not null check(preco >=0)
);

create table vendas(
	id_venda serial primary key,
	data_venda timestamp not null default now(),
	produto_vendido int not null references produtos(id_produto),
	quantidade int not null check (quantidade >0)
);


create table historico_produtos(
id serial primary key,
data_mudanca timestamp default now(),
preco_antigo numeric(10,2) not null,
preco_novo numeric(10,2) not null,
id_produto int not null
);

insert into produtos(nome, estoque, preco)
values ('Mouse', 10, 69.90);


-- Automatizar histórico de mudança do preço dos produtos
create or replace trigger trg_mudanca_preco
after update on produtos
for each row
execute function inserir_historico_precos;

create or replace function inserir_historico_precos()
returns trigger as $$
begin
	if (old.preco != new.preco) then
	insert into historico_produtos(preco_antigo, preco_novo, id_produto)
values (old.preco, new.preco, new.id);
	end if;
	return new;
end
$$ language plpgsql;

update produtos
set preco = 89.90
where id_produto =1;


-- Automatizar quando produto é vendido descontar do estoque
create or replace trigger trg_venda_produto
after insert on vendas
for each row 
execute function diminuir_estoque();

create or replace function diminuir_estoque().
returns trigger as $$
begin
	select estoque from produtos
	where id= new.produto_vendido; 

	if (new.quantidade <= (select estoque from produtos
	where id= new.produto_vendido)) then
	update produtos
	set estoque  = - new.quantidade
	where id - new.produto_vendido;
end if;
return new;
end
$$ language plpgsql

insert into vendas(quantidade, produto_vendido)
values (3,1);























































.