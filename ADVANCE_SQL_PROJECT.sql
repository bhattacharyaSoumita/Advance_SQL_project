/*1.Please send over the managers names at each stoe,with the full address of 
each property(street address,District,city and country */

SELECT 
    staff.first_name AS manager_firs_tname,
    staff.last_name AS manager_last_name,
    address.address,
    address.district,
    city.city,
    country.country
FROM store
     LEFT JOIN staff ON store.manager_staff_id = staff.staff_id
     LEFT JOIN address ON store.address_id = address.address_id
     LEFT JOIN city ON address.city_id = city.city_id
     LEFT JOIN country ON city.country_id = country.country_id
;

/* 2. pull together a list of each inventoryitem you have stocked,including the store_id number,the inventory_id,the name of the
 fillm,the film's rating,its rental rate and replacement cost.  */
 
SELECT 
     inventory.store_id,
     inventory.inventory_id,
     film.title,
     film.rating,
     film.rental_rate,
     film.replacement_cost
FROM inventory
     LEFT JOIN film 
     ON inventory.inventory_id = film.film_id
;    
 
/* 3.how many inventory items you have with each rating at each store.  */
SELECT 
     inventory.store_id,
     film.rating,
     COUNT(inventory_id) AS Inventory_items
FROM inventory
     LEFT JOIN film
     ON inventory.film_id = film.film_id
     GROUP BY
     inventory.store_id,
     film.rating
;     
/*4. We would like to see the number of films,as well as the average replacement 
cost,and total replacement cost,sliced by store and film category.  */ 

SELECT store_id,
       category.name AS category,
       COUNT(inventory.inventory_id) AS films,
       AVG(film.replacement_cost) AS avg_replacement_cost,
       SUM(film.replacement_cost) AS total_replacement_cost
       
FROM inventory
	 LEFT JOIN film
     ON inventory.film_id = film.film_id
     LEFT JOIN film_category
     ON film.film_id = film_category.film_id
     LEFT JOIN category
     ON category.category_id = film_category.category_id
     
GROUP BY 
     store_id,
     category.name
 
 ORDER BY SUM(film.replacement_cost) DESC
;     
   
/* 5.Please provide a list of all customer names,which store they go to,whether or not they are 
currently active,and their full address-street address,city,and country.  */   

SELECT 
     customer.first_name,
     customer.last_name,
     customer.store_id,
     customer.active,
     address.address,
     city.city,
     country.country
 
 FROM customer
      LEFT JOIN address ON customer.customer_id = address.address_id
      LEFT JOIN city ON address.city_id = city.city_id
      LEFT JOIN country ON city.country_id = country.country_id
;      
  
/*6. Please pull together a list of custmers names,their total lifetime rentals and the the 
sum of all payments you have collected from them.It would be great to see this ordered on 
total lifetime value,with the most valuable customers at the top of the list. */

SELECT 
	  customer.first_name,
      customer.last_name,
      COUNT(rental.rental_id) AS total_rentals,
      SUM(payment.amount) AS total_payment_amount
      
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
LEFT JOIN payment ON rental.rentalid = payment.rental_id

GROUP BY 
      customer.first_name,
      customer.last_name
      
 ORDER BY SUM(payment.amount) DESC
 ;
 
 /* 7.Could you please provide a list of advisor and investor names in one table?Could you
 please note whether they are an investor or an advisor,and for the investors,it would be good to
 include which company they work with. */
  
 SELECT 'investors' AS Type,
		first_name,
        last_name,
        company_name
 FROM investor
 UNION
 SELECT 'advisor' AS Type,
        first_name,
        last_name,
        'N/A'
 FROM advisor;   
 
/* 8.We are interested in how well you have coverted the most awarded actors.Of all the actors with three types of awards,for what % of them do we carry a film?And how about for actors with two types of awards?
same questions.Finally ,how about actors with just one award? */ 

  SELECT
     CASE
        WHEN actor_award.awards = 'Emmy, Oscar , Tony ' THEN ' 3 awards'
        WHEN actor_award.awards IN ('Emmy , Oscar','Emmy, Tony','Oscar,Tony') THEN '2 awards'
        ELSE '1 award'
        
      END AS Number_of_awards,
      
      AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film
      
FROM actor_award
      
GROUP BY
          CASE
			 WHEN actor_award.awards = 'Emmy, Oscar ,Tony' THEN ' 3 awards'
             WHEN actor_award.awards IN ('Emmy , Oscar','Emmy,Tony','Oscar,Tony') THEN '2 awards'
             ELSE '1 award'
          END
          
 
 
 
   
     
     

   
       
       
 