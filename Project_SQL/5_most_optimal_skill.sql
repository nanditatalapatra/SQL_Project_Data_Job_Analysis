/* what are the most optimal skills to learn (aka it's in high demand and high paying skill? )
- Identify skills in high demand and associated with high average salaries for Data Analyst role
-Concentrate on Remote positions with specified salaries
-why? Targets skills that offer job security (high demand) and financial benefits (high salaries)
offering strategic insights for career development in Data Analysis
*/

--what are the most indemand skills for my role

with skills_demand as
(
select
skills_job_dim.skill_id,
skills_dim.skills,
count(job_postings_fact.job_id) as skill_count
from
job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where 
job_title_short='Data Analyst'
and salary_year_avg is not null
and  job_work_from_home= TRUE
group by skills_job_dim.skill_id,skills_dim.skills
),
average_salary as 
(
SELECT
skills_job_dim.skill_id,
skills_dim.skills,
round(avg(salary_year_avg),0) as avg_salary
from job_postings_fact 
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
where
job_title_short='Data Analyst'
and salary_year_avg is not null
and job_work_from_home=TRUE
group by skills_job_dim.skill_id,skills_dim.skills
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.skill_count,
    average_salary.avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id=average_salary.skill_id
WHERE
    skill_count>10
ORDER BY
    avg_salary DESC,
    skill_count DESC
LIMIT 25
;