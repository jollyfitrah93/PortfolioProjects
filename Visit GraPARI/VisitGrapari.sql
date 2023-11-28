--SELECT * 
--FROM Visit

--DELETE FROM Visit
--WHERE [User ID] is null


--ALTER TABLE Visit
--ADD Nama_CSR NVARCHAR(255);

--SELECT [User ID], Nama_CSR,
--	CASE
--		WHEN [User ID] = 22248352 THEN 'Gatry Pertiwi'
--		WHEN [User ID] = 21239567 THEN 'Agista Anduarima'
--		WHEN [User ID] = 20235978 THEN 'Mayang Sari'
--		WHEN [User ID] = 20235977 THEN 'Risky Ramdanu'
--		WHEN [User ID] = 23256701 THEN 'Dewi Shinta Rahayu'
--		WHEN [User ID] = 23256702 THEN 'Wenni Wilman Putri'
--		WHEN [User ID] = 23259363 THEN 'Turiyan'
--	ELSE 'Invalid User ID'
--	END AS Nama_CSR
--FROM Visit

--UPDATE Visit
--SET Nama_CSR = CASE
--		WHEN [User ID] = 22248352 THEN 'Gatry Pertiwi'
--		WHEN [User ID] = 21239567 THEN 'Agista Anduarima'
--		WHEN [User ID] = 20235978 THEN 'Mayang Sari'
--		WHEN [User ID] = 20235977 THEN 'Risky Ramdanu'
--		WHEN [User ID] = 23256702 THEN 'Dewi Shinta Rahayu'
--		WHEN [User ID] = 23256701 THEN 'Wenni Wilman Putri'
--		WHEN [User ID] = 23259363 THEN 'Turiyan'
--		WHEN [User ID] = 23254901 THEN 'Resty Halipi'
--	ELSE 'Invalid User ID'
--	END

--ALTER TABLE Visit
--ADD issued_time_converted TIME;

--UPDATE Visit
--SET issued_time_converted = CONVERT(TIME,[Issued Time])

--ALTER TABLE Visit
--ADD call_time_converted TIME;

--UPDATE Visit
--SET call_time_converted = CONVERT(TIME,[Call Time])

--ALTER TABLE Visit
--ADD start_serve_time_converted TIME;

--UPDATE Visit
--SET start_serve_time_converted = CONVERT(TIME,[Start Serve Time])

--ALTER TABLE Visit
--ADD End_serve_time_converted TIME;

--UPDATE Visit
--SET End_serve_time_converted = CONVERT(TIME,[End Serve Time])

--ALTER TABLE Visit
--ADD waiting_duration_converted TIME;

--UPDATE Visit
--SET waiting_duration_converted = CONVERT(TIME,[Waiting Duration])

--ALTER TABLE Visit
--ADD	serving_duration_converted TIME;

--UPDATE Visit
--SET serving_duration_converted = CONVERT(TIME,[Serving Duration])

--ALTER TABLE PersonalProject.dbo.Visit
--ADD Trx_Date_converted DATE

--UPDATE Visit
--SET Trx_Date_converted = CONVERT(DATE, [Trx Date])




--select 
--  cast(cast(avg(cast(CAST([Serving Duration] as datetime) as float)) as datetime) as time) AvgTime,
--  cast(cast(sum(cast(CAST([Serving Duration] as datetime) as float)) as datetime) as time) TotalTime
--from Visit;


--select 
--  cast(cast(avg(cast(CAST([Waiting Duration] as datetime) as float)) as datetime) as time) AvgTime,
--  cast(cast(sum(cast(CAST([Waiting Duration] as datetime) as float)) as datetime) as time) TotalTime
--from Visit;

SELECT *
FROM Visit	

SELECT Trx_Date_converted, DATEPART(MONTH, Trx_Date_converted) as MonthNumber
FROM Visit