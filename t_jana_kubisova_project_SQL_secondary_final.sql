USE engeto_2024_02_22;

CREATE TABLE t_jana_kubisova_project_SQL_secondary_final AS
SELECT e.country,
	   c.continent,	
	   e.`year`,
	   e.population,
	   e.gdp, 
	   e.gini 
FROM economies e 
JOIN countries c 
	ON e.country =c.country
WHERE continent ='Europe'
	AND e.`year`BETWEEN '2006' AND '2018';
	




