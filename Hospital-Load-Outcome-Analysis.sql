-- ============================================
-- Project:  Hospital Load vs Outcome Efficiency Analysis (examining the relationship between hospital admission volume, length of stay, and patient outcomes including mortality and readmission)
-- Analyst: Anne-Marie Sharp
-- Date: July 2026
-- ============================================

-- SECTION 1: Data Exploration
--View first 10 rows of data
SELECT * FROM hospital_admissions LIMIT 10;

--View total number of imported rows
SELECT COUNT(*) FROM hospital_admissions;

--Check date ranges:
SELECT MIN(admission_date), MAX(admission_date) FROM hospital_admissions;

--Check for any NULL values in key columns:
SELECT 
    COUNT(*) FILTER (WHERE admission_date IS NULL) AS null_admission,
    COUNT(*) FILTER (WHERE discharge_date IS NULL) AS null_discharge,
    COUNT(*) FILTER (WHERE department IS NULL) AS null_department,
    COUNT(*) FILTER (WHERE severity_score IS NULL) AS null_severity
FROM hospital_admissions;

--Check distinct values in categorical columns
SELECT DISTINCT department FROM hospital_admissions;
SELECT DISTINCT discharge_status FROM hospital_admissions;
SELECT DISTINCT readmission_within_30_days FROM hospital_admissions;


-- SECTION 2: Admission Trend Views
--Get weekly admission counts
CREATE VIEW weekly_admission AS
SELECT DATE_TRUNC('week', admission_date) as week, 
COUNT(admission_date) AS total_admissions 
FROM hospital_admissions 
GROUP BY DATE_TRUNC('week', admission_date);

--Add a new column for the month
ALTER TABLE hospital_admissions ADD COLUMN admission_month DATE;
UPDATE hospital_admissions
SET admission_month = DATE_TRUNC('month', admission_date);
SELECT * FROM hospital_admissions LIMIT 10;

--Get monthly admission counts
CREATE VIEW monthly_admission AS
SELECT admission_month, 
COUNT(admission_date) AS total_admissions 
FROM hospital_admissions 
GROUP BY admission_month;


-- SECTION 3: Outcome Flag Engineering

--Add a new column for flagged deaths
ALTER TABLE hospital_admissions ADD COLUMN expired_flag INT;
UPDATE hospital_admissions
SET expired_flag = 
	CASE WHEN discharge_status = 'Expired' THEN 1
	ELSE 0
	END;
SELECT * FROM hospital_admissions LIMIT 10;

--Add a new column for readmission_flag
ALTER TABLE hospital_admissions ADD COLUMN readmission_flag INT;
UPDATE hospital_admissions
SET readmission_flag = 
	CASE WHEN readmission_within_30_days = 'Yes' THEN 1
	ELSE 0
	END;
SELECT * FROM hospital_admissions LIMIT 10;