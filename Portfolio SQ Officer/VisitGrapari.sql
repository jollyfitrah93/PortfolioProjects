SELECT [Nama Grapari], count([Visit Num]) FROM Visit
--where month(Trx_Date_converted) = 3
group by [Nama Grapari]
Having month(trx_date_converted) = 3
order by Trx_Date_converted

select * from Visit
where MONTH(trx_date_converted) = 4

SELECT [Nama Grapari], COUNT([Visit Num]) AS VisitCount
FROM Visit
WHERE MONTH(Trx_Date_converted) = 3
GROUP BY [Nama Grapari]
ORDER BY [Nama Grapari];

select * from Visit
where MONTH(trx_date_converted) = 3

--ALTER TABLE Visit
--ADD issued_time_converted TIME;

UPDATE Visit
SET issued_time_converted = CONVERT(TIME,[Issued Time])

--ALTER TABLE Visit
--ADD call_time_converted TIME;

UPDATE Visit
SET call_time_converted = CONVERT(TIME,[Call Time])

--ALTER TABLE Visit
--ADD start_serve_time_converted TIME;
UPDATE Visit
SET Trx_Date_converted = CONVERT(DATE, [Trx Date])

UPDATE Visit
SET waiting_duration_converted = CONVERT(time, [Waiting Duration])


UPDATE Visit
SET serving_duration_converted = CONVERT(time, [Serving Duration])

UPDATE Visit
SET start_serve_time_converted = CONVERT(TIME,[Start Serve Time])
where MONTH(Trx_Date_converted) = 4

--ALTER TABLE Visit
--ADD End_serve_time_converted TIME;

UPDATE Visit
SET End_serve_time_converted = CONVERT(TIME,[End Serve Time])
where MONTH(Trx_Date_converted) = 4

select count(*) from visit where month(trx_date_converted) = 4
order by trx_date_converted

Select * from Visit
where MONTH(Trx_Date_converted) = 4
--ALTER TABLE Visit
--ADD waiting_duration_converted TIME;

UPDATE Visit
SET waiting_duration_converted = CONVERT(TIME,[Waiting Duration])
where MONTH(Trx_Date_converted) = 4

--ALTER TABLE Visit
--ADD	serving_duration_converted TIME;

UPDATE Visit
SET serving_duration_converted = CONVERT(TIME,[Serving Duration])
where MONTH(Trx_Date_converted) = 4

--ALTER TABLE PersonalProject.dbo.Visit
--ADD Trx_Date_converted DATE






--select 
--  cast(cast(avg(cast(CAST([Serving Duration] as datetime) as float)) as datetime) as time) AvgTime,
--  cast(cast(sum(cast(CAST([Serving Duration] as datetime) as float)) as datetime) as time) TotalTime
--from Visit;


--select 
--  cast(cast(avg(cast(CAST([Waiting Duration] as datetime) as float)) as datetime) as time) AvgTime,
--  cast(cast(sum(cast(CAST([Waiting Duration] as datetime) as float)) as datetime) as time) TotalTime
--from Visit;

SELECT count(Nama_CSR)
FROM Visit	
where [Nama Grapari]= 'GraPARI BSD'

SELECT Trx_Date_converted, DATEPART(MONTH, Trx_Date_converted) as MonthNumber
FROM Visit

select [user ID]from visit
where [Nama Grapari] = 'GraPARI BSD' and Nama_CSR is null
group by [user ID]


select* from sdm

--update Visit
--Set Visit.Nama_CSR = sdm.NAMA
--from Visit
--JOIN sdm ON Visit.[User ID] = sdm.[NIK CSDM]

select count(MSISDN) from Visit
where  

--cek NIK
select distinct v.[User ID], c.EMPLOYEE_CODE, c.EMPLOYEE_NAME FROM visit as v
JOIN GrapariData.dbo.ccis as c
ON v.[User ID] = c.EMPLOYEE_CODE


