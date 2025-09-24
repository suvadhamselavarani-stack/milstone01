SELECT * FROM salary_dataset;
-- 1 -----
SELECT 
    `Industry`,
    `Gender`,
    AVG(`Annual Salary`) AS average_salary
FROM 
    salary_survey.survey_table
GROUP BY 
    `Industry`, `Gender`
ORDER BY 
    `Industry`;
-- 2 ---
SELECT 
    `Job Title`,
    AVG(`Annual Salary` + `Additional Monetary Compensation`) AS Total_Salary
FROM milstonesql
GROUP BY `Job Title`
ORDER BY Total_Salary DESC
LIMIT 0, 50000;
-- 3 ----

SELECT 
    `Highest Level of Education Completed`,
    AVG(`Annual Salary`) AS Average_salary,
    MIN(`Annual Salary`) AS Min_salary,
    MAX(`Annual Salary`) AS Max_salary
FROM 
    milstonesql
GROUP BY 
    `Highest Level of Education Completed`
ORDER BY 
    Average_salary DESC;

-- 4 ----

SELECT 
    `Industry`,
    `Years of Professional Experience in Field`,
    COUNT(*) AS Employee_count
FROM 
    milstonesql
GROUP BY 
    `Industry`, `Years of Professional Experience in Field`
ORDER BY 
    Employee_count DESC
LIMIT 0, 50000;
-- 5 ----
WITH salary_ranked AS (
    SELECT 
      `Age Range`, 
      `Gender`, 
      `Annual Salary`,
      ROW_NUMBER() OVER (
        PARTITION BY `Age Range`, `Gender` 
        ORDER BY `Annual Salary`
      ) AS rn,
      COUNT(*) OVER (
        PARTITION BY `Age Range`, `Gender`
      ) AS total
    FROM milstonesql
)
SELECT 
   `Age Range`,
   `Gender`,
   AVG(`Annual Salary`) AS Median_salary
FROM salary_ranked
WHERE rn IN (
   FLOOR((total + 1) / 2),
   FLOOR((total + 2) / 2)
)
GROUP BY `Age Range`, `Gender`
ORDER BY `Age Range`, `Gender`;


-- 6 ---

SELECT 
    t.Country,
    t.`Job Title`,
    t.`Annual Salary`
FROM 
    milstonesql t
JOIN (
    SELECT 
      Country, 
      `Job Title`,
      MAX(`Annual Salary`) AS max_salary
    FROM 
      milstonesql
    GROUP BY 
      Country, `Job Title`
) AS max_salaries
ON 
    t.Country = max_salaries.Country 
    AND t.`Job Title` = max_salaries.`Job Title`
    AND t.`Annual Salary` = max_salaries.max_salary
LIMIT 0, 50000;

-- 7 -----
  
SELECT 
  `City`, 
  `Industry`, 
  AVG(`Annual Salary`) AS avg_salary
FROM 
  milstonesql
GROUP BY 
  City, Industry
ORDER BY 
  avg_salary DESC;

-- 8 ---
  
SELECT 
    Gender,
    ROUND(
      SUM(CASE 
            WHEN `Additional Monetary Compensation` IS NOT NULL 
                 AND `Additional Monetary Compensation` != 0 
            THEN 1 ELSE 0 
          END) 
      / COUNT(*) * 100, 2
    ) AS percentage_with_compensation
FROM 
    milstonesql
GROUP BY 
    Gender
LIMIT 0, 50000;

-- 9 ---
  
SELECT 
   `Job Title`,
   `Years of Professional Experience in Field`,
   SUM(`Annual Salary` + IFNULL(`Years of Professional Experience in Field`, 0)) AS total_compensation
FROM 
   milstonesql
GROUP BY 
   `Job Title`, `Years of Professional Experience in Field`
ORDER BY 
   `Job Title`, `Years of Professional Experience in Field`;
   
-- 10 ----
SELECT 
   Industry,
   Gender,
   `Highest Level of Education Completed`,
   AVG(`Annual Salary`) AS avg_salary
FROM 
   milstonesql
GROUP BY 
   Industry, Gender, `Highest Level of Education Completed`
ORDER BY 
   Gender, `Highest Level of Education Completed`;





    
