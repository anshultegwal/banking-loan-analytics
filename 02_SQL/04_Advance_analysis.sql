


17. -- what is the banks outstanding loan amount after accounting for all payments recieved 
-- outstanding amount = total sanctioned amount - total paid amount 
use banking_loan_analytics;
SELECT 
    (SELECT 
            SUM(loan_amount)
        FROM
            loans) - (SELECT 
            SUM(payment_amount)
        FROM
            payments) AS outstanding_amount;

18. -- What is the repayment percentage of each role , and which loans have the lowest repayment 
-- repayment percentage % = total paid amount / sanctioned amount * 100

SELECT 
    l.loan_id,
    l.loan_amount,
    COALESCE(SUM(p.payment_amount), 0) AS total_paid_amount,
    ROUND(COALESCE(SUM(payment_amount)) / l.loan_amount * 100,
            2) AS repayment_percentage
FROM
    loans l
        JOIN
    payments p ON l.loan_id = p.loan_id
GROUP BY l.loan_id , l.loan_amount
ORDER BY repayment_percentage ASC;

19. -- How do brnaches rank based on their sanctional loan amount and which are the top 5 branches ?
WITH branch_ranking AS (
    SELECT
        b.branch_id,
        b.branch_name,
        SUM(l.loan_amount) AS total_sanctioned_amount,
        RANK() OVER (
            ORDER BY SUM(l.loan_amount) DESC
        ) AS branch_rank
    FROM branches b
    JOIN loans l
        ON b.branch_id = l.branch_id
    GROUP BY
        b.branch_id,
        b.branch_name
)
SELECT *
FROM branch_ranking
WHERE branch_rank <= 5
ORDER BY branch_rank;

20. -- Who are the top 3 customer within each branch based on their sanctioned loan amount 
WITH customer_branch_loans AS (
    SELECT
        l.branch_id,
        l.customer_id,
        c.customer_name,
        SUM(l.loan_amount) AS total_sanctioned_amount
    FROM loans l
    JOIN customers c
        ON l.customer_id = c.customer_id
    GROUP BY
        l.branch_id,
        l.customer_id,
        c.customer_name
),

customer_ranking AS (
    SELECT
        branch_id,
        customer_id,
        customer_name,
        total_sanctioned_amount,
        RANK() OVER (
            PARTITION BY branch_id
            ORDER BY total_sanctioned_amount DESC
        ) AS customer_rank
    FROM customer_branch_loans
)

SELECT
    branch_id,
    customer_id,
    customer_name,
    total_sanctioned_amount,
    customer_rank
FROM customer_ranking
WHERE customer_rank <= 3
ORDER BY
    branch_id,
    customer_rank;

21. -- Does customer income have significant relationship with loan approval rate ?
SELECT 
    CASE
        WHEN c.annual_income < 300000 THEN 'low income'
        WHEN c.annual_income < 600000 THEN 'medium income'
        WHEN c.annual_income < 1000000 THEN 'high income'
        ELSE 'very high income'
    END AS income_band,
    
    COUNT(la.application_id) AS total_application,
    SUM(
      CASE
        WHEN la.approval_status = 'approved' THEN 1
        ELSE 0
    END) AS approved_application,
    ROUND(SUM(CASE
                WHEN la.approval_status = 'approved' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(la.application_id),
            2) AS approval_rate
FROM
    customers c
        JOIN
    loan_application la ON c.customer_id = la.customer_id
GROUP BY income_band
ORDER BY approval_rate DESC;

22. -- Which loan type have the highest rejection rate and the highest outstanding loan amounts?

-- which loan type has the highest rejection rate ?

select 
loan_type, 
count(application_id) as total_application , 
sum(case
when approval_status = 'rejected' then 1 else 0
end ) as rejected_application,
round(sum(case 
when approval_status = 'rajected' then 1 else 0 end) * 100.0/ count(application_id), 2)
as rejection_rate 
from loan_application
group by loan_type
order by rejection_rate desc ; 


-- which loan type has the highest outstanding loan amount ?


SELECT 
    l.loan_type,
    SUM(l.loan_amount) AS total_sanctioned_amount,
    COALESCE(SUM(p.total_paid), 0) AS total_paid_amount,
    SUM(l.loan_amount) - COALESCE(SUM(p.total_paid), 0) AS outstanding_amount
FROM
    loans l
        LEFT JOIN
    (SELECT 
        loan_id, SUM(payment_amount) AS total_paid
    FROM
        payments
    GROUP BY loan_id) p ON l.loan_id = p.loan_id
GROUP BY l.loan_type
ORDER BY outstanding_amount DESC;

23. -- How does each branch perform across key business metrices , including :
-- Total Costomers 
-- Total loan application 
-- Approved application 
-- Loan Approval Rate 
-- Total Sanctional Amount 
-- Total paid amount
-- Outstanding Loan Amount 
-- Create a consolidated branch_level performance report using these metrices.

 WITH branch_customers AS (
    SELECT
        l.branch_id,
        COUNT(DISTINCT l.customer_id) AS total_customers
    FROM loans l
    GROUP BY l.branch_id
),

branch_applications AS (
    SELECT
        l.branch_id,
        COUNT(la.application_id) AS total_loan_applications,

        SUM(
            CASE
                WHEN la.approval_status = 'Approved' THEN 1
                ELSE 0
            END
        ) AS approved_applications,

        ROUND(
            SUM(
                CASE
                    WHEN la.approval_status = 'Approved' THEN 1
                    ELSE 0
                END
            ) * 100.0 / COUNT(la.application_id),
            2
        ) AS loan_approval_rate

    FROM loans l
    JOIN loan_application la
        ON l.application_id = la.application_id
    GROUP BY l.branch_id
),

branch_loans AS (
    SELECT
        branch_id,
        SUM(loan_amount) AS total_sanctioned_amount
    FROM loans
    GROUP BY branch_id
),

branch_payments AS (
    SELECT
        l.branch_id,
        SUM(p.payment_amount) AS total_paid_amount
    FROM loans l
    JOIN payments p
        ON l.loan_id = p.loan_id
    GROUP BY l.branch_id
)

SELECT
    b.branch_id,
    b.branch_name,

    COALESCE(bc.total_customers, 0) AS total_customers,

    COALESCE(ba.total_loan_applications, 0) AS total_loan_applications,

    COALESCE(ba.approved_applications, 0) AS approved_applications,

    COALESCE(ba.loan_approval_rate, 0) AS loan_approval_rate,

    COALESCE(bl.total_sanctioned_amount, 0) AS total_sanctioned_amount,

    COALESCE(bp.total_paid_amount, 0) AS total_paid_amount,

    COALESCE(bl.total_sanctioned_amount, 0)
    - COALESCE(bp.total_paid_amount, 0) AS outstanding_loan_amount

FROM branches b

LEFT JOIN branch_customers bc
    ON b.branch_id = bc.branch_id

LEFT JOIN branch_applications ba
    ON b.branch_id = ba.branch_id

LEFT JOIN branch_loans bl
    ON b.branch_id = bl.branch_id

LEFT JOIN branch_payments bp
    ON b.branch_id = bp.branch_id

ORDER BY total_sanctioned_amount DESC;    
     