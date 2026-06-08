-- what are the top skills based on salary for my role



WITH salarybased AS 
(
SELECT
job_id,
job_title_short,
salary_year_avg
FROM job_postings_fact
WHERE job_title_short='Data Analyst'
AND salary_year_avg IS NOT NULL
AND job_work_from_home =TRUE
)
(
SELECT
round(avg(salarybased.salary_year_avg),0) AS avg_salary,
skills_dim.skills,
count(salarybased.job_id) as skill_count
FROM salarybased 
INNER JOIN skills_job_dim ON salarybased.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
GROUP BY skills_dim.skills
ORDER BY avg_salary DESC
LIMIT 25
)
;