select * from ccis
where unit_name = 'GraPARI Banjar' AND [service] = 'P' AND topic_result LIKE '%ganti%'

select [trx Date], Regional, [Nama Grapari], MSISDN, [User ID], Nama_CSR, serving_duration_converted as serving_time from visit
where serving_duration_converted > '03:00:00'
order by serving_duration_converted desc

select [trx Date], Regional, [Nama Grapari], MSISDN, [User ID], Nama_CSR, waiting_duration_converted as waiting_time from visit
where waiting_duration_converted > '02:00:00'
order by waiting_duration_converted desc