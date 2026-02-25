
DROP TABLE IF EXISTS historico_preco;
DROP TABLE IF EXISTS vendas;
DROP TABLE IF EXISTS produtos;

create table produtos(
id_produto serial primary key,
nome varchar(80) not null, 
estoque int(50) not null,
preco numeric(10,2) not null check(preco >=0)
);

create table vendas(
id_venda serial primary key,
data_venda date,
produto_vendido INT references produtos(id_produto),
quantidade INT
);

create table historico_preco(
id_historico_preco serial primary key,
id_produto int,
preco_antigo numeric(10,2),
preco_novo numeric(10,2),
data_alteracao timestamp default current_timestamp
);

insert into produtos (nome, estoque, preco)
values ('Notebook', 10, '3000.00');


--Trigger1
create or replace function registrar_historico_preco()
returns trigger as $$
begin 
		if new.preco <> old.preco then 
		insert into historico_preco (id_produto, preco_antigo, preco_novo)
		values (old.id_produto, old.preco, new.preco);
	end if ;
	return new;
end;
$$ language plpgsql

create trigger trigger_historico_preco
before update on produtos
for each row 
execte function registrar_historico_preco();

--trigger 2, baixa no estoque

create or replace function baixar_estoque()
returns trigger as $$
begin
	update produtos
	set estoque = estoque - new.quantidade
	where id_produto = new.produto_vendido;

	return new;
end
$$ language plpgsql

CREATE TRIGGER trigger_baixa_estoque
AFTER INSERT ON vendas
FOR EACH ROW
EXECUTE FUNCTION baixar_estoque();



-- Teste 1: Alterar preço (deve registrar no histórico)
UPDATE produtos
SET preco = 3200.00
WHERE id_produto = 1;

-- Ver histórico
SELECT * FROM historico_preco;

-- Teste 2: Inserir venda (deve baixar estoque automaticamente)
INSERT INTO vendas (data_venda, produto_vendido, quantidade)
VALUES (CURRENT_DATE, 1, 2);

-- Ver estoque atualizado
SELECT * FROM produtos;



















