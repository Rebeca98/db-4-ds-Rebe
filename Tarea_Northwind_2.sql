--1 Obtener un reporte de edades de los empleados para checar su elegibilidad para seguro de gastos médicos menores.
select e.first_name, e.last_name , age(now(),e.birth_date )
from employees e;

--2 Cuál es la orden más reciente por cliente?
select o.customer_id, max(o.order_date)
from orders o 
group by o.customer_id;


--3 De nuestros clientes, qué función desempeñan y cuántos son?
select c.contact_title, count(c.contact_title)
from customers c
group by c.contact_title ;

--4 Cuántos productos tenemos de cada categoría?
select p.category_id, count(p.category_id) 
from products p
group by p.category_id;

select c.category_id, c.category_name 
from categories c ;

--5 Cómo podemos generar el reporte de reorder?
-- a que se refiere con reorder?

--6 A donde va nuestro envío más voluminoso?
select o.ship_country 
from orders o 
where o.order_id in (select od.order_id from order_details od
where od.quantity = (select  max(od2.quantity) from order_details od2));


-- querie de ayuda
select od.quantity , od.order_id 
from order_details od
order by od.quantity desc; 


--7 Cómo creamos una columna en customers que nos diga si un cliente es bueno, regular, o malo?
select * from order_details od2;
select * from orders o2;

--el numero de ordenes que generamos con cada customer
select o.customer_id, count(o.customer_id)
from orders o 
group by o.customer_id;

-- la cantidad de producto que pide cada customer
select o.customer_id, sum(od.quantity) as "suma"
from order_details od 
inner join orders o 
on o.order_id =od.order_id 
group by o.customer_id;


select max(select sum(od.quantity)
from order_details od 
inner join orders o 
on o.order_id =od.order_id 
group by o.customer_id) 


--8 Qué colaboradores chambearon durante las fiestas de navidad?

-- ¿como saber cuando un colaborador esta trabajando?
select * from employees e;
select * from orders o;


--ideas para extraer la fecha 
SELECT EXTRACT(YEAR FROM TIMESTAMP '2016-12-31 13:30:15');
SELECT EXTRACT(MONTH FROM TIMESTAMP '2016-12-31');
   

--9 Qué productos mandamos en navidad?
select o.shipped_date, p.product_name 
from orders o
inner join  order_details od on o.order_id = od.order_id 
inner join products p on p.product_id = od.product_id 
where o.shipped_date ='1996-12-24' or o.shipped_date ='1997-12-24' or o.shipped_date ='1998-12-24';

--10 Qué país recibe el mayor volumen de producto?
select o.ship_country 
from orders o 
where o.order_id in (select od.order_id from order_details od
where od.quantity = (select  max(od2.quantity) from order_details od2));





