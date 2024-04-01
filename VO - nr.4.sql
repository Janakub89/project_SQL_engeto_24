-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
-- Discord: jana_04527

USE engeto_2024_02_22;

SELECT tjk.`year`,
	   tjk2.`year` AS prev_year,
	   round(( tjk.price_year - tjk2.price_prev_year)/tjk2.price_prev_year*100,2) AS price_diff,
	   round((tjk.wages_year - tjk2.wages_prev_year)/tjk2.wages_prev_year*100,2) AS wages_diff,
	   round(( tjk.price_year - tjk2.price_prev_year)/tjk2.price_prev_year*100-(tjk.wages_year - tjk2.wages_prev_year)/tjk2.wages_prev_year*100,2) AS percent_diff
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
ORDER BY tjk.`year`DESC;