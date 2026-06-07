--What are the top paying data analyst jobs?
--Identify the top 10 highest-paying Data Analyst roles that are available remotely
--Focuses on job postings with specified salaries(remove nulls)
--why?highlight the top paying opportunities for Data Analysts, offering insight into 

select 
a.job_id,
a.job_title,
a.job_location,
a.salary_year_avg,
b.name
from job_postings_fact a
left join company_dim b
on a.company_id=b.company_id
where job_title_short='Data Analyst' and job_location='Anywhere' and salary_year_avg is NOT NULL
order by salary_year_avg desc
LIMIT 10;

