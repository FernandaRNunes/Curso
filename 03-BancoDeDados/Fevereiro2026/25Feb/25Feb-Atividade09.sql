--Criar uma trigger para quando o registro de uma venda for deletado o estoque seja devolvido.
-

drop table if exists vendas cascade;
drop table if exists historico_produtos cascade;
drop table if exists produtos cascade;

create table produtos (
	id_produto serial primary key,
	nome varchar(50) not null,
	estoque int not null default 0,
	preco numeric(10,2) not null check (preco >= 0)
);


create table vendas (
	id_venda serial primary key,
	data_venda timestamp not null default now(),
	produto_vendido int not null references produtos(id_produto),
	quantidade int not null check (quantidade > 0)
);


create table historico_produtos(
	id_historico_produto serial primary key,
	data_mudanca timestamp default now(),
	preco_antigo numeric(10,2) not null,
	preco_novo numeric(10,2) not null,
	id_produto int not null
);

insert into produtos(nome, estoque, preco)
values 
('Mouse', 10, 69.90),
('Teclado', 15, 129.90),
('Monitor', 5, 899.90);

-- Automatizar historico de mudança do preço dos produtos

create or replace function inserir_historico_preco()
returns trigger as $$
begin
	if (old.preco != new.preco) then
		insert into historico_produtos(preco_antigo, preco_novo, id_produto)
		values (old.preco , new.preco, old.id_produto);
	end if;

	return new;
end
$$ language plpgsql;

create trigger trg_mudanca_preco
after update on produtos
for each row
execute function inserir_historico_preco();

-- Automatizar quando produto é vendido descontar do estoque

create or replace function diminuir_estoque()
returns trigger as $$
declare
	estoque_produto int := (select estoque from produtos
		where id_produto = new.produto_vendido);
begin
	if (new.quantidade <= estoque_produto ) then
		update produtos
		set estoque = estoque - new.quantidade
		where id_produto = new.produto_vendido;
	else
		raise exception 'Estoque insuficiente';
	end if;

	return new;
end
$$ language plpgsql;

create trigger trg_venda_produto
after insert on vendas
for each row
execute function diminuir_estoque();

-- Automatizar quando venda for deletada devolver estoque

create or replace function devolver_estoque()
returns trigger as $$
begin
	update produtos
	set estoque = estoque + old.quantidade
	where id_produto = old.produto_vendido;

	return old;
end
$$ language plpgsql;

create trigger trg_devolver_estoque
after delete on vendas
for each row
execute function devolver_estoque();





































