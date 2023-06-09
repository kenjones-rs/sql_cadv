select * from analytics.claim
where tertiary_payer_index <> 0;

where claim_id = 'MAIN::100050::85';

select * from analytics.charge
where charge_id = 'MAIN::100050::85';

--select * from analytics.claim_history
--where charge_id = 'MAIN::5389881';

select * from analytics.claim_payer
where patient_id = '161447';


select charge_id,count(*) as count
from analytics.claim_history
group by charge_id
having count(*) > 1;

select * from analytics.claim_history
where charge_id = 'MAIN::5349406';

-- credit balance
select * from analytics.charge
where charge_id = 'MAIN::5824395';

select * from analytics.claim_transaction
where charge_id = 'MAIN::5824395';

select * from analytics.remittance
where charge_id = 'MAIN::5824395';

-- Medicare claim, patient has not paid
select * from analytics.charge
where charge_id = 'MAIN::5501468';

select * from analytics.claim_transaction
where charge_id = 'MAIN::5501468';

select * from analytics.remittance
where charge_id = 'MAIN::5501468';