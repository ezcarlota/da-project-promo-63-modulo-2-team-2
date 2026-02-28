-- 1.NUMERO DE CANCIONES POR GÉNERO
SELECT g.nombre_genero, COUNT(*) AS total_canciones
FROM canciones c
JOIN genero g 
USING(id_genero)
WHERE c.año_lanzamiento BETWEEN 2013 AND 2015
  AND g.nombre_genero IN ('flamenco','reggaeton','pop','rock','indie')
GROUP BY g.nombre_genero
ORDER BY total_canciones DESC;

-- 2. ¿En qué año se lanzaron más canciones?
SELECT c.año_lanzamiento, COUNT(*) AS total_canciones
FROM canciones c
WHERE c.año_lanzamiento BETWEEN 2013 AND 2015
GROUP BY c.año_lanzamiento
ORDER BY total_canciones DESC;

-- 3. Tendencia por género en los 3 años (canciones por género y año)
SELECT c.año_lanzamiento, g.nombre_genero, COUNT(*) AS total_canciones
FROM canciones AS c
JOIN genero AS g 
USING(id_genero)
WHERE c.año_lanzamiento BETWEEN 2013 AND 2015
GROUP BY c.año_lanzamiento, g.nombre_genero
ORDER BY c.año_lanzamiento, total_canciones DESC;

-- 4. Top 10 artistas por reproducciones (del catálogo 2013–2015) HEADLINER
SELECT a.nombre_artista, a.reproducciones, a.popularidad
FROM artistas AS a
JOIN fk_artistas_canciones AS ca USING( id_artista)
JOIN canciones AS c USING(id_cancion)
GROUP BY a.id_artista, a.nombre_artista, a.reproducciones, a.popularidad
ORDER BY a.reproducciones DESC
LIMIT 10;

-- 5. Canciones “estrella” del catálogo (Top 10) usando  reproducciones + popularidad del artista
SELECT c.nombre_cancion, a.nombre_artista, g.nombre_genero, c.año_lanzamiento,
       a.reproducciones, a.popularidad
FROM canciones AS c
JOIN genero AS g USING(id_genero)
JOIN fk_artistas_canciones AS ca USING(id_cancion)
JOIN artistas AS a USING(id_artista)
WHERE g.nombre_genero IN ('flamenco','reggaeton','pop','rock','indie')
ORDER BY a.reproducciones DESC, a.popularidad DESC
LIMIT 10;


-- 6.Género con más “impacto” por año (suma de reproducciones de artistas únicos por género/año)
SELECT
  t.año,
  t.nombre_genero,
  t.reproducciones_total
FROM (
  SELECT
    c.año_lanzamiento AS año,
    g.nombre_genero,
    SUM(DISTINCT a.reproducciones) AS reproducciones_total
  FROM canciones AS c
  JOIN genero AS g USING(id_genero)
  JOIN fk_artistas_canciones AS ca USING(id_cancion)
  JOIN artistas AS a USING(id_artista)
  WHERE g.nombre_genero IN ('flamenco','reggaeton','pop','rock','indie')
  GROUP BY c.año_lanzamiento, g.nombre_genero
) t
WHERE NOT EXISTS (
  SELECT 1
  FROM (
    SELECT
      c2.año_lanzamiento AS año,
      g2.nombre_genero,
      SUM(DISTINCT a2.reproducciones) AS reproducciones_total
    FROM canciones c2
    JOIN genero AS g2 USING(id_genero)
    JOIN fk_artistas_canciones AS ca2 USING(id_cancion)
    JOIN artistas AS a2 USING(id_artista)
    WHERE g2.nombre_genero IN ('flamenco','reggaeton','pop','rock','indie')
    GROUP BY c2.año_lanzamiento, g2.nombre_genero
  ) t2
  WHERE t2.año = t.año
    AND t2.reproducciones_total > t.reproducciones_total
)
ORDER BY t.año;

-- Artista con más reproducciones por año (Top 1 por año)
SELECT
  c.año_lanzamiento AS año,
  a.nombre_artista,
  a.reproducciones
FROM canciones AS c
JOIN fk_artistas_canciones AS ca USING (id_cancion)
JOIN artistas AS a USING(id_artista)
WHERE (
    SELECT COUNT(DISTINCT a2.id_artista)
    FROM canciones AS c2
    JOIN fk_artistas_canciones USING(id_cancion)
    JOIN artistas AS a2 USING(id_artista)
    WHERE c2.año_lanzamiento = c.año_lanzamiento
      AND a2.reproducciones > a.reproducciones
  ) = 0
GROUP BY año, a.id_artista, a.nombre_artista, a.reproducciones
ORDER BY año, a.reproducciones DESC;
-- 7. TOP 5 ARTISTAS 
SELECT g.nombre_genero, a.nombre_artista, a.reproducciones
FROM canciones AS c
JOIN genero  AS g 
USING(id_genero)
JOIN fk_artistas_canciones AS ac 
USING(id_cancion)
JOIN artistas AS a 
USING(id_artista)
WHERE (
    SELECT COUNT(DISTINCT a2.id_artista)
    FROM canciones AS c2
    JOIN genero AS  g2 USING(id_genero)
    JOIN  fk_artistas_canciones AS ac2 using(id_cancion)
    JOIN artistas AS a2 USING(id_artista)
    WHERE  g2.nombre_genero = g.nombre_genero
      AND a2.reproducciones > a.reproducciones
  ) < 5
