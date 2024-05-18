--Cek Detractor yang belum di callback
select * from tnps
where tnps_type = 'Detractor' AND notes_callback is null AND  MONTH(trx_date) = 3

--Cek Detractor dengan reason people
select UNIT_NAME, q6_ans, NOTES
FROM tnps
WHERE jenis_layanan = 'People' AND tnps_type = 'Detractor' AND  MONTH(trx_date) = 3

--ALTER TABLE tnps
--ADD Nama_CSR nvarchar(255)

--ALTER TABLE tnps
--ADD Nilai_tnps float

--Update kolom nilai_tnps
--UPDATE tnps
--SET Nilai_tnps =
--CASE 
--        WHEN tnps_type = 'PROMOTOR' THEN 1
--        WHEN tnps_type = 'PASSIVER' THEN 0
--        WHEN tnps_type = 'DETRACTOR' THEN -1
--    END

-- nilai tnps per grapari
SELECT unit_name, CONCAT(ROUND(AVG(Nilai_tnps * 100), 2), '%') AS rata_rata_tnps,
	 SUM(CASE WHEN tnps_type = 'PROMOTOR' THEN 1 ELSE 0 END) AS jumlah_promotor,
	 SUM(CASE WHEN tnps_type = 'PASSIVER' THEN 1 ELSE 0 END) AS jumlah_passiver,
	 SUM(CASE WHEN tnps_type = 'DETRACTOR' THEN 1 ELSE 0 END) AS jumlah_detractor
FROM tnps
where MONTH(trx_date) = 3
GROUP By unit_name
ORDER BY jumlah_promotor DESC


--Detractor KIP
SELECT unit_name, msisdn, tnps_type, q6_ans as keterangan, status_callback, jenis_layanan
from tnps 
where tnps_type = 'DETRACTOR' AND jenis_layanan = 'people'

--Detractor Analisa Status_callback
SELECT 
    status_callback, 
    COUNT(*) AS Total,
    CONCAT(
        CAST(ROUND((COUNT(*) * 100.0) / NULLIF(SUM(COUNT(*)) OVER (), 0), 2) AS DECIMAL(10, 2)),
        '%'
    ) AS percentage_status_callback
FROM 
    tnps
WHERE 
    tnps_type = 'DETRACTOR' AND status_callback IS NOT NULL
GROUP BY 
    status_callback
ORDER BY 
    Total DESC;

--1. Detractor Analisa jenis_layanan
SELECT 
    jenis_layanan, 
    COUNT(*) AS Total,
    CONCAT(
        CAST(ROUND((COUNT(*) * 100.0) / NULLIF(SUM(COUNT(*)) OVER (), 0), 2) AS DECIMAL(10, 2)),
        '%'
    ) AS percentage_jenis_layanan
FROM 
    tnps
WHERE 
    tnps_type = 'DETRACTOR' AND jenis_layanan IS NOT NULL AND MONTH(trx_date) = 4 AND unit_type <> 'mygrapari' 
GROUP BY 
    jenis_layanan
ORDER BY 
    Total DESC;

--2. nilai tnps per GraPARI exclude MyG
SELECT  unit_name, CONCAT(ROUND(AVG(Nilai_tnps * 100), 2), '%') AS rata_rata_tnps,
	 SUM(CASE WHEN tnps_type = 'PROMOTOR' THEN 1 ELSE 0 END) AS jumlah_promotor,
	 SUM(CASE WHEN tnps_type = 'PASSIVER' THEN 1 ELSE 0 END) AS jumlah_passiver,
	 SUM(CASE WHEN tnps_type = 'DETRACTOR' THEN 1 ELSE 0 END) AS jumlah_detractor
FROM tnps 
WHERE   MONTH(trx_date) = 4 --AND unit_type <> 'mygrapari'
GROUP By  unit_name
ORDER BY jumlah_promotor desc

--3.Detractor analisa by service
SELECT 
   [service], 
    COUNT(*) AS Total,
    CONCAT(
        CAST(ROUND((COUNT(*) * 100.0) / NULLIF(SUM(COUNT(*)) OVER (), 0), 2) AS DECIMAL(10, 2)),
        '%'
    ) AS percentage_by_service
