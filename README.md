# -Hospital-Analytics-SQL-Project

<img width="275" height="183" alt="image" src="https://github.com/user-attachments/assets/f56e37a8-b193-482f-b9e7-c407a16f4ad9" />

This project provides a comprehensive analysis of patient and hospital operations using SQL queries. It is designed to answer key business questions related to departments, patient demographics, billing, treatment outcomes, and more.

---

## 📁 Dataset
- Table: `hpt`
- Contains patient-level data with columns like: `patient_id`, `name`, `age`, `gender`, `admission_date`, `discharge_date`, `department`, `outcome`, `bill_amount`, etc.

---

## 📌 Key SQL Insights

1. **Patient Volume by Department**
   - Number of patients admitted per department.

2. **Monthly Patient Admission Trend (Last 12 Months)**
   - Identifies seasonal or monthly patterns in admissions.

3. **Common Admission Types by Department**
   - Distribution of Emergency, Routine, and Referral admissions.

4. **Gender Distribution**
   - Breakdown of male and female patients per department.

5. **Average Age by Department**
   - Age trends and department demographics.

6. **Average Length of Stay**
   - Calculated using `DATEDIFF(discharge_date, admission_date)`.

7. **Long Hospital Stays (>10 days)**
   - Number of patients with extended stays.

8. **Outcome Distribution**
   - Counts of Recovered, Deceased, and Under Treatment patients per department.

9. **Department-wise Mortality Rate**
   - Uses CASE + aggregation to compute mortality percentage.

10. **Patients Under Treatment & Their Doctors**
    - Patients currently admitted and their assigned doctors.

11. **Billing Insights**
    - Average and top bill amounts by department and diagnosis.

12. **Revenue Analysis**
    - Which doctors generate the most revenue and treat the most patients.

---

## ❓ SQL Project Questions

### 🔹 Admissions & Patient Overview

## 1.	How many patients were admitted in each department?
```sql
select department,count(patient_id) as Patients
from hpt
group by department
order by Patients desc;
```
# Output:

<img width="126" height="121" alt="image" src="https://github.com/user-attachments/assets/bced074e-948f-4303-8e09-61751b20f958" />





## 2.	What is the monthly trend of patient admissions over the last year?
```sql
select monthname(admission_date) as Month,year(admission_date) as Year,count(patient_id) as PatientsTrend
from hpt
where  admission_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
group by monthname(admission_date),year(admission_date)
order by Year ;
```
# Output:

<img width="199" height="228" alt="image" src="https://github.com/user-attachments/assets/e56317b2-24d2-4b3e-a40e-7c53d713254f" />




## 3.	Which admission type (Emergency, Routine, Referral) is most common per department?
```sql
select department,admission_type,count(*) as Most_common
from hpt
group by admission_type,department
order by admission_type,Most_common desc
limit 6 ;
```
# Output:

<img width="251" height="126" alt="image" src="https://github.com/user-attachments/assets/9a99e624-349b-40ad-a064-841a3549392f" />


## 4. What is the gender distribution across departments?
```sql
select department,gender,count(*) as TotalCount
from hpt
group by department,gender
order by department desc;
```
# Output:


## 5.	What is the average age of patients in each department?
```sql
select department,round(Avg(age),0) as avg_age
from hpt
group by department;
```

# Output:
<img width="127" height="123" alt="image" src="https://github.com/user-attachments/assets/bd6956fc-8486-4002-88c2-a6408a1ad1d5" />


## 6.	What is the average length of stay (in days) per department?
```sql
with als as
(select department,datediff(discharge_date,admission_date) as length_of_stay
from hpt)
select department,round(avg(length_of_stay),0) as Avg_length_of_stay
from als
group by department;
```
# Output:
<img width="181" height="123" alt="image" src="https://github.com/user-attachments/assets/0e120ea6-173c-4c27-9888-cd6ca930fc41" />

