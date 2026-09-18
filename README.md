# 🏦 Banking & Loan Analytics — SQL & Power BI Project

> **A business-focused data analytics portfolio project analyzing customers, loans, repayments, credit risk, and branch performance using MySQL SQL and Power BI.**

---

## 📌 Project Overview

This project analyzes a synthetic banking dataset to understand **customer behavior, loan applications, loan performance, repayment activity, credit risk, and branch-level performance**.

The project combines **MySQL SQL analysis** with an interactive **Power BI dashboard** to transform relational banking data into meaningful business insights and key performance metrics.

### 🎯 Key Areas of Analysis

- Customer & demographic analysis
- Credit score & risk analysis
- Loan application & approval analysis
- Loan type performance
- Customer loan exposure
- Payment & repayment analysis
- Outstanding loan analysis
- Branch performance
- Business KPI analysis
- Interactive Power BI dashboard analysis

---

## 🗂️ Dataset

The project contains **6 related tables** with a total of **10,108 records**.

| Table | Records |
|---|---:|
| `branches` | 50 |
| `customers` | 4,695 |
| `credit_profile` | 4,695 |
| `loan_application` | 279 |
| `loans` | 182 |
| `payments` | 217 |
| **Total** | **10,108** |

> The dataset is **synthetic** and contains no real banking or customer information.

---

## 🔗 Database Relationships

```text
customers.customer_id
        │
        ├──────────────→ loan_application.customer_id
        │
        ├──────────────→ loans.customer_id
        │
        └──────────────→ credit_profile.customer_id

loan_application.application_id
        │
        └──────────────→ loans.application_id

branches.branch_id
        │
        └──────────────→ loans.branch_id

loans.loan_id
        │
        └──────────────→ payments.loan_id
```

These relationships connect customers, credit profiles, applications, loans, branches, and payments for comprehensive analysis.

---

## 📊 Business Questions

The project answers **23 business-driven questions**, covering three levels of analysis.

### 🟢 Basic Analysis

Focuses on understanding the overall banking dataset:

- Customer base & demographics
- Customer income analysis
- Branch distribution
- Credit score categories
- Loan application status
- Loan amount analysis
- Payment analysis

### 🟡 Medium Analysis

Focuses on deeper loan and customer performance:

- Loan type application & performance
- Overall loan approval rate
- Loan type approval rates
- Credit score vs loan approval
- Customer loan exposure
- Top-performing branches
- Customer payment analysis
- Fully repaid loans

### 🔴 Advanced Analysis

Focuses on business KPIs, risk, and performance:

- Outstanding loan analysis
- Loan repayment performance
- High-risk customer identification
- Branch ranking
- Customer income vs loan approval outcomes
- Loan type rejection & outstanding analysis
- Consolidated branch-level performance report

> **Detailed business questions and SQL solutions are available in the `02_SQL` folder.**

---

## 🧠 SQL Skills Demonstrated

This project demonstrates practical SQL skills used in real-world data analysis:

- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `HAVING`
- Aggregate Functions
  - `SUM()`
  - `COUNT()`
  - `AVG()`
  - `MIN()`
  - `MAX()`
- `CASE WHEN`
- `INNER JOIN`
- `LEFT JOIN`
- Multi-table `JOIN`s
- Subqueries
- Common Table Expressions (`CTEs`)
- Date Functions
- Conditional Aggregation
- Percentage Calculations
- Top-N Analysis
- Calculated Business Metrics

---

## 📈 Key Business Metrics

The project calculates important banking and loan KPIs, including:

| KPI | Description |
|---|---|
| **Total Customers** | Total number of customers |
| **Total Loan Applications** | Total applications received |
| **Approved Applications** | Applications approved by the bank |
| **Loan Approval Rate** | Percentage of applications approved |
| **Total Loan Amount** | Total loan amount associated with approved loans |
| **Total Paid Amount** | Total payments received |
| **Outstanding Loan Amount** | Remaining loan amount after payments |
| **Repayment Percentage** | Percentage of loan amount repaid |
| **Customer Loan Exposure** | Total loan amount associated with a customer |
| **Branch Performance** | Branch-level loan and repayment performance |

