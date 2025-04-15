show databases;

create database Task23;

use Task23;

-- User 테이블 생성
CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    join_date DATE NOT NULL
);

-- Game 테이블 생성
CREATE TABLE Game (
    game_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    platform VARCHAR(50) NOT NULL
);

-- PlayLog 테이블 생성 (사용자의 게임 플레이 기록)
CREATE TABLE PlayLog (
    user_id INT,
    game_id INT,
    play_date DATE NOT NULL,
    play_time_minutes INT NOT NULL,
    PRIMARY KEY (user_id, game_id, play_date),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

-- Friendship 테이블 생성 (사용자 간의 친구 관계)
CREATE TABLE Friendship (
    user_id1 INT,
    user_id2 INT,
    since_date DATE NOT NULL,
    PRIMARY KEY (user_id1, user_id2),
    FOREIGN KEY (user_id1) REFERENCES User(user_id),
    FOREIGN KEY (user_id2) REFERENCES User(user_id),
    CHECK (user_id1 < user_id2) -- 중복 방지를 위한 제약조건
);

-- Review 테이블 생성 (사용자의 게임 리뷰)
CREATE TABLE Review (
    review_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

-- GameRecommendation 테이블 생성 (사용자 간의 게임 추천)
CREATE TABLE GameRecommendation (
    from_user INT,
    to_user INT,
    game_id INT,
    rec_date DATE NOT NULL,
    PRIMARY KEY (from_user, to_user, game_id),
    FOREIGN KEY (from_user) REFERENCES User(user_id),
    FOREIGN KEY (to_user) REFERENCES User(user_id),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

INSERT INTO User (user_id, username, join_date) VALUES
(1, 'alice', '2023-01-10'),
(2, 'bob', '2023-02-15'),
(3, 'charlie', '2023-03-01'),
(4, 'diana', '2023-03-10'),
(5, 'eric', '2023-04-05');

INSERT INTO Game (game_id, title, genre, platform) VALUES
(101, 'Apex Legends', 'FPS', 'PC'),
(102, 'Zelda: Breath of the Wild', 'Adventure', 'Switch'),
(103, 'Stardew Valley', 'Simulation', 'PC'),
(104, 'Overwatch 2', 'FPS', 'PC'),
(105, 'Hollow Knight', 'Metroidvania', 'PC');

INSERT INTO PlayLog (user_id, game_id, play_date, play_time_minutes) VALUES
(1, 101, '2023-05-01', 120),
(2, 101, '2023-05-02', 200),
(3, 101, '2023-05-03', 180),
(1, 102, '2023-05-04', 90),
(4, 103, '2023-05-05', 240),
(5, 104, '2023-05-06', 60),
(3, 105, '2023-05-07', 150),
(3, 103, '2023-05-08', 100);

INSERT INTO Friendship (user_id1, user_id2, since_date) VALUES
(1, 2, '2023-04-01'),
(1, 3, '2023-04-02'),
(2, 4, '2023-04-03'),
(2, 5, '2023-04-04'),
(3, 4, '2023-04-05');

INSERT INTO Review (review_id, user_id, game_id, rating, comment) VALUES
(201, 1, 101, 5, 'Awesome game'),
(202, 2, 101, 4, 'Fast paced'),
(203, 3, 101, 5, 'Very competitive'),
(204, 1, 102, 4, 'Beautiful world'),
(205, 3, 103, 5, 'Very relaxing'),
(206, 4, 103, 4, 'Charming'),
(207, 3, 105, 4, 'Challenging'),
(208, 2, 105, 3, 'Too hard');

INSERT INTO GameRecommendation (from_user, to_user, game_id, rec_date) VALUES
(1, 3, 101, '2023-06-01'),
(2, 3, 105, '2023-06-02'),
(4, 3, 103, '2023-06-03'),
(3, 1, 105, '2023-06-04');

-- 1. 사용자 목록 출력
SELECT username, join_date
FROM User;

-- 2. 플레이 목록 출력
SELECT User.username, Game.title
FROM User
JOIN PlayLog ON User.user_id = PlayLog.user_id
JOIN Game ON PlayLog.game_id = Game.game_id;

-- 3. 평점 5점 리뷰 목록
SELECT User.username, Game.title AS game_title, Review.rating
FROM User
JOIN Review ON User.user_id = Review.user_id
JOIN Game ON Review.game_id = Game.game_id
WHERE Review.rating = 5;

-- 4. 장르별 게임 수
SELECT genre, COUNT(game_id) as game_count
FROM Game
GROUP BY genre;

-- 5. 사용자별 친구 수
SELECT User.username, COUNT(*) AS friend_count
FROM User
JOIN (
SELECT user_id1 AS user_id FROM Friendship
UNION ALL
SELECT user_id2 AS user_id FROM Friendship
) AS all_friends ON User.user_id = all_friends.user_id
GROUP BY User.user_id, User.username;