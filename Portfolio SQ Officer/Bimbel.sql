
--Total Mengerjakan pretest dan posttest
SELECT 
    COUNT(DISTINCT CASE WHEN test = 'Pre Test' THEN [Nama Petugas] END) AS Total_mengerjakan_pretest,
    COUNT(DISTINCT CASE WHEN test = 'Post Test' THEN [Nama Petugas] END) AS Total_mengerjakan_posttest
FROM 
    bimbel
where jenis_bimbel = 'Soft SKill';

--List nama yang mengerjakan pretest dan post test

    SELECT b.[Nama Petugas], b.GraPARI, f.[Regional Name], b.Area
    FROM bimbel as b
	JOIN FoP as F
	ON b.[Nama Petugas] = f.Nama_CSR
    WHERE b.test IN ('Pre Test', 'Post Test') AND b.jenis_bimbel = 'hard Skill' AND b.Kuartal = 2 AND f.Periode = 'Maret 2024'
    GROUP BY b.[Nama Petugas], b.GraPARI, f.[Regional Name], b.Area
    HAVING COUNT(DISTINCT test) = 2
	ORDER BY b.Area

--List nama yang tidak ada mengerjakan pre test dan post test
SELECT 
    f.Nama_CSR,
	f.[Unit Name],
	f.[Regional Name],
	f.Area,
    f.Nama_kuadran,
    f.Periode
FROM 
    FoP AS f
LEFT JOIN 
    bimbel AS b ON f.Nama_CSR = b.[Nama Petugas] AND b.Kuartal = 2
WHERE 
    (f.Nama_kuadran = 'LOHACO' OR f.Nama_kuadran = 'LOLOCO') AND f.Periode = 'Maret 2024' AND b.[Nama Petugas] IS NULL AND f.Mitra = 'Infomedia'
ORDER BY
	Area, [Unit Name];

--Persentase peserta bimbel nasional
WITH BimbelAgents AS (
    SELECT COUNT(DISTINCT [Nama Petugas]) AS bimbel_count
    FROM bimbel
    WHERE kuartal = 2
),
FoPAgents AS (
    SELECT COUNT(*) AS FoP_count
    FROM FoP
    WHERE Mitra = 'Infomedia' AND Nama_kuadran IN ('LOHACO','LOLOCO') AND Periode = 'Maret 2024'
)
SELECT 
    BimbelAgents.bimbel_count,
    FoPAgents.FoP_count,
    FORMAT((BimbelAgents.bimbel_count * 1.0) / NULLIF(FoPAgents.FoP_count, 0), '0.00%') AS Persentase_keikutsertaan
FROM 
    BimbelAgents
CROSS JOIN 
    FoPAgents;

--Persentase peserta bimbel Area
WITH BimbelAgents AS (
    SELECT 
        Area,
        COUNT(DISTINCT [Nama Petugas]) AS bimbel_count
    FROM 
        bimbel
    WHERE 
        kuartal = 2
    GROUP BY 
        Area
),
FoPAgents AS (
    SELECT 
        Area,
        COUNT(*) AS FoP_count
    FROM 
        FoP
    WHERE 
        Mitra = 'Infomedia' AND Nama_kuadran IN ('LOHACO','LOLOCO') AND Periode = 'Maret 2024'
    GROUP BY 
        Area
)
SELECT 
    BimbelAgents.Area,
    BimbelAgents.bimbel_count,
    FoPAgents.FoP_count,
    FORMAT((BimbelAgents.bimbel_count * 1.0) / NULLIF(FoPAgents.FoP_count, 0), '0.00%') AS Persentase_keikutsertaan
FROM 
    BimbelAgents
JOIN 
    FoPAgents ON BimbelAgents.Area = FoPAgents.Area;

--Persentase peserta bimbel Regional
WITH BimbelAgents AS (
    SELECT 
        Regional,
        Area,
        COUNT(DISTINCT [Nama Petugas]) AS bimbel_count
    FROM 
        bimbel
    WHERE 
        kuartal = 2
    GROUP BY 
        Regional, Area
),
FoPAgents AS (
    SELECT 
        [Regional Name],
        Area,
        COUNT(*) AS FoP_count
    FROM 
        FoP
    WHERE 
        Mitra = 'Infomedia' AND Nama_kuadran IN ('LOHACO','LOLOCO') AND Periode = 'Maret 2024'
    GROUP BY 
        [Regional Name], Area
)
SELECT 
    BimbelAgents.Regional,
    BimbelAgents.Area,
    BimbelAgents.bimbel_count,
    FoPAgents.FoP_count,
    FORMAT((BimbelAgents.bimbel_count * 1.0) / NULLIF(FoPAgents.FoP_count, 0), '0.00%') AS persentase_keikutsertaan
FROM 
    BimbelAgents
JOIN 
    FoPAgents ON BimbelAgents.Regional = FoPAgents.[Regional Name] AND BimbelAgents.Area = FoPAgents.Area;

--persentase peserta bimbel by GraPARI

SELECT 
    f.[Unit Name],
    f.[Regional Name],
    f.Area,
    COUNT(f.nama_csr) AS Jumlah_tidak_ikut_bimbel,
    total_peserta_bimbel,
    CASE 
        WHEN total_peserta_bimbel = 0 THEN '0.00%'
        ELSE CONCAT(FORMAT(100 - ((COUNT(f.nama_csr) / CAST(total_peserta_bimbel AS FLOAT)) * 100), '0.00'), '%')
    END AS Persentase_keikutsertaan
