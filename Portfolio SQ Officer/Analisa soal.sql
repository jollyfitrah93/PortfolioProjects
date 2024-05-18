SELECT 
    Area,
    Regional,
    SUM(CASE WHEN Question_1 = 'E-KTP (NIK&NO KK)' THEN 1 ELSE 0 END) as Total_benar_Q1,
    SUM(CASE WHEN Question_2 = 'Disney+ Hotstar' THEN 1 ELSE 0 END) as Total_benar_Q2,
    SUM(CASE WHEN Question_3 = 'Surat Sewa menyewa' THEN 1 ELSE 0 END) as Total_benar_Q3,
    SUM(CASE WHEN Question_4 = 'Isolir sementara' THEN 1 ELSE 0 END) as Total_benar_Q4,
    SUM(CASE WHEN Question_5 = 'Rp 500.000,- ' THEN 1 ELSE 0 END) as Total_benar_Q5,
    SUM(CASE WHEN Question_6 = '2x MF' THEN 1 ELSE 0 END) as Total_benar_Q6,
    SUM(CASE WHEN Question_7 = 'Pastikan mendapatkan catuan daya listrik' THEN 1 ELSE 0 END) as Total_benar_Q7,
    SUM(CASE WHEN Question_8 = 'Restart ONT' THEN 1 ELSE 0 END) as Total_benar_Q8,
    SUM(CASE WHEN Question_9 = '3X24 Jam' THEN 1 ELSE 0 END) as Total_benar_Q9,
    SUM(CASE WHEN Question_10 = 'Tidak ada Perubahan jumlah tagihan yang akan terjadi pada tagihan berikutnya' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM 
    Bimbel
WHERE 
    Phase = 1 
    AND Jenis_bimbel = 'Hard Skill' 
    AND Test = 'Post Test' 
    AND Kuartal = 2 
    AND hari_bimbel = 'Day 2'
GROUP BY 
    Area,
    Regional
ORDER BY 
	Area;

SELECT 
    Area,
    Regional,
	Hari_bimbel,
    SUM(CASE WHEN Q1 = 'Benar' THEN 1 ELSE 0 END) as Total_benar_Q1,
    SUM(CASE WHEN Q2 = 'Benar' THEN 1 ELSE 0 END) as Total_benar_Q2,
    SUM(CASE WHEN Q3 = 'Benar' THEN 1 ELSE 0 END) as Total_benar_Q3,
    SUM(CASE WHEN Q4 = 'Benar' THEN 1 ELSE 0 END) as Total_benar_Q4,
    SUM(CASE WHEN Q5 = 'Benar' THEN 1 ELSE 0 END) as Total_benar_Q5,
    SUM(CASE WHEN Q6 = 'Benar' THEN 1 ELSE 0 END) as Total_benar_Q6,
    SUM(CASE WHEN Q7 = 'Benar' THEN 1 ELSE 0 END) as Total_benar_Q7,
    SUM(CASE WHEN Q8 = 'Benar' THEN 1 ELSE 0 END) as Total_benar_Q8,
    SUM(CASE WHEN Q9 = 'Benar' THEN 1 ELSE 0 END) as Total_benar_Q9,
    SUM(CASE WHEN Q10 ='Benar' THEN 1 ELSE 0 END) as Total_benar_Q10
FROM 
    AnalisaSoal
WHERE 
    Test = 'Post Test' 
GROUP BY 
    Area,
    Regional,
	Hari_bimbel
ORDER BY 
	Area;


SELECT 
    Area,
    Regional,
	Hari_bimbel,
    SUM(CASE WHEN Q1 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q1,
    SUM(CASE WHEN Q2 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q2,
    SUM(CASE WHEN Q3 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q3,
    SUM(CASE WHEN Q4 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q4,
    SUM(CASE WHEN Q5 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q5,
    SUM(CASE WHEN Q6 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q6,
    SUM(CASE WHEN Q7 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q7,
    SUM(CASE WHEN Q8 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q8,
    SUM(CASE WHEN Q9 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q9,
    SUM(CASE WHEN Q10 ='Salah' THEN 1 ELSE 0 END) as Total_Salah_Q10
FROM 
    AnalisaSoal
WHERE 
    Test = 'Post Test' 
GROUP BY 
    Area,
    Regional,
	Hari_bimbel
ORDER BY 
	Area;

SELECT * From analisasoal

SELECT * from soalbimbel
order by NO

ALTER TABLE soalbimbel
ADD Alias NVARCHAR(255)

UPDATE soalbimbel
SET Alias = 
    CASE 
        WHEN CAST(NO AS INT) % 10 = 1 THEN 'Q1'
        WHEN CAST(NO AS INT) % 10 = 2 THEN 'Q2'
        WHEN CAST(NO AS INT) % 10 = 3 THEN 'Q3'
        WHEN CAST(NO AS INT) % 10 = 4 THEN 'Q4'
        WHEN CAST(NO AS INT) % 10 = 5 THEN 'Q5'
        WHEN CAST(NO AS INT) % 10 = 6 THEN 'Q6'
        WHEN CAST(NO AS INT) % 10 = 7 THEN 'Q7'
        WHEN CAST(NO AS INT) % 10 = 8 THEN 'Q8'
        WHEN CAST(NO AS INT) % 10 = 9 THEN 'Q9'
        WHEN CAST(NO AS INT) % 10 = 0 THEN 'Q10'
    END

SELECT 
    Area,
    Regional,
    Hari_bimbel,
    SUM(CASE WHEN Materi = 'PSB Indihome (Fixed)' THEN Total_Salah ELSE 0 END) as Total_Salah_PSBI,
    SUM(CASE WHEN Materi = 'Berhenti Berlangganan Indihome (Fixed)' THEN Total_Salah ELSE 0 END) as Total_Salah_BBIndihome,
    SUM(CASE WHEN Materi = 'CLS Telkomsel (Mobile)' THEN Total_Salah ELSE 0 END) as Total_Salah_CLSTelkomsel,
    SUM(CASE WHEN Materi = 'Komplain - Internet tidak bisa koneksi (Pansol)' THEN Total_Salah ELSE 0 END) as Total_Salah_Komplain,
    SUM(CASE WHEN Materi = 'Migrasi paket Indihome (Fixed)' THEN Total_Salah ELSE 0 END) as Total_Salah_Migrasi
FROM (
    SELECT 
        Area,
        Regional,
        Hari_bimbel,
        CASE 
            WHEN Q1 = 'Salah' AND Q2 = 'Salah' THEN 'PSB Indihome (Fixed)'
            WHEN Q3 = 'Salah' AND Q4 = 'Salah' THEN 'Berhenti Berlangganan Indihome (Fixed)'
            WHEN Q5 = 'Salah' AND Q6 = 'Salah' THEN 'CLS Telkomsel (Mobile)'
            WHEN Q7 = 'Salah' AND Q8 = 'Salah' THEN 'Komplain - Internet tidak bisa koneksi (Pansol)'
            WHEN Q9 = 'Salah' AND Q10 = 'Salah' THEN 'Migrasi paket Indihome (Fixed)'
            ELSE 'Others'
        END as Materi,
        SUM(CASE WHEN Q1 = 'Salah' OR Q2 = 'Salah' 
                 OR Q3 = 'Salah' OR Q4 = 'Salah' 
                 OR Q5 = 'Salah' OR Q6 = 'Salah' 
                 OR Q7 = 'Salah' OR Q8 = 'Salah' 
                 OR Q9 = 'Salah' OR Q10 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah
    FROM 
        AnalisaSoal
    WHERE 
        Test = 'Post Test' 
    GROUP BY 
        Area,
        Regional,
        Hari_bimbel,
        CASE 
            WHEN Q1 = 'Salah' AND Q2 = 'Salah' THEN 'PSB Indihome (Fixed)'
            WHEN Q3 = 'Salah' AND Q4 = 'Salah' THEN 'Berhenti Berlangganan Indihome (Fixed)'
            WHEN Q5 = 'Salah' AND Q6 = 'Salah' THEN 'CLS Telkomsel (Mobile)'
            WHEN Q7 = 'Salah' AND Q8 = 'Salah' THEN 'Komplain - Internet tidak bisa koneksi (Pansol)'
            WHEN Q9 = 'Salah' AND Q10 = 'Salah' THEN 'Migrasi paket Indihome (Fixed)'
            ELSE 'Others'
        END
) AS SubQuery
GROUP BY 
    Area,
    Regional,
    Hari_bimbel
ORDER BY 
    Area;

	SELECT 
    Area,
    Regional,
	Hari_bimbel,
    SUM(CASE WHEN Q1 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q1,
    SUM(CASE WHEN Q2 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q2,
    SUM(CASE WHEN Q3 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q3,
    SUM(CASE WHEN Q4 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q4,
    SUM(CASE WHEN Q5 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q5,
    SUM(CASE WHEN Q6 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q6,
    SUM(CASE WHEN Q7 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q7,
    SUM(CASE WHEN Q8 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q8,
    SUM(CASE WHEN Q9 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Q9,
    SUM(CASE WHEN Q10 ='Salah' THEN 1 ELSE 0 END) as Total_Salah_Q10
FROM 
    AnalisaSoal
WHERE 
    Test = 'Post Test' 
GROUP BY 
    Area,
    Regional,
	Hari_bimbel
ORDER BY 
	Area;

SELECT 
    Area,
    Regional,
    SUM(CASE WHEN Q1 = 'Salah' THEN 1 ELSE 0 END + CASE WHEN Q2 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_PSB_Indihome,
    SUM(CASE WHEN Q3 = 'Salah' THEN 1 ELSE 0 END + CASE WHEN Q4 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Berhenti_Berlangganan_Indihome,
    SUM(CASE WHEN Q5 = 'Salah' THEN 1 ELSE 0 END + CASE WHEN Q6 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_CLS_Telkomsel,
    SUM(CASE WHEN Q7 = 'Salah' THEN 1 ELSE 0 END + CASE WHEN Q8 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Komplain_internet_tidak_bisa_koneksi,
    SUM(CASE WHEN Q9 = 'Salah' THEN 1 ELSE 0 END + CASE WHEN Q10 = 'Salah' THEN 1 ELSE 0 END) as Total_Salah_Migrasi_Paket_Indihome
FROM 
    AnalisaSoal
WHERE 
    Test = 'Post Test' 
GROUP BY 
    Area,
    Regional
ORDER BY 
    Area;