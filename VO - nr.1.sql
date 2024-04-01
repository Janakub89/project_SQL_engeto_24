-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
-- Discord: jana_04527

USE engeto_2024_02_22;

CREATE VIEW v_jana_kubisova_payroll_annual AS
SELECT industry_branch,
		`year`,
		round(avg(average_wages)) AS average_annual_wage
FROM t_jana_kubisova_project_sql_primary_final
GROUP BY industry_branch, `year` 
ORDER BY industry_branch, `year`; 

SELECT 
	vjkpa.industry_branch,
	sum(CASE 
		WHEN vjkpa.average_annual_wage - vjkpa1.average_annual_wage >0 then 1
		ELSE 0
	END) AS sum_increase_flag,
	count(*) AS branch_year_count
FROM v_jana_kubisova_payroll_annual vjkpa 
JOIN v_jana_kubisova_payroll_annual vjkpa1
	ON vjkpa.industry_branch=vjkpa1.industry_branch 
	AND vjkpa.`year`=vjkpa1.`year`+1
GROUP BY vjkpa.industry_branch
ORDER BY sum_increase_flag DESC 

