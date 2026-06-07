-- what are the top skills based on salary for my role



with salarybased as 
(
SELECT
job_id,
job_title_short,
salary_year_avg
from job_postings_fact
where job_title_short='Data Analyst'
and salary_year_avg is not null
and job_work_from_home =TRUE
)
(
SELECT
round(avg(salarybased.salary_year_avg),0) as avg_salary,
skills_dim.skills,
count(salarybased.job_id) as skill_count
from salarybased 
inner join skills_job_dim on salarybased.job_id=skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
group by skills_dim.skills
ORDER BY avg_salary DESC
limit 25
)
;