FROM 
    tnps
WHERE 
	MONTH(trx_date) = 4
    AND unit_type <> 'mygrapari'
GROUP BY 
    [service]
ORDER BY 
    Total DESC;

--4.service breakdown by unit_name
Select unit_name,
SUM(CASE WHEN [service] = 'Permintaan' THEN 1 ELSE 0 END) as total_permintaan,
SUM(CASE WHEN [service] = 'Informasi' THEN 1 ELSE 0 END) as total_informasi,
SUM(CASE WHEN [service] = 'Offering' THEN 1 ELSE 0 END) as total_offering,
SUM(CASE WHEN [service] = 'Komplain' THEN 1 ELSE 0 END) as total_Komplain
FROM tnps
WHERE 
	MONTH(Trx_date) = 4
	--AND unit_type = 'mygrapari'
GROUP BY unit_name
ORDER by total_permintaan DESC

--5.ccis vs dyandra
SELECT 
    c.UNIT_NAME,
    COUNT(DISTINCT c.msisdn) AS unique_ccis,
    COUNT(DISTINCT t.msisdn) AS unique_dyandra,
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
    ccis AS c
LEFT JOIN 
    tnps AS t ON c.UNIT_NAME = t.unit_name --AND c.MSISDN = t.msisdn
WHERE 
    c.TOPIC_REASON_1 <> 'BACKEND QUERY & SYSTEM' AND MONTH(t.trx_date) = 4 AND MONTH (c.UPDATE_STAMP) = 4
GROUP BY 
    c.UNIT_NAME
ORDER BY 
    unique_ccis DESC;

--Update the promoto_reason column with parsed string from q6_ans
update tnps
SET promotor_reason = SUBSTRING(q6_ans, 1,CHARINDEX('~', q6_ans) -1 ) 
WHERE MONTH(trx_date) = 4

--6. top reason promotor
SELECT 
    CASE 
        WHEN promotor_reason IN ('Pelayanan Pelanggan', 'Customer Service') THEN 'Customer Service'
        WHEN promotor_reason IN ('Kualitas Jaringan', 'Network Quality') THEN 'Network Quality'
        WHEN promotor_reason IN ('Program Promo', 'Promo Program') THEN 'Promo Program'
        WHEN promotor_reason IN ('Produk', 'Product') THEN 'Product'
        WHEN promotor_reason IN ('Pembayaran/Isi Ulang', 'Payment/Top Up') THEN 'Payment/Top Up'
        ELSE promotor_reason
    END AS promotor_reason,
    COUNT(*) AS total_reason,
    CONCAT(
        CAST(ROUND((COUNT(*) * 100.0) / NULLIF(SUM(COUNT(*)) OVER (), 0), 2) AS DECIMAL(10, 2)),
        '%'
    ) AS percentage_reason
FROM 
    tnps
WHERE 
	MONTH(trx_date) = 4 
    AND unit_type = 'mygrapari'
GROUP BY 
    CASE 
        WHEN promotor_reason IN ('Pelayanan Pelanggan', 'Customer Service') THEN 'Customer Service'
        WHEN promotor_reason IN ('Kualitas Jaringan', 'Network Quality') THEN 'Network Quality'
        WHEN promotor_reason IN ('Program Promo', 'Promo Program') THEN 'Promo Program'
        WHEN promotor_reason IN ('Produk', 'Product') THEN 'Product'
        WHEN promotor_reason IN ('Pembayaran/Isi Ulang', 'Payment/Top Up') THEN 'Payment/Top Up'
        ELSE promotor_reason
    END
ORDER BY 
    total_reason DESC;


