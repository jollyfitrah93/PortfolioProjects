UPDATE Fivas
SET Fivas.unit_name = ccis.unit_name
FROM Fivas
JOIN GrapariData..ccis
ON Fivas.user_id = ccis.EMPLOYEE_CODE OR fivas.employee_name = ccis.EMPLOYEE_NAME
where MONTH(fivas.tanggal) = 4 AND MONTH(ccis.Update_stamp) = 4 AND fivas.unit_name = '-'

Select * from Fivas
where unit_name = '-'

ALTER TABLE Fivas
DROP COLUMN customer_type, description, customer_subtype,order_action_type,subscription_trans_type_desc,order_status, order_reason

--total paket yang di aktivasi dan revenuenya
SELECT
    order_type_name,	
    COUNT(*) AS Count_aktivasi,
    SUM(order_act_amount) AS Revenue
FROM 
    Fivas
GROUP BY 
    order_type_name
ORDER BY Count_aktivasi DESC;


select * from Fivas
where order_type_name = 'Zoom Pro 15GB'

