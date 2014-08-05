-- LESSON 1

-- show the population of germany
select population
  FROM world
  WHERE name = 'Germany'

-- show per capita gdp
SELECT name, population/area, gdp/population
  FROM world
  WHERE area > 5000000

-- show name and continent where area < 2k and gdp > 5m
SELECT name, continent
  FROM world
  WHERE area < 2000
    AND gdp > 5000000000

-- show name and population for countries on list
SELECT name, population
  FROM world
  WHERE name IN ('Denmark', 'Finland', 'Norway', 'Sweden')

-- countries beginning with 'G'
SELECT name
  FROM world
  WHERE name LIKE 'G%'

-- show countries and landarea (in thousands km^2) between values
SELECT name, area/1000
  FROM world
  WHERE area BETWEEN 25000 and 300000

-- LESSON 2

-- name of countries with a poulation above 200m
SELECT name
  FROM world
  WHERE population > 200000000

-- name and gdp/capita for above
SELECT name, gdp/population
  FROM world
  WHERE population >= 200000000

-- name and pop (m) for SA countries
SELECT name, population/1000000
  FROM world
  WHERE continent = 'South America'

-- name and population from list
SELECT name, population
  FROM world
  WHERE name IN ('France', 'Germany', 'Italy')

-- find substring 'united'
SELECT name
  FROM world
  WHERE name LIKE '%united%'

-- LEVEL 3 (Nobel)

-- List years in which the physics prize was awarded, but not the chemistry



-- LEVEL 4 (Select within select)

-- List each country more populous that Russia
SELECT name FROM world
  WHERE population > 
    (SELECT population FROM WORLD
      WHERE name='Russia')

--  List the name and continent of countries containing 'Belize', 'Belgium'
SELECT name, continent FROM world
  WHERE continent IN (
    SELECT continent FROM world 
      WHERE name IN ('Belize', 'Belgium'))

-- Country with population between canada and poland
SELECT name FROM world
  WHERE population BETWEEN 
    (SELECT population FROM world
      WHERE name = 'Canada') AND
    (SELECT population FROM world
      WHERE name = 'Poland')

-- Find largest country on continent
SELECT continent, name, population FROM world x
  WHERE population >= ALL
    (SELECT population FROM world y
      WHERE y.continent = x.continent
        AND population > 0)

-- Largest country on each continent
SELECT continent, name, area FROM world x
  WHERE area >= ALL (
    SELECT area FROM world y
      WHERE x.continent = y.continent)

-- Find all countries belonging to a continent where all pops are less than 250m
SELECT name, continent, population 
  FROM world x
  WHERE 25000000 >= ALL (
    SELECT population FROM world y
      WHERE y.continent = x.continent
        AND x.population > 0)

-- Countries with population > 3x any neighbors
SELECT name, continent FROM world x
  WHERE population/3 >= ALL (
    SELECT population FROM world y
      WHERE x.continent = y.continent
        AND x.name <> y.name
        AND y.population > 0)


-- LESSON 5 (Sum and count)

-- Give the total gdp of africa
SELECT SUM(gdp) FROM world
  WHERE continent = 'Africa'

-- How many countries have an area of at least 1m
SELECT COUNT(name) FROM world
  WHERE area > 1000000

-- For each contient count the countries
SELECT continent, COUNT(name)
  FROM world
  GROUP BY continent

-- Number of countries with a pop over 10m in continent
SELECT continent, COUNT(name)
  FROM world
  WHERE population >= 10000000
  GROUP BY continent

-- List the continents with a total pop of at least 100m
SELECT DISTINCT continent FROM world x
  WHERE 100000000 <= (
    SELECT SUM(population) FROM world y
      WHERE x.continent = y.continent)

-- Name and pop density of country with largest population
SELECT name, population/area AS density FROM world x
  WHERE population >= ALL (SELECT population FROM world)


-- LESSON 6 (Join)

