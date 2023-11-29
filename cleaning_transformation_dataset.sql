use telecom_churn;

-- cleaning tables 
select * from population;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE population ADD id int;
UPDATE population SET id = CAST(SUBSTRING_INDEX(`ID,Zip Code,Population`, ',', 1) AS SIGNED);

ALTER TABLE population ADD zip_code varchar(5);
UPDATE population SET zip_code = SUBSTRING_INDEX(SUBSTRING_INDEX(`ID,Zip Code,Population`, ',', 2),',',-1) ;

ALTER TABLE population ADD population int;
UPDATE population SET population = cast(replace(replace(SUBSTRING_INDEX(`ID,Zip Code,Population`,',', -2),'"',''),',','') as signed);

alter table population drop column `ID,Zip Code,Population`;

select * from population;

select * from telco;
alter table telco drop telcocol; 

select * from status;
-- finding ranges of churn score for stayed and left customers
select `churn value`,max(`churn score`), min(`churn score`) from status group by `churn value`;
select distinct `churn reason` from status where `churn score` < 65;
select distinct `churn reason` from status where `churn score` <= 80 and `churn score` >= 65 and `churn value` = 1;
-- clean churn label column removing anomalies
select count(*) from status;
delete from status where lower(`churn label`) not in ('yes','no');
select count(*) from status;
select distinct `churn label` from status;
select distinct `churn value` from status;
select distinct `customer status` from status;
select `customer status`,sum(`churn value`) from status group by `customer status`;
select distinct `customer status`, `churn reason` from status where `customer status` = 'Yes' or `customer status` = 'No' and `churn value` = 1;
-- finding relation between satisfaction score and churn score
select `satisfaction score`,min(`churn score`),max(`churn score`) from status group by  `satisfaction score`;
-- low churn score less likely to leave service

select * from demographics;
select senior_citizen,min(age),max(age) from demographics group by senior_citizen;
select gender,under_30,married,count(*) from demographics group by under_30,married,gender;

select * from telco;
select city,count(*),sum(tenure_months) from telco group by 1 order by 2 desc,3 desc;
-- age wise usage of internet service
select internet_service,count(*) as internet_service_count, 
case 
when age<= 25 then "young adults"
when age> 25 and age <= 40 then "middle adults"
when age > 40 then "oldage adults" 
end as age_group
from telco t join demographics d on t.customer_id = d.customer_id
group by 1,3
order by 2,3;
-- age wise usage of payment method
select payment_method,count(*) as payment_method_count, 
case 
when age<= 25 then "young adults"
when age> 25 and age <= 40 then "middle adults"
when age > 40 then "oldage adults" 
end as age_group
from telco t join demographics d on t.customer_id = d.customer_id
group by 1,3
order by 2 desc,3;
-- churned customers because of competitor
select city,count(*) from telco where churn_value = 1 and churn_reason like '%competitor%' group by city order by 2 desc ;
-- What reasons did loyal customers give when they churned
select 
case when cltv >= 5000 then 'high'
when cltv < 5000 and cltv >= 3500 then 'moderate'
else 'low'
end as customer_retention
, churn_reason
, count(*) from telco where churn_value = 1 group by 1,2 order by 1,3 desc;