FROM 
    FoP AS f
LEFT JOIN 
    bimbel AS b ON f.Nama_CSR = b.[Nama Petugas] AND b.Kuartal = 2
LEFT JOIN 
    (SELECT 
         [Unit Name],
         COUNT(Nama_CSR) AS total_peserta_bimbel
     FROM 
         FoP
     WHERE 
         Nama_kuadran IN ('LOHACO', 'LOLOCO') AND Periode = 'Maret 2024' AND Mitra = 'Infomedia'
     GROUP BY 
         [Unit Name]
    ) AS tpb ON tpb.[Unit Name] = f.[Unit Name]
WHERE 
    (f.Nama_kuadran = 'LOHACO' OR f.Nama_kuadran = 'LOLOCO') AND f.Periode = 'Maret 2024' AND b.[Nama Petugas] IS NULL AND f.Mitra = 'Infomedia'
GROUP BY 
    f.[Unit Name], f.[Regional Name], f.Area, total_peserta_bimbel
ORDER BY 
   Area, [Unit Name];

--count yang mengerjakan pretest dan post test
SELECT COUNT(*)
FROM (
    SELECT [Nama Petugas]
    FROM bimbel
    WHERE test IN ('Pre Test', 'Post Test') AND jenis_bimbel = 'Soft SKill' 
    GROUP BY [Nama Petugas]
    HAVING COUNT(DISTINCT test) = 2
) AS Both_Pretest_Posttest;

--Total Peserta
Select Count(distinct nama_csr) as total_peserta from Peserta
where Nama_kuadran IN ('HALOCO', 'LOLOCO')

--persentase yang mengerjakan both test dengan total peserta
WITH Both_Pretest_Posttest_Count AS (
    SELECT COUNT(*) AS count_both_pre_post
    FROM (
        SELECT [Nama Petugas]
        FROM bimbel
        WHERE test IN ('Pre Test', 'Post Test') AND Jenis_bimbel = 'Soft Skill'
        GROUP BY [Nama Petugas]
        HAVING COUNT(DISTINCT test) = 2
    ) AS Both_Pretest_Posttest
),
Total_Peserta AS (
    SELECT COUNT(DISTINCT nama_csr) AS total_peserta
    FROM Peserta
    WHERE Nama_kuadran IN ('HALOCO', 'LOLOCO')--sesi IN (1,2,3,4,5,6,7,8)
)

SELECT 
    CONCAT(FORMAT(CAST(count_both_pre_post AS DECIMAL(10,2)) * 100.0 / total_peserta, 'N2'), '%') AS Percentage
FROM 
    Both_Pretest_Posttest_Count, Total_Peserta;

--Average nilai pre test dan post test
SELECT 
    ROUND(AVG(CASE WHEN test = 'Pre Test' THEN score END), 2) AS Avg_Pre_Test,
    ROUND(AVG(CASE WHEN test = 'Post Test' THEN score END), 2) AS Avg_Post_Test,
    CONCAT(ROUND(((AVG(CASE WHEN test = 'Post Test' THEN score END) - AVG(CASE WHEN test = 'Pre Test' THEN score END)) / AVG(CASE WHEN test = 'Pre Test' THEN score END)) * 100, 2), '%') AS Grow_Percentage
FROM 
    bimbel
WHERE 
    test IN ('Pre Test', 'Post Test');

--Average nilai pre test dan post test berdasarkan nama yg mengerjakan keduanya
SELECT 
    ROUND(AVG(CASE WHEN test = 'Pre Test' THEN score END), 2) AS Avg_Pre_Test,
    ROUND(AVG(CASE WHEN test = 'Post Test' THEN score END), 2) AS Avg_Post_Test,
    CONCAT(ROUND(((AVG(CASE WHEN test = 'Post Test' THEN score END) - AVG(CASE WHEN test = 'Pre Test' THEN score END)) / AVG(CASE WHEN test = 'Pre Test' THEN score END)) * 100, 2), '%') AS Grow_Percentage
FROM 
    bimbel
WHERE 
    [nama petugas] IN (
        SELECT [nama petugas]
        FROM bimbel
        WHERE test IN ('Pre Test', 'Post Test')
        GROUP BY [nama petugas]
        HAVING COUNT(DISTINCT test) = 2
    )
    AND test IN ('Pre Test', 'Post Test');

