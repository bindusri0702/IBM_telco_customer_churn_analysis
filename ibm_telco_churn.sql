-- Insights

-- Demographics

-- Understand the distribution of customers based on gender, age, 
-- senior citizen status, marital status, and the presence of dependents.
SELECT 
    gender,
    senior_citizen,
    Married,
    Dependents,
    COUNT(*) AS customer_count
FROM
    demographics
GROUP BY 1 , 2 , 3 , 4
ORDER BY 5 DESC;

-- Analyze the average number of dependents per customer.

SELECT 
    AVG(number_of_dependents)
FROM
    demographics
WHERE
    dependents LIKE '%yes%'; 

-- Population

-- Examine the relationship between the population of a zip code area and the number of customers in that area.
-- Which countries, states, and cities have the highest concentration of customers?

SELECT 
    city,zip_code,population,COUNT(*) AS customer_count
FROM
    (SELECT 
        t.city,p.zip_code, p.population, t.customer_id
    FROM
        population p
    LEFT JOIN telco t ON p.zip_code = t.zip_code) AS customer_population_ratio
	GROUP BY 1,2,3
    order by 3 desc,4 desc; 
    
-- Location

-- Is there any correlation between customer location and the services they subscribe to?

SELECT 
    city,
    COUNT(CASE
        WHEN phone_service LIKE '%yes%' THEN 1
    END) AS phone_count,
    COUNT(CASE
        WHEN internet_service != 'No' THEN 1
    END) AS internet_count,
    COUNT(CASE
        WHEN online_security LIKE '%yes%' THEN 1
    END) AS security_count,
    COUNT(CASE
        WHEN online_backup LIKE '%yes%' THEN 1
    END) AS backup_count,
    COUNT(CASE
        WHEN device_protection LIKE '%yes%' THEN 1
    END) AS protection_count,
    COUNT(CASE
        WHEN tech_support LIKE '%yes%' THEN 1
    END) AS support_count,
    COUNT(CASE
        WHEN streaming_tv LIKE '%yes%' THEN 1
    END) AS tv_count,
    COUNT(CASE
        WHEN streaming_movies LIKE '%yes%' THEN 1
    END) AS movies_count
FROM
    population p
        LEFT JOIN
    telco t ON p.zip_code = t.zip_code
GROUP BY city
ORDER BY 
    2 DESC, 3 DESC, 4 DESC, 5 DESC, 6 DESC, 7 DESC, 8 DESC, 9 DESC;

-- Services

-- What are the most popular internet service types among customers?

SELECT 
    internet_service, COUNT(*) AS customer_count
FROM
    telco
GROUP BY 1
ORDER BY 2 DESC;

-- How does the contract of a customer relate to the services they subscribe to?

SELECT 
    contract,
    COUNT(CASE
        WHEN phone_service LIKE '%yes%' THEN 1
    END) AS phone_count,
    COUNT(CASE
        WHEN internet_service != 'No' THEN 1
    END) AS internet_count,
    COUNT(CASE
        WHEN online_security LIKE '%yes%' THEN 1
    END) AS security_count,
    COUNT(CASE
        WHEN online_backup LIKE '%yes%' THEN 1
    END) AS backup_count,
    COUNT(CASE
        WHEN device_protection LIKE '%yes%' THEN 1
    END) AS protection_count,
    COUNT(CASE
        WHEN tech_support LIKE '%yes%' THEN 1
    END) AS support_count,
    COUNT(CASE
        WHEN streaming_tv LIKE '%yes%' THEN 1
    END) AS tv_count,
    COUNT(CASE
        WHEN streaming_movies LIKE '%yes%' THEN 1
    END) AS movies_count
FROM
    telco
GROUP BY 1
ORDER BY 2 DESC , 3 DESC , 4 DESC , 5 DESC , 6 DESC , 7 DESC , 8 DESC , 9 DESC;

-- Status

-- how is cltv related to satisfaction score?

SELECT 
    AVG(`satisfaction score`) AS avg_satisfaction_score,
    CASE
        WHEN cltv >= 5000 THEN 'high'
        WHEN cltv < 5000 AND cltv >= 3500 THEN 'moderate'
        ELSE 'low'
    END AS customer_retention
FROM
    status
GROUP BY 2
ORDER BY 1 DESC;

-- customer segmentation 

-- Aggregations to calculate the average monthly charges for each segment.

SELECT 
    d.gender,
    d.senior_citizen,
    d.Married,
    d.Dependents,
    AVG(t.monthly_charges) AS avg_monthly_charges
FROM
    demographics d
        JOIN
    telco t ON d.customer_id = t.customer_id
GROUP BY 1 , 2 , 3 , 4
ORDER BY 5 DESC;

-- Geospatial Analysis

