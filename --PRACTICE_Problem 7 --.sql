--PRACTICE Problem 7 -- FOLLOW ALONG PROBLEM (2:42:00)--

/*
FIND THE COUNT OF THE NUMBER OF REMOTE JOB POSTINGS PER SKILL FOR 'DATA ANALYST' POSTS:
    - Display the top 5 skills by theirs demand in remote jobs
    - Include skill Id, name, and count of postings requiring the skill
*/
--1st step - combining in a CTE the 'job_postings_fact table' and 'skills_job_dim table' to just showcase part of the combining table (inner join) 
WITH remote_job_skills AS (
SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
    job_postings.job_work_from_home = TRUE AND
    job_postings.job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)
--2nd step - combine the CTE with w/ 'skills_dim'
SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;