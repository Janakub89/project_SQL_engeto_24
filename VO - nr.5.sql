-- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce,
-- projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
-- Discord: jana_04527

USE engeto_2024_02_22;

SELECT tjk.`year`,
	   tjk2.`year`AS prev_year,
	   tjk.price_year,
	   tjk2.price_prev_year,
	   tjk.wages_year,
	   tjk2.wages_prev_year,
	   gdp.gdp
FROM (
	SELECT `year` ,
			round(avg(average_price_food)) AS price_year,
			round(avg(average_wages)) AS wages_year		
	FROM t_jana_kubisova_project_sql_primary_final tjkp
	GROUP BY `year`) AS tjk
JOIN (
	SELECT `year` ,
			round(avg(average_price_food)) AS price_prev_year,
			round(avg(average_wages)) AS wages_prev_year		
	FROM t_jana_kubisova_project_sql_primary_final tjkp
	GROUP BY `year`) AS tjk2
	ON tjk.`year`= tjk2.`year`+1
JOIN (	
	SELECT `year` ,
			gdp 
	FROM t_jana_kubisova_project_sql_secondary_final tjkpssf 
	WHERE country='Czech Republic') AS gdp
	ON tjk.`year`=gdp.`year`
ORDER BY `year`DESC