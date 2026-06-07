--what are the most indemand skills for my role

with myrole as(
select
job_id,
job_title_short
from job_postings_fact
where job_title_short='Data Analyst'
)
select
skills_dim.skills,
count(myrole.job_id) as skill_count
from
myrole
inner join skills_job_dim on myrole.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
group by skills_dim.skills
order by skill_count desc
limit 5
;