-- Show the player, teamid and mdate for every German goal
SELECT player, teamid, mdate
  FROM game JOIN goal ON (id=matchid)
  WHERE teamid = 'GER'

-- List the dates of the matches and the name of the team in which 
-- 'Fernando Santos' was the team1 coach
SELECT mdate, teamname
  FROM game JOIN eteam ON (eteam.id = team1)
  WHERE coach = 'Fernando Santos'

-- List the player who scored each goal in Warsaw
SELECT player
  FROM goal JOIN game ON (goal.matchid = game.id)
  WHERE stadium = 'National Stadium, Warsaw'

-- Names of all Greek players who scored against Germany
SELECT player, gtime
  FROM game JOIN goal on matchid = id
  WHERE (team1='GER' AND team2='GRE')

-- Names of all players to score against Germany
SELECT DISTINCT player
  FROM game JOIN goal on matchid = id
  WHERE goal.teamid <> 'GER'
    AND (team1 = 'GER' OR team2 = 'GER')

-- Show team name and number of goals scored
SELECT teamname, COUNT(matchid)
  FROM eteam JOIN goal ON (teamid = id)
  GROUP BY teamid

-- Number of goals scored in each stadium
SELECT stadium, COUNT(teamid)
  FROM game JOIN goal ON (matchid = id)
  GROUP BY stadium

-- For every match involving 'POL' show matchid, date, number of goals
SELECT id, mdate, COUNT(teamid)
  FROM game JOIN goal ON (matchid = id)
  WHERE team1 = 'POL' OR team2 = 'POL'
  GROUP BY matchid

-- For matches where 'GER' scored show stuff + German goals
SELECT matchid, mdate, COUNT(teamid)
  FROM game JOIN goal ON (matchid = id)
  WHERE teamid = 'GER'
  GROUP BY matchid


-- LESSON 7 (More Joins)

-- Obtain the cast list for Casablanca (id: 11768)
SELECT name
  FROM actor JOIN casting ON (actorid = id)
  WHERE movieid = '11768'

-- Obtain cast list for Alien
SELECT name
  FROM actor JOIN casting ON (actorid = id)
  WHERE movieid = (SELECT id FROM movie WHERE title = 'Alien')

-- List the films in which Harrison Ford has appeared
SELECT title
  FROM movie JOIN casting ON (movieid = id)
  WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford')

-- List the films which featured, but did not star Harrison Ford
SELECT title, 
  FROM movie JOIN casting ON (movieid = id)
  WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford')
    AND ord <> 1

-- List leading star of each movie from 1962
SELECT title, name
  FROM casting JOIN actor ON actor.id = actorid JOIN movie ON movieid = movie.id
  WHERE ord = '1'
  AND yr = '1962'

-- How many movies did John Travolta make each year
SELECT yr, COUNT(title) FROM
  movie JOIN casting ON movie.id = movieid
        JOIN actor ON actor.id = actorid
  WHERE name = 'John Travolta'
  GROUP BY yr
  HAVING COUNT(title) > 2

  -- Their demo answer:
  SELECT yr, COUNT(title) 
    FROM movie JOIN casting ON movie.id = movieid
               JOIN actor ON actor.id = actorid
    WHERE name = 'John Travolta'
    GROUP BY yr
    HAVING COUNT(title) = (SELECT MAX(c) FROM
      (SELECT yr, COUNT(title) AS c FROM
        movie JOIN casting ON movie.id = movieid
              JOIN actor ON actor.id = actorid
        WHERE name = 'John Travolta'
        GROUP BY yr) as t
      )

-- Title and lead in films featuring Julie Andrews
SELECT title, name FROM
  movie JOIN casting ON movie.id = movieid
        JOIN actor ON actor.id = actorid
  WHERE ord = 1
    AND movieid IN (
      SELECT movieid FROM
      actor JOIN casting ON actor.id = actorid
      WHERE name = 'Julie Andrews')

