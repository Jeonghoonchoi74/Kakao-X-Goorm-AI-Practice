show databases;

create database Task22;

use Task22;

-- 1. users 테이블 생성
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    subscription VARCHAR(20)
);

-- 2. movies 테이블 생성
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(200),
    genre VARCHAR(50)
);

-- 3. watch_history 테이블 생성
CREATE TABLE watch_history (
    history_id INT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    watched_at DATETIME,
    duration INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-- JOIN을 사용하여 한번이라도 영화를 본 적이 있는 사용자와 영화를 구하기
SELECT users.name, movies.title
FROM users
JOIN watch_history ON users.user_id = watch_history.user_id
JOIN movies ON watch_history.movie_id = movies.movie_id

-- INNER JOIN + GROUP BY 를 사용하여 각 장르별로 시청된 총 횟수 (watch_histroy 기준)를 구하기
SELECT movies.genre AS genre, COUNT(watch_history.history_id) AS watch_count
FROM movies
INNER JOIN watch_history ON movies.movie_id = watch_history.movie_id
GROUP BY movies.genre;

-- JOIN + GROUP BY + HAVING을 사용하여 총 시청 시간이 1000분 이상인 사용자들의 이름과 총 시청 시간을 출력하기
SELECT users.name, SUM(watch_history.duration) AS total_duration
FROM users
JOIN watch_history ON users.user_id = watch_history.user_id
GROUP BY users.name
HAVING total_duration >= 1000;

-- 복합 조건 + JOIN VIP 사용자 중에서 '액션' 장르의 영화를 시청한 사용자의 이름과 시청한 영화 제목을 출력하기
SELECT users.name, movies.title
FROM users
JOIN watch_history ON users.user_id = watch_history.user_id
JOIN movies ON watch_history.movie_id = movies.movie_id
WHERE users.subscription = 'VIP' AND movies.genre = '액션';

-- 서브쿼리 or GROUP BY MAX 가장 많이 시청된 영화의 제목과 그 시청 횟수를 출력
SELECT movies.title, COUNT(watch_history.history_id) AS watch_count
FROM movies
JOIN watch_history ON movies.movie_id = watch_history.movie_id
GROUP BY movies.title
ORDER BY watch_count DESC
LIMIT 1;

-- JOIN 없는 GROUP BY 고급 문제 각 구독 유형별로 영화를 시청한 평균 시청 시간 (Duration)을 구하기 (단, 시청한 적이 없는 구독 유저는 제외)
SELECT subscription, ROUND(AVG(avg_duration), 1) AS avg_duration
FROM (
    SELECT u.subscription, w.duration AS avg_duration
    FROM users u, watch_history w
    WHERE u.user_id = w.user_id
) AS user_watch_data
GROUP BY subscription;
