Select * from Wellbeing
where MONTH(timestamp) = 4 AND area = 'Area 3' AND [Nama Petugas] LIKE '%Naina%'

select * from Employee
where Nama LIKE '%Naina%'

select * from FoP
where Nama_CSR  LIKE '%Naina%'

select * from Employee
where nama like '%NAINA CICI RAHMADANY AP%'

EXEC sp_rename 'wellbeing._Seberapa puaskah Anda dengan keseimbangan kehidupan kerja dan k', 'Work_life_balance';
EXEC sp_rename 'wellbeing.Apakah Anda merasa beban kerja berdampak negatif terhadap keseha', 'Beban_kerja_vs_kesehatan';
EXEC sp_rename 'wellbeing.Pekerjaan membuat anda mengalami stress atau kecemasan dalam sat', 'Level_stress';
EXEC sp_rename 'wellbeing.Anda merasa didukung oleh rekan kerja dan supervisor di tempat a', 'Support_Spv_dan_rekan_kerja';
EXEC sp_rename 'wellbeing.Apakah Anda puas dengan peran dan tanggung jawab Anda saat ini?', 'Kepuasan_terhadap_peran_dan_tanggung_jawab';
EXEC sp_rename 'wellbeing._Apakah Anda merasa beban kerja Anda dapat dikelola dengan mempe', 'Pengelolaan_beban_kerja';
EXEC sp_rename 'wellbeing._Pernahkah Anda mengalami kelelahan atau kelelahan karena stres ', 'Kelelahan_karena_stress';
EXEC sp_rename 'wellbeing._Anda merasa memiliki hubungan positif dengan rekan kerja Anda', 'Hubungan_positif_dengan_rekan_kerja';
EXEC sp_rename 'wellbeing.Anda pernah mengalami konflik atau ketegangan dengan rekan kerja', 'Konflik_dengan_rekan_kerja';

ALTER Table wellbeing
ALTER COLUMN Area NVARCHAR(MAX)

select * from wellbeing
	select
	ROUND(AVG(Work_life_balance), 2) as average_work_life_balance,
	ROUND(AVG(Beban_kerja_vs_kesehatan), 2) as Average_workload_vs_health,
	ROUND(AVG(Level_stress), 2) as Average_stress_dan_anxiety,
	ROUND(AVG(Support_Spv_dan_rekan_kerja), 2) as Average_Support,
	ROUND(AVG(Kepuasan_terhadap_peran_dan_tanggung_jawab), 2) as Average_role_satisfaction,
	ROUND(AVG(Apresiasi_oleh_perusahaan), 2) as Apresiasi_oleh_perusahaan,
	ROUND(AVG(Pengelolaan_beban_kerja), 2) as Average_workload_management,
	ROUND(AVG(Kelelahan_karena_stress), 2) as Average_Tiredness,
	ROUND(AVG(Hubungan_positif_dengan_rekan_kerja), 2) as Average_positive_relationship,
	ROUND(AVG(Konflik_dengan_rekan_kerja), 2) as Average_conflict
	from wellbeing
	JOIN FoP
	ON wellbeing.[Nama Petugas] = FoP.Nama_CSR
	JOIN Employee
	ON Employee.Nama = wellbeing.[Nama Petugas]
	WHERE Fop.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Februari 2024' AND Employee.Jenis_CTP = 'Household' 
	AND Employee.level = 'Expert'

