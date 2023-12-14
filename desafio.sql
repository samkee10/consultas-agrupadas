Requerimientos
1. ¿Cuántos registros hay?

   consultas_agrupadas=# SELECT COUNT (*) FROM INSCRITOS;
 count
-------
    16
(1 row)

2. ¿Cuántos inscritos hay en total?

 consultas_agrupadas=# SELECT SUM(cantidad) FROM INSCRITOS;     
 sum
-----
 774
(1 row)

3. ¿Cuál o cuáles son los registros de mayor antigüedad?

consultas_agrupadas=# SELECT * FROM INSCRITOS WHERE fecha = (SELECT MIN(fecha) FROM INSCRITOS);
 cantidad |   fecha    | fuente
----------+------------+--------
       44 | 2021-01-01 | Blog
       56 | 2021-01-01 | Página
(2 rows)

4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de
    ahora en adelante).</h2>

    consultas_agrupadas=# SELECT SUM(cantidad), fecha FROM INSCRITOS GROUP BY fecha ORDER BY fecha;
 sum |   fecha
-----+------------
 100 | 2021-01-01
 120 | 2021-02-01
 103 | 2021-03-01
  93 | 2021-04-01
  88 | 2021-05-01
  30 | 2021-06-01
  58 | 2021-07-01
 182 | 2021-08-01
(8 rows)


5. ¿Cuántos inscritos hay por fuente?</h2>

consultas_agrupadas=# SELECT SUM(cantidad), fuente FROM INSCRITOS GROUP BY fuente;
 sum | fuente
-----+--------
 441 | Página
 333 | Blog
(2 rows)

6. ¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se
    inscribieron en ese día?</h2>

consultas_agrupadas=# SELECT * FROM INSCRITOS WHERE cantidad = (SELECT MAX(cantidad) FROM INSCRITOS);
 cantidad |   fecha    | fuente
----------+------------+--------
       99 | 2021-08-01 | Página
(1 row)

7. ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas
    personas fueron?</h2>

    consultas_agrupadas=# SELECT fecha, MAX(cantidad)
consultas_agrupadas-# FROM INSCRITOS
consultas_agrupadas-# WHERE fuente = 'Blog'
consultas_agrupadas-# GROUP BY fecha ORDER BY fecha
consultas_agrupadas-# DESC LIMIT 1;
   fecha    | max
------------+-----
 2021-08-01 |  83
(1 row)

8. ¿Cuál es el promedio de personas inscritas por día?

consultas_agrupadas=# SELECT AVG(cantidad), fecha FROM INSCRITOS GROUP BY fecha ORDER BY fecha;
         avg         |   fecha
---------------------+------------
 50.0000000000000000 | 2021-01-01
 60.0000000000000000 | 2021-02-01
 51.5000000000000000 | 2021-03-01
 46.5000000000000000 | 2021-04-01
 44.0000000000000000 | 2021-05-01
 15.0000000000000000 | 2021-06-01
 29.0000000000000000 | 2021-07-01
 91.0000000000000000 | 2021-08-01
(8 rows)


9. ¿Qué días se inscribieron más de 50 personas?

consultas_agrupadas=# SELECT SUM(cantidad), fecha FROM INSCRITOS WHERE cantidad>=50 GROUP BY fecha ORDER BY fecha;
 sum |   fecha
-----+------------
  56 | 2021-01-01
  81 | 2021-02-01
  91 | 2021-03-01
  55 | 2021-05-01
 182 | 2021-08-01
(5 rows)

10. ¿Cuál es el promedio diario de personas inscritas a partir del tercer día en adelante,
    considerando únicamente las fechas posteriores o iguales a la indicada?
    consultas_agrupadas=# SELECT AVG(cantidad), fecha FROM INSCRITOS GROUP BY fecha ORDER BY fecha OFFSET 3 ROWS;
         avg         |   fecha
---------------------+------------
 46.5000000000000000 | 2021-04-01
 44.0000000000000000 | 2021-05-01
 15.0000000000000000 | 2021-06-01
 29.0000000000000000 | 2021-07-01
 91.0000000000000000 | 2021-08-01
(5 rows)