GROUP BY g.nombre_genero, a.id_artista, a.nombre_artista, a.reproducciones
ORDER BY g.nombre_genero, a.reproducciones DESC;


-- 8. Densidad de hits” por género: % de canciones con artistas muy populares (umbral 70)
SELECT g.nombre_genero,
  COUNT(DISTINCT CASE WHEN a.popularidad >= 70 THEN c.id_cancion END) AS canciones_populares,
  COUNT(DISTINCT c.id_cancion) AS total_canciones,
  (COUNT(DISTINCT CASE WHEN a.popularidad >= 70 THEN c.id_cancion END) * 100.0
   / COUNT(DISTINCT c.id_cancion)) AS pct_populares
FROM canciones AS c
JOIN genero AS g USING(id_genero)
JOIN fk_artistas_canciones AS ca USING(id_cancion)
JOIN artistas AS a USING(id_artista)
WHERE g.nombre_genero IN ('flamenco','reggaeton','pop','rock','indie')
GROUP BY g.nombre_genero
ORDER BY pct_populares DESC;

-- 9. promedio de reproducciones por genero 
SELECT
  g.nombre_genero,
  AVG(DISTINCT a.reproducciones) AS promedio_reproducciones
FROM canciones AS c
JOIN genero AS g USING(id_genero)
JOIN fk_artistas_canciones AS ca USING(id_cancion)
JOIN artistas AS a ON a.id_artista = ca.id_artista
GROUP BY g.nombre_genero
ORDER BY promedio_reproducciones DESC;

-- 10. Promedio popularidad por género
SELECT g.nombre_genero,
       AVG(DISTINCT a.popularidad) AS promedio_popularidad
FROM canciones AS c
JOIN genero AS g ON g.id_genero = c.id_genero
JOIN fk_artistas_canciones AS ca USING(id_cancion)
JOIN artistas AS a USING(id_artista)
GROUP BY g.nombre_genero
ORDER BY promedio_popularidad DESC;

-- 11. Artistas presentes en los 3 años (2013, 2014 y 2015)
SELECT a.nombre_artista
FROM artistas AS  a
JOIN fk_artistas_canciones AS ca USING(id_artista)
JOIN canciones AS c ON c.id_cancion = ca.id_cancion
WHERE c.año_lanzamiento BETWEEN 2013 AND 2015
GROUP BY a.id_artista, a.nombre_artista
HAVING COUNT(DISTINCT c.año_lanzamiento) = 3
ORDER BY a.nombre_artista;

-- 12. Artistas “puente” (aparecen en 2+ géneros)
SELECT a.nombre_artista, COUNT(DISTINCT g.nombre_genero) AS num_generos
FROM canciones AS c
JOIN genero AS g USING(id_genero)
JOIN fk_artistas_canciones AS ca USING(id_cancion)
JOIN artistas AS a USING(id_artista)
GROUP BY a.id_artista, a.nombre_artista
HAVING COUNT(DISTINCT g.nombre_genero) > 2
ORDER BY num_generos DESC, a.reproducciones DESC;

-- 13. Artista similar más repetido
SELECT s.nombre_artistas_similar, COUNT(*) AS veces_aparece
FROM FK_artistas_artistas_similares AS f
JOIN artistas_similares AS s ON s.id_artista_similar = f.id_artista_similar
GROUP BY s.id_artista_similar, s.nombre_artistas_similar
ORDER BY veces_aparece DESC
LIMIT 10;

-- 14. Qué géneros son “más fuertes”  si combinamo reproducciones y popularidad
SELECT
  g.nombre_genero,
  AVG(DISTINCT a.reproducciones) AS avg_reproducciones,
  AVG(DISTINCT a.popularidad) AS avg_popularidad
FROM canciones AS c
JOIN genero AS g USING(id_genero)
JOIN fk_artistas_canciones AS ca USING(id_cancion)
JOIN artistas AS a USING(id_artista)
WHERE g.nombre_genero IN ('flamenco','reggaeton','pop','rock','indie')
GROUP BY g.nombre_genero
ORDER BY avg_reproducciones DESC, avg_popularidad DESC;

-- 15. Artistas con más reproducciones por género

SELECT DISTINCT
    c.id_genero,
    a.nombre_artista,
    a.reproducciones
FROM artistas a
JOIN fk_artistas_canciones fac 
    ON a.id_artista = fac.id_artista
JOIN canciones c 
    ON fac.id_cancion = c.id_cancion
WHERE (c.id_genero, a.reproducciones) IN (
    SELECT 
        c2.id_genero,
        MAX(a2.reproducciones)
    FROM artistas a2
    JOIN fk_artistas_canciones fac2 
        ON a2.id_artista = fac2.id_artista
    JOIN canciones c2 
        ON fac2.id_cancion = c2.id_cancion
    GROUP BY c2.id_genero
)
ORDER BY c.id_genero;
