/**
 * Una de las métricas para saber si un cliente es bueno, aparte de la suma y el promedio de sus pagos, es si tenemos una 
 * progresión consistentemente creciente en los montos.

Debemos calcular para cada cliente su promedio mensual de deltas en los pagos de sus órdenes en la tabla order_details en la 
BD de Northwind, es decir, la diferencia entre el monto total de una orden en tiempo t y el anterior en t-1, para tener la foto 
completa sobre el customer lifetime value de cada miembro de nuestra cartera.
 */
select c.customer_id as cliente, 
o.order_date as fecha,
od.unit_price*od.quantity as pago_t,
lag(od.unit_price*od.quantity) over w as pago_tmenos1,
(lag(od.unit_price*od.quantity) over w + (od.unit_price*od.quantity))*0.5 as promedio_deltas
from customers c inner join orders o on(o.customer_id = c.customer_id)
inner join order_details od on(od.order_id = o.order_id)
window w as (partition by c.customer_id) ;


with pago_mensual as (
	select c.customer_id as cliente, 
	o.order_date as fecha,
	od.unit_price*od.quantity as pago_t,
	lag(od.unit_price*od.quantity) over w as pago_tmenos1,
	(lag(od.unit_price*od.quantity) over w - (od.unit_price*od.quantity)) as diferencia_deltas
	from customers c inner join orders o on(o.customer_id = c.customer_id)
	inner join order_details od on(od.order_id = o.order_id)
	window w as (partition by c.customer_id)
)
select cliente, extract(month from fecha) as mes, avg(diferencia_deltas) as promedio_diferenci_deltas
from pago_mensual
group by cliente,mes
order by cliente;










 




 
