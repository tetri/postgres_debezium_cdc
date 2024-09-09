CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    salesperson_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(10, 2) DEFAULT 0,
    commission DECIMAL(10, 2) DEFAULT 0,
    region VARCHAR(50),
    customer_location VARCHAR(100),
    customer_name VARCHAR(100),
    salesperson_name VARCHAR(100)
);

ALTER TABLE orders REPLICA IDENTITY FULL;

CREATE TEMP TABLE region_location_mapping (
    region VARCHAR(50),
    location VARCHAR(100)
);

INSERT INTO region_location_mapping (region, location) VALUES
    ('Norte', 'Acre'),
    ('Norte', 'Amapá'),
    ('Norte', 'Amazonas'),
    ('Norte', 'Pará'),
    ('Norte', 'Rondônia'),
    ('Norte', 'Roraima'),
    ('Norte', 'Tocantins'),
    ('Nordeste', 'Alagoas'),
    ('Nordeste', 'Bahia'),
    ('Nordeste', 'Ceará'),
    ('Nordeste', 'Maranhão'),
    ('Nordeste', 'Paraíba'),
    ('Nordeste', 'Pernambuco'),
    ('Nordeste', 'Piauí'),
    ('Nordeste', 'Rio Grande do Norte'),
    ('Nordeste', 'Sergipe'),
    ('Sudeste', 'Espírito Santo'),
    ('Sudeste', 'Minas Gerais'),
    ('Sudeste', 'Rio de Janeiro'),
    ('Sudeste', 'São Paulo'),
    ('Sul', 'Paraná'),
    ('Sul', 'Rio Grande do Sul'),
    ('Sul', 'Santa Catarina'),
    ('Centro-Oeste', 'Distrito Federal'),
    ('Centro-Oeste', 'Goiás'),
    ('Centro-Oeste', 'Mato Grosso'),
    ('Centro-Oeste', 'Mato Grosso do Sul');

CREATE TEMP TABLE salesperson_mapping (
    salesperson_id INT,
    salesperson_name VARCHAR(100)
);

INSERT INTO salesperson_mapping (salesperson_id, salesperson_name) VALUES
    (1, 'João Silva'),
    (2, 'Maria Oliveira'),
    (3, 'Pedro Souza'),
    (4, 'Ana Costa'),
    (5, 'Carlos Pereira'),
    (6, 'Fernanda Lima'),
    (7, 'Luiz Mendes'),
    (8, 'Mariana Ramos'),
    (9, 'Gabriel Martins'),
    (10, 'Juliana Alves'),
    (11, 'Rodrigo Gonçalves'),
    (12, 'Paula Fernandes'),
    (13, 'Rafael Cardoso'),
    (14, 'Bianca Rocha'),
    (15, 'Diego Santana'),
    (16, 'Carla Castro'),
    (17, 'Vitor Gomes'),
    (18, 'Isabela Ribeiro'),
    (19, 'André Souza'),
    (20, 'Bruna Costa'),
    (21, 'Guilherme Cunha'),
    (22, 'Larissa Lima'),
    (23, 'Leonardo Barros'),
    (24, 'Rita Santos'),
    (25, 'Marcelo Moreira'),
    (26, 'Aline Duarte'),
    (27, 'Lucas Nunes'),
    (28, 'Patrícia Freitas'),
    (29, 'Thiago Vieira'),
    (30, 'Camila Barbosa'),
    (31, 'Danilo Neves'),
    (32, 'Flávia Araújo'),
    (33, 'Ricardo Teixeira'),
    (34, 'Tainá Silva'),
    (35, 'Eduardo Lima'),
    (36, 'Adriana Matos'),
    (37, 'Felipe Campos'),
    (38, 'Roberta Souza'),
    (39, 'Daniel Dias'),
    (40, 'Mônica Nogueira'),
    (41, 'Sérgio Alves'),
    (42, 'Vanessa Moura'),
    (43, 'Renato Farias'),
    (44, 'Helena Rocha'),
    (45, 'Fábio Cardoso'),
    (46, 'Paula Mendes'),
    (47, 'Otávio Fernandes'),
    (48, 'Tânia Gomes'),
    (49, 'Rogério Correia'),
    (50, 'Simone Duarte'),
    (51, 'Bruno Reis'),
    (52, 'Cíntia Barbosa'),
    (53, 'Jorge Pinto'),
    (54, 'Tatiane Almeida'),
    (55, 'Murilo Braga'),
    (56, 'Sofia Santos'),
    (57, 'Wagner Souza'),
    (58, 'Melissa Ramos'),
    (59, 'Leandro Martins'),
    (60, 'Ariane Oliveira');

CREATE TEMP TABLE customer_mapping (
    customer_id INT,
    customer_name VARCHAR(100)
);