--7.count of promotor reason by ctp
SELECT unit_name,
(SUM(CASE WHEN promotor_reason = 'Pelayanan Pelanggan' THEN 1 ELSE 0 END) + SUM(CASE WHEN Promotor_reason = 'Customer Service' THEN 1 ELSE 0 END)) as Pelayanan_Pelanggan,
(SUM(CASE WHEN promotor_reason = 'Kualitas Jaringan' THEN 1 ELSE 0 END) + SUM(CASE WHEN promotor_reason= 'Network Quality' THEN 1 ELSE 0 END)) as Kualitas_Jaringan,
(SUM(CASE WHEN Promotor_reason = 'Program Promo' THEN 1 ELSE 0 END) + SUM(CASE WHEN Promotor_reason = 'Promo Program' THEN 1 ELSE 0 END)) as Program_promo,
(SUM(CASE WHEN Promotor_reason = 'Produk' THEN 1 ELSE 0 END)+SUM(CASE WHEN Promotor_reason = 'Product' THEN 1 ELSE 0 END))  as Produk,
(SUM(CASE WHEN Promotor_reason = 'Pembayaran/Isi Ulang' THEN 1 ELSE 0 END) + SUM(CASE WHEN promotor_reason = 'Payment/Top Up' THEN 1 ELSE 0 END)) as Pembayaran_isi_ulang
FROM tnps
WHERE unit_type <> 'mygrapari' AND MONTH(trx_date) = 4
GROUP BY unit_name
ORDER by Pelayanan_Pelanggan DESC

--8.total respon tnps

SELECT unit_name,
COUNT(MSISDN) as total_respon,
COUNT(distinct msisdn) as total_unique_respon,
(COUNT(MSISDN) - COUNT(distinct msisdn)) as not_unique_msisdn
FROM tnps
where MONTH(Trx_date) = 4
GROUP BY unit_name
ORDER by total_respon DESC;

select distinct msisdn from tnps
where unit_name like '%GraPARI Mall Kota Kasablanka Jakarta%' AND MONTH(trx_date) = 4
order by msisdn






--split q6 ans to get Promotor reason

SELECT 
    SUBSTRING(q6_ans, 1, CHARINDEX('~', q6_ans) - 1) AS Promotor_reason_1,
    SUBSTRING(q6_ans, CHARINDEX('~', q6_ans) + 1, CHARINDEX('~', q6_ans, CHARINDEX('~',q6_ans) + 1) - CHARINDEX('~', q6_ans) - 1) AS Promotor_reason_2,
    SUBSTRING(q6_ans, CHARINDEX('~', q6_ans, CHARINDEX('~',q6_ans) + 1) + 1, LEN(q6_ans)) AS Promotor_reason_3
FROM 
    tnps
WHERE
    MONTH(trx_date) = 4;



select * from tnps

--Add promotor_reason column
--ALTER Table tnps
--ADD promotor_reason NVARCHAR(255);





--select * from tnps	
--where unit_name = 'GraPARI Supermall Karawaci' AND unit_type = 'mygrapari'

--select * from tnps
--where unit_name = 'GraPARI Supermall Karawaci' AND unit_type <> 'mygrapari'

--SELECT 
--    SUM(CASE WHEN tnps_type = 'PROMOTOR' THEN 1 ELSE 0 END) AS jumlah_promotor,
--    SUM(CASE WHEN tnps_type = 'PASSIVER' THEN 1 ELSE 0 END) AS jumlah_passiver,
--    SUM(CASE WHEN tnps_type = 'DETRACTOR' THEN 1 ELSE 0 END) AS jumlah_detractor
--FROM tnps;

--update kolom Nama_csr filter myg dan backend query
UPDATE tnps
SET tnps.Nama_CSR = ccis.EMPLOYEE_NAME
FROM tnps
JOIN ccis ON tnps.msisdn = ccis.MSISDN
WHERE tnps.unit_type <> 'mygrapari' AND ccis.TOPIC_REASON_1 <> 'BACKEND QUERY & SYSTEM'

--UPDATE tnps
--SET Nama_CSR = NULL
--WHERE unit_type = 'mygrapari';

select * from tnps
where unit_type <> 'mygrapari'

select unit_name from tnps
where unit_name like '%Cianjur%' and MONTH(trx_date) = 4

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
	