--update nama CSR lookup employee
UPDATE Visit
SET visit.[Nama_CSR] = Employee.Nama
from Visit
JOIN GrapariData..Employee as Employee
ON visit.[User ID] = Employee.NIK_SIAD


--update nama CSR lookup ccis
UPDATE Visit
SET visit.[Nama_CSR] = ccis.employee_name
from Visit
JOIN GrapariData..ccis as ccis
ON visit.[User ID] = ccis.EMPLOYEE_CODE
where MONTH(ccis.UPDATE_STAMP) = 4

select [Nama Grapari], [User ID] from Visit
where Nama_CSR is null AND [User ID] is not null
group by [Nama Grapari], [User ID]

UPDATE Visit
SET visit.[Nama_CSR] = ccis.employee_name
from Visit
JOIN GrapariData..ccis as ccis
ON visit.[User ID] = ccis.EMPLOYEE_CODE

select [Nama Grapari], nama_csr, MAX(waiting_duration_converted) as max_wait, max(serving_duration_converted) as max_serve from Visit
group by [Nama Grapari], Nama_CSR
order by max_serve DESC 

select [nama grapari], [trx date]
from Visit
where waiting_duration_converted = (select MAX(waiting_duration_converted))

select * from Visit
where [User ID] = '23250207'

select [Trx Date], Regional, [Nama Grapari], MSISDN, [User ID], Nama_CSR, waiting_duration_converted
from Visit
where waiting_duration_converted > '02:00:00'
order by waiting_duration_converted desc

select [Trx Date], Regional, [Nama Grapari], MSISDN, [User ID], Nama_CSR, serving_duration_converted
from Visit
where serving_duration_converted > '03:00:00'
order by serving_duration_converted desc

select c.unit_name, count(distinct c.msisdn) as msisdn_ccis, count(distinct v.msisdn) as msisdn_visit,
(count(distinct c.msisdn)  - count(distinct v.msisdn)) as selisih_trx
from visit as v
RIGHT JOIN GrapariData.dbo.ccis as c
ON c.MSISDN = v.MSISDN 
where unit_name is not null
GROUP BY c.UNIT_NAME
ORDER by msisdn_ccis

--priorty waiting time
SELECT [Nama Grapari], msisdn, [Visit Num], [user ID], nama_CSR, waiting_duration_converted
       --CAST(CAST(AVG(CAST(CAST([Waiting Duration] AS datetime) AS float)) AS datetime) AS time) AS AvgWaitingTime_Priority
FROM Visit
WHERE [Visit Num] LIKE 'P%'
Order by waiting_duration_converted desc

--ccis vs visit
SELECT 
    c.UNIT_NAME,
    COUNT(DISTINCT c.msisdn) AS unique_ccis,
    COUNT(DISTINCT t.msisdn) AS unique_visit,
    CONCAT(
        CONVERT(DECIMAL(10, 2), 
            CASE 
                WHEN COUNT(DISTINCT t.msisdn) = 0 THEN 0
                ELSE (COUNT(DISTINCT t.msisdn) * 1.0 / NULLIF(COUNT(DISTINCT c.msisdn), 0)) * 100
            END
        ),
        '%'
    ) AS persentase_respon
FROM 
    GrapariData..ccis AS c
LEFT JOIN 
    PersonalProject..visit as t ON c.UNIT_NAME = t.[Nama Grapari] --AND c.MSISDN = t.msisdn
WHERE 
     MONTH(t.Trx_Date_converted) = 2 AND MONTH (c.UPDATE_STAMP) = 2
GROUP BY 
    c.UNIT_NAME
ORDER BY 
    persentase_respon DESC;

Select * from Visit
where MONTH(trx_date_converted) = 3 AND Nama_CSR is null
order by Trx_Date_converted desc

select * from GrapariData..Employee
where NIK_SIAD = 22242103 

select * from GrapariData..employee 
where [Job Title] = 'Team Leader'
AND area = 2

