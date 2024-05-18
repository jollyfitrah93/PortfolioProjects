select * from PLCSR

SELECT 
    CONCAT(ROUND(AVG([Seragam_(5%)] * 100), 2), '%') AS Seragam_5,
    CONCAT(ROUND(AVG([Grooming_(5%)] * 100), 2), '%') AS Grooming_5,
    CONCAT(ROUND(AVG([Informatif(5%)] * 100), 2), '%') AS Informatif_5,
    CONCAT(ROUND(AVG([Sikap Layanan_(5%)] * 100), 2), '%') AS Sikap_layanan_5,
    CONCAT(ROUND(AVG([Problem Solving_(5%)] * 100), 2), '%') AS Alat_pendukung_5,
    CONCAT(ROUND(AVG([Edukasi/feedback pelanggan_(5%)] * 100), 2), '%') AS Edukasi_layanan_5,
    CONCAT(ROUND(AVG([Pendengar yang baik(5%)] * 100), 2), '%') AS Pendengar_yg_baik_5,
    CONCAT(ROUND(AVG([Magic Word(5%)] * 100), 2), '%') AS Magic_word_5,
    CONCAT(ROUND(AVG([Identifikasi dan analisa masalah_(5%)] * 100), 2), '%') AS Identifikasi_dan_analisa_masalah_5,
    CONCAT(ROUND(AVG([case_eskalasi(5%)] * 100), 2), '%') AS case_eskalasi_5,
    CONCAT(ROUND(AVG([Kejelasan Informasi(5%)] * 100), 2), '%') AS kejelasan_informasi_5,
    CONCAT(ROUND(AVG([Kestabilan emosi_(10%)] * 100), 2), '%') AS kestabilan_emosi_10,
    CONCAT(ROUND(AVG([Alternatif Solusi_(5%)] * 100), 2), '%') AS alternatif_solusi_5,
    CONCAT(ROUND(AVG([Cross Selling(5%)] * 100), 2), '%') AS cross_selling_5,
    CONCAT(ROUND(AVG([FCR(5%)] * 100), 2), '%') AS FCR_5,
    CONCAT(ROUND(AVG([Akurasi_KIP(5%)] * 100), 2), '%') AS akurasi_KIP_5,
    CONCAT(ROUND(AVG([brief_debrief(5%)] * 100), 2), '%') AS brief_debrief_5,
    CONCAT(ROUND(AVG([Responsif(5%)] * 100), 2), '%') AS Responsif_5,
    CONCAT(ROUND(AVG([Alat_pendukung(2%)] * 100), 2), '%') AS Alat_pendukung_2,
    CONCAT(ROUND(AVG([Pdp(3%)] * 100), 2), '%') AS pdp_3,
    CONCAT(ROUND(AVG([Problem Solving_(5%)] * 100), 2), '%') AS problem_solver_5
FROM PLCSR;

