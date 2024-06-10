select *
from netflix_titles

SELECT *
FROM netflix_titles
WHERE show_id IS NULL;

--- lets see if we have null values in the type column
SELECT *
FROM netflix_titles
WHERE type IS NULL;

-- to be sure that the type column holds nothing weird 
Select distinct type
FROM netflix_titles

SELECT *
FROM netflix_titles
WHERE title IS NULL;

SELECT *
FROM netflix_titles
WHERE director IS NULL;

-- to deal with the blanks, i have decided to replace them with unknown
UPDATE netflix_titles
SET director = 'Unknown'
WHERE director IS NULL;

--- lets check if we have anymore blanks in that column
SELECT count(*)
FROM netflix_titles
WHERE director IS NULL;


-- to be sure that the director column holds nothing weird 
SELECT DISTINCT director
FROM netflix_titles
WHERE director ~ '[0-9]';

-- check for blanks in the cast column
SELECT count(*)
FROM netflix_titles
WHERE cast IS NULL;

--- this was a learning moment for me, i kept getting an errror with my last query because pgadamin kept seeing cast as a syntax and not a coulmn
SELECT count(*)
FROM netflix_titles
WHERE "cast" IS NULL;

--- lets replace the nulls in cast with unknown
UPDATE netflix_titles
SET "cast" = 'Unknown'
WHERE "cast" IS NULL;

-- count the number of blanks in the country colum
SELECT count(*)
FROM netflix_titles
WHERE country IS NULL;

--- replace those blanks in the country column with Unknown
UPDATE netflix_titles
SET country = 'Unknown'
WHERE country IS NULL;

Select distinct (country)
FROM netflix_titles

SELECT *
FROM netflix_titles
WHERE date_added IS NULL;

-- i love challenges like this, so we have 10 tv shows that do not have the dates they were added to netflix, well a data anlyst is also an investigator so lets get to work by searching the interent for the dates they were added
UPDATE netflix_titles
SET date_added = '2016-12-09'
WHERE title = 'A Young Doctor''s Notebook and Other Stories';

UPDATE netflix_titles
SET date_added = '2014-12-01'
WHERE title = 'Anthony Bourdain: Parts Unknown'

UPDATE netflix_titles
SET date_added = '2020-12-30'
WHERE title = 'Frasier'

UPDATE netflix_titles
SET date_added = '2015-01-01'
WHERE title = 'Friends'

UPDATE netflix_titles
SET date_added = '2013-03-08'
WHERE title = 'Gunslinger Girl'

UPDATE netflix_titles
SET date_added = '2016-07-19'
WHERE title = 'La Familia P. Luche'

UPDATE netflix_titles
SET date_added = '2015-11-01'
WHERE title = 'Kikoriki'

UPDATE netflix_titles
SET date_added = '2013-08-14'
WHERE title = 'Maron'

UPDATE netflix_titles
SET date_added = '2014-04-01'
WHERE title = 'Red vs. Blue'

UPDATE netflix_titles
SET date_added = '2015-02-15'
WHERE title = 'The Adventures of Figaro Pho';

-- check if we have nulls in the release_year column
SELECT *
FROM netflix_titles
WHERE release_year IS NULL;

-- check for blanks in the rating column
SELECT *
FROM netflix_titles
WHERE rating IS NULL;

-- another chance to dig for information to sort out the blanks
UPDATE netflix_titles
SET rating = 'TV-PG'
Where show_id = 's5990'

UPDATE netflix_titles
SET rating = 'TV-MA'
Where show_id = 's7538'

UPDATE netflix_titles
SET rating = 'TV-14'
Where show_id = 's6828'

UPDATE netflix_titles
SET rating = 'TV-G'
Where show_id = 's7313'

-- check for the unique values in the column
SELECT distinct (rating)
from netflix_titles

--- something looks weird in the rating columns, why do we have 74 , 66 and 84 min as rating characters
select *
from netflix_titles
where rating = '74 min'

-- i realized that the duration might have mistakenely been inputed as rating
--lets move it to duration first
Update netflix_titles
set duration = '74 min'
where show_id ='s5542'
 
 -- now lets do some research to find the ratings of Louis C.K. 2017
Update netflix_titles
set rating = 'TV-MA'
where show_id ='s5542' 

-- lets sort out 66 min

select *
from netflix_titles
where rating = '66 min'

Update netflix_titles
set duration = '66 min'
where show_id ='s5814'

Update netflix_titles
set rating = 'TV-MA'
where show_id ='s5814' 

-- lets sort out 84 min
select *
from netflix_titles
where rating = '84 min'

Update netflix_titles
set duration = '84 min'
where show_id ='s5795'

Update netflix_titles
set rating = 'TV-MA'
where show_id ='s5795'


-- crosscheck for the unique values in the column
SELECT distinct (rating)
from netflix_titles

--- THE 'A' rating is pretty weird, lets do some research
select *
from netflix_titles
where rating = 'A'

-- i did some research and found that the movie serena is rated R and not A
UPDATE netflix_titles
SET rating = 'R'
WHERE show_id = 's8809'

--- just to be sure let's check the rating columns again
SELECT distinct (rating)
from netflix_titles

