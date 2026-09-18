9. -- Which loan types generates the highets number of applications and the highest total loan amount

SELECT 
    la.loan_type,
    COUNT(la.application_id) AS total_application,
    SUM(CASE
        WHEN la.approval_status = 'approved' THEN l.loan_amount
        ELSE 0
    END) AS total_loan_amount
FROM
    loan_application la
        LEFT JOIN
    loans l ON la.application_id = l.application_id
GROUP BY la.loan_type
ORDER BY total_application DESC;

10. -- What is the overall approval rate of the bank 

SELECT 
    COUNT(application_id) AS total_application,
    SUM(CASE
        WHEN approval_status = 'approved' THEN 1
        ELSE 0
    END) AS approved_application,
    ROUND(SUM(CASE
                WHEN approval_status = 'approved' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(application_id),
            2) AS overall_approval_rate
FROM
    loan_application;

11. -- Which loan type have the highest and lowest approval rate.
SELECT 
    loan_type,
    COUNT(application_id) AS total_application,
    SUM(CASE
        WHEN approval_status = 'approved' THEN 1
        ELSE 0
    END) AS total_approval,
    ROUND(SUM(CASE
                WHEN approval_status = 'approved' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(application_id),
            2) AS approval_rate
FROM
    loan_application
GROUP BY loan_type
ORDER BY approval_rate;

12. -- How does a customer's credit score influence the likelihood of loan approval

SELECT 
    credit_profile.credit_band,
    COUNT(loan_application.application_id) AS total_application,
    SUM(CASE
        WHEN loan_application.approval_status = 'approved' THEN 1
        ELSE 0
    END) AS approved_application,
    ROUND(SUM(CASE
                WHEN loan_application.approval_status = 'approved' THEN 1
                ELSE 0
            END) * 100 / COUNT(loan_application.application_id),
            2) AS approval_rate
FROM
    credit_profile
        JOIN
    loan_application ON credit_profile.customer_id = loan_application.customer_id
GROUP BY credit_profile.credit_band
ORDER BY approval_rate DESC;

13. -- How much total loan amount has been sanctioned to each customer  
-- and who are the top 10 customers by total loan exposure 

SELECT 
    customers.customer_id,
    customers.customer_name,
    SUM(loans.loan_amount) AS total_sanctioned_amount
FROM
    customers
        JOIN
    loan_application ON customers.customer_id = loan_application.customer_id
        JOIN
    loans ON loan_application.application_id = loans.application_id
WHERE
    loan_application.approval_status = 'approved'
GROUP BY customers.customer_id , customers.customer_name
ORDER BY total_sanctioned_amount DESC;


14. -- Which brnaches have sanctioned the highest total loan amount 
-- And what are the total five top performing branch 

SELECT 
    branches.branch_id,
    branches.branch_name,
    sum(loans.loan_amount) AS total_sanctioned_amount
FROM
    branches
        JOIN
    loans ON branches.branch_id = loans.branch_id
GROUP BY branches.branch_id , branches.branch_name
ORDER BY total_sanctioned_amount DESC
limit 5;

15. -- HOw much has each customer paid toward their loans 
-- and who are the top 10 customer by total payment amount 

SELECT 
    c.customer_id,
    c.customer_name,
    SUM(p.payment_amount) AS total_payment
FROM
    customers c
        JOIN
    loans l ON c.customer_id = l.customer_id
        JOIN
    payments p ON l.loan_id = p.loan_id
GROUP BY c.customer_id , customer_name
ORDER BY total_payment DESC
LIMIT 5;

16. -- Which loans are fully repaid and what is their current repayment status 

SELECT 
    l.loan_id,
    l.customer_id,
    l.loan_amount,
    SUM(p.payment_amount) AS total_paid,
    CASE
        WHEN SUM(p.payment_amount) >= l.loan_amount THEN 'fully paid'
        ELSE 'not fully paid '
    END AS repayment_status,
    l.loan_status AS current_loan_status
FROM
    loans l
        JOIN
    payments p ON l.loan_id = p.loan_id
GROUP BY l.loan_id , l.customer_id , l.loan_amount , l.loan_status
ORDER BY repayment_status DESC;