select * from ccis
where unit_name = 'GraPARI Cilegon'
AND MONTH(update_stamp) = 3

SELECT Employee_name, Employee_code, Unit_name, Reg_name, COUNT(DISTINCT MSISDN) as total_berhenti
FROM ccis
Where MONTH(update_stamp) = 3 AND TOPIC_RESULT = 'P71-Permintaan berhenti berlangganan' AND REG_NAME = 'West Jakarta'
Group by Employee_name, Employee_code, UNIT_NAME, Reg_name
order by UNIT_NAME

SELECT Employee_name, employee_code, UNIT_NAME, REG_NAME, count(DISTINCT MSISDN) as total_retensi
FROM ccis
Where MONTH(update_stamp) = 3 AND REG_NAME = 'West Jakarta'
AND TOPIC_RESULT IN 
('P71-batal berhenti ambil produk churn prevention',
'P59-Permintaan Migrasi post to pre',
'P71-Permintaan aktivasi program retention',
'P71-Batal berhenti berlangganan telkomsel Halo')
group by Employee_name, employee_code, UNIT_NAME, REG_NAME
order by UNIT_NAME


--Retensi mobile per CS
WITH Berhenti AS (
    SELECT 
        Employee_name, 
        Employee_code, 
        Unit_name, 
        Reg_name, 
        COUNT(DISTINCT MSISDN) AS total_berhenti
    FROM 
        GraPARIdata..ccis
    WHERE 
        MONTH(update_stamp) = 4
        AND TOPIC_RESULT = 'P71-Permintaan berhenti berlangganan' 
        --AND REG_NAME = 'West Jakarta'
    GROUP BY 
        Employee_name, 
        Employee_code, 
        UNIT_NAME, 
        Reg_name
), Retensi AS (
    SELECT 
        Employee_name, 
        employee_code, 
        UNIT_NAME, 
        REG_NAME, 
        COUNT(DISTINCT MSISDN) AS total_retensi
    FROM 
        GraPARIData..ccis
    WHERE 
        MONTH(update_stamp) = 4
        --AND REG_NAME = 'West Jakarta'
        AND TOPIC_RESULT IN ('P71-batal berhenti ambil produk churn prevention',
                             'P59-Permintaan Migrasi post to pre',
                             'P71-Permintaan aktivasi program retention',
                             'P71-Batal berhenti berlangganan telkomsel Halo')
    GROUP BY 
        Employee_name, 
        employee_code, 
        UNIT_NAME, 
        REG_NAME
)
SELECT 
    b.Employee_name, 
    b.Employee_code, 
    b.Unit_name, 
    b.Reg_name, 
    b.total_berhenti,
    r.total_retensi,
    FORMAT((CAST(r.total_retensi AS FLOAT) / (b.total_berhenti + r.total_retensi)) * 100, '0.00') + '%' AS retention_percentage
FROM 
    Berhenti b
    LEFT JOIN Retensi r ON b.Employee_name = r.Employee_name
                          AND b.Employee_code = r.employee_code
                          AND b.UNIT_NAME = r.UNIT_NAME
                          AND b.Reg_name = r.REG_NAME
ORDER BY 
    b.UNIT_NAME;

--Retensi Mobile graPARI
WITH Berhenti AS (
    SELECT 
        Unit_name, 
        Reg_name, 
        COUNT(DISTINCT MSISDN) AS total_berhenti
    FROM 
        GraPARIdata..ccis
    WHERE 
        MONTH(update_stamp) = 4 
        AND TOPIC_RESULT = 'P71-Permintaan berhenti berlangganan' 
        --AND REG_NAME = 'West Jakarta'
    GROUP BY 
        UNIT_NAME, 
        Reg_name
), Retensi AS (
    SELECT 
        UNIT_NAME, 
        REG_NAME, 
        COUNT(DISTINCT MSISDN) AS total_retensi
    FROM 
        Graparidata..ccis
    WHERE 
        MONTH(update_stamp) = 4 
        --AND REG_NAME = 'West Jakarta'
        AND TOPIC_RESULT IN ('P71-batal berhenti ambil produk churn prevention',
                             'P59-Permintaan Migrasi post to pre',
                             'P71-Permintaan aktivasi program retention',
                             'P71-Batal berhenti berlangganan telkomsel Halo')
    GROUP BY 
        UNIT_NAME, 
        REG_NAME
)
SELECT 
    b.Unit_name, 
    b.Reg_name, 
    b.total_berhenti,
    r.total_retensi,
    FORMAT((CAST(r.total_retensi AS FLOAT) / (b.total_berhenti + r.total_retensi)) * 100, '0.00') + '%' AS retention_percentage