--Count most wrong answer
SELECT
SUM(CASE WHEN  Question_1 = '1000 menit (sesuai paket yang dipilih) atau setara dengan 17 jam perbulan' THEN 1 ELSE 0 END) as Total_benar_Q1,
SUM(CASE WHEN  Question_2 = '2 menit Rp 250' THEN 1 ELSE 0 END) as Total_benar_Q2,
SUM(CASE WHEN  Question_3 = 'Thailand' THEN 1 ELSE 0 END) as Total_benar_Q3,
SUM(CASE WHEN  Question_4 = '12 – 18 Perangkat' THEN 1 ELSE 0 END) as Total_benar_Q4,
SUM(CASE WHEN  Question_5 = 'TV on Demand' THEN 1 ELSE 0 END) as Total_benar_Q5,
SUM(CASE WHEN  Question_6 = 'Tayang ulang acara live sampai dengan 7 hari kebelakang' THEN 1 ELSE 0 END) as Total_benar_Q6,
SUM(CASE WHEN  Question_7 = 'Prime Video' THEN 1 ELSE 0 END) as Total_benar_Q7,
SUM(CASE WHEN  Question_8 = '146 Channel, 5 Dolby Ch, 1 Promo Ch' THEN 1 ELSE 0 END) as Total_benar_Q8,
SUM(CASE WHEN  Question_9 = 'Paket Channel movie box office, film dari studio Paramount, film festival, film hits lawas serta film blocbuster Asia.' THEN 1 ELSE 0 END) as Total_benar_Q9,
SUM(CASE WHEN  Question_10 = 'Film dan series maupun konten hiburan terutama persembahan MAXstream Original dengan beragam genre' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM Bimbel
where Test = 'Pre test' AND Jenis_bimbel = 'Soft Skill'

----Count most wrong answer bimbel soft skill
SELECT
SUM(CASE WHEN  Question_1 = 'Integrity' THEN 1 ELSE 0 END) as Total_benar_Q1,
SUM(CASE WHEN  Question_2 = 'Empathy' THEN 1 ELSE 0 END) as Total_benar_Q2,
SUM(CASE WHEN  Question_3 = 'Focus' THEN 1 ELSE 0 END) as Total_benar_Q3,
SUM(CASE WHEN  Question_4 = 'Flexibilty' THEN 1 ELSE 0 END) as Total_benar_Q4,
SUM(CASE WHEN  Question_5 = 'Compassion' THEN 1 ELSE 0 END) as Total_benar_Q5,
SUM(CASE WHEN  Question_6 = 'Team Work' THEN 1 ELSE 0 END) as Total_benar_Q6,
SUM(CASE WHEN  Question_7 = 'Multitasker' THEN 1 ELSE 0 END) as Total_benar_Q7,
SUM(CASE WHEN  Question_8 = 'Personal Resilience' THEN 1 ELSE 0 END) as Total_benar_Q8,
SUM(CASE WHEN  Question_9 = 'Efficiency' THEN 1 ELSE 0 END) as Total_benar_Q9,
SUM(CASE WHEN  Question_10 = 'Integrity' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM Bimbel
where Test = 'Post test' AND Jenis_bimbel = 'Soft Skill'

--count most wrong Hard skill phase 2
SELECT
SUM(CASE WHEN  Question_1 = 'Pastikan mendapatkan catuan daya listrik' THEN 1 ELSE 0 END) as Total_benar_Q1,
SUM(CASE WHEN  Question_2 = 'Advance Info, Cek CPU & Memory' THEN 1 ELSE 0 END) as Total_benar_Q2,
SUM(CASE WHEN  Question_3 = 'Check Client di ACSIS' THEN 1 ELSE 0 END) as Total_benar_Q3,
SUM(CASE WHEN  Question_4 = 'Edukasi melakukan pembayaran tagihan jika sudah muncul tanpa eskalasi permintaan' THEN 1 ELSE 0 END) as Total_benar_Q4,
SUM(CASE WHEN  Question_5 = 'Rp 250.000,-' THEN 1 ELSE 0 END) as Total_benar_Q5,
SUM(CASE WHEN  Question_6 = '75.000 Belum PPN 11%' THEN 1 ELSE 0 END) as Total_benar_Q6,
SUM(CASE WHEN  Question_7 = 'Panggilan ke call center 188 biaya 300 rupiah' THEN 1 ELSE 0 END) as Total_benar_Q7,
SUM(CASE WHEN  Question_8 = 'Panggilan ke Operator Lain' THEN 1 ELSE 0 END) as Total_benar_Q8,
SUM(CASE WHEN  Question_9 = 'Rp 300.000,-' THEN 1 ELSE 0 END) as Total_benar_Q9,
SUM(CASE WHEN  Question_10 = 'Rp 1.000.000,-' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM Bimbel
where Phase = 2 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post Test'

--count most wrong answer Hard skill Q2 Phase 1 Sesi 1 & 2 (area 1,2,4), sesi 1, 2 & 3 (Area 3)
SELECT 
SUM(CASE WHEN  Question_1 = 'Informasikan untuk tracking oder hanya bisa melalui Call Center' THEN 1 ELSE 0 END) as Total_benar_Q1,
SUM(CASE WHEN  Question_2 = 'Akan ada proses survey oleh teknisi' THEN 1 ELSE 0 END) as Total_benar_Q2,
SUM(CASE WHEN  Question_3 = 'Surat kematian pelanggan lama dari Rumah Sakit dan KTP asli yang mengajukan' THEN 1 ELSE 0 END) as Total_benar_Q3,
SUM(CASE WHEN  Question_4 = 'GraPARI' THEN 1 ELSE 0 END) as Total_benar_Q4,
SUM(CASE WHEN  Question_5 = 'Perubahan Limit maksimalnya adalah 2x MF' THEN 1 ELSE 0 END) as Total_benar_Q5,
SUM(CASE WHEN  Question_6 = '2 x 24 Jam' THEN 1 ELSE 0 END) as Total_benar_Q6,
SUM(CASE WHEN  Question_7 = 'Reset Port di ACSIS' THEN 1 ELSE 0 END) as Total_benar_Q7,
SUM(CASE WHEN  Question_8 = 'Pastikan lampu indikator powernya menyala' THEN 1 ELSE 0 END) as Total_benar_Q8,
SUM(CASE WHEN  Question_9 = 'Perubahan tagihan mulai bulan N' THEN 1 ELSE 0 END) as Total_benar_Q9,
SUM(CASE WHEN  Question_10 = 'Semua Jawaban Benar' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Pre Test' AND Kuartal = 2 AND ([Sesi Bimbel] = 'Sesi 1' OR [Sesi Bimbel] = 'Sesi 2')

--count peserta pretest
SELECT COUNT(*) AS total_peserta
FROM bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Pre Test' AND Kuartal = 2 AND Hari_bimbel = 'Day 2'

--Detail most wrong answer Hard skill Q2 Phase 1 Sesi 1 & 2 (area 1,2,4), sesi 1, 2 & 3 (Area 3)
SELECT [Nama Petugas],[NIK SIAD], Area, Regional, GraPARI, [Sesi Bimbel],Test, Jenis_ctp, Level, Hari_bimbel,
(CASE WHEN  Question_1 = 'Informasikan untuk tracking oder hanya bisa melalui Call Center' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q1,
(CASE WHEN  Question_2 = 'Akan ada proses survey oleh teknisi' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q2,
(CASE WHEN  Question_3 = 'Surat kematian pelanggan lama dari Rumah Sakit dan KTP asli yang mengajukan' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q3,
(CASE WHEN  Question_4 = 'GraPARI' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q4,
(CASE WHEN  Question_5 = 'Perubahan Limit maksimalnya adalah 2x MF' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q5,
(CASE WHEN  Question_6 = '2 x 24 Jam' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q6,
(CASE WHEN  Question_7 = 'Reset Port di ACSIS' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q7,
(CASE WHEN  Question_8 = 'Pastikan lampu indikator powernya menyala' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q8,
(CASE WHEN  Question_9 = 'Perubahan tagihan mulai bulan N' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q9,
(CASE WHEN  Question_10 = 'Semua Jawaban Benar' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill'  AND Kuartal = 2 AND [Hari_bimbel] = 'Day 1'
--AND ([Sesi Bimbel] = 'Sesi 1' OR [Sesi Bimbel] = 'Sesi 2') --AND Test = 'Post Test'

--count most wrong answer Hard skill Q2 Phase 1 Sesi 3 & 4 (area 1,2,4), sesi 4 (Area 3)
SELECT 
SUM(CASE WHEN  Question_1 = 'E-KTP (NIK&NO KK)' THEN 1 ELSE 0 END) as Total_benar_Q1,
SUM(CASE WHEN  Question_2 = 'Disney+ Hotstar' THEN 1 ELSE 0 END) as Total_benar_Q2,
SUM(CASE WHEN  Question_3 = 'Surat Sewa menyewa' THEN 1 ELSE 0 END) as Total_benar_Q3,
SUM(CASE WHEN  Question_4 = 'Isolir sementara' THEN 1 ELSE 0 END) as Total_benar_Q4,
SUM(CASE WHEN  Question_5 = 'Rp 500.000,- ' THEN 1 ELSE 0 END) as Total_benar_Q5,
SUM(CASE WHEN  Question_6 = '2x MF' THEN 1 ELSE 0 END) as Total_benar_Q6,
SUM(CASE WHEN  Question_7 = 'Pastikan mendapatkan catuan daya listrik' THEN 1 ELSE 0 END) as Total_benar_Q7,
SUM(CASE WHEN  Question_8 = 'Restart ONT' THEN 1 ELSE 0 END) as Total_benar_Q8,
SUM(CASE WHEN  Question_9 = '3X24 Jam' THEN 1 ELSE 0 END) as Total_benar_Q9,
SUM(CASE WHEN  Question_10 = 'Tidak ada Perubahan jumlah tagihan yang akan terjadi pada tagihan berikutnya' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post Test' AND Kuartal = 2 AND hari_bimbel = 'Day 2'

--Detail most wrong answer Hard skill Q2 Phase 1 Sesi 3 & 4 (area 1,2,4), sesi 4 (Area 3)
SELECT [Nama Petugas],[NIK SIAD], Area, Regional, GraPARI, [Sesi Bimbel],Test, Jenis_ctp, Level, Hari_bimbel,
(CASE WHEN  Question_1 = 'E-KTP (NIK&NO KK)' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q1,
(CASE WHEN  Question_2 = 'Disney+ Hotstar' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q2,
(CASE WHEN  Question_3 = 'Surat Sewa menyewa' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q3,
(CASE WHEN  Question_4 = 'Isolir sementara' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q4,
(CASE WHEN  Question_5 = 'Rp 500.000,- ' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q5,
(CASE WHEN  Question_6 = '2x MF' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q6,
(CASE WHEN  Question_7 = 'Pastikan mendapatkan catuan daya listrik' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q7,
(CASE WHEN  Question_8 = 'Restart ONT' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q8,
(CASE WHEN  Question_9 = '3X24 Jam' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q9,
(CASE WHEN  Question_10 = 'Tidak ada Perubahan jumlah tagihan yang akan terjadi pada tagihan berikutnya' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill'  AND Kuartal = 2 AND Hari_bimbel = 'Day 2'
--AND [Sesi Bimbel] = 'Sesi 4' AND Area = 'Area 3'

--count most wrong answer Hard skill Q2 Phase 1 Day 3
SELECT 
SUM(CASE WHEN  Question_1 = 'Meminta pelanggan untuk melakukan pengisian form registrasi secara Offline' THEN 1 ELSE 0 END) as Total_benar_Q1,
SUM(CASE WHEN  Question_2 = 'Speed on Demand' THEN 1 ELSE 0 END) as Total_benar_Q2,
SUM(CASE WHEN  Question_3 = 'Surat pernyataan sepihak' THEN 1 ELSE 0 END) as Total_benar_Q3,
SUM(CASE WHEN  Question_4 = 'Semua Jawaban Benar' THEN 1 ELSE 0 END) as Total_benar_Q4,
SUM(CASE WHEN  Question_5 = 'Rp. 5.000.000' THEN 1 ELSE 0 END) as Total_benar_Q5,
SUM(CASE WHEN  Question_6 = '2x MF' THEN 1 ELSE 0 END) as Total_benar_Q6,
SUM(CASE WHEN  Question_7 = 'Open Ticket Symptom: Tidak Bisa Browsing - Tidak Bisa Koneksi' THEN 1 ELSE 0 END) as Total_benar_Q7,
SUM(CASE WHEN  Question_8 = 'Pastikan kabel pacth cord sudha terpasang/tertancap kencang/benar' THEN 1 ELSE 0 END) as Total_benar_Q8,
SUM(CASE WHEN  Question_9 = 'Variasi paket IndiHome, harga beserta benefitnya' THEN 1 ELSE 0 END) as Total_benar_Q9,
SUM(CASE WHEN  Question_10 = 'Edukasi melakukan Balik Nama' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Pre Test' AND Kuartal = 2 AND hari_bimbel = 'Day 3'

SELECT COUNT(*) AS total_peserta
FROM bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post Test' AND Kuartal = 2 AND Hari_bimbel = 'Day 3'

--Detail most wrong day 3
SELECT [Nama Petugas],[NIK SIAD], Area, Regional, GraPARI, [Sesi Bimbel],Test, Jenis_ctp, Level, Hari_bimbel,
(CASE WHEN  Question_1 = 'Meminta pelanggan untuk melakukan pengisian form registrasi secara Offline' THEN 'Benar' ELSE 'Salah' END) as Q1,
(CASE WHEN  Question_2 = 'Speed on Demand' THEN 'Benar' ELSE 'Salah' END) as Q2,
(CASE WHEN  Question_3 = 'Surat pernyataan sepihak' THEN 'Benar' ELSE 'Salah' END) as Q3,
(CASE WHEN  Question_4 = 'Semua Jawaban Benar' THEN 'Benar' ELSE 'Salah' END) as Q4,
(CASE WHEN  Question_5 = 'Rp. 5.000.000' THEN 'Benar' ELSE 'Salah' END) as Q5,
(CASE WHEN  Question_6 = '2x MF' THEN 'Benar' ELSE 'Salah' END) as Q6,
(CASE WHEN  Question_7 = 'Open Ticket Symptom: Tidak Bisa Browsing - Tidak Bisa Koneksi' THEN 'Benar' ELSE 'Salah' END) as Q7,
(CASE WHEN  Question_8 = 'Pastikan kabel pacth cord sudha terpasang/tertancap kencang/benar' THEN 'Benar' ELSE 'Salah' END) as Q8,
(CASE WHEN  Question_9 = 'Variasi paket IndiHome, harga beserta benefitnya' THEN 'Benar' ELSE 'Salah' END) as Q9,
(CASE WHEN  Question_10 = 'Edukasi melakukan Balik Nama' THEN 'Benar' ELSE 'Salah' END) as Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill' AND Kuartal = 2 AND hari_bimbel = 'Day 3'

--count most wrong answer Hard skill Q2 Phase 1 Day 4
SELECT 
SUM(CASE WHEN  Question_1 = 'Starclick atau DSC' THEN 1 ELSE 0 END) as Total_benar_Q1,
SUM(CASE WHEN  Question_2 = 'QC 1' THEN 1 ELSE 0 END) as Total_benar_Q2,
SUM(CASE WHEN  Question_3 = 'Paket data monthly fee/paket dasar dihitung secara Full' THEN 1 ELSE 0 END) as Total_benar_Q3,
SUM(CASE WHEN  Question_4 = 'Alamat instalasi IndiHome' THEN 1 ELSE 0 END) as Total_benar_Q4,
SUM(CASE WHEN  Question_5 = '10000000' THEN 1 ELSE 0 END) as Total_benar_Q5,
SUM(CASE WHEN  Question_6 = 'Jumlah tagihan terakhir' THEN 1 ELSE 0 END) as Total_benar_Q6,
SUM(CASE WHEN  Question_7 = 'ONU DISABLE' THEN 1 ELSE 0 END) as Total_benar_Q7,
SUM(CASE WHEN  Question_8 = 'Eskala Open Ticket Symptom: Tidak Bisa Browsing - Tidak Bisa Koneksi (Submit)' THEN 1 ELSE 0 END) as Total_benar_Q8,
SUM(CASE WHEN  Question_9 = 'Premium' THEN 1 ELSE 0 END) as Total_benar_Q9,
SUM(CASE WHEN  Question_10 = 'Free' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post Test' AND Kuartal = 2 AND hari_bimbel = 'Day 4'

SELECT COUNT(*) AS total_peserta
FROM bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Pre Test' AND Kuartal = 2 AND Hari_bimbel = 'Day 4'

--count most wrong answer Hard skill Q2 Phase 1 Day 4
SELECT [Nama Petugas],[NIK SIAD], Area, Regional, GraPARI, [Sesi Bimbel],Test, Jenis_ctp, Level, Hari_bimbel,
(CASE WHEN  Question_1 = 'Starclick atau DSC' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q1,
(CASE WHEN  Question_2 = 'QC 1' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q2,
(CASE WHEN  Question_3 = 'Paket data monthly fee/paket dasar dihitung secara Full' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q3,
(CASE WHEN  Question_4 = 'Alamat instalasi IndiHome' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q4,
(CASE WHEN  Question_5 = '10000000' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q5,
(CASE WHEN  Question_6 = 'Jumlah tagihan terakhir' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q6,
(CASE WHEN  Question_7 = 'ONU DISABLE' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q7,
(CASE WHEN  Question_8 = 'Eskala Open Ticket Symptom: Tidak Bisa Browsing - Tidak Bisa Koneksi (Submit)' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q8,
(CASE WHEN  Question_9 = 'Premium' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q9,
(CASE WHEN  Question_10 = 'Free' THEN 'Benar' ELSE 'Salah' END) as Total_benar_Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Hard Skill' AND Kuartal = 2 AND hari_bimbel = 'Day 4'
--count most wrong answer Soft Skill Q2 Phase 1 Day 1
SELECT 
SUM(CASE WHEN  Question_1 = 'monotasking' THEN 1 ELSE 0 END) as Total_benar_Q1,
SUM(CASE WHEN  Question_2 = 'Pelanggan kategori Diamond akan mendapatkan antrean prioritas serta dilayani dan didampingi oleh Team Leader/ Supervisor CCO dengan bantuan CSR' THEN 1 ELSE 0 END) as Total_benar_Q2,
SUM(CASE WHEN  Question_3 = 'Melayani dengan berat hati' THEN 1 ELSE 0 END) as Total_benar_Q3,
SUM(CASE WHEN  Question_4 = 'Integrity & Emphaty' THEN 1 ELSE 0 END) as Total_benar_Q4,
SUM(CASE WHEN  Question_5 = 'Empathy' THEN 1 ELSE 0 END) as Total_benar_Q5,
SUM(CASE WHEN  Question_6 = 'Pelanggan akan mendapatkan antrean regular dan dilayani oleh CSR GraPARI di counter' THEN 1 ELSE 0 END) as Total_benar_Q6,
SUM(CASE WHEN  Question_7 = 'Semua jawaban benar' THEN 1 ELSE 0 END) as Total_benar_Q7,
SUM(CASE WHEN  Question_8 = 'Influencing others' THEN 1 ELSE 0 END) as Total_benar_Q8,
SUM(CASE WHEN  Question_9 = 'Setelah selesai melayani pelanggan, petugas tidak perlu membantu mengantarkan pelanggan hingga keluar dari GraPARI' THEN 1 ELSE 0 END) as Total_benar_Q9,
SUM(CASE WHEN  Question_10 = 'Compassion' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Soft Skill' AND Test = 'Pre Test' AND Kuartal = 2 AND hari_bimbel = 'Day 1'

SELECT COUNT(*) AS total_peserta
FROM bimbel
where Phase = 1 AND Jenis_bimbel = 'Soft Skill' AND Test = 'Pre Test' AND Kuartal = 2 AND Hari_bimbel = 'Day 1'


--count most wrong answer Soft Skill Q2 Phase 1 Day 2
SELECT 
SUM(CASE WHEN  Question_1 = 'Prioritizing Task' THEN 1 ELSE 0 END) as Total_benar_Q1,
SUM(CASE WHEN  Question_2 = 'Accounting Skill' THEN 1 ELSE 0 END) as Total_benar_Q2,
SUM(CASE WHEN  Question_3 = 'MYSIMETRI' THEN 1 ELSE 0 END) as Total_benar_Q3,
SUM(CASE WHEN  Question_4 = 'Personal resilience' THEN 1 ELSE 0 END) as Total_benar_Q4,
SUM(CASE WHEN  Question_5 = 'Diamond' THEN 1 ELSE 0 END) as Total_benar_Q5,
SUM(CASE WHEN  Question_6 = 'OOTD' THEN 1 ELSE 0 END) as Total_benar_Q6,
SUM(CASE WHEN  Question_7 = 'Multitasker' THEN 1 ELSE 0 END) as Total_benar_Q7,
SUM(CASE WHEN  Question_8 = 'Compassion – Love in Action' THEN 1 ELSE 0 END) as Total_benar_Q8,
SUM(CASE WHEN  Question_9 = 'Focus' THEN 1 ELSE 0 END) as Total_benar_Q9,
SUM(CASE WHEN  Question_10 = 'mendapatkan nomor antrean ke CSR' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Soft Skill' AND Test = 'Post Test' AND Kuartal = 2 AND hari_bimbel = 'Day 2'

SELECT COUNT(*) AS total_peserta
FROM bimbel
where Phase = 1 AND Jenis_bimbel = 'Soft Skill' AND Test = 'Post Test' AND Kuartal = 2 AND Hari_bimbel = 'Day 2'


--count most wrong answer Soft Skill Q2 Phase 1 Day 2
SELECT 
SUM(CASE WHEN  Question_1 = 'Prioritizing task' THEN 1 ELSE 0 END) as Total_benar_Q1,
SUM(CASE WHEN  Question_2 = 'Accounting Skill' THEN 1 ELSE 0 END) as Total_benar_Q2,
SUM(CASE WHEN  Question_3 = 'MYSIMETRI' THEN 1 ELSE 0 END) as Total_benar_Q3,
SUM(CASE WHEN  Question_4 = 'Personal resilience' THEN 1 ELSE 0 END) as Total_benar_Q4,
SUM(CASE WHEN  Question_5 = 'Diamond' THEN 1 ELSE 0 END) as Total_benar_Q5,
SUM(CASE WHEN  Question_6 = 'OOTD' THEN 1 ELSE 0 END) as Total_benar_Q6,
SUM(CASE WHEN  Question_7 = 'Multitasker' THEN 1 ELSE 0 END) as Total_benar_Q7,
SUM(CASE WHEN  Question_8 = 'Compassion – Love in Action' THEN 1 ELSE 0 END) as Total_benar_Q8,
SUM(CASE WHEN  Question_9 = 'Focus' THEN 1 ELSE 0 END) as Total_benar_Q9,
SUM(CASE WHEN  Question_10 = 'Mendapatkan nomor antrean ke CSR' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM Bimbel
where Phase = 1 AND Jenis_bimbel = 'Soft Skill' AND Test = 'Post Test' AND Kuartal = 2 AND hari_bimbel = 'Day 2'

SELECT COUNT(*) AS total_peserta
FROM bimbel
where Phase = 1 AND Jenis_bimbel = 'Soft Skill' AND Test = 'Post Test' AND Kuartal = 2 AND Hari_bimbel = 'Day 2'
ALTER TABLE Bimbel
ADD Hari_bimbel NVARCHAR(255)

Select * from bimbel
where Hari_bimbel = 'Day 3' OR Hari_bimbel = 'Day 4'

select * from bimbel
where Jenis_bimbel = 'Soft Skill' AND [Sesi Bimbel] = 'Sesi 1' AND Area = 'Area 1'

--------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from bimbel
where Kuartal =2 AND [Nama Petugas] = 'Yuliana' AND DAY(timestamp) = 5

UPDATE bimbel
SET Kuartal = 2 
WHERE Kuartal is null


--update level
UPDATE Bimbel
SET Level = Employee.level
FROM bimbel
JOIN Employee
ON bimbel.[Nama Petugas] = Employee.Nama
where bimbel.Kuartal = 2

--update jenis CTP
UPDATE Bimbel
SET Jenis_ctp = Employee.Jenis_CTP
FROM bimbel
JOIN Employee
ON bimbel.[Nama Petugas] = Employee.Nama
where bimbel.Kuartal = 2

--Update Regional
UPDATE bimbel
SET Regional = Employee.Regional
FROM bimbel
JOIN Employee
ON bimbel.[Nama Petugas] = Employee.Nama AND bimbel.[NIK SIAD] = Employee.NIK_SIAD
where bimbel.Kuartal = 2 

--Update GraPARI
UPDATE bimbel
SET GraPARI = Employee.GraPARI
FROM bimbel
JOIN Employee
ON bimbel.[Nama Petugas] = Employee.Nama AND bimbel.[NIK SIAD] = Employee.NIK_SIAD
where bimbel.Kuartal = 2 

update bimbel
set Jenis_bimbel = 'Hard Skill'
where Jenis_bimbel is null


update bimbel
set Phase = 1
where Phase is null and kuartal = 2

select * from bimbel
where kuartal = 2

select B.[Nama Petugas], B.Score, B.Test, B.phase, B.Jenis_bimbel, E.jenis_ctp
from bimbel as B
Join Employee as E
ON B.[Nama Petugas] = E.Nama

select SUM(CASE WHEN jenis_ctp = 'Telkomsel' THEN 1 ELSE 0 END),
SUM(CASE WHEN jenis_CTP = 'Household' THEN 1 ELSE 0 END)

ALter table bimbel
ADD [Level] NVARCHAR(255)

ALTER TABLE bimbel
ADD Jenis_ctp NVARCHAR(255)

select 
SUM(CASE WHEN bimbel.jenis_ctp = 'Household' THEN 1 ELSE 0 END) as Household,
SUM(CASE WHEN bimbel.jenis_ctp = 'Telkomsel' THEN 1 ELSE 0 END) as Telkomsel
From Bimbel
JOIN FoP
ON Bimbel.[Nama Petugas] = FoP.Nama_CSR
WHERE Phase = 2 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post test' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Februari 2024'

select 
SUM(CASE WHEN bimbel.[Level] = 'Basic' THEN 1 ELSE 0 END) as Basic,
SUM(CASE WHEN bimbel.[Level] = 'Intermediate' THEN 1 ELSE 0 END) as Intermediate,
SUM(CASE WHEN bimbel.[Level] = 'Advance' THEN 1 ELSE 0 END) as Advance,
SUM(CASE WHEN bimbel.[Level] = 'Expert' THEN 1 ELSE 0 END) as Expert
From Bimbel
JOIN FoP
ON Bimbel.[Nama Petugas] = FoP.Nama_CSR
WHERE Phase = 2 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post test' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Februari 2024'

Select Avg(Score) as Avg_score
From bimbel
JOIN FoP
ON Bimbel.[Nama Petugas] = FoP.Nama_CSR
where [level] = 'BASIC' AND Phase = 2 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post test' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Februari 2024'

Select Avg(Score) as Avg_score
From bimbel
JOIN FoP
ON Bimbel.[Nama Petugas] = FoP.Nama_CSR
where [level] = 'Intermediate' AND Phase = 2 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post test' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Februari 2024'

Select Avg(Score) as Avg_score
From bimbel
JOIN FoP
ON Bimbel.[Nama Petugas] = FoP.Nama_CSR
where [level] = 'Advance' AND Phase = 2 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post test' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Februari 2024'

Select Avg(Score) as Avg_score
From bimbel
JOIN FoP
ON Bimbel.[Nama Petugas] = FoP.Nama_CSR
where [level] = 'Expert' AND Phase = 2 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post test' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Februari 2024'

Select Avg(Score) as Avg_score
From bimbel
JOIN FoP
ON Bimbel.[Nama Petugas] = FoP.Nama_CSR
where bimbel.Jenis_CTP = 'Household' AND Phase = 2 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post test' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Februari 2024'

Select Avg(Score) as Avg_score
From bimbel
JOIN FoP
ON Bimbel.[Nama Petugas] = FoP.Nama_CSR
where bimbel.Jenis_CTP = 'Telkomsel' AND Phase = 2 AND Jenis_bimbel = 'Hard Skill' AND Test = 'Post test' AND FoP.Nama_kuadran = 'LOLOCO' AND FoP.Periode = 'Februari 2024'

ALTER TABLE Bimbel
ADD Bobot FLOAT

UPDATE bimbel
SET Bobot = 0.4 * Score
where Phase = 2 AND test = 'Post test' AND jenis_bimbel = 'hard skill'

select * from bimbel
where kuartal = 2
--Final score
Select B.[nama petugas],B.[Level], B.GraPARI,F.Nama_kuadran, B.Bobot as bobot_bimbel, F.Bobot as bobot_fgd, (B.Bobot + F.Bobot) as Final_score
FROM bimbel as B
JOIN FGD as F
On B.[Nama Petugas] = F.Nama_Csr
WHERE B.Phase = 2 AND B.test = 'Post test' AND B.jenis_bimbel = 'hard skill' AND F.Kehadiran = 'Hadir FGD' AND Nama_kuadran = 'LOLOCO'
order by Final_score DESC

select * from FGD
where Nama_Csr LIKE '%nasrul%'
Where Kehadiran = 'Hadir FGD'
order by bobot


select DISTINCT bimbel.[Nama Petugas], fop.Nama_kuadran from bimbel
JOIN FoP
ON bimbel.[Nama Petugas] = Fop. Nama_CSR
where bimbel.Aktif_Phase_2 = 'Ya' AND FoP.Periode = 'Februari 2024' AND FoP.Nama_kuadran = 'LOHACO'

select * from bimbel

--Persentase kelulusan
SELECT 
    'GraPARI' AS LevelType,
    GraPARI AS Level,
    SUM(CASE WHEN Score >= 90 THEN 1 ELSE 0 END) AS JumlahLulus,
    COUNT(*) AS TotalPeserta,
    CAST(ROUND((CAST(SUM(CASE WHEN Score >= 90 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100, 2) AS VARCHAR(10)) + '%' AS PersentaseLulus
FROM 
    bimbel
WHERE
	Kuartal = 2 AND Test = 'Post test' AND Jenis_bimbel = 'Hard Skill'
GROUP BY 
    GraPARI
UNION ALL
SELECT 
    'Area' AS LevelType,
    Area AS Level,
    SUM(CASE WHEN Score >= 90 THEN 1 ELSE 0 END) AS JumlahLulus,
    COUNT(*) AS TotalPeserta,
    CAST(ROUND((CAST(SUM(CASE WHEN Score >= 90 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100, 2) AS VARCHAR(10)) + '%' AS PersentaseLulus
FROM 
    bimbel
WHERE
	Kuartal = 2 AND Test = 'Post test' AND Jenis_bimbel = 'Hard Skill'
GROUP BY 
    Area
UNION ALL
SELECT 
    'Regional' AS LevelType,
    Regional AS Level,
    SUM(CASE WHEN Score >= 90 THEN 1 ELSE 0 END) AS JumlahLulus,
    COUNT(*) AS TotalPeserta,
    CAST(ROUND((CAST(SUM(CASE WHEN Score >= 90 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100, 2) AS VARCHAR(10)) + '%' AS PersentaseLulus
FROM 
    bimbel
WHERE
	Kuartal = 2 AND Test = 'Post test' AND Jenis_bimbel = 'Hard Skill'
GROUP BY 
    Regional;

--Persentase kelulusan all 
SELECT 
    GraPARI,
    Regional,
	Area,
    SUM(CASE WHEN Score >= 90 THEN 1 ELSE 0 END) AS JumlahLulus,
    COUNT(*) AS TotalPeserta,
    CAST(ROUND((CAST(SUM(CASE WHEN Score >= 90 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100, 2) AS VARCHAR(10)) + '%' AS PersentaseLulus
FROM 
    bimbel
WHERE
	Kuartal = 2 AND Test = 'Post test' AND Jenis_bimbel = 'Hard Skill' 
GROUP BY 
    Regional,
	GraPARI,
	Area;

SELECT * from bimbel
where GraPARI LIKE '%Yogyakarta%' AND Kuartal = 2 AND test = 'Post Test' AND Jenis_bimbel = 'Hard skill'

select * from Employee
where Nama LIKE '%Milzam Abi Jabbar%'

select * from Employee
where GraPARI = 'GraPARI Yogyakarta Yos Sudarso'

select * from bimbel
where [Nama Petugas] LIKE '%Andreas Hendra Prijatna%'

UPDATE bimbel
SET [Nama Petugas] = 'Cherry Vyoline Baso'
WHERE [Nama Petugas] = 'Cherry Vyolline Baso'

UPDATE Employee
SET Regional = 'Jawa Tengah Western'
WHERE Nama = 'Andreas Hendra Prijatna'

