1. --  Cutomer Base Analysis..
 
 SELECT 
    COUNT(*)
FROM
    customers; 

2. -- Distribution of Customers by gender and Employement tyep ..

SELECT 
    gender,
    employment_type,
    COUNT(customer_id) AS total_customers
FROM
    customers
GROUP BY gender , employment_type
ORDER BY total_customers DESC;

3. -- Average annual income of customers, and who are the top 10 customers by annual income..

SELECT 
    customer_id, customer_name, AVG(annual_income) AS avg_salary
FROM
    customers
GROUP BY customer_id
ORDER BY annual_income DESC
LIMIT 10;

4. -- How are the bank's branches distributed accros states 
   -- And which state has the highest numbers of branches 

 SELECT 
    states, COUNT(branch_id) AS total_branches
FROM
    branches
GROUP BY states
ORDER BY total_branches DESC;

5. -- How are customers distributed across different credit score categories.

SELECT 
    credit_band, COUNT(customer_id) AS total_customers
FROM
    credit_profile
GROUP BY credit_band;

6. -- Distribution of loan application across Approved, Rejected, and pending status 

SELECT 
    approval_status, COUNT(application_id) AS total_status
FROM
    loan_application
GROUP BY approval_status;

7. -- What is the Total loan amount sanctioned by the bank 
   -- and what is the average sanctioned loan amount. 
SELECT 
    SUM(loan_amount) AS total_sanctioned_amount,
     AVG(loan_amount) AS average_sanctioned_amount
FROM 
    loans;

8. -- SELECT  What is the total amount recieved through loan payments
   -- and what is the average payment amount

SELECT 
    SUM(payment_amount) AS total_recieved_amount,
    AVG(payment_amount) AS average_payment_amount
FROM
    payments;