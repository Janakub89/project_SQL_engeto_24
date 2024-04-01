-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
-- Discord: jana_04527

use engeto_2024_02_22;

SELECT gcn.category_name,
	   round(avg(gcn.price_diff),2) AS average_increase
FROM (SELECT cn.category_name,
	   cn.`year` ,
	   cn1.`year` AS year_prev,
	   cn.average_annual_price ,
	   cn1.average_annual_price AS average_annual_price_prev ,
	   round((cn.average_annual_price-cn1.average_annual_price)/cn1.average_annual_price*100,2) price_diff
FROM (
	SELECT category_name,
	avg(average_price_food) AS average_annual_price,
	`year`  
	FROM t_jana_kubisova_project_sql_primary_final tjkpspf 
	GROUP BY category_name ,`year`) AS cn
JOIN (
	SELECT category_name,
	avg(average_price_food) AS average_annual_price,
	`year`  
	FROM t_jana_kubisova_project_sql_primary_final tjkpspf 
	GROUP BY category_name ,`year`) AS cn1
	ON cn.category_name= cn1.category_name
	AND cn.`year`=cn1.`year`+1
ORDER BY cn.category_name, cn.`year`DESC) AS gcn
GROUP BY gcn.category_name
ORDER BY average_increase
	


			