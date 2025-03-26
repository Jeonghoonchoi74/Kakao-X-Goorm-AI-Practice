-- 과제 1: 나만의 햄버거 추가하기
INSERT INTO burgers (name, price, gram, kcal, protein) 
VALUES ("BigMac", 5000, 300, 500, 20);

-- 과제 2: 내 정보 추가하기
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INTEGER,
    favorite_burger VARCHAR(50)
);

INSERT INTO customers (name, age, favorite_burger)
VALUES ('홍길동', 22, 'Double Spicy Burger');

-- 과제 3: 나만의 음료 추가하기
CREATE TABLE drinks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    price INTEGER,
    ml INTEGER
);

INSERT INTO drinks (name, price, ml)
VALUES ('Lemonade', 1800, 350);

-- 보너스 과제: 나만의 테이블 만들기
CREATE TABLE employees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(30),
  position VARCHAR(30)
);

INSERT INTO employees (name, position)
VALUES ('Jane', 'Manager'), ('Tom', 'Cashier');
