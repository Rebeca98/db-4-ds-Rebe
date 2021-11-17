/**
 * TAREA 1
 * 
 * Una aplicación frecuente de Ciencia de Datos aplicada a la industria del microlending es el de calificaciones crediticias 
 * (credit scoring). Puede interpretarse de muchas formas: propensión a pago, probabilidad de default, etc. 
 * La intuición nos dice que las variables más importantes son el saldo o monto del crédito, y la puntualidad del pago; 
 * sin embargo, otra variable que frecuentemente escapa a los analistas es el tiempo entre cada pago. La puntualidad 
 * es una pésima variable para anticipar default o inferir capacidad de pago de micropréstamos, por su misma naturaleza. 
 * Si deseamos examinar la viabilidad de un producto de crédito para nuestras videorental stores:

    Cuál es el promedio, en formato human-readable, de tiempo entre cada pago por cliente de la BD Sakila?
    Sigue una distribución normal?
    Qué tanto difiere ese promedio del tiempo entre rentas por cliente? 
 */
-- Pregunta 1
    SELECT customer_id, AVG(tiempo_entre_pagos) AS tiempo_promedio_entre_pagos
    from ( SELECT customer_id,payment_date - LAG(payment_date)
           OVER (PARTITION BY customer_id ORDER BY payment_date) AS tiempo_entre_pagos
           FROM payment p
    	) AS a
    GROUP BY customer_id;


-- Pregunta 2
-- Load Histogram function
CREATE OR REPLACE FUNCTION histogram(table_name_or_subquery text, column_name text)
RETURNS TABLE(bucket int, "range" numrange, freq bigint, bar text)
AS $func$
BEGIN
RETURN QUERY EXECUTE format('
  WITH
  source AS (
    SELECT * FROM %s
  ),
  min_max AS (
    SELECT min(%s) AS min, max(%s) AS max FROM source
  ),
  histogram AS (
    SELECT
      width_bucket(%s, min_max.min, min_max.max, 20) AS bucket,
      numrange(min(%s)::numeric, max(%s)::numeric, ''[]'') AS "range",
      count(%s) AS freq
    FROM source, min_max
    WHERE %s IS NOT NULL
    GROUP BY bucket
    ORDER BY bucket
  )
  SELECT
    bucket,
    "range",
    freq::bigint,
    repeat(''*'', (freq::float / (max(freq) over() + 1) * 15)::int) AS bar
  FROM histogram',
  table_name_or_subquery,
  column_name,
  column_name,
  column_name,
  column_name,
  column_name,
  column_name,
  column_name
  );
END
$func$ LANGUAGE plpgsql;

-- divido entre 3600 para convertir la unidad de epoch a horas
SELECT histogram('(SELECT customer_id, FLOOR(EXTRACT(epoch FROM AVG(tiempo_entre_pagos))/3600) AS tiempo_promedio_entre_pagos
    FROM
    (SELECT customer_id, payment_date - LAG(payment_date)
    OVER (PARTITION BY customer_id ORDER BY payment_date) AS tiempo_entre_pagos
    FROM payment p) AS a
    GROUP BY customer_id) AS a','tiempo_promedio_entre_pagos');
-- no sigue una distribución normal 
   

-- Pregunta 3
select stddev(tiempo_promedio_entre_pagos)/3600 AS desv_estan_dias_entre_rentas
FROM ( select EXTRACT(epoch FROM AVG(tiempo_entre_pagos)) AS tiempo_promedio_entre_pagos
   	FROM
    (
        SELECT customer_id, payment_date - LAG(payment_date)
        OVER (PARTITION BY customer_id ORDER BY payment_date) AS tiempo_entre_pagos
        FROM payment p
    ) AS a
    GROUP BY customer_id
    ) AS ABT;





