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
	insert into historico_produtos(preco_antigo, preco_novo, id_produto)
values (old.preco, new.preco, new.id);
	return new;
end
$$ language plpgsql;

update produtos
set preco = 89.90
where id_produto =1;














-- Automatizar quando produto é vendido descontar do estoque