CREATE DATABASE movie_streaming;
USE movie_streaming;

														-- TABLE CREATION --

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    city VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    release_year INT CHECK (release_year >= 1900),
    duration_minutes INT CHECK (duration_minutes > 0),
    language VARCHAR(50),
    rating DECIMAL(3,1) CHECK (rating BETWEEN 0 AND 10)
);

CREATE TABLE genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE movie_genre (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    plan_type VARCHAR(50) CHECK (plan_type IN ('Basic','Standard','Premium')),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE watch_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    watched_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    subscription_id INT,
    amount DECIMAL(8,2) CHECK (amount > 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_mode VARCHAR(30),
    FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id)
);

													  -- INSERTION OF VALUES --

INSERT INTO users (name, email, password, city) VALUES
('Rahul Sharma', 'rahul@gmail.com', 'pass123', 'Mumbai'),
('Amit Verma', 'amit@gmail.com', 'pass123', 'Delhi'),
('Neha Singh', 'neha@gmail.com', 'pass123', 'Pune'),
('Priya Patel', 'priya@gmail.com', 'pass123', 'Ahmedabad'),
('Rohan Mehta', 'rohan@gmail.com', 'pass123', 'Bangalore'),
('Anjali Gupta', 'anjali@gmail.com', 'pass123', 'Jaipur'),
('Karan Malhotra', 'karan@gmail.com', 'pass123', 'Chandigarh'),
('Sneha Iyer', 'sneha@gmail.com', 'pass123', 'Chennai'),
('Vikas Yadav', 'vikas@gmail.com', 'pass123', 'Noida'),
('Pooja Nair', 'pooja@gmail.com', 'pass123', 'Kochi');

SELECT * FROM users;

INSERT INTO movies (title, release_year, duration_minutes, language, rating) VALUES
('Inception', 2010, 148, 'English', 8.8),
('Interstellar', 2014, 169, 'English', 8.6),
('3 Idiots', 2009, 170, 'Hindi', 8.4),
('Dangal', 2016, 161, 'Hindi', 8.3),
('KGF Chapter 1', 2018, 156, 'Kannada', 8.2),
('Bahubali', 2015, 159, 'Telugu', 8.1),
('Drishyam', 2015, 163, 'Hindi', 8.2),
('Avengers Endgame', 2019, 181, 'English', 8.4),
('Jawan', 2023, 169, 'Hindi', 7.8),
('Pathaan', 2023, 146, 'Hindi', 7.2);

SELECT * FROM MOVIES;

INSERT INTO genres (genre_name) VALUES
('Action'),
('Drama'),
('Sci-Fi'),
('Thriller'),
('Comedy'),
('Romance'),
('Adventure'),
('Crime'),
('Fantasy'),
('Biography');

SELECT * FROM GENRES;

INSERT INTO movie_genre (movie_id, genre_id) VALUES
(1, 3),
(2, 3),
(3, 5),
(4, 2),
(5, 1),
(6, 9),
(7, 4),
(8, 7),
(9, 1),
(10, 1);

SELECT * FROM MOVIE_GENRE;

INSERT INTO subscriptions (user_id, plan_type, start_date, end_date) VALUES
(1, 'Premium', '2025-01-01', '2025-02-01'),
(2, 'Standard', '2025-01-05', '2025-02-05'),
(3, 'Basic', '2025-01-10', '2025-02-10'),
(4, 'Premium', '2025-01-12', '2025-02-12'),
(5, 'Standard', '2025-01-15', '2025-02-15'),
(6, 'Basic', '2025-01-18', '2025-02-18'),
(7, 'Premium', '2025-01-20', '2025-02-20'),
(8, 'Standard', '2025-01-22', '2025-02-22'),
(9, 'Basic', '2025-01-25', '2025-02-25'),
(10, 'Premium', '2025-01-28', '2025-02-28');


SELECT * FROM SUBSCRIPTIONS;

INSERT INTO watch_history (user_id, movie_id) VALUES
(1, 1),
(2, 3),
(3, 5),
(4, 2),
(5, 4),
(6, 6),
(7, 8),
(8, 7),
(9, 9),
(10, 10);

SELECT * FROM WATCH_HISTORY;


