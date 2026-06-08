
WITH top_paying_jobs AS(
SELECT 
a.job_id,
a.job_title,
a.job_title_short,
a.job_location,
a.salary_year_avg,
b.name AS company_name
FROM job_postings_fact a
LEFT JOIN company_dim b
ON a.company_id=b.company_id
WHERE job_title_short='Data Analyst' AND job_location='Anywhere' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
)
SELECT top_paying_jobs.*,
skills
FROM
top_paying_jobs
LEFT JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
ORDER BY salary_year_avg DESC
LIMIT 10
;