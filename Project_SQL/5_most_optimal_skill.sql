/* what are the most optimal skills to learn (aka it's in high demand and high paying skill? )
- Identify skills in high demand and associated with high average salaries for Data Analyst role
-Concentrate on Remote positions with specified salaries
-why? Targets skills that offer job security (high demand) and financial benefits (high salaries)
offering strategic insights for career development in Data Analysis
*/

--what are the most indemand skills for my role

WITH skills_demand AS
(
SELECT
skills_job_dim.skill_id,
skills_dim.skills,
count(job_postings_fact.job_id) AS skill_count
FROM
job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE 
job_title_short='Data Analyst'
AND salary_year_avg IS NOT NULL
and  job_work_from_home= TRUE
GROUP BY skills_job_dim.skill_id,skills_dim.skills
),
average_salary AS 
(
SELECT
skills_job_dim.skill_id,
skills_dim.skills,
round(avg(salary_year_avg),0) AS avg_salary
FROM job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
WHERE
job_title_short='Data Analyst'
AND salary_year_avg IS NOT NULL
and job_work_from_home=TRUE
GROUP BY skills_job_dim.skill_id,skills_dim.skills
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