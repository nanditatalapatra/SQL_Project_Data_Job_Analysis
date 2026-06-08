--what are the most indemand skills for my role

WITH myrole AS(
SELECT
job_id,
job_title_short
FROM job_postings_fact
WHERE job_title_short='Data Analyst'
)
SELECT
skills_dim.skills,
count(myrole.job_id) AS skill_count
FROM
myrole
INNER JOIN skills_job_dim ON myrole.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
GROUP BY skills_dim.skills
ORDER BY skill_count DESC
LIMIT 5
;