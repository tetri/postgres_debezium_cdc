CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    region VARCHAR(50)
);

ALTER TABLE orders REPLICA IDENTITY FULL;

CREATE OR REPLACE FUNCTION generate_orders(num_records INT)
RETURNS VOID AS
$$
DECLARE
    i INT;
    random_date DATE;
    random_customer_id INT;
    random_amount DECIMAL(10, 2);
    random_region VARCHAR(50);
    regions TEXT[] := ARRAY['North', 'South', 'East', 'West', 'Central', 'Northeast', 'Northwest', 'Southeast', 'Southwest', 'Midwest'];
BEGIN
    FOR i IN 1..num_records LOOP
        random_date := CURRENT_DATE - (RANDOM() * 365 * 5)::INT;
        random_customer_id := (RANDOM() * 1000)::INT + 1;
        random_amount := (RANDOM() * 100000)::NUMERIC(10, 2);
        random_region := regions[(RANDOM() * (ARRAY_LENGTH(regions, 1) - 1) + 1)::INT];

        INSERT INTO orders (order_date, customer_id, amount, region)
        VALUES (random_date, random_customer_id, random_amount, random_region);

        --PERFORM pg_sleep(.2);
    END LOOP;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.update_random_orders(num_updates integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    i INT;
    random_order_id INT;
    random_amount DECIMAL(10, 2);
    random_region VARCHAR(50);
    regions TEXT[] := ARRAY['North', 'South', 'East', 'West', 'Central', 'Northeast', 'Northwest', 'Southeast', 'Southwest', 'Midwest'];
BEGIN
    FOR i IN 1..num_updates LOOP
        SELECT order_id INTO random_order_id
        FROM orders
        ORDER BY RANDOM()
        LIMIT 1;
        
        random_amount := (RANDOM() * 100000)::NUMERIC(10, 2);
        random_region := regions[(RANDOM() * (ARRAY_LENGTH(regions, 1) - 1) + 1)::INT];

        UPDATE orders
        SET amount = random_amount,
            region = random_region
        WHERE order_id = random_order_id;
        
        --PERFORM pg_sleep(.2);
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
        
        --PERFORM pg_sleep(.2);
    END LOOP;
END
$$ LANGUAGE plpgsql;

select generate_orders(10000);

select update_random_orders(1000);

select delete_random_orders(1000);