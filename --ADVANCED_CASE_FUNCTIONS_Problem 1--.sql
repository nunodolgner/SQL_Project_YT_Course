--ADVANCED_CASE_FUNCTIONS_Problem 1--

SELECT
    job_id,
    job_title,
    salary_year_avg,
    CASE
    WHEN salary_year_avg > 100000 THEN 'High salary'
    WHEN salary_year_avg BETWEEN 60000 AND 99000 THEN 'Std salary'
    WHEN salary_year_avg < 60000 THEN 'Low salary'
    END AS Salary_Category
FROM 
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;

----------------------------------------------------------------------------------------
--ADVANCED_CASE_FUNCTIONS_Problem 2--

SELECT
    COUNT (DISTINCT CASE WHEN job_work_from_home = TRUE THEN company_id END) AS wfh_companies,
    COUNT (DISTINCT CASE WHEN job_work_from_home = FALSE THEN company_id END) AS non_wfh_companies
FROM
    job_postings_fact;

----------------------------------------------------------------------------------------
--ADVANCED_CASE_FUNCTIONS_Problem 3--

SELECT
    job_id,
    salary_year_avg,
CASE   --statement to categorize the job based on experience level from job_title--
    WHEN job_title ILIKE '%Senior%' THEN 'Senior'
    WHEN job_title ILIKE '%Manager%' OR job_title ILIKE '%Lead%' THEN 'Lead/Manager'
    WHEN job_title ILIKE '%Junior%' OR job_title ILIKE '%Entry%' THEN 'Junior/Entry'
    ELSE ' Not Specified'
END AS experience_level,

CASE   --statement to flag whether the job offers a remote work option--
    WHEN job_work_from_home THEN 'Yes'
    ELSE 'No'
END AS remote_option

FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
ORDER BY
    job_id;