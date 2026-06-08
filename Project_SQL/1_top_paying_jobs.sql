--What are the top paying data analyst jobs?
--Identify the top 10 highest-paying Data Analyst roles that are available remotely
--Focuses on job postings with specified salaries(remove nulls)
--why?highlight the top paying opportunities for Data Analysts, offering insight into 

SELECT 
a.job_id,
a.job_title,
a.job_location,
a.salary_year_avg,
b.name
FROM job_postings_fact a
LEFT JOIN company_dim b
ON a.company_id=b.company_id
WHERE job_title_short='Data Analyst' 
AND job_location='Anywhere' 
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;

