
--list peserta survey soft skill dan hard skill
select Nama_CSR,[Job Function], [Unit Name], Nama_kuadran from FoP
where Mitra = 'Infomedia' AND Periode= 'Maret 2024' AND Area = 'Area 2' AND Nama_kuadran = 'HAHACO'
Order by Nama_CSR

select * from FoP
where Nama_CSR like '%Achmad Dendi%'

select Nama_CSR, [Regional Name], [Unit Name] from FoP
where Periode = 'April 2024'
AND Nama_kuadran IN ('HALOCO', 'LOLOCO') AND Area = 'Area 2' AND Mitra = 'Infomedia'
ORDER BY Nama_CSR

select Nama_CSR, [Regional Name], [Unit Name] from FoP
where Periode = 'Maret 2024'
AND Nama_kuadran IN ('HALOCO', 'LOLOCO') AND Area = 'Area 2' AND Mitra = 'Infomedia'
ORDER BY Nama_CSR

--list peserta survey wellbeing
select Nama_CSR, [Job Function], [Unit Name], Nama_kuadran from FoP
where Mitra = 'Infomedia' AND Periode= 'Maret 2024' AND Area = 'Area 2' AND (Nama_kuadran = 'HALOCO' OR Nama_kuadran = 'LOLOCO')
Order by Nama_CSR

select [Unit Name] from FoP
where Mitra = 'Infomedia' AND Periode= 'Maret 2024' AND Area = 'Area 2' AND (Nama_kuadran = 'HALOCO' OR Nama_kuadran = 'LOLOCO')
group by [Unit Name]

select [unit name] From FoP
where Mitra = 'Infomedia' AND Periode= 'Maret 2024' AND Area = 'Area 2'
Group by [Unit Name]

select * from employee 
where  nama Like '%Wulan%'AND GraPARI Like '%Cianjur%'

select * from FoP
where Area = 'Area 2' AND [Unit Name] Like '%Miko%' AND Periode = 'Maret 2024'

select * from FoP
where Nama_CSR Like '%Yuliana%' AND Mitra = 'Infomedia' AND Periode= 'Maret 2024'

select * from Employee where area = 2
LEFT JOIN Employee
ON Fop.[NIK SIAD] = Employee.NIK_SIAD
where Nama_CSR is not null --AND FoP.Mitra = 'Infomedia'
Order by employee.Nama DESC

Delete from FoP
Where [NIK SIAD] is null

UPDATE FoP
SET [Week 4] = 100,
[Kuadran CREDO] = 'Kuadran 2',
Nama_kuadran = 'HAHACO',
AVERAGE = 95
where [NIK SIAD] = 17011024 

update FoP
SET Area = 'Area 2'
Where [Unit Name] = 'GraPARI Wisma Alia Jakarta'

--Update nama CSR
UPDATE FoP
SET FoP.Nama_CSR = employee.Nama
from FoP
JOIN Employee
ON FoP.[NIK SIAD] = employee.NIK_SIAD

--Update Mitra
UPDATE FoP
SET FoP.Mitra = employee.Mitra
from FoP
JOIN Employee
ON FoP.Nama_CSR = employee.Nama AND FoP.[NIK SIAD] = employee.NIK_SIAD

--update nama GraPARI
UPDATE FoP
Set FoP.[Unit Name] = Employee.GraPARI
From FoP
JOIN Employee
ON FoP.[NIK SIAD] = employee.NIK_SIAD AND FoP.[Nama_CSR] = Employee.Nama
WHERE FoP.Periode IN ('Maret 2024', 'April 2024')

select * from FoP where Nama_CSR like '%Fransiska%'


--update job function
UPDATE FoP
Set FoP.[Job Function] = Employee.[Job Title]
From FoP
JOIN Employee
ON FoP.[NIK SIAD] = employee.NIK_SIAD AND FoP.[Nama_CSR] = Employee.Nama

--Update nama Regional
UPDATE FoP
Set FoP.[Regional Name] = Employee.Regional
From FoP
JOIN Employee
ON FoP.[NIK SIAD] = employee.NIK_SIAD AND FoP.[Nama_CSR] = Employee.Nama

--Update Jenis CTP
UPDATE FoP
Set FoP.Jenis_CTP = Employee.Jenis_CTP
From FoP
JOIN Employee
ON FoP.[NIK SIAD] = employee.NIK_SIAD AND FoP.[Nama_CSR] = Employee.Nama

select count(*) from FoP
where area = 'Area 3' And Periode = 'Maret 2024'

select * from FoP
where area = 'Area 3' and Nama_CSR like '%Naina%'
order by Nama_CSR