-- List of actors starring in at least 30 roles
SELECT name FROM
  actor JOIN casting ON actor.id = actorid
  WHERE ord = 1
  GROUP BY name
  HAVING COUNT(name) >= 30

-- 1978 films in order of cast size
SELECT  title, COUNT(actorid) FROM
  movie JOIN casting ON movieid = movie.id
  WHERE yr = '1978'
  GROUP BY title
  ORDER BY COUNT(actorid) DESC

-- List the people who have worked with Art Garfunkel
SELECT name FROM
  actor JOIN casting ON actor.id = actorid
  WHERE movieid IN (
    SELECT movieid FROM
      actor JOIN casting ON actor.id = actorid
      WHERE name = 'Art Garfunkel')
    AND name <> 'Art Garfunkel'


-- LESSON 8 (Null)

-- List the teachers who have NULL for their deptartments
SELECT name FROM teacher WHERE dept IS NULL

-- Inner join misses the teacher with no dept and the dept with no teacher
SELECT teacher.name, dept.name
  FROM teacher INNER JOIN dept
    ON teacher.dept = dept.id

-- Use  a different JOIN so that all teachers are listed
SELECT teacher.name, dept.name
  FROM teacher LEFT JOIN dept
    ON teacher.dept = dept.id

-- Use COALESCE to print a default mobile number
SELECT name, COALESCE(mobile, '07986 444 2266')
  FROM teacher

-- List all the teachers; if they are not a member of a dept list 'None'
SELECT teacher.name, COALESCE(dept.name, 'None')
  FROM teacher LEFT JOIN dept
    ON teacher.dept = dept.id

-- Count the teachers and mobiles
SELECT COUNT(name), COUNT(mobile)
  FROM teacher

-- Show number of staff per dept
SELECT dept.name, COUNT(teacher.name)
  FROM teacher RIGHT JOIN dept
    ON dept = dept.id
  GROUP BY dept
  ORDER BY COUNT(teacher.name) DESC

-- Use CASE to show dept as 'Sci' is 1 or 2 and 'Art' otherwise
SELECT name, CASE
  WHEN dept <= 2 THEN 'Sci'
  ELSE 'Art'
  END as dept
  FROM teacher

-- As before, or none
SELECT name, CASE
  WHEN dept IN (1,2) THEN 'Sci'
  WHEN dept IN (3)   THEN 'Art'
  ELSE 'None'
  END as dept
  FROM teacher


-- LESSON: Self Join

-- Use self JOIN to show the services from stop 53 stop 149
SELECT a.company, a.num, a.stop, b.stop
  FROM route a JOIN route b
    ON a.company = b.company AND a.num = b.num
  WHERE a.stop = 53 AND b.stop = 149

-- To the above JOIN two copies of stops to refer to stops by name
SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON
    a.company = b.company AND a.num = b.num
  JOIN stops stopa ON a.stop = stopa.id
  JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart'
  AND stopb.name = 'London Road'

-- Give a list of serviecs connecting 115 and 137
SELECT DISTINCT a.company, a.num
  FROM route a JOIN route b
    ON a.company = b.company AND a.num = b.num
  WHERE a.stop = 115 AND b.stop = 137

-- Give a list of services between Craiglockhart and Tollcross
SELECT DISTINCT a.company, a.num
  FROM route a JOIN route b
    ON a.company = b.company AND a.num = b.num
  JOIN stops stopa ON a.stop = stopa.id
  JOIN stops stopb ON b.stop = stopb.id
  WHERE stopa.name = 'Craiglockhart'
    AND stopb.name = 'Tollcross'

-- List of stops which may be reached from Craiglockhart on a single bus
SELECT name, a.company, a.num
  FROM route a JOIN (
    -- Bus routes that have Craiglockhart (53)
    SELECT company, num
      FROM route
      WHERE stop = 53
  ) b ON a.company = b.company AND a.num = b.num
  JOIN stops ON stops.id = a.stop