--Nilai Deskriptif 
select  w.Timestamp, w.[Nama Petugas], w.NIK, w.[Job Function], w.[Grapari asal],W.area, f.[Regional Name], f.Nama_kuadran, employee.Jenis_CTP, employee.Level,
(CASE WHEN Work_life_balance > 2 THEN 'Puas' else 'Tidak Puas' END) as Work_life_balance,
(CASE WHEN Beban_kerja_vs_kesehatan > 2 THEN 'Berdampak Negatif' else 'Tidak Berdampak Negatif' END) as Beban_kerja,
(CASE WHEN Level_stress > 2 THEN 'Stress' else 'Tidak Stress' END) as Level_stress,
(CASE WHEN Support_Spv_dan_rekan_kerja > 2 THEN 'Didukung' else 'Tidak Didukung' END) as Support_spv_dan_rekan_kerja,
(CASE WHEN Kepuasan_terhadap_peran_dan_tanggung_jawab > 2 THEN 'Puas' else 'Tidak Puas' END) as Peran_dan_tanggung_jawab,
(CASE WHEN Apresiasi_oleh_perusahaan > 2 THEN 'Diapresiasi' else 'Kurang apresiasi' END) as Apresiasi_oleh_perusahaan,
(CASE WHEN Pengelolaan_beban_kerja > 2 THEN 'Dapat dikelola' else 'Tidak dapat dikelola' END) as workload,
(CASE WHEN Kelelahan_karena_stress > 2 THEN 'Pernah' else 'Tidak Pernah' END) as Kelelahan_karena_stress,
(CASE WHEN Hubungan_positif_dengan_rekan_kerja > 2 THEN 'Iya' else 'Tidak' END) as Hubungan_positif,
(CASE WHEN Konflik_dengan_rekan_kerja > 2 THEN 'Pernah' else 'Tidak Pernah' END) as Konflik_dgn_rekan_kerja
from wellbeing as W
LEFT JOIN FoP as F
ON w.[Nama Petugas] = f.Nama_CSR 
LEFT JOIN Employee
ON Employee.Nama = w.[Nama Petugas] AND Employee.NIK_SIAD = w.NIK 
WHERE MONTH(w.Timestamp)  = 4 AND F.Periode = 'Maret 2024'
order by W.Area--F.Nama_kuadran = 'LOLOCO' AND Employee.Jenis_CTP = 'Household' AND Employee.level = 'BASIC'


select * from FoP where Nama_CSR LIKE '%Puti lenggo%'  AND Periode = 'Maret 2024'
select * from Employee where Nama LIKE '%Puti lenggo%'
update wellbeing
set NIK = 22246393
where [Nama Petugas] = 'MHD HANAFI LUBIS'

select * from wellbeing
WHERE MONTH(Timestamp)  = 4
order by [Nama Petugas]


-----------------------------------------count nilai deskriptif--------------------------------------------------------------------------------------------------
--Work life balance
SELECT 
    (CASE 
        WHEN [Work_life_balance] < 3 THEN 'Tidak puas' 
        ELSE 'puas' 
    END) as Work_life_balance,
    COUNT(*) AS Count_Work_Life_Balance
FROM wellbeing
JOIN FoP
ON wellbeing.[Nama Petugas] = FoP.Nama_CSR 
WHERE wellbeing.AREA = 'Area 2' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Maret 2024'
GROUP BY 
    (CASE 
        WHEN Work_life_balance < 3 THEN 'Tidak puas' 
        ELSE 'puas' 
    END);

--Dampak negatif beban kerja terhadap kesehatan
SELECT 
    (CASE 
        WHEN Beban_kerja_vs_kesehatan> 2 THEN 'Berdampak Negatif' 
        ELSE 'Tidak Berdampak Negatif' 
    END) as Beban_kerja,
    COUNT(*) AS Count_Beban_kerja
FROM wellbeing
JOIN FoP
ON wellbeing.[Nama Petugas] = FoP.Nama_CSR 
WHERE wellbeing.AREA = 'Area 2' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Maret 2024'
GROUP BY 
    (CASE 
        WHEN Beban_kerja_vs_kesehatan > 2 THEN 'Berdampak Negatif' 
        ELSE 'Tidak Berdampak Negatif' 
    END);

--Stress level
SELECT 
    (CASE 
        WHEN Level_stress > 2 THEN 'Stress' 
        ELSE 'Tidak Stress' 
    END) as Level_stress,
    COUNT(*) AS Count_Level_stress
FROM wellbeing
JOIN FoP
ON wellbeing.[Nama Petugas] = FoP.Nama_CSR 
WHERE wellbeing.AREA = 'Area 2' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Maret 2024'
GROUP BY 
    (CASE 
        WHEN Level_stress > 2 THEN 'Stress' 
        ELSE 'Tidak Stress' 
    END);

