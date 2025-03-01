-- TABLE CITY
CREATE TABLE city (
    id INT PRIMARY KEY,
    city_name VARCHAR(255),
    lat DECIMAL(9, 6),
    long DECIMAL(9, 6),
    county_id INT
);

INSERT INTO city (id, city_name, lat, long, county_id)
VALUES
    (1, 'Berlin', 52.5200, 13.4050, 101),
    (2, 'Belgrade', 44.8176, 20.4633, 102),
    (3, 'Zagreb', 45.8131, 15.978, 103),
    (4, 'New York', 40.7128, -74.0060, 104),
    (5, 'Los Angeles', 34.0522, -118.2437, 105),
    (6, 'Warsaw', 52.2298, 21.0118, 106);


-- TABLE Customer
CREATE TABLE customer (
    id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    city_id INT,
    customer_address VARCHAR(255),
    next_call_date DATE,
    ts_inserted TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customer (id, customer_name, city_id, customer_address, next_call_date)
VALUES
    (1, 'Jewelry Store', 1, '123 Main St, Berlin, Germany', '2025-03-10'),
    (2, 'Bakery', 2, '456 Oak St, Belgrade, Serbia', '2025-03-15'),
    (3, 'Cafe', 3, '789 Pine St, Zagreb, Croatia', '2025-03-20'),
    (4, 'Restaurant', 4, '101 Maple St, New York, NY', '2025-03-25');


-- THE COUNTRY TABLE
CREATE TABLE country (
    id INT PRIMARY KEY,
    country_name VARCHAR(255),
    country_name_eng VARCHAR(255),
    country_code VARCHAR(10)
);

INSERT INTO country (id, country_name, country_name_eng, country_code)
VALUES
    (1, 'Deutschland', 'Germany', 'DE'),
    (2, 'Srbija', 'Serbia', 'RS'),
    (3, 'Hrvatska', 'Croatia', 'HR'),
    (4, 'United States of America', 'United States', 'US'),
    (5, 'Polska', 'Poland', 'PL'),
    (6, 'España', 'Spain', 'ES'),
    (7, 'Rossiya', 'Russia', 'RU');


-- TASK 1
--  (join multiple tables using left join)
-- List all Countries and customers related to these countries.
-- For each country displaying its name in English, the name of the city customer is located in as 
-- well as the name of the customer. 
-- Return even countries without related cities and customers.
SELECT 
    c.country_name_eng AS country_name,
    ci.city_name AS city_name,
    cu.customer_name AS customer_name
FROM 
    country c
LEFT JOIN 
    city ci ON c.id = ci.county_id
LEFT JOIN 
    customer cu ON ci.id = cu.city_id
ORDER BY 
    c.country_name_eng, ci.city_name, cu.customer_name;



 -- TASK 2
-- (join multiple tables using both left and inner join)
-- Return the list of all countries that have pairs(exclude countries which are not referenced by any 
-- city). For such pairs return all customers.
-- Return even pairs of not having a single customer
SELECT 
    c.country_name_eng AS country_name,
    ci.city_name AS city_name,
    cu.customer_name AS customer_name
FROM 
    country c
INNER JOIN 
    city ci ON c.id = ci.county_id  -- Ensure country is referenced by at least one city
LEFT JOIN 
    customer cu ON ci.id = cu.city_id  -- Include even if there are no customers
ORDER BY 
    c.country_name_eng, ci.city_name, cu.customer_name;


