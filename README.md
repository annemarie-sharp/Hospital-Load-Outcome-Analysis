# Hospital Load vs Outcome Efficiency Analysis

A SQL and Power BI analysis examining the relationship between hospital 
admission volume, length of stay, and patient outcomes including 
mortality and readmission.

---

## Project Overview

This project explores whether periods of high hospital demand influence 
treatment efficiency and patient outcomes. Using SQL for data preparation 
and Power BI for reporting, the analysis moves from raw admission records 
to a structured comparison of how hospital load relates to length of stay, 
mortality, and readmission across departments and time.

The dataset covers 500 patient admissions across 9 departments over a 
full calendar year (2023).

---

## Project Questions

- Does hospital admission volume correlate with longer patient stays?
- Are mortality and readmission rates higher during peak admission periods?
- Which departments carry the highest operational and clinical burden?
- How does patient severity interact with outcomes across departments?

---

## Dataset

**Synthetic Healthcare Admissions Dataset**  
Source: [Kaggle, yashdev01](https://www.kaggle.com/datasets/yashdev01/synthetic-healthcare-admissions)  
File used: train.csv  

---

## Tools

- **PostgreSQL / pgAdmin 4:** data loading, exploration, and feature engineering
- **Power BI Desktop:** DAX measures and report building

---

## Analytical Pipeline

**SQL**

After initial data exploration (null checks, date range validation, 
distinct value checks across key columns), three columns were 
engineered directly in the table:

- `admission_month:` date truncated to month for time-based grouping
- `expired_flag:` binary flag (1 = Expired, 0 = all other outcomes) 
  enabling mortality rate calculation as a numeric average
- `readmission_flag:` binary flag (1 = Yes, 0 = No) enabling 
  readmission rate calculation as a numeric average

Two aggregation views were also created:
- `weekly_admission:` admission counts per week
- `monthly_admission:` admission counts per month

**Power BI**

Three DAX measures were built: Total Admissions, Avg LOS, and 
Mortality Rate. The report was structured across four pages.

---

## Report Structure

**Page 1, Hospital Overview**  
KPI snapshot: 500 total admissions, average length of stay of 8.80 days, 
average severity score of 5.23, and a 2% mortality rate. Monthly 
admissions trend, average LOS by department, and total admissions 
by department.

**Page 2, Load vs Outcome Analysis**  
Three dual-axis charts comparing monthly admission volume directly 
against length of stay, mortality rate, and readmission rate across 
the year.

**Page 3, Department Performance**  
Average LOS and average severity score by department. A combo chart 
overlays severity score against mortality rate per department. A 
summary table consolidates all department-level metrics in a single 
view: total admissions, average LOS, mortality rate, and readmission 
rate.

**Page 4, Patient Profile**  
Admission breakdown by age group and gender. Average severity score 
by age group. Mortality rate by insurance type.

---

## Key Findings

Hospital admission volume does not consistently predict worse patient 
outcomes across the year.

- The load versus LOS trend shows some seasonal alignment, with 
  both peaking in January and December, but the relationship does 
  not hold consistently across the full year.

- Readmission rate fluctuated throughout the year without consistently 
  following admission volume, with February recording the highest 
  readmission rate at 31.58% despite not being a peak admission month.

- Mortality was concentrated in the first half of the year, January 
  through June, and recorded zero across the second half, despite 
  admission volumes remaining relatively stable throughout. This 
  suggests patient severity is a stronger driver of mortality than raw admission volume.

- ICU consistently recorded the highest values across every outcome 
  metric: average LOS of 12.32 days, mortality rate of 8%, and 
  readmission rate of 45%. Geriatrics followed as the second 
  highest-burden department.

- Severity score and mortality rate do not move together uniformly 
  across departments. ICU and Geriatrics show both high severity 
  and high mortality. Departments below Pulmonology in severity 
  rank show near-zero mortality, suggesting that high severity 
  outside of the most critical departments does not translate to 
  worse outcomes in this dataset.

- Patients aged 61+ recorded the highest admission volume and the 
  highest average severity score. Patients aged 25 to 40 recorded 
  the lowest average severity, a non-linear pattern that would 
  warrant further investigation in a real-world dataset.

- All recorded deaths occurred among Medicare patients. Given that 
  Medicare primarily covers patients aged 65 and older, this reflects 
  the intersection of age and severity rather than insurance type 
  as an independent risk factor.

---

## Limitations

- The dataset is synthetic and not derived from real hospital records. 
  Findings should not be interpreted as clinical conclusions.

- The analysis does not account for patient-level clinical history, 
  comorbidities beyond what is recorded, or treatment protocols, 
  factors that would be essential in a real-world outcome study.

---

## Files
| File | Description |
|------|-------------|
| `hospital_load_analysis.sql` | Full SQL script: exploration, feature engineering, and views |
| `Hospital_Load_Outcome_Analysis.pbix` | Power BI report file |
| `page1-hospital-overview.png` | Report screenshot, Page 1 |
| `page2-load-vs-outcome.png` | Report screenshot, Page 2 |
| `page3-department-performance.png` | Report screenshot, Page 3 |
| `page4-patient-profile.png` | Report screenshot, Page 4 |

---

## Conclusion
Hospital admission volume alone does not determine patient outcomes. 
What this analysis reveals is that department type and patient severity 
carry more weight than how busy a hospital is on any given month. The 
patterns here are drawn from synthetic data, but the analytical questions 
they raise are real ones: which departments are under the most strain, 
which patient profiles carry the most risk, and whether the numbers being 
recorded are actually telling the full story. Those are the same questions 
worth asking of any hospital dataset.

---



*Anne-Marie Sharp | July 2026*
