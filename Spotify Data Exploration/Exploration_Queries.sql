select * from tracks;

-- Sort the data based on the popularity of the song (Most heard Song)
select title, artist, release_year 
from tracks 
order by popularity desc;

-- Number of distinct artists
select count(distinct(artist)) 
from tracks 
order by artist;

-- The Artists with Most Popular songs (Top 25)
select artist, AVG(popularity) 
from tracks 
group by artist
order by avg(popularity) desc
limit 25;

-- Top Songs for Partying
select title, artist, genre, avg(danceability) 
from tracks 
group by artist 
order by avg(danceability) desc
limit 50; 

-- Most popular song in each decade (First we add decade column)

-- Add a new column called decade 
alter table tracks
add decade varchar(8);

-- add value to decade based on the year 
SET SQL_SAFE_UPDATES = 0;  -- To toggle the safe update in MySQL 
update tracks
set decade = (CASE 
					when release_year between 1950 and 1960
						then '1950s'
					when release_year between 1960 and 1970
						then '1960s'
					when release_year between 1970 and 1980
						then '1970s'
					when release_year between 1980 and 1990
						then '1980s'
					when release_year between 1990 and 2000
						then '1990s'
					when release_year between 2000 and 2010
						then '2000s'
					when release_year between 2010 and 2020
						then '2010s'
                        END);

-- Finding the most popular song in each decade 
select title, artist, genre, MAX(popularity), decade
from tracks
group by decade
order by decade;

-- Songs based on genre
WITH rock_songs as (select title, artist, release_year, genre
	from tracks
	where genre in (select genre from tracks where genre like '%rock%')
	order by title),
    
    pop_songs as (select title, artist, release_year, genre
	from tracks
	where genre in (select genre from tracks where genre like '%pop%')
	order by title),
	
    jazz_songs as (select title, artist, release_year, genre
	from tracks
	where genre in (select genre from tracks where genre like '%jazz%')
	order by title),
    
    disco_songs as (select title, artist, release_year, genre
	from tracks
	where genre in (select genre from tracks where genre like '%disco%')
	order by title),
    
    metal_songs  as (select title, artist, release_year, genre
	from tracks
	where genre in (select genre from tracks where genre like '%metal%')
	order by title),
    
    soul_songs  as (select title, artist, release_year, genre
	from tracks
	where genre in (select genre from tracks where genre like '%soul%')
	order by title),
    
    hip_hop_songs  as (select title, artist, release_year, genre
	from tracks
	where genre in (select genre from tracks where genre like '%hip%')
	order by title),
    
    beat_songs  as (select title, artist, release_year, genre
	from tracks
	where genre in (select genre from tracks where genre like '%beat%')
	order by title)

-- select * from rock_songs;
-- select * from pop_songs;  
-- select * from jazz_songs;
-- select * from disco_songs; 
-- select * from metal_songs;
-- select * from hip_hop_songs;
-- select * from beat_songs;
select * from soul_songs;
