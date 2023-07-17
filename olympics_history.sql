# HOW MANY GAMES HELD?
select count(distinct games) as total_olympic_games
from athlete_events;

#-----------------------------------------------------------------------------------------------------------
#  LIST OF ALL GAMES HEL
select distinct ate.year, ate.season, ate.city
 from athlete_events ate order by year;
 
#----------------------------------------------------------------------------------------------------------
# Break down all olympic games where india won medal for Hockey and how many medals in each olympic games
select team, sport, games, count(1) as total_medals
from athlete_events
where medal <> 'NA'
and team = 'India' and sport = 'Hockey'
group by team, sport, games
order by total_medals desc;
#----------------------------------------------------------------------------------------------------------------------
# All gold, silver and bronze medals won so far
SELECT
    COUNT(CASE WHEN Medal = 'Gold' THEN 1 END) AS gold_medals,
    COUNT(CASE WHEN Medal = 'Silver' THEN 1 END) AS silver_medals,
    COUNT(CASE WHEN Medal = 'Bronze' THEN 1 END) AS bronze_medals
FROM athlete_events
WHERE Medal <> 'NA';

#---------------------------------------------------------------------------------------------------------------------------------------------
# Identify medals won by a specific country.
SELECT *
FROM athlete_events
WHERE NOC = 'USA' 
    AND Medal <> 'NA';

#------------------------------------------------------------------------------------------------------------------------------------------

# The country that has won the most gold medals in a single Olympics.
SELECT NOC, COUNT(1) AS gold_medals
FROM athlete_events
WHERE Medal = 'Gold'
GROUP BY NOC
ORDER BY gold_medals DESC
LIMIT 1;

#-----------------------------------------------------------------------------------------------------------------------------------------------

# The country that has won the most medals in the history of the Olympics
SELECT NOC, COUNT(1) AS total_medals
FROM athlete_events
WHERE Medal <> 'NA'
GROUP BY NOC
ORDER BY total_medals DESC
LIMIT 1;
#-----------------------------------------------------------------------------------------------------------------------------------------

# have participated in the Summer Olympics but not in the Winter Olympics,
SELECT NOC
FROM athlete_events
WHERE Season = 'Summer'
GROUP BY NOC
HAVING COUNT(DISTINCT Year) = (SELECT COUNT(DISTINCT Year) FROM athlete_events WHERE Season = 'Summer')
    AND NOC NOT IN (SELECT NOC FROM athlete_events WHERE Season = 'Winter');
