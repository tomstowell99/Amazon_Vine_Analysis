-- Project challenge

-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

-- Load data from hard drive to to table

copy vine_table(review_id, star_rating, helpful_votes, total_votes, vine, verified_purchase)
from 'c:\bootcamp\vinedata22.csv'
delimiter ','
csv header;

select * from vine_table

-- step 1 create table with total votes greater than equal to 20
create table vinevotes as
select *
from vine_table
where total_votes >= 20
select * from vinevotes

-- step 2 % of helpful votes is at least 50%
create table vinehelpful as
select *
from vinevotes
where cast(helpful_votes as float)/cast(total_votes as float)>= .5
select * from vinehelpful

--step 3 vine reviews Y
create table vine_yes as
select *
from vinehelpful
where vine = 'Y';   
--select * from vine_yes

--step 4 vine reviews N
create table vine_no as
select *
from vinehelpful
where vine = 'N'
--select * from vine_no

-- Step 5 - summary for vine reviewers

select count(*) as Total_counts,
       count(*) Filter (where star_rating =5) as Five_Star_rating,
       --(count(*) Filter(where star_rating =5))  / count(*) as Percent_of_five_stars
       to_char((count(*) Filter(where star_rating =5))  / cast(count(*) as real),'0.00') as Percent_of_five_stars
From vine_yes


-- Step 5b - summary for non-reviewers

select count(*) as Total_counts,
       count(*) Filter (where star_rating =5) as Five_Star_rating,
       --(count(*) Filter(where star_rating =5))  / count(*) as Percent_of_five_stars
       to_char((count(*) Filter(where star_rating =5))  / cast(count(*) as real),'0.00') as Percent_of_five_stars
From vine_no


