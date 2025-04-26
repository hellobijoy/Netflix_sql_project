SELECT* FROM netflix

SELECT COUNT(*) as total_rows
FROM netflix

SELECT distinct type as unique_type
from netflix

---15 BUSINESS PROBLEMS----
#1. Count the number of Movies vs TV Shows
SELECT type,
      count(*) as total_content
	  FROM netflix
	  GROUP BY 1
#2.Find the most common rating for movies and TV shows
SELECT type ,
        rating
		FROM
(SELECT type,
       rating,
	   COUNT(*),
	   RANK() OVER (PARTITION BY type order by  COUNT(*) desc) as rank
	   from netflix
	   GROUP BY 1,2) as t1
	   WHERE rank = 1
	   
#3.List all movies released in a specific year (e.g., 2020)
SELECT *
      from netflix
	  WHERE type = 'Movie'
	  AND release_year = '2020'
#4. Find the top 5 countries with the most content on Netflix
 SELECT UNNEST(STRING_TO_ARRAY(country,',')) as new_country,
        count(*) as hope
        from netflix
		GROUP BY 1
		order by 2 desc
		LIMIT 5
#5.Identify the longest movie
SELECT type,
       max(duration) as highest_duration
	  FROM netflix
	  WHERE type = 'Movie'
	  GROUP BY 1
#6.Find content added in the last 5 years
SELECT *
FROM netflix
 WHERE
 TO_DATE(date_added,'Month DD,YYYY')>= CURRENT_DATE - INTERVAL '5 years'
      
#7.Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT *
from netflix
WHERE director LIKE '%Rajiv Chilaka%'

#8. List all TV shows with more than 5 seasons
SELECT *
      from netflix
	  WHERE type = 'TV Show'
	  AND SPLIT_PART(duration,' ',1):: numeric > 5
#9.Count the number of content items in each genre
SELECT 
       COUNT(show_id) as new_content,
       UNNEST(STRING_TO_ARRAY(listed_in,',')) as new_genre 
	   from netflix
	   GROUP BY 2 	
#10.#10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

1.each year,
2.WHERE  condition
3.we need total number of content COUNT(*)
4.sub_query.
ANS.

SELECT EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD,YYYY')) as year,
       COUNT(*),
	   COUNT(*):: numeric/(SELECT COUNT(*) FROM netflix where country = 'India'):: numeric * 100 as avg_content_india
FROM netflix 
WHERE country = 'India'
GROUP BY 1


	SELECT COUNT(*) FROM netflix where country = 'India'
	
#11. List all movies that are documentaries
SELECT * FROM netflix
WHERE
     listed_in like '%Documentaries%'
	 
#12.Find all content without a director
select * 
from netflix 
WHERE director is NULL 

#13.Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT *
FROM netflix
WHERE casts ilike '%Salman Khan%'
AND release_year > EXTRACT(YEAR FROM current_DATE) - 10 

#14 find the top 10 actors who have appear in the highest number of movie produced in India.
SELECT 
UNNEST(STRING_TO_ARRAY(casts,',')) as actors,
count(*) as total_content
FROM netflix
WHERE country ilike '%india'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