FROM 
    Berhenti b
    LEFT JOIN Retensi r ON
                          b.UNIT_NAME = r.UNIT_NAME
                          AND b.Reg_name = r.REG_NAME
ORDER BY 
    retention_percentage DESC;

--Retention Fixed
WITH Berhenti AS (
    SELECT 
        [Agent Name], 
        Grapari,
		[Region Update],
        COUNT([hasil caring]) AS total_berhenti
    FROM 
        retentionfixed
    WHERE 
        MONTH(date) = 3 
        AND [HASIL CARING] = 'CAPS' 
        AND [Region Update] = 'West'
    GROUP BY 
      [Agent Name], 
        Grapari,
		[Region Update]
), Retensi AS (
    SELECT 
     [Agent Name], 
        Grapari,
		[Region Update], 
        COUNT([HASIL CARING]) AS total_retensi
    FROM 
        RetentionFixed
    WHERE 
        MONTH(date) = 3 
        AND [Region Update] = 'West'
        AND [HASIL CARING] IN ('RETENSI', 'PAKET_EKSISTING')
    GROUP BY 
		[Agent Name], 
		Grapari,
		[Region Update]
)
SELECT 
    b.[Agent Name], 
    b.Grapari, 
    b.[Region Update], 
    b.total_berhenti,
    r.total_retensi,
    FORMAT((CAST(r.total_retensi AS FLOAT) / (b.total_berhenti + r.total_retensi)) * 100, '0.00') + '%' AS retention_percentage
FROM 
    Berhenti b
    LEFT JOIN Retensi r ON b.[Agent Name]= r.[Agent Name]
                          AND b.Grapari = r.Grapari
                          AND b.[Region Update] = r.[Region Update]
ORDER BY 
    retention_percentage DESC;

--Retention rate GraPARI
WITH Berhenti AS (
    SELECT 
        Grapari,
		[Region Update],
        COUNT([hasil caring]) AS total_berhenti
    FROM 
        retentionfixed
    WHERE 
        MONTH(date) = 3 
        AND [HASIL CARING] = 'CAPS' 
        --AND [Region Update] = 'West'
    GROUP BY  
        Grapari,
		[Region Update]
), Retensi AS (
    SELECT
        Grapari,
		[Region Update], 
        COUNT([HASIL CARING]) AS total_retensi
    FROM 
        RetentionFixed
    WHERE 
        MONTH(date) = 3 
        --AND [Region Update] = 'West'
        AND [HASIL CARING] IN ('RETENSI', 'PAKET_EKSISTING')
    GROUP BY  
		Grapari,
		[Region Update]
)
SELECT  
    b.Grapari, 
    b.[Region Update], 
    b.total_berhenti,
    r.total_retensi,
    FORMAT((CAST(r.total_retensi AS FLOAT) / (b.total_berhenti + r.total_retensi)) * 100, '0.00') + '%' AS retention_percentage
FROM 
    Berhenti b
    LEFT JOIN Retensi r ON  b.Grapari = r.Grapari
                          AND b.[Region Update] = r.[Region Update]
ORDER BY 
    retention_percentage DESC;

select [Region Update] from RetentionFixed
group by [Region Update]

UPDATE RetentionFixed
SET [Region Update] = 'Central'
WHERE [Region Update] = 'CENTRAL JABOTABEK'

select * from RetentionFixed
where [AGENT NAME] = 'Risma Aprilia'
AND MONTH(date) = 4 AND [HASIL CARING] = 'CAPS'

UPDATE TargetPSB
SET Mitra = 'Infomedia'
where graPARI IN  (
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

Select * from RetentionFixed