INSERT INTO reviews (user_id, movie_id, rating, review_text) VALUES
(1, 1, 5, 'Amazing movie'),
(2, 3, 4, 'Very funny'),
(3, 5, 5, 'Superb action'),
(4, 2, 4, 'Mind blowing'),
(5, 4, 5, 'Very inspiring'),
(6, 6, 4, 'Great visuals'),
(7, 8, 5, 'Best Marvel movie'),
(8, 7, 4, 'Good thriller'),
(9, 9, 3, 'Average movie'),
(10, 10, 3, 'One-time watch');

SELECT * FROM REVIEWS;

INSERT INTO payments (subscription_id, amount, payment_mode) VALUES
(1, 499, 'UPI'),
(2, 299, 'Card'),
(3, 199, 'UPI'),
(4, 499, 'Net Banking'),
(5, 299, 'UPI'),
(6, 199, 'Card'),
(7, 499, 'UPI'),
(8, 299, 'Net Banking'),
(9, 199, 'UPI'),
(10, 499, 'Card');

SELECT * FROM PAYMENTS;


													-- QUERY EXECUTION --


-- FETCH MOVIES WITH RATING ABOVE 8 --

SELECT title, rating FROM movies
WHERE rating > 8;


--  MOVIES WATCHED BY EACH USER --

SELECT 
  u.name AS user_name,
  GROUP_CONCAT(
    DISTINCT CONCAT(m.title, ' (', DATE(w.watched_on), ')')
    ORDER BY w.watched_on DESC
    SEPARATOR ', '
  ) AS movies_last_watched
FROM watch_history w
JOIN users u ON w.user_id = u.user_id
JOIN movies m ON w.movie_id = m.movie_id
GROUP BY u.user_id, u.name;









-- NUMBER OF MOVIES PER GENRE --

SELECT g.genre_name, COUNT(mg.movie_id) AS total_movies
FROM genres g
JOIN movie_genre mg ON g.genre_id = mg.genre_id
GROUP BY g.genre_name;


-- Movies whose rating is higher than  ALL Hindi Movies

SELECT title, rating
FROM movies
WHERE rating > ALL (
  SELECT rating FROM movies WHERE language = 'Hindi'
);


-- Movies whose rating is higher than ANY Hollywood movie --

SELECT title, rating
FROM movies
WHERE rating > ANY (
    SELECT rating FROM movies WHERE language = 'English'
);

-- NUMBER OF MOVIES BY LANGUAGE --

SELECT language, COUNT(*) AS total_movies
FROM movies
GROUP BY language;


-- highest and lowest rated movie --

SELECT 
  title, 
  rating,
  CASE 
    WHEN rating = (SELECT MAX(rating) FROM movies) THEN 1
    WHEN rating = (SELECT MIN(rating) FROM movies) THEN 2
  END AS sort_order
FROM movies
WHERE rating = (SELECT MAX(rating) FROM movies)
   OR rating = (SELECT MIN(rating) FROM movies)
ORDER BY sort_order;




-- total revenue generated by movies --

SELECT Language , SUM(amount)  AS total_revenue
FROM payments JOIN movies 
GROUP BY Language ;


-- top 5 highest-rated movies --

SELECT title, rating
FROM movies
ORDER BY rating DESC
LIMIT 5;

-- users who watched more than 1 movie --

SELECT u.name, COUNT(w.movie_id) AS movies_watched
FROM users u
JOIN watch_history w ON u.user_id = w.user_id
GROUP BY u.name
HAVING COUNT(w.movie_id) > 1;

-- USERS WITH PREMIUM PLAN --

SELECT u.name, u.city
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
WHERE s.plan_type = 'Premium';


-- MOST WATCHED MOVIES --

SELECT m.title, COUNT(w.movie_id) AS watch_count
FROM watch_history w
JOIN movies m ON w.movie_id = m.movie_id
GROUP BY m.title
ORDER BY watch_count DESC
LIMIT 1;


-- MOST PREFERRED PAYMENT MODE --

SELECT 
  p.payment_mode,
  COUNT(DISTINCT s.user_id) AS total_users
FROM payments p
JOIN subscriptions s ON p.subscription_id = s.subscription_id
GROUP BY p.payment_mode
ORDER BY total_users DESC;



-- CREATE INDEX --

