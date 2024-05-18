select count(*) from PSB
select * from PSB
where employee_name = '-'
where unit_name  LIKE '%BSD%' and subscription_trans_type_desc IN ('PSB', 'Migrasi') AND MONTH(tanggal) = 3
ALTER TABLE PSB
DROP COLUMN customer_type, description, customer_subtype,order_action_type, order_status, order_reason, note_spv, sub_kategori;

select * from PSB

UPDATE PSB
SET PSB.unit_name = ccis.unit_name
FROM PSB
JOIN GrapariData..ccis
ON psb.user_id = ccis.EMPLOYEE_CODE OR psb.employee_name = ccis.EMPLOYEE_NAME
where MONTH(psb.tanggal) = 4 AND MONTH(ccis.Update_stamp) = 4 AND psb.unit_name = '-'

--Cek Nilai KKM CS by Cek_FOS
SELECT 
    employee_name, 
    COUNT(msisdn) AS total_trx,
    COUNT(CASE WHEN cek_fos = 'NOK' THEN 1 ELSE NULL END) AS count_cek_fos_nok,
    FORMAT((CAST(COUNT(CASE WHEN cek_fos = 'NOK' THEN 1 ELSE NULL END) AS FLOAT) / COUNT(msisdn)) * 100, '0.00') + '%' AS ratio_cek_fos_nok
FROM 
    PSB
GROUP BY 
    employee_name;


Select * from PSB
where order_act_amount > 1000000

UPDATE PSB
SET order_act_amount = 100000
WHERE order_id = '1030899800' AND tanggal = '2024-03-29'

select * from psb
WHERE order_id = '1030899800' AND tanggal = '2024-03-29'

UPDATE PSB
SET order_act_amount = CASE 
                            WHEN order_type_name IN ('Halo+ 120K', 'Halo+ Max 120K', 'New Halo+ 120K', 'Halo+ Kontrak 120k') THEN 120000
							WHEN order_type_name IN ('Halo+ 100K', 'Halo+ Max 100K', 'New Halo+ 100K', 'Halo+ Kontrak 100k') THEN 100000
							WHEN order_type_name IN ('Halo+ 140K', 'Halo+ Max 140K', 'New Halo+ 140K', 'Halo+ Kontrak 140k') THEN 140000
							WHEN order_type_name IN ('Halo+ 150K', 'Halo+ Max 150K', 'New Halo+ 150K', 'Halo+ Kontrak 150k') THEN 150000
							WHEN order_type_name IN ('Halo+ 250K', 'Halo+ Max 250K', 'New Halo+ 250K', 'Halo+ Kontrak 250k') THEN 250000
                            ELSE order_act_amount
                        END;

select * from PSB where order_act_amount > 1000000

select * from PSB
where unit_name = '-'

select * from TargetPSB
where GraPARI like '%BSD%'




