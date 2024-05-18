select * from FoC
where periode = 'April'

ALTER TABLE FoC
DROP COLUMN [Kuadran credo]

Delete from FoC
Where [Kuadran DETRACTOR] is null

ALTER TABLE FoC 
ADD [Kuadran credo] NVARCHAR(MAX)

ALTER TABLE FoC
Add nama_kuadran NVARCHAR(255)

update FoC
Set Periode = 'Maret 2024'
where periode is null

--Update kuadran_credo
UPDATE FoC
SET kuadran_credo = FoP.Nama_kuadran
FROM FoC
JOIN FoP
ON FoC.nama_CSR = Fop.Nama_CSR 
WHERE FoC.Periode = 'April'


--Update nama kuadran
UPDATE FoC
SET Nama_Kuadran = 
CASE
WHEN [kuadran Detractor] = 'Kuadran 1' THEN 'HALODO'
WHEN [kuadran Detractor] = 'Kuadran 2' THEN 'HAHADO'
WHEN [kuadran Detractor] = 'Kuadran 3' THEN 'LOHADO'
WHEN [kuadran Detractor] = 'Kuadran 4' THEN 'LOLODO'
ELSE 'Not In Any Quadrant'
END

----Update Kuadran detractor
UPDATE FoC
SET [kuadran Detractor] = 
CASE
WHEN Nama_Kuadran  =  'HALODO' THEN  'Kuadran 1' 
WHEN Nama_Kuadran = 'HAHADO' THEN 'Kuadran 2'
WHEN Nama_Kuadran = 'LOHADO' THEN 'Kuadran 3'  
WHEN Nama_Kuadran = 'LOLODO' THEN 'Kuadran 4'  
ELSE 'Not In Any Quadrant'
END

--Update nama CSR
UPDATE FoC
SET FoC.Nama_CSR = employee.Nama
from FoC
JOIN Employee
ON FoC.[NIK SIAD] = employee.NIK_SIAD

--update nama GraPARI
UPDATE FoC
Set FoC.[Unit Name] = Employee.GraPARI
From FoC
JOIN Employee
ON FoC.[NIK SIAD] = employee.NIK_SIAD AND FoC.[NIK SIAD] = employee.NIK_SIAD

--Update nama Regional
UPDATE FoC
Set FoC.[Regional] = Employee.Regional
From FoC
JOIN Employee
ON FoC.[NIK SIAD] = employee.NIK_SIAD AND FoC.[NIK SIAD] = employee.NIK_SIAD

--Update job function
UPDATE FoC
Set FoC.[Job Function] = Employee.[Job Title]
From FoC
JOIN Employee
ON FoC.[NIK SIAD] = employee.NIK_SIAD AND FoC.[NIK SIAD] = employee.NIK_SIAD


--Mapping Low knowledge FoC dan FoP
select c.nama_CSR, c.[unit name], c. Nama_kuadran, p.Nama_CSR, p.nama_kuadran from foc as c
Join fop as p
ON c.[NIK SIAD] = p.[NIK SIAD]
where (c.nama_kuadran = 'LOLODO' OR c.nama_kuadran = 'LOLODO') AND c.Periode = 'Maret 2024' AND p.Periode = 'Maret 2024'


--Mapping High knowledge FoC dan FoP
select c.Nama_CSR, c.[unit name], c. Nama_kuadran, p.Nama_CSR, p.nama_kuadran from foc as c
Join fop as p
ON c.[NIK SIAD] = p.[NIK SIAD]
where (c.nama_kuadran = 'HALODO' OR c.nama_kuadran = 'HAHADO') AND c.Periode = 'Maret 2024' AND p.Periode = 'Maret 2024'


--Mapping jumlah pesebaran by kuadran
select 
SUM(CASE WHEN nama_kuadran = 'HALODO' THEN 1 ELSE 0 END) as Total_HALODO,
SUM(CASE WHEN nama_kuadran = 'HAHADO' THEN 1 ELSE 0 END) as Total_HAHADO,
SUM(CASE WHEN nama_kuadran = 'LOHADO' THEN 1 ELSE 0 END) as Total_LOHADO,
SUM(CASE WHEN nama_kuadran = 'LOLODO' THEN 1 ELSE 0 END) as Total_LOLODO
FROM FoC

--Mapping list kuadran HALODO
Select Nama_CSR as nama_petugas, [NIK SIAD] as NIK, [job function], [unit name],regional, [count of Detractor] as total_detractor, [Average of knowledge] as rata_rata_Try_Out,nama_kuadran
from FoC
where nama_kuadran = 'HALODO' AND Periode= 'Februari 2024' AND Area = 'Area - 3'
order by [Unit Name]

--Mapping list kuadran LOLODO
Select Nama_CSR as nama_petugas, [NIK SIAD] as NIK, [job function], [unit name],regional, [count of Detractor] as total_detractor, [Average of knowledge] as rata_rata_Try_Out,nama_kuadran
from FoC
where nama_kuadran = 'LOLODO' AND Periode= 'Februari 2024' AND Area = 'Area - 3'
order by [Unit Name]

Select Nama_CSR as nama_petugas, [NIK SIAD] as NIK, [job function], [unit name],regional, [count of Detractor] as total_detractor, [Average of knowledge] as rata_rata_Try_Out,nama_kuadran
from FoC
where (nama_kuadran = 'LOLODO' OR nama_kuadran = 'HALODO') AND Periode= 'Februari 2024' AND Area = 'Area - 2'
order by nama_petugas


select FoC.nama_CSR, FoC.[NIK SIAD], FOC.[Unit Name], Foc.nama_kuadran, FoP.Nama_kuadran from FoC
JOIN FoP
ON FoC.[NIK SIAD] = FoP.[NIK SIAD] AND FoP.Nama_CSR = FoC.nama_CSR
where FoC.Periode = 'maret 2024' AND FoC.nama_CSR LIKE '%Rahma Fit%'
order by [Unit Name], nama_kuadran

Select * from employee
where GraPARI LIKE '%cilegon%'

Select * from FoP
where Nama_CSR like '%Afrizal Fahmi%' AND Periode = 'Maret 2024'

UPDATE Employee
SET [Job Title] = 'TL'
Where Nama = 'Afrizal Fahmi' AND NIK_SIAD = 22247070

UPDATE FoP
SET [Unit Name] = 'GraPARI Graha Merah Putih'
Where Nama_CSR = 'Elya Nastainala Syari' AND [NIK SIAD] = 23254776

select * from tnps