--  Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
--  Discord: jana_04527

USE engeto_2024_02_22;

SELECT category_name,
		round(avg(average_wages)/avg(average_price_food)) AS annual_purchase,
		`year` 
FROM t_jana_kubisova_project_sql_primary_final tj
WHERE (category_name LIKE lower('%chleb%')
	 OR category_name LIKE lower('%mleko%'))
	AND `year`IN ('2006','2018')
GROUP BY category_name, `year`; 