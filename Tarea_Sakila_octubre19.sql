-- Tarea 

--Cómo obtenemos todos los nombres y correos de nuestros clientes canadienses para una campaña?
select concat(c.first_name,' ', c.last_name), c.email, c3.country 
from customer c
inner join address a on (a.address_id=c.address_id)
inner join city c2 on (a.city_id = c2.city_id)
inner join country c3 on (c3.country_id = c2.country_id)
where c3.country = 'Canada';

--Qué cliente ha rentado más de nuestra sección de adultos?

--categoria de adultos: NC-17
select c2.customer_id,concat(c2.first_name,' ', c2.last_name),f.rating,count(f.rating) as numero_rentas
from rental r 
inner join customer c2 on (r.customer_id=c2.customer_id)
inner join inventory i on (r.inventory_id = i.inventory_id)
inner join film f on (i.film_id=f.film_id)
group by f.rating,c2.customer_id 
having f.rating = 'NC-17'
order by numero_rentas desc;


--Qué películas son las más rentadas en todas nuestras stores?
-- para cada una de las rentas se genera un recibo de renta con un rental_id
select  f.film_id,f.title,count(r.rental_id) as numero_rentas
from film f 
inner join inventory i on (i.film_id=f.film_id)
inner join rental r on (i.inventory_id=r.inventory_id)
inner join store s on (s.store_id=i.store_id)
group by f.film_id
order by numero_rentas desc; 

--Cuál es nuestro revenue por store?
select s.store_id, sum(p.amount) as revenue
from store s 
inner join inventory i on( i.store_id=s.store_id)
inner join rental r on (i.inventory_id=r.inventory_id)
inner join payment p on (r.customer_id=p.customer_id)
group by s.store_id;