INSERT INTO customer_mapping (customer_id, customer_name) VALUES
    (1, 'Agropecuária Silva'),
    (2, 'Fazenda Oliveira'),
    (3, 'Sítio do Pedro'),
    (4, 'Chácara da Ana'),
    (5, 'Fazenda Pereira'),
    (6, 'Sítio São João'),
    (7, 'Fazenda Mendes'),
    (8, 'Agropecuária Ramos'),
    (9, 'Sítio Martins'),
    (10, 'Fazenda Alves'),
    (11, 'Chácara Gonçalves'),
    (12, 'Fazenda Fernandes'),
    (13, 'Agropecuária Cardoso'),
    (14, 'Sítio Rocha'),
    (15, 'Chácara Santana'),
    (16, 'Fazenda Castro'),
    (17, 'Sítio Gomes'),
    (18, 'Fazenda Ribeiro'),
    (19, 'Chácara Souza'),
    (20, 'Fazenda Costa'),
    (21, 'Sítio Cunha'),
    (22, 'Chácara Lima'),
    (23, 'Fazenda Barros'),
    (24, 'Agropecuária Santos'),
    (25, 'Fazenda Moreira'),
    (26, 'Sítio Duarte'),
    (27, 'Chácara Nunes'),
    (28, 'Agropecuária Freitas'),
    (29, 'Fazenda Vieira'),
    (30, 'Sítio Barbosa'),
    (31, 'Agropecuária Neves'),
    (32, 'Chácara Araújo'),
    (33, 'Fazenda Teixeira'),
    (34, 'Sítio Silva'),
    (35, 'Agropecuária Lima'),
    (36, 'Chácara Matos'),
    (37, 'Fazenda Campos'),
    (38, 'Sítio Souza'),
    (39, 'Fazenda Dias'),
    (40, 'Agropecuária Nogueira'),
    (41, 'Sítio Alves'),
    (42, 'Chácara Moura'),
    (43, 'Fazenda Farias'),
    (44, 'Agropecuária Rocha'),
    (45, 'Sítio Cardoso'),
    (46, 'Fazenda Mendes'),
    (47, 'Chácara Fernandes'),
    (48, 'Fazenda Gomes'),
    (49, 'Agropecuária Correia'),
    (50, 'Sítio Duarte'),
    (51, 'Fazenda Reis'),
    (52, 'Agropecuária Barbosa'),
    (53, 'Sítio Pinto'),
    (54, 'Chácara Almeida'),
    (55, 'Fazenda Braga'),
    (56, 'Sítio Santos'),
    (57, 'Agropecuária Souza'),
    (58, 'Fazenda Ramos'),
    (59, 'Sítio Martins'),
    (60, 'Fazenda Oliveira');

CREATE OR REPLACE FUNCTION generate_orders(num_records INT)
RETURNS VOID AS
$$
DECLARE
    i INT;
    random_date DATE;
    random_customer_id INT;
    random_salesperson_id INT;
    random_amount DECIMAL(10, 2);
    random_discount DECIMAL(10, 2);
    random_commission DECIMAL(10, 2);
    random_region VARCHAR(50);
    random_customer_location VARCHAR(100);
    random_customer_name VARCHAR(100);
    random_salesperson_name VARCHAR(100);

BEGIN
    FOR i IN 1..num_records LOOP
        random_date := CURRENT_DATE - (RANDOM() * 365 * 5)::INT;
        random_customer_id := (RANDOM() * 60)::INT + 1;
        random_salesperson_id := (RANDOM() * 60)::INT + 1;
        random_amount := (RANDOM() * 100000)::NUMERIC(10, 2);
        random_discount := (RANDOM() * 0.2 * random_amount)::NUMERIC(10, 2);
        random_commission := (0.05 * (random_amount - random_discount))::NUMERIC(10, 2);

        SELECT region, location INTO random_region, random_customer_location
        FROM region_location_mapping
        ORDER BY RANDOM()
        LIMIT 1;

        SELECT customer_name INTO random_customer_name
        FROM customer_mapping
        WHERE customer_id = random_customer_id;

        SELECT salesperson_name INTO random_salesperson_name
        FROM salesperson_mapping
        WHERE salesperson_id = random_salesperson_id;

        INSERT INTO orders (order_date, customer_id, salesperson_id, amount, discount, commission, region, customer_location, customer_name, salesperson_name)
        VALUES (random_date, random_customer_id, random_salesperson_id, random_amount, random_discount, random_commission, random_region, random_customer_location, random_customer_name, random_salesperson_name);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.update_random_orders(num_updates integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    i INT;
    random_order_id INT;
    random_amount DECIMAL(10, 2);
    random_discount DECIMAL(10, 2);
    random_commission DECIMAL(10, 2);
BEGIN
    FOR i IN 1..num_updates LOOP
        SELECT order_id INTO random_order_id
        FROM orders
        ORDER BY RANDOM()
        LIMIT 1;
        
        random_amount := (RANDOM() * 100000)::NUMERIC(10, 2);
        random_discount := (RANDOM() * 0.2 * random_amount)::NUMERIC(10, 2);
        random_commission := (0.05 * (random_amount - random_discount))::NUMERIC(10, 2);
        
        UPDATE orders
        SET amount = random_amount,
            discount = random_discount,
            commission = random_commission
        WHERE order_id = random_order_id;
    END LOOP;
END
$function$
;

CREATE OR REPLACE FUNCTION delete_random_orders(num_deletes INT)
RETURNS VOID AS
$$
DECLARE
    i INT;
    random_order_id INT;
BEGIN
    FOR i IN 1..num_deletes LOOP
        SELECT order_id INTO random_order_id
        FROM orders
        ORDER BY RANDOM()
        LIMIT 1;

        DELETE FROM orders
        WHERE order_id = random_order_id;
    END LOOP;
END
$$ LANGUAGE plpgsql;

SELECT generate_orders(50100);

SELECT update_random_orders(10000);

SELECT delete_random_orders(100);