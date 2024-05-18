Select * from soalbimbel

---Persentase jawaban benar pre test
SELECT NO, SOAL, CONCAT(ROUND(([Total benar pre test] / [Total peserta pre test]) * 100,2), '%') AS Persentase_Jawaban_Benar
FROM Soalbimbel;

---Persentase jawaban benar post test
SELECT NO, SOAL, CONCAT(ROUND(([Total benar post test] / [Total peserta post test]) * 100,2), '%') AS Persentase_Jawaban_Benar
FROM Soalbimbel;

--persentase increase_decrease
SELECT 
    sb.NO,
    sb.SOAL,
	CONCAT(ROUND((sb.[Total benar pre test] / sb.[Total peserta pre test]) * 100, 2), '%') AS Persentase_Jawaban_Benar_Pre_Test,
    CONCAT(ROUND((sb.[Total benar post test] / sb.[Total peserta post test]) * 100, 2), '%') AS Persentase_Jawaban_Benar_Post_Test,
    CONCAT(
        ROUND(((sb.[Total benar post test] / sb.[Total peserta post test]) - (sb.[Total benar pre test] / sb.[Total peserta pre test])) * 100, 2),
        '%'
    ) AS Persentase_Increase_Decrease
FROM 
    Soalbimbel sb;

UPDATE Soalbimbel
SET kuartal = 2