## 7.	How many patients had a hospital stay longer than 10 days?
```sql
select count(patient_id) as Patients,datediff(discharge_date,admission_date) as Days
from hpt 
where datediff(discharge_date,admission_date) > 10
group by datediff(discharge_date,admission_date);
```
# Output:
<img width="97" height="109" alt="image" src="https://github.com/user-attachments/assets/ae0e0fce-b1e2-4e5c-afae-62fc54b1c10d" />



## 8.	What is the count of patient outcomes (Recovered, Deceased, etc.) per department?
```sql
select department,outcome,count(patient_id) as Patients
from hpt
group by department,outcome
order by department,outcome;
```
# Output:
<img width="214" height="331" alt="image" src="https://github.com/user-attachments/assets/91656b75-f8be-4f08-9ce6-052d13a2e840" />




## 9.	Which departments have the highest mortality rate?
```sql
select department,
concat(round(count(case when outcome= 'Deceased' then 1 end) * 100 / count(*),2), ' % ')  as MortalityRate
from hpt
group by department
order by MortalityRate desc;
```
# Output:
<img width="184" height="126" alt="image" src="https://github.com/user-attachments/assets/e2559af9-e5db-41d9-8372-af814c095222" />



## 10. List patients currently under treatment and their attending doctors.
```sql
select name,outcome as Status,attending_doctor
from hpt
where outcome = 'Under Treatment';
```
# Output:
<img width="323" height="330" alt="image" src="https://github.com/user-attachments/assets/54ff4f3c-ec10-47ab-ae21-ab7e1dad7a49" />


## 11. What is the total and average bill amount per department?
```sql
select department,round(avg(bill_amount),2) as Avg_Bill
from hpt
group by department;
```
# Output:
<img width="132" height="124" alt="image" src="https://github.com/user-attachments/assets/2b40787a-3e63-40c8-aa02-131ff3fe7810" />


## 12. Who are the top 5 highest-billed patients?
```sql
select name,max(bill_amount) as Bill_Amt
from hpt
group by name
order by Bill_Amt desc
limit 5;
```
# Output:
<img width="166" height="107" alt="image" src="https://github.com/user-attachments/assets/307b477a-1e3f-4adc-91d3-5772141c5e3c" />



## 13. What is the average bill amount based on admission type?
```sql
select admission_type,round(avg(bill_amount),0) as Avg_Bill
from hpt
group by admission_type;
```
# Output:
<img width="150" height="77" alt="image" src="https://github.com/user-attachments/assets/c89e27db-bf82-41af-b534-5d565a914731" />



## 14. Which diagnosis has generated the highest total billing?
```sql
select diagnosis,max(bill_amount) as Bill_Amt
from hpt
group by diagnosis
order by Bill_Amt desc 
limit 1;
```
# Output:
<img width="157" height="50" alt="image" src="https://github.com/user-attachments/assets/19ee604f-c2da-416e-b9a7-70a7f2151ae8" />



## 15. Which doctors have treated the most patients and generated the most revenue?
```sql
select attending_doctor,count(patient_id) as Patient_count
from hpt
group by attending_doctor
order by Patient_count desc
limit 2;
```
# Output:
<img width="177" height="60" alt="image" src="https://github.com/user-attachments/assets/5bf46163-3b1d-4926-a566-4e4202a43171" />



---

## 💻 Tools Used
- SQL (MySQL Syntax)
- Text Editor or DB tool like MySQL Workbench

---

## 📂 Files
- `Hsptl.sql`: Contains all 15 queries.
- *(Optional)* `hsptl_data.csv`: Mock patient data.

---

## 👤 Author
**Akhil Madanu**  
[GitHub Profile](https://github.com/AkhilMadanu21)

---

## 🔗 Live Portfolio
View this and more projects at:  
🌐 [akhil-madanu-analytics-journey.lovable.app](https://akhil-madanu-analytics-journey.lovable.app)

---
