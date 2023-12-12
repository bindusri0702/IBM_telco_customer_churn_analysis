# IBM_telco_customer_analysis
Comprehensive analysis of customer churn in the telecommunications industry with SQL. 
The dataset used is sourced from IBM's telco customer records, a fictional telco company that provided home phone and Internet services to 7043 customers in California in Q3.  It indicates which customers have left, stayed, or signed up for their service. Multiple important demographics are included for each customer, as well as a Satisfaction Score, Churn Score, and Customer Lifetime Value (CLTV) index.

SQL scripts consists of detailed analysis along with cleaning and transformations done on telco customer data.

The insights from detailed analysis are published as visualization in Tableau [here](https://public.tableau.com/views/CustomerChurnAnalysisinTelecommunications/ServicesbyRegionandcontract?:language=en-US&:display_count=n&:origin=viz_share_link)

## Key Findings

### Factors Contributing to Customer Churn

Identification of key factors contributing to customer churn in the telco industry.

### Customer Behavior Insights

Insights into customer behavior, usage patterns, and service preferences influencing churn rates.

### Demographics

Understand the distribution of customers based on gender, age, 
senior citizen status, marital status, and the presence of dependents.

Analyze the average number of dependents per customer.

### Concentration of customers w.r.to Population

Examine the relationship between the population of a zip code area and the number of customers in that area.

Which countries, states, and cities have the highest concentration of customers?

### Location and services correlation

Is there any correlation between customer location and the services they subscribe to?

### In demand Services

What are the most popular internet service types among customers?

How does the contract of a customer relate to the services they subscribe to?

### Status

How is cltv related to satisfaction score?

### Customer segmentation 

Aggregations to calculate the average monthly charges for each segment.

### Geospatial Analysis

Average satisfaction score for customers in different geographic regions.

Join the Services table with the Status table to analyze service subscription patterns among churned and retained customers.

### Customer Tenure Analysis

Analyze the average monthly charges and total charges based on different contract types.

### Churn Prediction

Use the churn score from the Status table to identify high-risk customers.

### Paperless Billing Impact

Investigate the impact of paperless billing on customer satisfaction and churn rates.

### Multi-dimensional Analysis:

Analyze customer behavior based on a combination of factors such as age, location, and service subscriptions.

### Correlation Analysis

Use aggregations and statistical functions to identify correlations between variables such as satisfaction score, monthly charges, and tenure.


