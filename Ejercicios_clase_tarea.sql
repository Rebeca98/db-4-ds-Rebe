--Cuales pagos no son del cliente con ID 5, y cuyo monto sea mayor a 8 o cuya fecha sea 23 de Agosto de 2005?
select *
from payment p 
where (p.customer_id != 5
and p.amount > 8)
or p.payment_date between '2005-08-23 00:00:00' and '2005-08-23 23:59:59';

---Cuales pagos son del cliente con ID 5 y cuyo monto no sea mayor a 6 y su fecha tampoco sea del 19 de Junio de 2005?
select count(*)
from payment p
where p.customer_id = 5
and not p.amount > 6
and p.payment_date not between '2005-06-19 00:00:00' and '2005-06-19 23:59:59';

--Cuales pagos tienen el monto 1.98, 7.98 o 9.98?
select * 
from payment p
where p.amount = 1.98 or p.amount = 7.98 or p.amount = 9.98;


--Cuales la suma total pagada por los clientes que tienen una letra A en la segunda posición de su apellido y una W en cualquier lugar después de la A?
select c.first_name,sum(p.amount)
from customer c 
inner join payment p on (p.customer_id=c.customer_id)
where c.first_name like '_A%W%'
group by c.first_name;