--cek serving pelanggan priority
select Nama_csr, e.[Job Title], [nama grapari],Count(Msisdn) as total_served
from Visit
JOIN GrapariData..employee as E
ON E.NIK_SIAD = visit.[User ID]
where (e.[Job Title] = 'Team Leader' OR e.[Job Title] = 'FOS' ) AND MONTH(visit.trx_date_converted) = 2 AND visit.[Nama Grapari] LIKE '%Bekasi Cyber%'  AND Visit.[Visit Num] like '%P%'
group by Nama_CSR, e.[Job Title], visit.[Nama Grapari]
order by total_served

select * from visit

--DATA CLEANING INFOMEDIA ONLY
SELECT distinct [Nama Grapari] --count(distinct unit_name)
FROM PersonalProject.dbo.Visit
WHERE [Nama Grapari] IN (
    'GraPARI Mall Kota Kasablanka Jakarta',
    'GraPARI Central Park Jakarta',
    'GraPARI Mall Kelapa Gading Jakarta',
    'GraPARI Mall Sarinah',
    'GraPARI Pondok Indah',
    'GraPARI Graha Merah Putih',
    'GraPARI Wisma Alia Jakarta',
    'GraPARI Fatmawati',
    'GraPARI Gunung Sahari',
    'GraPARI Jatinegara',
    'GraPARI Kalibata',
    'GraPARI Palmerah',
    'GraPARI S Parman',
    'GraPARI Rawamangun',
    'GraPARI Yos Sudarso',
    'GraPARI Bassura City Mall Jakarta',
    'GraPARI Emporium Pluit Jakarta',
    'GraPARI Mall Technomart Karawang',
    'GraPARI Bekasi Cyber Park',
    'GraPARI Mall Grand Cibubur',
    'GraPARI Sukabumi',
    'GraPARI Cibadak',
    'GraPARI Cibinong',
    'GraPARI Cicurug',
    'GraPARI Cikarang',
    'GraPARI Cisarua',
    'GraPARI Parung',
    'GraPARI Pelabuhan Ratu',
    'GraPARI Lite Mega City Bekasi',
    'GraPARI Bogor',
    'GraPARI ITC Depok',
    'GraPARI The Park Sawangan',
    'GraPARI GraPARI Cianjur Ir H Juanda',
    'GraPARI Dago',
    'GraPARI Tasikmalaya',
    'GraPARI Lembong',
    'GraPARI Banjar',
    'GraPARI Cianjur',
	'GraPARI Cianjur Ir H Juanda',
    'GraPARI Cimahi',
    'GraPARI Cirebon',
    'GraPARI Gegerkalong',
    'GraPARI Padalarang',
    'GraPARI Rajawali',
    'GraPARI Rancaekek',
    'GraPARI Sindanglaya',
    'GraPARI Subang',
    'GraPARI Supratman',
    'GraPARI Ujung Berung',
    'GraPARI Bandung Elektronik Center',
    'GraPARI Cirebon Super Blok',
    'GraPARI Metro Trade Center Bandung',
    'GraPARI Trans Studio Mall Bandung',
    'GraPARI Cilegon',
    'GraPARI Serang',
    'GraPARI BSD',
    'GraPARI Terminal 3 Bandara Soetta',
    'GraPARI Cilegon Warnasari',
    'GraPARI Ciputat R E Martadinata',
    'GraPARI Pandeglang',
    'GraPARI Supermall Karawaci',
    'GraPARI Cikupa',
    'GraPARI Bintaro Jaya Xchange',
	'GraPARI Purwakarta'
)
order by [Nama Grapari];

--update nama_grapari
UPDATE Visit
SET [Nama Grapari] = REPLACE([Nama Grapari], 'Plasa Telkom Subang', 'GraPARI Subang')
WHERE [Nama Grapari]  = 'Plasa Telkom Subang';