--- we have 14 distinct ratings in the ratings coulmn, we are good to go to the duration column
select *
from netflix_titles
where duration is null

-- no blanks in the duration column, lets move to listed_in column
Select *
from netflix_titles
where listed_in is null

--- no blanks in the listed_in column, lets check for blanks in the description column
select *
from netflix_titles
where description is null

--lets check the consinstency of the listed_in 
select distinct(listed_in)
from netflix_titles

-- we have succesfully taken care of the blanks in the dataset.
-- lets move to checking for duplicates

SELECT show_id, COUNT(*) AS duplicate_count
FROM netflix_titles
GROUP BY show_id
HAVING COUNT(*) > 1;


-- we have handled the blanks, the duplicates, the incosistency in the columns
--lets get into a little EDA

-- to see the total number of shows and movies that we have
select count(*)
from netflix_titles

-- to see the total number that each type has
Select type, count(*)
from netflix_titles
Group by type

--- to see the oldest movie or show in the data
select min(release_year)
from netflix_titles

-- to see the newest movie or show in the data
select max(release_year)
from netflix_titles


-- Content Availability
-- Apinke, can you tell me how many movies and TV shows are available on Netflix?
Select type, count(*)
from netflix_titles
Group by type

--Can you find out which country has the most titles available on Netflix?
select country, count(*) 
from netflix_titles
group by country
order by count(*) desc
limit 1

-- Director and Cast Insights
--Who are the most prolific directors on Netflix?
select director, count(*)
from netflix_titles
where director != 'Unknown'
group by director
order by count(*) desc
limit 10


--Genre and Category Analysis
--What are the most popular genres on Netflix?
select listed_in, count(*)
from netflix_titles
group by listed_in
order by count(*) desc
limit 10

--New Releases
--What are the newest titles added to Netflix in the past month?
select *
from netflix_titles
where date_added between '2024-01-01' and '2024-06-01'

-- Which year had the most releases on Netflix?
select release_year, count(*)
from netflix_titles
group by release_year
order by count(*) desc
limit 5

--Can you provide a breakdown of the different ratings (like PG-13, TV-MA) for movies and TV shows?
SELECT type, rating, COUNT(*) AS count
FROM netflix_titles
GROUP BY type, rating
ORDER BY type, rating;

SELECT Round(AVG(CAST(SUBSTRING(duration FROM '[0-9]+') AS INTEGER)),2) AS avg_duration_minutes
FROM netflix_titles
WHERE type = 'Movie';

-- Based on the dataset, what titles would you recommend for someone who loves documentaries?
SELECT title, rating
FROM netflix_titles
WHERE listed_in ILIKE '%documentaries%';


--Trends and Patterns
--Are there any noticeable trends in the types of content being added to Netflix over the years?
SELECT
    EXTRACT(YEAR FROM date_added) AS year,
    type,
    COUNT(*) AS count
FROM netflix_titles
GROUP BY year, type
ORDER BY year, type;

--Can you find out if certain genres are becoming more or less popular over time?
WITH genre_year AS (
    SELECT
        EXTRACT(YEAR FROM date_added) AS year,
        UNNEST(STRING_TO_ARRAY(listed_in, ', ')) AS genre
    FROM
        netflix_titles)
SELECT year, genre, COUNT(*) AS count
FROM genre_year
GROUP BY year, genre
ORDER BY year, genre;

--Can you find out which directors have directed the most documentaries?
Select director, count(*) as documentary_count
From netflix_titles
Where listed_in ilike '%documentaries%' and director != 'Unknown'
group by director
order by documentary_count desc
limit 5

--- Can you identify actors who have the highest average ratings for their performances?
WITH actor_ratings AS (
    SELECT
        UNNEST(STRING_TO_ARRAY("cast", ', ')) AS actor,
        CASE 
            WHEN rating = 'G' THEN 1
            WHEN rating = 'PG' THEN 2
            WHEN rating = 'PG-13' THEN 3
            WHEN rating = 'R' THEN 4
            WHEN rating = 'NC-17' THEN 5
            ELSE 0 -- Handle other ratings if needed
        END AS rating_value
    FROM
        netflix_titles
    WHERE
        "cast" IS NOT NULL
)
SELECT
    actor,
    round(AVG(rating_value),2) AS avg_rating
FROM
    actor_ratings
GROUP BY
    actor
HAVING
    COUNT(actor) > 1 -- Ensure the actor has performed in more than one title
ORDER BY
    avg_rating DESC
LIMIT 10;


--Which actors or actresses are featured in the most diverse genres?
WITH actor_genres AS (
    SELECT
        UNNEST(STRING_TO_ARRAY("cast", ', ')) AS actor,
        UNNEST(STRING_TO_ARRAY(listed_in, ', ')) AS genre
    FROM
        netflix_titles
    WHERE
        "cast" IS NOT NULL
        AND listed_in IS NOT NULL)
SELECT
    actor,
    COUNT(DISTINCT genre) AS genre_count
FROM actor_genres
where actor is not null and actor != 'Unknown'
GROUP BY actor
ORDER BY genre_count DESC
LIMIT 10;


