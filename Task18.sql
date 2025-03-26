
show databases;
CREATE DATABASE Task18;
use Task18;

-- customers 테이블 생성
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(100),
    age INT,
    city VARCHAR(50)
);

-- products 테이블 생성
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price INT,
    stock INT
);

-- orders 테이블 생성
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- 새로운 고객 김철수 추가
INSERT INTO customers (name, email, age, city) 
VALUES ('김철수', 'kim@example.com', 28, 'Seoul');

-- AirPods Pro 상품 추가
INSERT INTO products (name, price, stock) 
VALUES ('AirPods Pro', 329000, 20);

-- 나이가 30 이상인 고객들의 이름과 나이 조회
SELECT name, age 
FROM customers 
WHERE age >= 30;

-- 가격이 100000원 이상이고 재고가 10개 이하인 상품 조회
SELECT * 
FROM products 
WHERE price >= 100000 AND stock <= 10;

-- Seoul에 거주하는 고객의 이메일만 출력
SELECT email 
FROM customers 
WHERE city = 'Seoul';

-- 2024년 이후 주문된 주문 내역 조회
SELECT * 
FROM orders 
WHERE order_date >= '2024-01-01';

-- 김철수의 이메일 변경
UPDATE customers 
SET email = 'kimcs@example.com' 
WHERE name = '김철수';

-- AirPods Pro의 재고 업데이트
UPDATE products 
SET stock = 25 
WHERE name = 'AirPods Pro';

-- 도시가 Busan인 고객들 삭제
DELETE FROM customers 
WHERE city = 'Busan';

-- 재고가 0인 상품들 삭제
DELETE FROM products 
WHERE stock = 0;
