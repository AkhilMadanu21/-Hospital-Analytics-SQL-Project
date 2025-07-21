use Hsptl_project;
select * from hpt;


#1.	How many patients were admitted in each department?
select department,count(patient_id) as Patients
from hpt
group by department
order by Patients desc;




#2.	What is the monthly trend of patient admissions over the last year?
select monthname(admission_date) as Month,year(admission_date) as Year,count(patient_id) as PatientsTrend
from hpt
where  admission_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
group by monthname(admission_date),year(admission_date)
order by Year ;




#3.	Which admission type (Emergency, Routine, Referral) is most common per department?
select department,admission_type,count(*) as Most_common
from hpt
group by admission_type,department
order by admission_type,Most_common desc
limit 6 ;




# 4. What is the gender distribution across departments?
select department,gender,count(*) as TotalCount
from hpt
group by department,gender
order by department desc;



#5.	What is the average age of patients in each department?
select department,round(Avg(age),0) as avg_age
from hpt
group by department;





#6.	What is the average length of stay (in days) per department?
with als as
(select department,datediff(discharge_date,admission_date) as length_of_stay
from hpt)
select department,round(avg(length_of_stay),0) as Avg_length_of_stay
from als
group by department;




#7.	How many patients had a hospital stay longer than 10 days?
select count(patient_id) as Patients,datediff(discharge_date,admission_date) as Days
from hpt 
where datediff(discharge_date,admission_date) > 10
group by datediff(discharge_date,admission_date);


#8.	What is the count of patient outcomes (Recovered, Deceased, etc.) per department?
select department,outcome,count(patient_id) as Patients
from hpt
group by department,outcome
order by department,outcome;





#9.	Which departments have the highest mortality rate?
select department,
concat(round(count(case when outcome= 'Deceased' then 1 end) * 100 / count(*),2), ' % ')  as MortalityRate
from hpt
group by department
order by MortalityRate desc;



#10. List patients currently under treatment and their attending doctors.
select name,outcome as Status,attending_doctor
from hpt
where outcome = 'Under Treatment';



#11. What is the total and average bill amount per department?
select department,round(avg(bill_amount),2) as Avg_Bill
from hpt
group by department;



#12. Who are the top 5 highest-billed patients?
select name,max(bill_amount) as Bill_Amt
from hpt
group by name
order by Bill_Amt desc
limit 5;




#13. What is the average bill amount based on admission type?
select admission_type,round(avg(bill_amount),0) as Avg_Bill
from hpt
group by admission_type;



#14. Which diagnosis has generated the highest total billing?
select diagnosis,max(bill_amount) as Bill_Amt
from hpt
group by diagnosis
order by Bill_Amt desc 
limit 1;


#15. Which doctors have treated the most patients and generated the most revenue?
select attending_doctor,count(patient_id) as Patient_count
from hpt
group by attending_doctor
order by Patient_count desc
limit 2;


