-- Criação das Tabelas
CREATE TABLE clientes (
id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
nome VARCHAR(100),
estado VARCHAR(2)
);
CREATE TABLE produtos (
id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
nome VARCHAR(100),
categoria VARCHAR(50),
preco DECIMAL(10,2)
);
CREATE TABLE vendas (
id_venda INTEGER PRIMARY KEY AUTOINCREMENT,
id_cliente INTEGER,
id_produto INTEGER,
data_venda DATE,
quantidade INTEGER,
valor_total DECIMAL(10,2),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
-- Inserção de Dados Automática
INSERT INTO clientes (nome, estado) VALUES
('Ana Souza', 'PR'), ('Carlos Lima', 'SP'), ('Mariana Silva', 'PR'), ('João Pedro',
'SC');
INSERT INTO produtos (nome, categoria, preco) VALUES
('Notebook', 'Eletrônicos', 3500.00), ('Mouse', 'Eletrônicos', 150.00),
('Cadeira Gamer', 'Móveis', 800.00), ('Mesa de Escritório', 'Móveis', 600.00);
INSERT INTO vendas (id_cliente, id_produto, data_venda, quantidade, valor_total)
VALUES
(1, 1, '2026-11-01', 1, 3500.00), (2, 2, '2026-11-02', 2, 300.00),
(1, 2, '2026-11-03', 1, 150.00), (3, 3, '2026-11-05', 1, 800.00),
(4, 4, '2026-11-06', 2, 1200.00), (2, 1, '2026-11-07', 1, 3500.00);

-- Consulta de dados
-- ds1
SELECT 
    p.categoria AS Categoria,
    SUM(v.valor_total) AS Total_Vendido
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.categoria;

-- ds2
SELECT 
    c.nome AS Cliente,
    SUM(v.valor_total) AS Total_Gasto
FROM vendas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING SUM(v.valor_total) > 1000;

--ds3
SELECT 
    nome AS Produto,
    categoria AS Categoria,
    preco AS Preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);
