
-- TABLE CREATION SCRIPT


-- 1. BRANCHES TABLE
CREATE TABLE `branches` (
    `branch_id` INT NOT NULL,
    `branch_name` VARCHAR(100) NOT NULL,
    `city` VARCHAR(100) NOT NULL,
    `states` VARCHAR(100) NOT NULL,
    `region` VARCHAR(100) NOT NULL,
    `branch_type` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


-- 2. CUSTOMERS TABLE
CREATE TABLE `customers` (
    `customer_id` INT NOT NULL,
    `customer_name` VARCHAR(100) NOT NULL,
    `age` INT NOT NULL,
    `gender` VARCHAR(10) DEFAULT NULL,
    `city` VARCHAR(50) DEFAULT NULL,
    `state` VARCHAR(50) DEFAULT NULL,
    `employment_type` VARCHAR(50) DEFAULT NULL,
    `annual_income` DECIMAL(15,2) DEFAULT NULL,
    `customer_since` DATE DEFAULT NULL,
    PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


-- 3. CREDIT PROFILE TABLE
CREATE TABLE `credit_profile` (
    `credit_profile_id` INT NOT NULL,
    `customer_id` INT DEFAULT NULL,
    `credit_score` INT DEFAULT NULL,
    `credit_band` VARCHAR(20) DEFAULT NULL,
    `credit_history_years` DECIMAL(5,2) DEFAULT NULL,
    `existing_loans` INT DEFAULT NULL,
    `total_outstanding` DECIMAL(15,2) DEFAULT NULL,
    `last_update` DATE DEFAULT NULL,
    PRIMARY KEY (`credit_profile_id`),
    KEY `customer_id` (`customer_id`),
    CONSTRAINT `credit_profile_ibfk_1`
        FOREIGN KEY (`customer_id`)
        REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


-- 4. LOAN APPLICATION TABLE
CREATE TABLE `loan_application` (
    `application_id` INT NOT NULL,
    `customer_id` INT DEFAULT NULL,
    `application_date` DATE DEFAULT NULL,
    `loan_type` VARCHAR(50) DEFAULT NULL,
    `requested_amount` DECIMAL(15,2) DEFAULT NULL,
    `approval_status` VARCHAR(30) DEFAULT NULL,
    `rejection_reason` VARCHAR(300) DEFAULT NULL,
    PRIMARY KEY (`application_id`),
    KEY `customer_id` (`customer_id`),
    CONSTRAINT `loan_application_ibfk_1`
        FOREIGN KEY (`customer_id`)
        REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


-- 5. LOANS TABLE
CREATE TABLE `loans` (
    `loan_id` INT NOT NULL,
    `application_id` INT DEFAULT NULL,
    `customer_id` INT DEFAULT NULL,
    `branch_id` INT DEFAULT NULL,
    `loan_type` VARCHAR(50) DEFAULT NULL,
    `loan_amount` DECIMAL(15,2) DEFAULT NULL,
    `interest_rate` DECIMAL(5,2) DEFAULT NULL,
    `tenure_month` INT DEFAULT NULL,
    `loan_start_date` DATE DEFAULT NULL,
    `loan_end_date` DATE DEFAULT NULL,
    `loan_status` VARCHAR(30) DEFAULT NULL,
    PRIMARY KEY (`loan_id`),
    KEY `application_id` (`application_id`),
    KEY `customer_id` (`customer_id`),
    KEY `branch_id` (`branch_id`),
    CONSTRAINT `loans_ibfk_1`
        FOREIGN KEY (`application_id`)
        REFERENCES `loan_application` (`application_id`),
    CONSTRAINT `loans_ibfk_2`
        FOREIGN KEY (`customer_id`)
        REFERENCES `customers` (`customer_id`),
    CONSTRAINT `loans_ibfk_3`
        FOREIGN KEY (`branch_id`)
        REFERENCES `branches` (`branch_id`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


-- 6. PAYMENTS TABLE
CREATE TABLE `payments` (
    `payment_id` INT NOT NULL,
    `loan_id` INT DEFAULT NULL,
    `payment_date` DATE DEFAULT NULL,
    `due_date` DATE DEFAULT NULL,
    `payment_amount` DECIMAL(15,2) DEFAULT NULL,
    `payment_status` VARCHAR(30) DEFAULT NULL,
    `days_late` INT DEFAULT NULL,
    PRIMARY KEY (`payment_id`),
    KEY `loan_id` (`loan_id`),
    CONSTRAINT `payments_ibfk_1`
        FOREIGN KEY (`loan_id`)
        REFERENCES `loans` (`loan_id`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;