--Dukungan rekan kerja dan spv
SELECT 
    (CASE 
        WHEN Support_spv_dan_rekan_kerja > 2 THEN 'Didukung' 
        ELSE 'Tidak Didukung' 
    END) as Support,
    COUNT(*) AS Count_Support
FROM wellbeing
JOIN FoP
ON wellbeing.[Nama Petugas] = FoP.Nama_CSR 
WHERE wellbeing.AREA = 'Area 2' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Maret 2024'
GROUP BY 
    (CASE 
        WHEN Support_spv_dan_rekan_kerja > 2 THEN 'Didukung' 
        ELSE 'Tidak Didukung' 
    END);

--Kepuasan peran dan tanggung jawab
SELECT 
    (CASE 
        WHEN Kepuasan_terhadap_peran_dan_tanggung_jawab > 2 THEN 'Puas' 
        ELSE 'Tidak Puas' 
    END) as Peran_dan_tanggung_jawab,
    COUNT(*) AS Count_Peran_dan_tanggung_jawab
FROM wellbeing
JOIN FoP
ON wellbeing.[Nama Petugas] = FoP.Nama_CSR 
WHERE wellbeing.AREA = 'Area 2' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Maret 2024'
GROUP BY 
    (CASE 
        WHEN Kepuasan_terhadap_peran_dan_tanggung_jawab > 2 THEN 'Puas' 
        ELSE 'Tidak Puas' 
    END);

--Apresiasi oleh perusahaan

SELECT 
    (CASE 
        WHEN Apresiasi_oleh_perusahaan > 2 THEN 'Diapresiasi' 
        ELSE 'Kurang diapresiasi' 
    END) as Apresiasi,
    COUNT(*) AS Count_Apresiasi
FROM wellbeing
JOIN FoP
ON wellbeing.[Nama Petugas] = FoP.Nama_CSR 
WHERE wellbeing.AREA = 'Area 2' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Maret 2024'
GROUP BY 
    (CASE 
        WHEN Apresiasi_oleh_perusahaan > 2 THEN 'Diapresiasi' 
        ELSE 'Kurang diapresiasi' 
    END);

--workload
SELECT 
    (CASE 
        WHEN Pengelolaan_beban_kerja > 2 THEN 'Dapat dikelola' 
        ELSE 'Tidak dapat dikelola' 
    END) as Workload,
    COUNT(*) AS Count_Workload
FROM wellbeing
JOIN FoP
ON wellbeing.[Nama Petugas] = FoP.Nama_CSR 
WHERE wellbeing.AREA = 'Area 2' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Maret 2024'
GROUP BY 
    (CASE 
        WHEN Pengelolaan_beban_kerja > 2 THEN 'Dapat dikelola' 
        ELSE 'Tidak dapat dikelola' 
    END);

--Kelelahan karena stress
SELECT 
    (CASE 
        WHEN Kelelahan_karena_stress > 2 THEN 'Pernah' 
        ELSE 'Tidak Pernah' 
    END) as Kelelahan_karena_stress,
    COUNT(*) AS Count_Kelelahan_karena_stress
FROM wellbeing
JOIN FoP
ON wellbeing.[Nama Petugas] = FoP.Nama_CSR 
WHERE wellbeing.AREA = 'Area 2' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Maret 2024'
GROUP BY 
    (CASE 
        WHEN Kelelahan_karena_stress > 2 THEN 'Pernah' 
        ELSE 'Tidak Pernah' 
    END);

--Hubungan positif dengan rekan kerja
SELECT 
    (CASE 
        WHEN Hubungan_positif_dengan_rekan_kerja > 2 THEN 'Iya' 
        ELSE 'Tidak' 
    END) as Hubungan_positif,
    COUNT(*) AS Count_Hubungan_positif
FROM wellbeing
JOIN FoP
ON wellbeing.[Nama Petugas] = FoP.Nama_CSR 
WHERE wellbeing.AREA = 'Area 2' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Maret 2024'
GROUP BY 
    (CASE 
        WHEN Hubungan_positif_dengan_rekan_kerja > 2 THEN 'Iya' 
        ELSE 'Tidak' 
    END);