delete  from FoP
where area = 'Area 3'
--Update Periode
UPDATE FoP
SET Periode = 'Februari 2024'
where Area = 'Area 1'

DELETE FROM FoP
Where Nama_CSR is null	

select * from FoP
--where Nama_CSR is not null
where [Unit Name] = 'GraPARI Dago'


--ADD Nama_CSR
ALTER TABLE FoP
ADD Nama_CSR NVARCHAR(255);

--add nama Kuadran
ALTER TABLE FoP
ADD Nama_kuadran NVARCHAR(255);

--Update nama kuadran
UPDATE FoP
SET Nama_Kuadran = 
CASE
WHEN [kuadran CREDO] = 'Kuadran 1' THEN 'HALOCO'
WHEN [kuadran CREDO] = 'Kuadran 2' THEN 'HAHACO'
WHEN [kuadran CREDO] = 'Kuadran 3' THEN 'LOHACO'
WHEN [kuadran CREDO] = 'Kuadran 4' THEN 'LOLOCO'
ELSE 'Not In Any Quadrant'
END

--Update kuadran
UPDATE FoP
SET [kuadran CREDO] = 
CASE
WHEN Nama_Kuadran ='HALOCO' THEN 'Kuadran 1' 
WHEN Nama_Kuadran ='HAHACO' THEN 'Kuadran 2'
WHEN Nama_Kuadran ='LOHACO' THEN 'Kuadran 3'
WHEN Nama_Kuadran ='LOLOCO' THEN 'Kuadran 4'
ELSE 'Not In Any Quadrant'
END
FROM FoP
WHERE Periode = 'April 2024'
--Tarik data kuadran
Select Nama_CSR, [Job Function], [Unit Name], [Regional Name], Area, AVERAGE as Avg_TO, CREDO as Avg_credo, Nama_kuadran, Mitra, Periode
From FoP
WHERE Area = 'Area 2' AND Mitra = 'infomedia' AND Periode = 'April 2024' AND CREDO = 0
ORDER by [Unit Name]
--Check change in kuadran
SELECT 
    nama_csr,
	[unit name],
	Area,
	[Regional Name],
    Kuadran_March,
    Kuadran_April
FROM (
    SELECT 
        outer_table.nama_csr,
		outer_table.[unit name],
		outer_table.Area,
		outer_table.[Regional Name],
        outer_table.nama_kuadran AS Kuadran_March,
        (SELECT MAX(nama_kuadran) 
         FROM FoP 
         WHERE periode = 'April 2024' 
         AND FoP.nama_csr = outer_table.nama_csr AND Mitra = 'Infomedia') AS Kuadran_April
    FROM 
        FoP AS outer_table
    WHERE 
        periode = 'Maret 2024'
) AS subquery
WHERE 
    Kuadran_March <> Kuadran_April;

--Pergeseran kuadran Februari-Maret
SELECT 
    nama_csr,
	[unit name],
	Area,
    Kuadran_February,
    Kuadran_March
FROM (
    SELECT 
        outer_table.nama_csr,
		outer_table.[unit name],
		outer_table.Area,
        outer_table.nama_kuadran AS Kuadran_February,
        (SELECT MAX(nama_kuadran) -- Using MAX aggregate function to ensure only one value is returned
         FROM FoP 
         WHERE periode = 'Maret 2024' 
         AND FoP.nama_csr = outer_table.nama_csr AND Mitra = 'Infomedia' ) AS Kuadran_March
    FROM 
        FoP AS outer_table
    WHERE 
        periode = 'Februari 2024'
) AS subquery
WHERE 
    Kuadran_February <> Kuadran_March;

--Pergeseran kuadran Januari-Maret
SELECT 
    nama_csr,
	[unit name],
    Kuadran_January,
    Kuadran_March
FROM (
    SELECT 
        outer_table.nama_csr,
		outer_table.[unit name],
        outer_table.nama_kuadran AS Kuadran_January,
        (SELECT MAX(nama_kuadran) -- Using MAX aggregate function to ensure only one value is returned
         FROM FoP 
         WHERE periode = 'Maret 2024' 
         AND FoP.nama_csr = outer_table.nama_csr AND Mitra = 'Infomedia' AND [Regional Name] = 'Jabar') AS Kuadran_March
    FROM 
        FoP AS outer_table
    WHERE 
        periode = 'Januari 2024'
) AS subquery
WHERE 
    Kuadran_January <> Kuadran_March;

