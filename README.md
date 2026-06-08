# Introduction
Dive into the data job market! Focusing on Data Analyst roles, this project explores top-paying jobs, in demand skills, and where hig demand meets high salary in data analytics.

SQL queries? Check them out here: [Project_SQL folder](/Project_SQL/)
# Background
Driven by a quest to navigate the Data Analyst job market more effectively, the project was born from a desire to pinpoint top-paid and in-demand skills,streamlining others work to find optimal jobs.

### The questions I wanted to answer through my SQL quesries are:
1. What are the top paying Data Analyst jobs?
2. What skills are required for these top paying jobs?
3. What skills are most in demand for Data Analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learns?
# Tools I used
- **SQL:** the backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data
- **Visual Studio Code:** My go-to for database management and executing queries
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
# The Analysis
Each query for this project aimed at  investigating specific aspects of the data analyst job market. Here's how I approach each question:

### 1. Top paying Data Analyst jobs
To identify the highest paying roles, I filtered data analyst positions by average yearly salary and location,focusing on remote jobs.The query highlights the high paying opportunities in the field.

```SQL
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
LIMIT 10;;
```
### 2. Skills are required for these top paying jobs

```

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
```
### 3. What skills are most in demand for Data Analysts?

```
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
```
### 4. Which skills are associated with higher salaries?

```
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
```
### 5.What are the most optimal skills to learns?

```
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
```

# What I learned
 This project enhanced my SQL skills and provided valuable insights into the data analyst job market.