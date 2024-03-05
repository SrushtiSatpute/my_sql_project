-- Data cleaning


-- Rename column

ALTER TABLE genre
RENAME COLUMN  Number_of_Sub_genres TO Subgenre_Count;



-- Remove symbol from price column

UPDATE books
SET price = REPLACE(price, 'â‚¹', '');

-- Delete column

ALTER TABLE books
DROP COLUMN row_id;

-- Add Column


ALTER TABLE books
ADD book_id INT AUTO_INCREMENT PRIMARY KEY FIRST ;


-- Removing Null values

SELECT *
FROM books
WHERE Title IS NULL
   OR Author IS NULL
   OR Main_Genre IS NULL
   OR Sub_Genre IS NULL
   OR Type IS NULL
   OR Price IS NULL
   OR Rating IS NULL
   OR Ratings_Count IS NULL;


-- Remove duplicates

SELECT Title,
COUNT(Title) as count
FROM books
GROUP BY Title
HAVING(count > 1);


SELECT Title,
     ROW_NUMBER() OVER(PARTITION BY Title) AS rn
FROM books;

SELECT 
DISTINCT Title
FROM books;