--Detail
select [NIK SIAD], NAMA_CSR,[Job Function], [Unit Name], [Regional Name], [AVERAGE] as Average_TO, Credo as Nilai_Credo,[Kuadran Credo], Nama_Kuadran
from FoP
where periode = 'Maret 2024' and Area = 'Area 2' and Mitra = 'infomedia' AND [Unit Name] Like '%Dago%'
ORDER BY [kuadran credo]

update FoP
set  [Job Function] = 'FOS'
where Nama_CSR = 'Ayu Marluthy' AND [NIK SIAD] = '23254675'
--count by Kuadran credo
SELECT
SUM(CASE WHEN [Kuadran Credo] = 'Kuadran 1' THEN 1 ELSE 0 END) as HALOCO,
SUM(CASE WHEN [Kuadran Credo] = 'Kuadran 2' THEN 1 ELSE 0 END) as HAHACO,
SUM(CASE WHEN [Kuadran Credo] = 'Kuadran 3' THEN 1 ELSE 0 END) as LOHACO,
SUM(CASE WHEN [Kuadran Credo] = 'Kuadran 4' THEN 1 ELSE 0 END) as LOLOCO
from FoP
JOIN employee
ON Fop.[NIK SIAD] = Employee.NIK_SIAD
where [Nama_CSR] is not null AND Periode = 'Februari 2024' --AND employee.Mitra = 'INFOMEDIA' AND Employee.[Status] = 'Active'

SELECT
SUM(CASE WHEN [Kuadran Credo] = 'Kuadran 1' THEN 1 ELSE 0 END) as HALOCO,
SUM(CASE WHEN [Kuadran Credo] = 'Kuadran 2' THEN 1 ELSE 0 END) as HAHACO,
SUM(CASE WHEN [Kuadran Credo] = 'Kuadran 3' THEN 1 ELSE 0 END) as LOHACO,
SUM(CASE WHEN [Kuadran Credo] = 'Kuadran 4' THEN 1 ELSE 0 END) as LOLOCO
from FoP

where Periode = 'Januari 2024' AND FoP.Area ='Area - 4' 

--Mapping list per kuadran
select [NIK SIAD], Nama_Csr, Employee.[Job Title], [Regional Name],[Unit Name], [AVERAGE] as Average_Try_Out, CREDO as Nilai_credo,  Nama_kuadran
from  FoP
JOIN Employee
ON FoP.[NIK SIAD] = Employee.NIK_SIAD
where Nama_kuadran = 'LOHACO'
AND [Nama_CSR] is not null AND Periode = 'Februari 2024'   --Employee.Mitra = 'INFOMEDIA' 
Order by [Unit Name]

select [NIK SIAD], Nama_Csr, Employee.[Job Title], [Regional Name],[Unit Name], [AVERAGE] as Average_Try_Out, CREDO as Nilai_credo,  Nama_kuadran
from  FoP
JOIN Employee
ON FoP.[NIK SIAD] = Employee.NIK_SIAD
where Nama_kuadran = 'HAHACO'
AND [Nama_CSR] is not null AND Periode = 'Februari 2024'  --AND Employee.Mitra = 'INFOMEDIA' --AND [Unit Name] = 'GraPARI Dago' 
Order by [Unit Name]

select [NIK SIAD], Nama_Csr, Employee.[Job Title], [Regional Name],[Unit Name], [AVERAGE] as Average_Try_Out, CREDO as Nilai_credo,  Nama_kuadran
from  FoP
JOIN Employee
ON FoP.[NIK SIAD] = Employee.NIK_SIAD
where Nama_kuadran = 'HALOCO'
AND [Nama_CSR] is not null AND Periode = 'Januari 2024'  --AND Employee.Mitra = 'INFOMEDIA' --AND [Unit Name] = 'GraPARI Dago' 
Order by [Unit Name]

select [NIK SIAD], Nama_Csr, Employee.[Job Title], [Regional Name],[Unit Name], [AVERAGE] as Average_Try_Out, CREDO as Nilai_credo,  Nama_kuadran, Periode
from  FoP
JOIN Employee
ON FoP.[NIK SIAD] = Employee.NIK_SIAD
where Nama_kuadran = 'LOLOCO' and [Job Title] = 'Team Leader' 
AND [Nama_CSR] is not null AND Periode = 'Februari 2024' --AND [Unit Name] = 'GraPARI Dago' 
Order by [Unit Name]