-- Average satisfaction score for customers in different geographic regions.

SELECT 
        t.city, p.population,COUNT(*) AS customer_count, avg(s.`Satisfaction Score`) as avg_satisfaction_score
    FROM
        population p
    JOIN telco t ON p.zip_code = t.zip_code
    JOIN status s ON t.customer_id = s.`Customer ID` group by 1,2
ORDER BY 3 DESC , 4 DESC; 

-- Join the Services table with the Status table to analyze service subscription patterns among churned and retained customers.

SELECT 
    `Customer Status`,
    COUNT(CASE
        WHEN phone_service LIKE '%yes%' THEN 1
    END) AS phone_count,
    COUNT(CASE
        WHEN internet_service != 'No' THEN 1
    END) AS internet_count,
    COUNT(CASE
        WHEN online_security LIKE '%yes%' THEN 1
    END) AS security_count,
    COUNT(CASE
        WHEN online_backup LIKE '%yes%' THEN 1
    END) AS backup_count,
    COUNT(CASE
        WHEN device_protection LIKE '%yes%' THEN 1
    END) AS protection_count,
    COUNT(CASE
        WHEN tech_support LIKE '%yes%' THEN 1
    END) AS support_count,
    COUNT(CASE
        WHEN streaming_tv LIKE '%yes%' THEN 1
    END) AS tv_count,
    COUNT(CASE
        WHEN streaming_movies LIKE '%yes%' THEN 1
    END) AS movies_count
FROM
    status s
        LEFT JOIN
    telco t ON s.`Customer ID` = t.customer_id
GROUP BY `Customer Status`
ORDER BY 
    2 DESC, 3 DESC, 4 DESC, 5 DESC, 6 DESC, 7 DESC, 8 DESC, 9 DESC;

-- Customer Tenure Analysis

-- Analyze the average monthly charges and total charges based on different contract types.

SELECT 
    Contract,
    AVG(`Monthly Charge`) AS avg_monthly_charges,
    AVG(`Total Charges`) AS avg_total_charges
FROM
    services
GROUP BY Contract;

-- Churn Prediction

-- Use the churn score from the Status table to identify high-risk customers.
select `churn value`, max(`churn score`), min(`churn score`), max(cltv), min(cltv) from status group by `churn value`;
-- retained customers
select * from status where `churn reason` like '%yes%' and `satisfaction score` >= 3;

-- Paperless Billing Impact

-- Investigate the impact of paperless billing on customer satisfaction and churn rates.
SELECT 
    t.paperless_billing, sum(s.`Satisfaction Score`) as satisfaction_score, sum(s.`Churn Score`) as churn_score
FROM
    telco t
        JOIN
    status s ON t.customer_id = s.`Customer ID`
GROUP BY t.paperless_billing;

-- Multi-dimensional Analysis:

-- Analyze customer behavior based on a combination of factors such as age, location, and service subscriptions.

SELECT 
    city,
    CASE
        WHEN age < 30 THEN 'young adults'
        WHEN age >= 30 AND age < 50 THEN 'adults'
        ELSE 'elder adults'
    END AS age_group,
    COUNT(CASE
        WHEN phone_service LIKE '%yes%' THEN 1
    END) AS phone_count,
    COUNT(CASE
        WHEN internet_service != 'No' THEN 1
    END) AS internet_count,
    COUNT(CASE
        WHEN online_security LIKE '%yes%' THEN 1
    END) AS security_count,
    COUNT(CASE
        WHEN online_backup LIKE '%yes%' THEN 1
    END) AS backup_count,
    COUNT(CASE
        WHEN device_protection LIKE '%yes%' THEN 1
    END) AS protection_count,
    COUNT(CASE
        WHEN tech_support LIKE '%yes%' THEN 1
    END) AS support_count,
    COUNT(CASE
        WHEN streaming_tv LIKE '%yes%' THEN 1
    END) AS tv_count,
    COUNT(CASE
        WHEN streaming_movies LIKE '%yes%' THEN 1
    END) AS movies_count
FROM
    demographics d
        LEFT JOIN
    telco t ON d.customer_id = t.customer_id
GROUP BY city , age_group
ORDER BY 2 DESC , 3 DESC , 4 DESC , 5 DESC , 6 DESC , 7 DESC , 8 DESC , 9 DESC;
    
-- Correlation Analysis

-- Use aggregations and statistical functions to identify correlations between variables such as satisfaction score, monthly charges, and tenure.

SELECT 
    t.contract,
    AVG(s.`Satisfaction Score`) AS satisfaction_score,
    AVG(t.monthly_charges) AS monthly_charges
FROM
    telco t
        JOIN
    status s ON t.customer_id = s.`Customer ID`
GROUP BY t.contract;