--Konflik dengan rekan kerja
SELECT 
    (CASE 
        WHEN Konflik_dengan_rekan_kerja > 2 THEN 'Pernah' 
        ELSE 'Tidak Pernah' 
    END) as Konflik_dgn_rekan_kerja,
    COUNT(*) AS Count_Konflik_dgn_rekan_kerja
FROM wellbeing
JOIN FoP
ON wellbeing.[Nama Petugas] = FoP.Nama_CSR 
WHERE wellbeing.AREA = 'Area 2' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Maret 2024'
GROUP BY 
    (CASE 
        WHEN Konflik_dengan_rekan_kerja > 2 THEN 'Pernah' 
        ELSE 'Tidak Pernah' 
    END);

--Survey Hard Skill dan SOft skill
select * from hsass2
--Strong Hard skill
SELECT 
    H.[Nama Petugas], 
    H.[NIK Telkomsel], 
    H.[Job Function],
	H.[Nama GraPARI],
	E.Regional,
	E.Level,
	E.jenis_ctp,
    ([Apakah Anda menguasai Aplikasi Starclick?] +
     [Apakah Anda menguasai Aplikasi MyCx?] +
     [Apakah Anda menguasai Aplikasi ACS I-Booster?] +
	 [Apakah Anda menguasai Aplikasi DSC?]) AS total_menguasai_hardskill,
	 ([Kemampuan anda dalam mengkomunikasikan ide secara ringkas] +
     [Apakah anda baik dalam menangani konflik?] +
     [Apakah Anda nyaman mengambil keputusan di bawah tekanan?] +
	 [Apakah Anda cepat beradaptasi dalam perubahan atau tantangan tak] + 
	 [Bagaimana nilai kepemimpinan anda] + 
	 [Apakah Anda memastikan bahwa kebutuhan pelanggan terpenuhi sekal]) AS total_menguasai_soft_skill
FROM 
    hsass2 as H
JOIN Employee as E
ON H.[Nama Petugas] = E.Nama
order by total_menguasai_hardskill DESC, [Job Function]

select * from Employee

select GraPARI , count([nama petugas]) as total_HAHACO from HSaSS
group by GraPARI
order by total_HAHACO desc

select * from FoP
where Nama_CSR LIKE '%Alfan%'

select COUNT(*) from FoP
join Employee
ON Fop.Nama_CSR = Employee.Nama
where periode = 'Februari 2024' AND (FoP.Area = 'Area - 2' OR FoP.Area = 'Area 2') AND Nama_kuadran = 'HAHACO'
AND Employee.Jenis_CTP = 'Telkomsel'

select * from HSaSS2

SELECT
  COUNT(CASE WHEN Jenis_ctp = 'Telkomsel' THEN 1 ELSE 0 END) as Telkomsel,
  COUNT(CASE WHEN Jenis_ctp = 'Household' THEN 1 ELSE 0 END) as Household
FROM 
  FoP 
WHERE 
  Nama_kuadran = 'HAHACO' 
  AND Periode = 'Maret 2024' 
  AND Area = 'Area 2' 
  AND Mitra = 'infomedia';

  SELECT count(*)
FROM 
  FoP 
WHERE 
  Nama_kuadran = 'HAHACO' 
  AND Jenis_CTP = 'Telkomsel'
  AND Periode = 'Maret 2024' 
  AND Area = 'Area 2' 
  AND Mitra = 'infomedia'

    SELECT count(*)
FROM 
  FoP 
JOIN
Employee
ON FoP.Nama_CSR = Employee.Nama AND FoP.[NIK SIAD] = Employee.NIK_SIAD
WHERE 
  Nama_kuadran = 'HAHACO' 
  AND [Level] = 'Expert'
  AND Periode = 'Maret 2024' 
  AND Fop.Area = 'Area 2' 
  AND FoP.Mitra = 'infomedia'
Select *
FROM 
  FoP 
WHERE 
  Nama_kuadran = 'HAHACO' 
  AND Periode = 'Maret 2024' 
  AND Area = 'Area 2' 
  AND Mitra = 'infomedia'

select * from wellbeing
where MONTH(timestamp) = 4

select * from FoP
where periode = 'Januari 2024' AND [Regional Name] = 'Jabar'