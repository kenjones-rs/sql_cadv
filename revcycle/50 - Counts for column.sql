select PAYORCODE,count(*) as count
FROM [POC].[gemms].[transaction]
group by PAYORCODE
order by count(*) desc

