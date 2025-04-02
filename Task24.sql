/*
데일리미션 
문제1: 고객 데이터 전처리 및 NULL 값 처리
[배경]
마케팅 부서는 최근 수집된 고객 데이터를 기반으로 캠페인을 기획하려고 합니다. 하지만 일부 고객 정보가 누락되어 있어 분석을 위해 전처리가 필요합니다.
[테이블 구조 및 예시 데이터]
sql
복사편집
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, '홍길동', 'hong@example.com', 28, '남', '서울'),
(2, '김영희', NULL, NULL, '여', '부산'),
(3, '이철수', 'lee@example.com', 35, NULL, '대구'),
(4, NULL, 'choi@example.com', 42, '남', NULL),
(5, '박민수', NULL, NULL, NULL, '서울');

📝 문제
NULL 처리하기각 고객의 이름이 NULL인 경우, '이름없음' 으로 대체하여 조회하세요.
나이 정보 전처리나이(age)가 NULL인 경우 평균 나이로 대체하여 표시하세요. (소수점 첫째 자리까지 반올림)
이메일이 없는 고객 수 구하기이메일이 NULL인 고객 수를 계산하세요.
서울에 거주하는 고객 중 성별(gender)이 NULL인 사람의 customer_id를 조회하세요.
NULL 값이 하나라도 있는 고객 행 조회해서 출력하기

힌트:
COALESCE() 또는 IFNULL() 함수는 NULL 대체에 가장 흔히 사용됨.
ROUND() 함수로 평균값을 반올림 가능.
서브쿼리 안에서 AVG()는 NULL 제외하고 계산됨.
*/


show databases;

create table Task24;

use Task24;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, '홍길동', 'hong@example.com', 28, '남', '서울'),
(2, '김영희', NULL, NULL, '여', '부산'),
(3, '이철수', 'lee@example.com', 35, NULL, '대구'),
(4, NULL, 'choi@example.com', 42, '남', NULL),
(5, '박민수', NULL, NULL, NULL, '서울');

-- 문제 1: 이름이 NULL인 경우 '이름없음'으로 대체하여 조회
SELECT customer_id, IFNULL(name, '이름없음') AS name
FROM customers;

-- 문제 2: 나이가 NULL인 경우 평균 나이로 대체 (소수점 첫째 자리까지 반올림)
SELECT customer_id, name,
       ROUND(IFNULL(age, (SELECT AVG(age) FROM customers)), 1) AS age
FROM customers;

-- 문제 3: 이메일이 NULL인 고객 수 구하기
SELECT COUNT(*) AS email_null_count
FROM customers
WHERE email IS NULL;

-- 문제 4: 서울 거주 고객 중 성별이 NULL인 고객의 customer_id 조회
SELECT customer_id
FROM customers
WHERE city = '서울' AND gender IS NULL;

-- 문제 5: NULL 값이 하나라도 있는 고객 행 조회
SELECT *
FROM customers
WHERE name IS NULL
   OR email IS NULL
   OR age IS NULL
   OR gender IS NULL
   OR city IS NULL;