--pesebaran by GraPARI
SELECT [Unit Name], [Regional Name],  
    SUM(CASE WHEN Nama_Kuadran = 'HAHACO' THEN 1 ELSE 0 END) AS HAHACO,
    SUM(CASE WHEN Nama_Kuadran = 'HALOCO' THEN 1 ELSE 0 END) AS HALOCO,
    SUM(CASE WHEN Nama_Kuadran = 'LOHACO' THEN 1 ELSE 0 END) AS LOHACO,
    SUM(CASE WHEN Nama_Kuadran = 'LOLOCO' THEN 1 ELSE 0 END) AS LOLOCO
FROM FoP
where Periode = 'Februari 2024'
GROUP BY [Unit Name], [Regional Name]
ORDER BY HAHACO DESC, [Unit Name] DESC;

--Pesebaran by Regional
SELECT [Regional Name], 
    SUM(CASE WHEN Nama_Kuadran = 'HAHACO' THEN 1 ELSE 0 END) AS HAHACO,
    SUM(CASE WHEN Nama_Kuadran = 'HALOCO' THEN 1 ELSE 0 END) AS HALOCO,
    SUM(CASE WHEN Nama_Kuadran = 'LOHACO' THEN 1 ELSE 0 END) AS LOHACO,
    SUM(CASE WHEN Nama_Kuadran = 'LOLOCO' THEN 1 ELSE 0 END) AS LOLOCO
FROM FoP
GROUP BY [Regional Name]
ORDER BY HAHACO DESC;

---------------------------------------TRY OUT SIMPLE ANALYSIS-----------------------------------------------------------------------
UPDATE FoP
SET Jenis_CTP = 'GraPARI'
Where [Unit Name] NOT IN (
	'GraPARI Cibadak',
    'GraPARI Cibinong',
    'GraPARI Cicurug',
    'GraPARI Cikarang',
    'GraPARI Cisarua',
    'GraPARI Parung',
    'GraPARI Pelabuhan Ratu',
	'GraPARI Purwakarta',
	'GraPARI Fatmawati',
    'GraPARI Gunung Sahari',
    'GraPARI Jatinegara',
    'GraPARI Kalibata',
    'GraPARI Palmerah',
    'GraPARI S Parman',
    'GraPARI Rawamangun',
    'GraPARI Yos Sudarso',
	'GraPARI Cilegon Warnasari',
    'GraPARI Ciputat R E Martadinata',
    'GraPARI Pandeglang',
	'GraPARI Banjar',
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
    'GraPARI Ujung Berung'
	)

--AVG TO Februari ex-plasa
select AVG(AVERAGE) as Average_TO_explasa
From FoP
WHERE Periode = 'Februari 2024' AND Jenis_CTP = 'Ex-Plasa'

--AVG TO Februari GraPARI
select AVG(AVERAGE) as Average_TO_grapari
From FoP
WHERE Periode = 'Februari 2024' AND Jenis_CTP = 'GraPARI'

--AVG TO Jenis_ctp
SELECT Jenis_CTP, AVG(Average) as Average_TO
From FoP
where periode = 'Februari 2024'
GROUP BY Jenis_CTP

--Avg TO by regional
Select [Regional Name], AVG(Average) as Average_TO
FROM FoP
where periode = 'Februari 2024'
GROUP BY [Regional Name]

--DATA CLEANING INFOMEDIA ONLY
UPDATE FoP
SET Mitra = 'INFOMEDIA'
WHERE [unit name] IN (
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


--update nama_grapari
UPDATE FoP
SET [Unit Name] = REPLACE([Unit Name], 'Plasa Telkom Subang', 'GraPARI Subang')
WHERE [Unit Name]  = 'Plasa Telkom Subang';

UPDATE FoP
SET [Unit Name]  = REPLACE([Unit Name] , 'Plasa Telkom Yos Sudarso', 'GraPARI Yos Sudarso')
WHERE [Unit Name]  = 'Plasa Telkom Yos Sudarso';

UPDATE FoP
SET [Unit Name]  = REPLACE([Unit Name] , 'Plasa Telkom Pelabuhan Ratu', 'GraPARI Pelabuhan Ratu')
WHERE [Unit Name]  = 'Plasa Telkom Pelabuhan Ratu';

UPDATE FoP
SET [Unit Name] = REPLACE([Unit Name], 'Plasa Telkom Cibinong', 'GraPARI Cibinong')
WHERE [Unit Name] = 'Plasa Telkom Cibinong';


Delete from FoP
where [Unit Name] NOT IN  (
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


select Nama_CSR
FROM FoP
where Periode = 'Maret 2024' AND Mitra = 'Infomedia' AND (Nama_kuadran = 'LOHACO' OR Nama_kuadran = 'LOLOCO') ANd Area = 'Area 2'
Order by Nama_CSR
