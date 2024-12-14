-- 1. Quais são os documentos registrados no dia 13 de dezembro de 2024?
-- Objetivo: Buscar todos os documentos registrados no dia específico.
SELECT * 
FROM documento 
WHERE data = '2024-12-13';

-- 2. Quais são as fazendas localizadas no município de Seropédica?
-- Objetivo: Mostrar nome e área das fazendas localizadas em Seropédica, com JOIN entre as tabelas fazenda, fazenda_municipio e municipio.
SELECT f.nome, f.area
FROM fazenda f
JOIN fazenda_municipio fm ON f.id = fm.id_fazenda
JOIN municipio m ON fm.id_municipio = m.id
WHERE m.nome = 'Seropédica';

-- 3. Quais são os tipos de documentos relacionados à regularização fundiária?
-- Objetivo: Listar todos os tipos de documentos (nome e sigla).
SELECT nome, sigla 
FROM tipo_documento;

-- 4. Qual é a área total das fazendas localizadas em Seropédica?
-- Objetivo: Somar a área de todas as fazendas em Seropédica, usando GROUP BY e SUM para calcular a área total.
SELECT SUM(f.area) AS area_total
FROM fazenda f
JOIN fazenda_municipio fm ON f.id = fm.id_fazenda
JOIN municipio m ON fm.id_municipio = m.id
WHERE m.nome = 'Seropédica';

-- 5. Quais documentos foram acessados entre os dias 12 e 14 de dezembro de 2024?
-- Objetivo: Buscar documentos acessados em um intervalo de datas, utilizando BETWEEN.
SELECT * 
FROM documento
WHERE data BETWEEN '2024-12-12' AND '2024-12-14';

-- 6. Quais são os endereços registrados no município de Seropédica?
-- Objetivo: Buscar todos os endereços relacionados ao município de Seropédica.
SELECT estado, cidade, logradouro, bairro, numero, cep
FROM endereco
WHERE cidade = 'Seropédica';

-- 7. Quais documentos possuem a sigla "EPCV" (Escritura Pública de Compra e Venda)?
-- Objetivo: Buscar tipo de documentos com a sigla específica.
SELECT * 
FROM tipo_documento 
WHERE sigla = 'EPCV';

-- 8. Qual é o nome das fazendas com mais de 100 hectares localizadas em Seropédica?
-- Objetivo: Mostrar o nome das fazendas que têm mais de 100 hectares em Seropédica.
SELECT f.nome
FROM fazenda f
JOIN fazenda_municipio fm ON f.id = fm.id_fazenda
JOIN municipio m ON fm.id_municipio = m.id
WHERE m.nome = 'Seropédica' AND f.area > 100;

-- 9. Quais são os documentos e suas respectivas siglas no banco de dados?
-- Objetivo: Listar todos os tipos de documentos com suas siglas.
SELECT nome, sigla 
FROM tipo_documento;

-- 10. Quais documentos foram acessados no formato PDF?
-- Objetivo: Buscar documentos no formato PDF, usando LIKE para filtrar a extensão do arquivo.
SELECT * 
FROM documento 
WHERE arquivo LIKE '%.pdf';


-- 11. Exibir as fazendas com área maior que 100 hectares, ordenadas de forma crescente por nome.
-- Objetivo: Buscar as fazendas com área superior a 100 hectares e ordenar pelo nome de forma crescente.
SELECT f.nome, f.area
FROM fazenda f
WHERE f.area > 100
ORDER BY f.nome ASC;

-- 12. Mostrar os documentos que foram acessados depois do dia 10 de dezembro de 2024, limitando a 5 resultados.
-- Objetivo: Exibir os 5 primeiros documentos acessados após uma data específica.
SELECT * 
FROM documento 
WHERE data > '2024-12-10'
LIMIT 5;

-- 13. Quais são as fazendas localizadas em Seropédica com a área entre 50 e 200 hectares?
-- Objetivo: Buscar fazendas em Seropédica com área dentro de um intervalo específico.
SELECT f.nome, f.area
FROM fazenda f
JOIN fazenda_municipio fm ON f.id = fm.id_fazenda
JOIN municipio m ON fm.id_municipio = m.id
WHERE m.nome = 'Seropédica' AND f.area BETWEEN 50 AND 200;

-- 14. Quais são os documentos que não estão no formato PDF ou Excel?
-- Objetivo: Buscar documentos que não possuem as extensões 'pdf' ou 'xlsx', utilizando NOT IN.
SELECT * 
FROM documento
WHERE arquivo NOT LIKE '%.pdf' AND arquivo NOT LIKE '%.xlsx';

-- 15. Qual é a soma total da área das fazendas em Seropédica que têm nome começando com 'B'?
-- Objetivo: Calcular a soma das áreas das fazendas cujo nome começa com 'B', utilizando LIKE para filtrar o nome.
SELECT SUM(f.area) AS area_total
FROM fazenda f
JOIN fazenda_municipio fm ON f.id = fm.id_fazenda
JOIN municipio m ON fm.id_municipio = m.id
WHERE m.nome = 'Seropédica' AND f.nome LIKE 'B%';

-- 16. Qual é o nome e área das fazendas que pertencem a mais de 1 município?
-- Objetivo: Buscar fazendas que aparecem em mais de um município.
SELECT f.nome, f.area
FROM fazenda f
JOIN fazenda_municipio fm ON f.id = fm.id_fazenda
GROUP BY f.nome, f.area
HAVING COUNT(fm.id_municipio) > 1;

-- 17. Quais são os documentos com nome contendo a palavra "relatorio"?
-- Objetivo: Buscar documentos que possuem a palavra "relatorio" em seu nome, usando LIKE.
SELECT * 
FROM documento
WHERE arquivo LIKE '%relatorio%';

-- 18. Quais são os municípios com mais de 10 fazendas associadas a eles?
-- Objetivo: Buscar municípios com mais de 10 fazendas, utilizando GROUP BY e HAVING.
SELECT m.nome, COUNT(fm.id_fazenda) AS quantidade_fazendas
FROM municipio m
JOIN fazenda_municipio fm ON m.id = fm.id_municipio
GROUP BY m.nome
HAVING COUNT(fm.id_fazenda) > 10;

-- 19. Quais documentos foram acessados no ano de 2024?
-- Objetivo: Buscar documentos acessados no ano de 2024, utilizando YEAR para filtrar o ano.
SELECT * 
FROM documento
WHERE YEAR(data) = 2024;

-- 20. Quais são as fazendas com área superior a 200 hectares, ordenadas de forma decrescente por área?
-- Objetivo: Buscar fazendas com área maior que 200 hectares e ordenar pela área de forma decrescente.
SELECT f.nome, f.area
FROM fazenda f
WHERE f.area > 200
ORDER BY f.area DESC;