### Key Formulas

**Loan Approval Rate**

```text
Approved Applications / Total Applications × 100
```

**Repayment Percentage**

```text
Total Paid Amount / Total Loan Amount × 100
```

**Outstanding Loan Amount**

```text
Total Loan Amount - Total Paid Amount
```

---

# 📊 Power BI Dashboard

The SQL analysis was further developed into an interactive **Power BI dashboard** to provide a visual view of banking and loan performance.

### Power BI Analysis Includes

- Overall banking KPIs
- Loan application and approval analysis
- Customer analysis
- Loan performance
- Repayment and outstanding loan analysis
- Branch-level performance
- Interactive filters and slicers
- Business-focused visualizations

### Dashboard Pages

The Power BI report contains **4 dashboard pages**:

1. **Overview**
2. **Loan Analysis**
3. **Customer Analysis**
4. **Branch Analysis**

The Power BI report is available in the `03_Power_BI` folder.

---

## 🔄 Project Workflow

```text
Raw CSV Data
     ↓
MySQL Database
     ↓
Table Creation & Relationships
     ↓
Data Import & Validation
     ↓
Exploratory SQL Analysis
     ↓
Business Questions
     ↓
KPI Calculations
     ↓
Business Insights
     ↓
Power BI Data Preparation
     ↓
Data Model & Relationships
     ↓
DAX Measures
     ↓
Interactive Power BI Dashboard
     ↓
Documentation & Screenshots
```

---

## 📁 Project Structure

```text
Banking-Loan-Analytics/
│
├── README.md
│
├── 01_Data/
│   ├── branches.csv
│   ├── customers.csv
│   ├── credit_profile.csv
│   ├── loan_application.csv
│   ├── loans.csv
│   └── payments.csv
│
├── 02_SQL/
│   └── Banking_Loan_Analytics.sql
│
├── 03_Power_BI/
│   └── Banking_Loan_Analytics.pbix
│
├── 04_Screenshots/
│   ├── SQL_Screenshots/
│   └── Power_BI_Screenshots/
│       ├── Page_1_Overview.png
│       ├── Page_2_Loan_Analysis.png
│       ├── Page_3_Customer_Analysis.png
│       └── Page_4_Branch_Analysis.png
│
└── 05_Documentation/
    └── Project documentation
```

---

## 📸 Screenshots

The `04_Screenshots` folder contains visual evidence of both SQL analysis and Power BI dashboard results.

### SQL Screenshots

The `SQL_Screenshots` folder contains screenshots of SQL queries and their corresponding results from MySQL.

### Power BI Screenshots

The `Power_BI_Screenshots` folder contains screenshots of all 4 Power BI dashboard pages.

---

## 🛠️ Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| **MySQL** | Database management & SQL analysis |
| **SQL** | Data querying & business analysis |
| **Power BI** | Interactive dashboards & data visualization |
| **DAX** | Business metrics and Power BI calculations |
| **Power Query** | Data preparation and transformation |
| **CSV** | Source data |
| **GitHub** | Version control & portfolio presentation |

---

## 💡 Project Objective

The main objective of this project is to demonstrate how **SQL and Power BI can be used together to solve real-world business problems using relational data**.

The analysis helps evaluate:

- Customer and credit profiles
- Loan application and approval performance
- Loan type performance
- Customer borrowing behavior
- Payment and repayment performance
- Outstanding loan exposure
- Customer credit risk
- Branch-level performance

---

## ⭐ Project Highlights

- **6 relational tables**
- **10,108 records**
- **23 business-driven questions**
- Customer, credit, loan, payment & branch analysis
- Multi-table SQL analysis
- Business KPI calculations
- Risk and repayment analysis
- Branch performance analysis
- Power BI data modeling and visualization
- DAX-based business metrics
- 4-page interactive Power BI dashboard
- Portfolio-ready project structure

---

## 👨‍💻 About

**Project:** Banking & Loan Analytics  
**Database:** MySQL  
**Dataset:** Synthetic Banking Dataset  
**Project Type:** SQL & Power BI Data Analytics Portfolio Project  
**Primary Skills:** SQL, MySQL, Power BI, DAX, Power Query