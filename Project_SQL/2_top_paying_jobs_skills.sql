
with top_paying_jobs as(
select 
a.job_id,
a.job_title,
a.job_title_short,
a.job_location,
a.salary_year_avg,
b.name as company_name
from job_postings_fact a
left join company_dim b
on a.company_id=b.company_id
where job_title_short='Data Analyst' and job_location='Anywhere' and salary_year_avg is NOT NULL
order by salary_year_avg desc
LIMIT 10
)
select top_paying_jobs.*,
skills
FROM
top_paying_jobs
left join skills_job_dim on top_paying_jobs.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
ORDER BY salary_year_avg DESC
limit 10
;