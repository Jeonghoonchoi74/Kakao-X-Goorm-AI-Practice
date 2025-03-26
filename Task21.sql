create database task21;

use task21;

drop tables users, posts;

create table users (
	id int primary key,
    username varchar (50),
    age int,
    join_date date
    );

create table posts (
	id int primary key,
    user_id int,
    content text,
    view_count int,
    ad_revenue decimal(10,2),
    is_public boolean,
    created_at datetime,
    foreign key (user_id) references users (id)
    );

insert into users(id, username, age, join_date) values
(1, 'alice', 25, '2024-01-10'),
(2, 'bob', 32, '2024-01-15'),
(3, 'charlie', 41, '2024-02-01');

insert into posts (id, user_id, content, view_count, ad_revenue, is_public, created_at) values
(101, 1, 'Hello world!', 120, 15.50, TRUE ,'2025-03-20 09:00'),
(102, 2, 'Good morning', 300, 42.75, TRUE, '2025-03-20 10:30'),
(103, 3, 'SQL is fun!', 80, 0.00, FALSE, '2025-03-21 14:00'),
(104, 1, '광고 테스트', 50, 5.00, TRUE, '2025-03-22 11:00');


SELECT COUNT(*) 
FROM posts;

SELECT SUM(view_count) 
FROM posts; 

SELECT ROUND(AVG(ad_revenue), 2) 
FROM posts 
WHERE ad_revenue > 0;

SELECT user_id, SUM(ad_revenue) 
FROM posts 
GROUP BY user_id;

SELECT id, ad_revenue 
FROM posts 
WHERE ad_revenue = (SELECT MAX(ad_revenue) FROM posts);

SELECT id, view_count, ad_revenue, ROUND((ad_revenue / view_count),4) AS revenue_per_view
FROM posts 
WHERE view_count > 0 and ad_revenue > 0
ORDER BY revenue_per_view DESC
LIMIT 1;


SELECT ROUND(AVG(view_count), 2) AS avg_view_count, 
       ROUND(AVG(ad_revenue), 2) AS avg_ad_revenue
FROM posts
WHERE is_public = TRUE;




    