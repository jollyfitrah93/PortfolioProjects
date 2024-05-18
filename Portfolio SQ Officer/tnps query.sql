
select * from tnps
where MONTH(trx_date) = 4 AND unit_name LIKE '%Pangkal Pinang%'
where unit_type <> 'mygrapari' AND tnps_type = 'DETRACTOR' AND jenis_layanan = 'people'

ALTER TABLE tnps
ADD Area_x NVARCHAR(255)

UPDATE tnps
SET Area_x = 
CASE
	WHEN Area = 1 THEN 'Area 1'
	WHEN Area = 2 THEN 'Area 2'
	WHEN Area = 3 THEN 'Area 3'
	WHEN Area = 4 THEN 'Area 4'
 END

UPDATE tnps
SET Mitra = Employee.Mitra
FROM tnps
JOIN Employee
ON tnps.unit_name = Employee.GraPARI

select * from tnps
where MONTH(trx_date) = 3 AND Nama_CSR LIKE '%Aghnia%'
order by trx_date

--check occurences
SELECT UNIT_NAME, MSISDN,  COUNT(*) AS Occurrences
FROM ccis
WHERE MONTH(UPDATE_STAMP) = 4 AND UNIT_NAME Like '%Tasikmalaya%'--AND MSISDN = 6281382195580
GROUP BY UNIT_NAME, MSISDN
order by Occurrences DESC;

--Create New column
--ALTER TABLE tnps
--ADD Nama_CSR nvarchar(255)

--Add new column
--ALTER TABLE tnps
--ADD Nilai_tnps float

--Update kolom nilai_tnps
UPDATE tnps
SET Nilai_tnps =
CASE 
        WHEN tnps_type = 'PROMOTOR' THEN 1
        WHEN tnps_type = 'PASSIVER' THEN 0
        WHEN tnps_type = 'DETRACTOR' THEN -1
    END

--Score tnps All GraPARI exclude MyG
SELECT unit_name, CONCAT(ROUND(AVG(Nilai_tnps * 100), 2), '%') AS rata_rata_tnps,
	 SUM(CASE WHEN tnps_type = 'PROMOTOR' THEN 1 ELSE 0 END) AS jumlah_promotor,
	 SUM(CASE WHEN tnps_type = 'PASSIVER' THEN 1 ELSE 0 END) AS jumlah_passiver,
	 SUM(CASE WHEN tnps_type = 'DETRACTOR' THEN 1 ELSE 0 END) AS jumlah_detractor
FROM tnps
WHERE unit_type <> 'mygrapari' AND MONTH(trx_date) = 2
GROUP By unit_name
ORDER BY jumlah_promotor DESC

--Not MyG and Filter by GraPARI
SELECT Nama_CSR, unit_name, CONCAT(ROUND(AVG(Nilai_tnps * 100), 2), '%') AS rata_rata_tnps,
	 SUM(CASE WHEN tnps_type = 'PROMOTOR' THEN 1 ELSE 0 END) AS jumlah_promotor,
	 SUM(CASE WHEN tnps_type = 'PASSIVER' THEN 1 ELSE 0 END) AS jumlah_passiver,
	 SUM(CASE WHEN tnps_type = 'DETRACTOR' THEN 1 ELSE 0 END) AS jumlah_detractor
FROM tnps 
WHERE unit_name = 'GraPARI Supermall Karawaci' AND unit_type <> 'mygrapari'
GROUP By Nama_CSR, unit_name
ORDER BY rata_rata_tnps, jumlah_promotor Desc

--MyG and Filter
select * from tnps
where unit_name = 'GraPARI Supermall Karawaci' AND unit_type = 'mygrapari'

--Not MyG and Filter
select * from tnps
where unit_name = 'GraPARI Supermall Karawaci' AND unit_type <> 'mygrapari'

--Total Promotor, passiver dan Detractor
SELECT 
    SUM(CASE WHEN tnps_type = 'PROMOTOR' THEN 1 ELSE 0 END) AS jumlah_promotor,
    SUM(CASE WHEN tnps_type = 'PASSIVER' THEN 1 ELSE 0 END) AS jumlah_passiver,
    SUM(CASE WHEN tnps_type = 'DETRACTOR' THEN 1 ELSE 0 END) AS jumlah_detractor
FROM tnps;

--update kolom Nama_csr filter myg dan backend query
UPDATE tnps
SET tnps.Nama_CSR = ccis.EMPLOYEE_NAME
FROM tnps
RIGHT JOIN ccis ON tnps.msisdn = ccis.MSISDN
WHERE tnps.unit_type <> 'mygrapari' AND ccis.TOPIC_REASON_1 <> 'BACKEND QUERY & SYSTEM' AND MONTH(ccis.UPDATE_STAMP) = 4 AND MONTH(tnps.trx_date) = 4 
AND ccis.TOPIC_RESULT = tnps.Detail AND DAY(ccis.UPDATE_STAMP) = DAY(tnps.trx_date)

ALTER TABLE tnps
ALTER COLUMN trx_date DATE;
--UPDATE nilai tnps
UPDATE tnps
SET tnps.Nama_CSR = ccis.EMPLOYEE_NAME
FROM tnps
RIGHT JOIN ccis ON tnps.msisdn = ccis.MSISDN
WHERE tnps.unit_type <> 'mygrapari' 
AND ccis.TOPIC_REASON_1 <> 'BACKEND QUERY & SYSTEM' 
AND MONTH(ccis.UPDATE_STAMP) = 4 
AND MONTH(tnps.trx_date) = 4 
AND ccis.TOPIC_RESULT = tnps.Detail 
AND CONVERT(VARCHAR, DATEPART(DAY, ccis.UPDATE_STAMP)) = CONVERT(VARCHAR, DATEPART(DAY, tnps.trx_date));




UPDATE tnps
SET Nama_CSR = NULL
WHERE unit_type = 'mygrapari';



--data cleaning tnps
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
UPDATE tnps
SET unit_name = REPLACE(unit_name, 'Plasa Telkom Subang', 'GraPARI Subang')
WHERE unit_name  = 'Plasa Telkom Subang';

UPDATE tnps
SET unit_name  = REPLACE(unit_name , 'Plasa Telkom Yos Sudarso', 'GraPARI Yos Sudarso')
WHERE unit_name  = 'Plasa Telkom Yos Sudarso';

UPDATE tnps
SET unit_name  = REPLACE(unit_name , 'Plasa Telkom Pelabuhan Ratu', 'GraPARI Pelabuhan Ratu')
WHERE unit_name  = 'Plasa Telkom Pelabuhan Ratu';

UPDATE tnps
SET unit_name = REPLACE(unit_name, 'Plasa Telkom Cibinong', 'GraPARI Cibinong')
WHERE unit_name = 'Plasa Telkom Cibinong';

SELECT *
FROM tnps
WHERE unit_name LIKE '%yos%';

Delete from tnps
where unit_name NOT IN  (
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

--handle duplicate numbers
;WITH NumberedRows AS (
    SELECT No,
           ROW_NUMBER() OVER (ORDER BY No) AS RowNumber
    FROM tnps
)
UPDATE NumberedRows
SET No = RowNumber;




select * From ccis
where UNIT_NAME  LIKE '%Karawang%'