UPDATE Visit
SET [Nama Grapari]  = REPLACE([Nama Grapari] , 'Plasa Telkom Yos Sudarso', 'GraPARI Yos Sudarso')
WHERE [Nama Grapari]  = 'Plasa Telkom Yos Sudarso';

UPDATE Visit
SET [Nama Grapari]  = REPLACE([Nama Grapari] , 'Plasa Telkom Pelabuhan Ratu', 'GraPARI Pelabuhan Ratu')
WHERE [Nama Grapari]  = 'Plasa Telkom Pelabuhan Ratu';

UPDATE Visit
SET [Nama Grapari] = REPLACE([Nama Grapari], 'Plasa Telkom Cibinong', 'GraPARI Cibinong')
WHERE [Nama Grapari] = 'Plasa Telkom Cibinong';

SELECT *
FROM tnps
WHERE unit_name LIKE '%yos%';

Delete from Visit
where [Nama Grapari] NOT IN  (
    'GraPARI Mall Kota Kasablanka Jakarta',
    'GraPARI Central Park Jakarta',
    'GraPARI Mall Kelapa Gading Jakarta',
    'GraPARI Mall Sarinah',
    'GraPARI Pondok Indah',
    'GraPARI Graha Merah Putih',
    'GraPARI Wisma Alia Jakarta',
    'GraPARI Fatmawati',
    'GraPARI Gunung Sahari',
    'GraPARI Jatinegara',
    'GraPARI Kalibata',
    'GraPARI Palmerah',
    'GraPARI S Parman',
    'GraPARI Rawamangun',
    'GraPARI Yos Sudarso',
    'GraPARI Bassura City Mall Jakarta',
    'GraPARI Emporium Pluit Jakarta',
    'GraPARI Mall Technomart Karawang',
    'GraPARI Bekasi Cyber Park',
    'GraPARI Mall Grand Cibubur',
    'GraPARI Sukabumi',
    'GraPARI Cibadak',
    'GraPARI Cibinong',
    'GraPARI Cicurug',
    'GraPARI Cikarang',
    'GraPARI Cisarua',
    'GraPARI Parung',
    'GraPARI Pelabuhan Ratu',
    'GraPARI Lite Mega City Bekasi',
    'GraPARI Bogor',
    'GraPARI ITC Depok',
    'GraPARI The Park Sawangan',
    'GraPARI GraPARI Cianjur Ir H Juanda',
    'GraPARI Dago',
    'GraPARI Tasikmalaya',
    'GraPARI Lembong',
    'GraPARI Banjar',
    'GraPARI Cianjur',
	'GraPARI Cianjur Ir H Juanda',
    'GraPARI Cimahi',
    'GraPARI Cirebon',
    'GraPARI Gegerkalong',
    'GraPARI Padalarang',
    'GraPARI Rajawali',
    'GraPARI Rancaekek',
    'GraPARI Sindanglaya',
    'GraPARI Subang',
    'GraPARI Supratman',
    'GraPARI Ujung Berung',
    'GraPARI Bandung Elektronik Center',
    'GraPARI Cirebon Super Blok',
    'GraPARI Metro Trade Center Bandung',
    'GraPARI Trans Studio Mall Bandung',
    'GraPARI Cilegon',
    'GraPARI Serang',
    'GraPARI BSD',
    'GraPARI Terminal 3 Bandara Soetta',
    'GraPARI Cilegon Warnasari',
    'GraPARI Ciputat R E Martadinata',
    'GraPARI Pandeglang',
    'GraPARI Supermall Karawaci',
    'GraPARI Cikupa',
    'GraPARI Bintaro Jaya Xchange',
	'GraPARI Purwakarta'
);

update Visit
SET Nama_CSR = 'Indra Ardiansyah'
WHERE [User ID] = 24264192



Select * from Visit
where MONTH(trx_date_converted) = 3 AND Nama_CSR is null
order by Trx_Date_converted desc