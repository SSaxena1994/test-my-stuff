-- Telling MySQL to use Sakila DB to look for the following tables. 
USE Sakila;

-- Using Select to display first and last name of all the actors in the table actors. 

Select first_name, last_name from actor;

-- Joining two coloums to create a new column - all of the characters are already in upper case so no new code required. 
-- This query only displays the names but does not add them to the actual table. 

 Select Concat (first_name, ' ', last_name) from actor as Actor_Name;
	
-- Locating the ID and last name of an actor called 'Joe'. 

Select actor_id, first_name, last_name from actor
where first_name = 'Joe';

-- Locating all actors with last names containin - GEN (I added the % with the GEN - but don't remember the logic) 

Select  actor_id, first_name, last_name from actor 
Where last_name like '%GEN%' ; 

-- Locating all actors containing the letters LI in their last name, ordering rows - last and first name. 

Select last_name, first_name from actor 
Where last_name like '%LI%'; 

-- Using the SQL command 'IN' displaying country_id and country for Afghanistan, Bangladesh and China

Select country_id, country from country
Where country IN ('Afghanistan', 'Bangladesh', 'China')
; 

-- Adding a 'Description' column to the table Actor as the vlaue blob. 
Alter table actor 
ADD description blob;

-- Deleting the column Description from the table Actor. 

Alter table actor drop description;


-- list all the last names and a sum of all of the last names (not sure why select count (distinct column_name) as unique_value did not work. 

select DISTINCT last_name, count(last_name) as unique_last_names
from actor
group by last_name; 

-- List all the last names that belong to more than one actor. [I am really not sure on how I came to this script - is it the proper way? do we prefer to use sub queries?] 

Select distinct last_name, count(last_name) as unique_values from actor 
group by last_name 
having unique_values>1; 

-- Changing the actors name from  GROUCHO WILLIAMS to HARPO WILLIAMS - we need to find the unique actor ID as there are multiple entries for the same name. 
Select actor_id from actor 
where (first_name = 'GROUCHO' AND last_name = 'WILLIAMS') ;


Update actor 
Set first_name = 'HARPO'
where actor_id = 172
;
-- to double check if the update happened. 
Select first_name  last_name from actor
Where actor_id = 172; 

-- Chaning the name back to GROUCHO. 

Update actor 
Set first_name = 'GROUCHO'
where actor_id = 172
;

-- In MySQL - create database = create schema - this will create a new sakila if one does not exists (I did not run this code). 
Create database if not exists sakila; 
 
 -- Using the JOIN command, linking address and staff to find the first, last name and address if each staff member. 
  
Select staff.first_name, staff.last_name, address.address 
from staff 
inner join address on staff.address_id=address.address_id; 

-- Using JOIN finding the total amount payments collected by each person on staff. 

Select  staff.first_name, staff.last_name, COUNT(payment.amount) as Total_Payment 
from payment
inner join staff on staff.staff_id=payment.staff_id
Group by staff.first_name; 

 
 -- Each film and the number of actors listed in actors table. 
 
Select Count(film_actor.actor_id), film.title 
from film_actor 
inner join film on film_actor.film_id=film.film_id
group by film.title
; 

-- Number of copies of 'HunchBack Impossible' are there in the inventory. 


Select count(inventory_id) from inventory 
Where film_id = ( Select film_id from film 
Where title = 'HunchBack Impossible')
group by film_id; 
 
 -- Total payments made by each customer last name alphabetically -- 
 
Select sum(payment.amount), customer.first_name, customer.last_name, customer.customer_id
from customer	
inner join payment on customer.customer_id=payment.customer_id 
group by customer.customer_ID
order by customer.last_name asc
; 

-- Sub queries to show number of films starting with K and Q which are in English 

Select language_id from language where name = 'English'; 

Select * from film
Where film_id IN (select film_id from film where title like 'Q%' OR title like 'K%') AND Language_id = 1 
; 

 
 
 



