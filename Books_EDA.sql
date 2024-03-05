-- Create database
 
 CREATE DATABASE Amazon_Books;
 
  
  -- Create table 
  
  CREATE TABLE Genre(
         Title VARCHAR(100) NOT NULL PRIMARY KEY,
         Number_of_Sub_genres INT NOT NULL,
         URL VARCHAR(255) NOT NULL UNIQUE
         );
  
  
  CREATE TABLE Sub_Genre(
         Title VARCHAR(100) NOT NULL PRIMARY KEY,
         Main_genre VARCHAR(100) NOT NULL,
         No_of_books INT NOT NULL,
         URLs VARCHAR(255) NOT NULL UNIQUE
         );
  
  
  CREATE TABLE Books (
    Title VARCHAR(200) NOT NULL,
    Author VARCHAR(50) NOT NULL,
    Main_genre VARCHAR(100) NOT NULL,
    Sub_genre VARCHAR(100) NOT NULL,
    Type VARCHAR(20) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Rating DECIMAL(5,2) NOT NULL,
    No_of_people_rated INT NOT NULL,
    URLs VARCHAR(255) NOT NULL UNIQUE
);
        
  
  -- EDA


-- 1. Count the total no of books in the dataset

SELECT
COUNT(book_id) AS total_books
FROM books;


-- 2. Count the distinct genre available

SELECT
COUNT(Title) AS genre_tally
FROM genre;



-- 3. Average rating for each genre


SELECT
    g.Title,
    ROUND(AVG(b.Rating),2) AS avg_rating
FROM genre g
JOIN books b
ON g.Title = b.Main_genre
GROUP BY g.Title
ORDER BY g.Title;


-- 4. Most reviewed book in main_genre


SELECT
Main_Genre,
Title,
Ratings_Count
FROM books
WHERE Ratings_Count = (
                        SELECT
                        MAX(Ratings_Count)
                        FROM books b
                        WHERE b.Main_Genre = books.Main_Genre
                        );
                        

-- 5. Maximum number of books for top 5 sub_genre


SELECT
    Title,
    MAX(No_of_books) AS max_books
FROM sub_genre
GROUP BY Title
ORDER BY max_books DESC
LIMIT 5;


-- 6. Show book title and id with kindle edition and rating 4.5 and above


SELECT
book_id,
Title
FROM books
WHERE TYPE LIKE 'Kindle Edition'
AND Rating >= 4.5 ;




-- 7. Which authors have the highest average book price


SELECT
Author,
ROUND(AVG(Price),0) AS avg_price
FROM books
GROUP BY Author
ORDER BY avg_price DESC;


-- 8. which author have written most number of books

SELECT Author, COUNT(*) AS total_books
FROM books
GROUP BY Author
ORDER BY total_books DESC
LIMIT 1;


-- 9. Author with highest number of ratings

SELECT Author, SUM(Ratings_Count) AS total_ratings
FROM books
GROUP BY Author
ORDER BY total_ratings DESC
LIMIT 1;


-- 10. Rank and Dense_Rank of book  within each title based on rating category

SELECT
  Title,
  Rating,
  RANK() OVER (PARTITION BY Rating ORDER BY Title) AS title_rank,
  DENSE_RANK() OVER (PARTITION BY Rating ORDER BY Title) AS dense_title_rank
FROM books
LIMIT 10;

  
  
  
  