select * from suppliers s;
select * from orders o;
select * from products p;
select * from categories c;
select * from employees e;
select * from customers c;

--1. Qué contactos de proveedores tienen la posición de sales representative?
select s.contact_name,s.contact_title 
from suppliers s
where s.contact_title ='Sales Representative';

--2. Qué contactos de proveedores no son marketing managers?
select s.contact_name ,s.contact_title 
from suppliers s 
where s.contact_title  != 'Marketing Manager';


--3. Cuales órdenes no vienen de clientes en Estados Unidos?
select o.order_id , o.ship_country 
from orders o 
where o.ship_country != 'USA';

-- otra forma de ver el problema 

select count(*)
from orders o 
where o.ship_country != 'USA';

select count(*)
from orders o, customers c 
join customers c using (customer_id)
where o.customer_id = c.customer_id and c.country != 'USA';

select count(*)
from orders o
join customers c using (customer_id)
where c.country != 'USA';


--4. Qué productos de los que transportamos son quesos?
select p.product_name 
from products p, categories c 
where c.description like '%Cheese%'
and c.category_id = p.category_id;

select count(*)
from products p
where p.category_id = (
	select c.category_id
	from categories c 
	where c.description = "Cheeses"
);

select count(*)
from products p 
where p.category_id ) = 4;



--5. Qué ordenes van a Bélgica o Francia?
select o.order_id, o.ship_country 
from orders o 
where ship_country = 'Belgium' or ship_country = 'France'; 

--6. Qué órdenes van a LATAM?

-- ¿qué países hay?
select distinct o.ship_country
from orders o;

select o.order_id,o.ship_country 
from orders o 
where o.ship_country in('Argentina','Venezuela','Mexico','Brazil');

--7. Qué órdenes no van a LATAM?
select o.order_id,o.ship_country 
from orders o 
where o.ship_country not in('Argentina','Venezuela','Mexico','Brazil');

--9. Necesitamos los nombres completos de los empleados, nombres y apellidos unidos en un mismo registro
select concat(e.first_name ,' ', e.last_name)
as complete_name_employees
from employees e;

--10. Cuánta lana tenemos en inventario?
select p.product_name, (p.unit_price*p.units_in_stock) as lana
from products p;
-- en inventario solo estan lo units_in_stock? ¿que son los units_on_order?
-- en inventario actualmente?

--11. Cuantos clientes tenemos de cada país?
select c.country , count(*) as Cantidad_de_clientes 
from customers c
group by c.country;