CREATE INDEX idx_movie_rating ON movies(rating);

SELECT * FROM MOVIES WHERE RATING>8.5;

CREATE INDEX idx_payments_payment_mode ON payments(Payment_mode);

SELECT * FROM PAYMENTS WHERE Payment_mode ='UPI'


                                          -- AUTOMATION & SECURITY --
									
-- Stored Procedure --

DELIMITER //

CREATE PROCEDURE GetMoviesByYear(IN rel_year INT)
BEGIN
    SELECT 
        title, 
        language, 
        rating
    FROM movies
    WHERE release_year = rel_year
    ORDER BY rating DESC;
END //

DELIMITER ;

CALL GetMoviesByYear(2023);






-- TRIGGER (TO CHECK RATING BETWEEN 1-5) --

DELIMITER //
CREATE TRIGGER check_review_rating
BEFORE INSERT ON reviews
FOR EACH ROW
BEGIN
    IF NEW.rating > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating must be between 1 and 5';
    END IF;
END //
DELIMITER ;

SELECT * FROM REVIEWS;


-- TRANSACTIONS --


START TRANSACTION;

INSERT INTO users (name, email, password, city)
VALUES ('Ramesh Shah;', 'ramesh.shah@gmail.com', 'pass123', 'Mumbai');

INSERT INTO subscriptions (user_id, plan_type, start_date, end_date)
VALUES (LAST_INSERT_ID(), 'Premium', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 MONTH));

COMMIT;


SELECT * FROM SUBSCRIPTIONS ;





                                                   --  JSON --

DESCRIBE movies;
ALTER TABLE movies ADD COLUMN metadata JSON;

-- BOX OFFICE PERFORMANCE --

UPDATE movies
SET metadata = JSON_SET(
  COALESCE(metadata, JSON_OBJECT()),
  '$.box_office',
  CASE
    WHEN title = 'Inception' THEN JSON_OBJECT(
      'india', '50 Crore INR',
      'overseas', '550M USD',
      'worldwide', '829M USD'
    )
    WHEN title = 'Interstellar' THEN JSON_OBJECT(
      'india', '45 Crore INR',
      'overseas', '630M USD',
      'worldwide', '677M USD'
    )
    WHEN title = '3 Idiots' THEN JSON_OBJECT(
      'india', '202 Crore INR',
      'overseas', '66 Crore INR',
      'worldwide', '268 Crore INR'
    )
    WHEN title = 'Dangal' THEN JSON_OBJECT(
      'india', '387 Crore INR',
      'overseas', '1,574 Crore INR',
      'worldwide', '1,961 Crore INR'
    )
    WHEN title = 'KGF Chapter 1' THEN JSON_OBJECT(
      'india', '238 Crore INR',
      'overseas', '12 Crore INR',
      'worldwide', '250 Crore INR'
    )
    WHEN title = 'Bahubali' THEN JSON_OBJECT(
      'india', '420 Crore INR',
      'overseas', '230 Crore INR',
      'worldwide', '650 Crore INR'
    )
    WHEN title = 'Drishyam' THEN JSON_OBJECT(
      'india', '60 Crore INR',
      'overseas', '10 Crore INR',
      'worldwide', '70 Crore INR'
    )
    WHEN title = 'Avengers Endgame' THEN JSON_OBJECT(
      'india', '373 Crore INR',
      'overseas', '2.4B USD',
      'worldwide', '2.79B USD'
    )
    WHEN title = 'Jawan' THEN JSON_OBJECT(
      'india', '640 Crore INR',
      'overseas', '400 Crore INR',
      'worldwide', '1,040 Crore INR'
    )
    WHEN title = 'Pathaan' THEN JSON_OBJECT(
      'india', '524 Crore INR',
      'overseas', '543 Crore INR',
      'worldwide', '1,067 Crore INR'
    )
  END
);

SELECT * FROM MOVIES;



  -- TESTING AND DEBUGGING --

-- Should fail (CHECK)
INSERT INTO movies (title, release_year, duration_minutes, language, rating)
VALUES ('Test', 1800, -5, 'English', 12);

-- Debug
EXPLAIN
SELECT m.title, COUNT(w.movie_id)
FROM movies m JOIN watch_history w ON m.movie_id=w.movie_id
GROUP BY m.title;





