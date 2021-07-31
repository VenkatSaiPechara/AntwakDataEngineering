/*Please use database name present in your system*/
use rent-a-film;

/*We want to run an Email Campaigns for customers of Store 2*/
select t1.email from customer t1 , store t2 where t1.store_id=t2.store_id;

/*List of the movies with a rental rate of 0.99$*/
select title from film where rental_rate=0.99;

/*Your objective is to show the rental rate and how many movies are in each rental
rate categories*/
select rental_rate,count(rental_rate) from film group by rental_rate;

/*Which rating do we have the most films in?*/
select rating,count(rating) from film group by rating order by count(rating) desc limit 1;

/*Which rating is most prevalent in each store?*/
select t2.rating as ratings_in_store_2 ,count(t2.rating) from inventory t1, film t2, store t3 where t1.film_id =t2.film_id and t1.store_id =t3.store_id and t3.store_id=2  group by t2.rating order by count(t2.rating) desc limit 1;

/* We want to mail the customers about the upcoming promotion*/
select email from customer;

/*List of films by Film Name, Category, Language*/
select t1.title,t2.name category,t3.name as Language  from film t1, category t2, language t3, film_category t4 where t1.film_id=t4.film_id and t4.category_id=t2.category_id and t1.language_id and t3.language_id;

/*How many times each movie has been rented out?*/
select t1.title,count(t1.title) from film t1, inventory t2, rental t3 where t1.film_id =t2.film_id and t2.inventory_id=t3.inventory_id group by t1.title;

/*What is the Revenue per Movie?*/
select t1.title,sum(t4.amount) from film t1, inventory t2, rental t3 , payment t4
where t1.film_id =t2.film_id and t2.inventory_id=t3.inventory_id and t4.rental_id=t3.rental_id
group by t1.title;

/*Most Spending Customer so that we can send him/her rewards or debate points*/
select t1.customer_id, sum(t3.amount) amount from customer t1, rental t2, payment t3
where t1.customer_id=t2.customer_id and t2.rental_id=t3.rental_id
group by t1.customer_id order by amount desc limit 1 ;

/*What Store has historically brought the most revenue?*/
select t1.store_id,sum(t4.amount) amount from store t1, inventory t2, rental t3 , payment t4
where t1.store_id =t2.store_id and t2.inventory_id=t3.inventory_id and t4.rental_id=t3.rental_id
group by t1.store_id  order by amount desc limit 1 ;

/*.How many rentals do we have for each month?*/
select  count(rental_id)/12 rentals_per_month from rental;

/*Rentals per Month (such Jan => How much, etc)*/
select extract(month from rental_date) month_name, count(*) count from rental group by month_name;

/*Which date the first movie was rented out?*/
select rental_date from rental order by rental_date asc limit 1;

/*Which date the last movie was rented out?*/
select rental_date from rental order by rental_date desc limit 1;

/*.For each movie, when was the first time and last time it was rented out?*/
select t1.title,min(t3.rental_date) first_time, max(t3.rental_date) last_time 
from film t1, inventory t2, rental t3 
where t1.film_id =t2.film_id and t2.inventory_id=t3.inventory_id  group by t1.title   ; 

/*What is the Last Rental Date of every customer?*/
select t1.customer_id, max(t2.rental_date) amount from customer t1, rental t2
where t1.customer_id=t2.customer_id 
group by t1.customer_id  ;

/*What is our Revenue Per Month?*/
select extract(month from rental_date) month_name, sum(t2.amount)  Revenue_per_month
from rental t1,payment t2 where t1.rental_id=t2.rental_id group by month_name order by month_name;

/*How many distinct Renters do we have per month?*/
select  extract(month from t2.rental_date) month_name,count(distinct t1.customer_id) no_of_customers from customer t1, rental t2
where t1.customer_id=t2.customer_id 
group by month_name ;

/*Show the Number of Distinct Film Rented Each Month*/
select  extract(month from t3.rental_date) month_name,count(distinct t1.film_id)
from film t1, inventory t2, rental t3 
where t1.film_id =t2.film_id and t2.inventory_id=t3.inventory_id  group by month_name  ; 

/*Number of Rentals in Comedy, Sports, and Family*/
select t3.name, count(t5.rental_id) count  from film t1,film_category t2,category t3, inventory t4, rental t5
where t1.film_id=t2.film_id and t2.category_id =t3.category_id and t3.name in ('Comedy','Sports','Family') and t1.film_id =t4.film_id and t4.inventory_id=t5.inventory_id
group by t3.name;

/*Users who have been rented at least 3 times*/
select t1.customer_id, count(t2.rental_id) count  from customer t1, rental t2
where t1.customer_id=t2.customer_id 
group by t1.customer_id
having  count>=3 ;

/*.How much revenue has one single store made over PG13 and R-rated films?*/
select  t4.store_id,sum(t5.amount) Revenue
from film t1, inventory t2, rental t3 ,store t4,payment t5
where t1.film_id =t2.film_id and t2.inventory_id=t3.inventory_id  and t2.store_id=t4.store_id and t3.rental_id=t5.rental_id  and t1.rating in ('PG13','R')
group by t4.store_id  ; 

/*Active User where active = 1*/
select customer_id from customer where active=1;

/*Reward Users: who has rented at least 30 times*/
select t1.customer_id Reward_user_id, count(t2.rental_id) count  from customer t1, rental t2
where t1.customer_id=t2.customer_id 
group by t1.customer_id
having  count>=30 ;

/*Reward Users who are also active*/
select t1.customer_id Reward_user_id, count(t2.rental_id) count  from customer t1, rental t2
where t1.customer_id=t2.customer_id  and t1.active=1
group by t1.customer_id
having  count>=30 ;

/*All Rewards Users with Phone*/
 select t1.customer_id Reward_user_id,  t3.phone from customer t1, rental t2,address t3
where t1.customer_id=t2.customer_id and t1.address_id=t3.address_id
group by t1.customer_id
having  count(t2.rental_id)>=30 ;