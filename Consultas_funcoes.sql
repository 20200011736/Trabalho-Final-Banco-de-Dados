-- 1. Lista os lotes que têm área maior que 140 ou estão inativos.
SELECT * 
FROM lote 
WHERE area > 140 OR situacao = 'Inativo';

-- 2. Busca os lotes com as áreas 110.2, 120.3 e 130.6.
SELECT * 
FROM lote 
WHERE area IN (110.2, 120.3, 130.6);

-- 3. Exibe os lotes cuja equipe não é 'Equipe A'.
SELECT * 
FROM lote 
WHERE NOT Equipe = 'Equipe A';

-- 4. Ordena os lotes pela área em ordem crescente e, em caso de empate, pela equipe em ordem decrescente.
SELECT * 
FROM lote 
ORDER BY area ASC, Equipe DESC;

-- 5. Busca as zonas que têm pelo menos um lote vinculado.
SELECT * 
FROM zona z 
WHERE EXISTS (
  SELECT 1 
  FROM lote l 
  WHERE l.id_gleba = z.id
);

-- 6. Encontra o nome do município que possui a maior quantidade de zonas, verificando a contagem em um nível intermediário.
SELECT nome 
FROM municipio 
WHERE id = (
  SELECT id_municipio 
  FROM (
    SELECT id_municipio, COUNT(*) AS total_zonas 
    FROM zona 
    GROUP BY id_municipio 
    ORDER BY total_zonas DESC 
    LIMIT 1
  ) AS subconsulta
);

-- 7. Retorna os 5 primeiros lotes em ordem decrescente de área.
SELECT * 
FROM lote 
ORDER BY area DESC 
LIMIT 5;

-- 8. Calcula e exibe a área de cada lote.
SELECT id, codigo, ST_Area(poligono) AS area_calculada 
FROM lote;

-- 9. Encontra a distância entre as sedes de dois lotes específicos (L001 e L002).
SELECT ST_Distance(
  (SELECT sede FROM lote WHERE codigo = 'L001'),
  (SELECT sede FROM lote WHERE codigo = 'L002')
) AS distancia;

-- 10. Encontra os lotes cujos polígonos se intersectam com uma zona específica.
SELECT l.* 
FROM lote l 
JOIN zona z ON ST_Intersects(l.poligono, z.perimetro) 
WHERE z.id = 11;

-- 12. Encontra os lotes completamente contidos dentro de uma zona específica.
SELECT l.* 
FROM lote l 
JOIN zona z ON ST_Within(l.poligono, z.perimetro) 
WHERE z.id = 15;

-- 12. Retorna a coordenada central (centroide) de cada lote.
SELECT id, codigo, ST_Centroid(poligono) AS centroide 
FROM lote;

-- 13. Verifica quais lotes têm um polígono que toca o perímetro de uma zona específica.
SELECT l.* 
FROM lote l 
JOIN zona z ON ST_Touches(l.poligono, z.perimetro) 
WHERE z.id = 18;


-- 14. Encontra o lote com a maior área dentro da zona que possui o maior perímetro.
SELECT codigo, area 
FROM lote 
WHERE id_gleba = (
  -- Subconsulta para encontrar a zona com o maior perímetro
  SELECT id 
  FROM zona 
  ORDER BY ST_Length(perimetro) DESC 
  LIMIT 1
) 
ORDER BY area DESC 
LIMIT 1;
