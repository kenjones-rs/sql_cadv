-- Update claims with payer codes
UPDATE claim
SET primary_payer_code = claim_payer.payer_code
FROM analytics.claim
JOIN analytics.claim_payer ON claim.patient_id = claim_payer.patient_id AND claim.primary_payer_index = claim_payer.payer_index;

UPDATE claim
SET secondary_payer_code = claim_payer.payer_code
FROM analytics.claim
JOIN analytics.claim_payer ON claim.patient_id = claim_payer.patient_id AND claim.secondary_payer_index = claim_payer.payer_index;

UPDATE claim
SET tertiary_payer_code = claim_payer.payer_code
FROM analytics.claim
JOIN analytics.claim_payer ON claim.patient_id = claim_payer.patient_id AND claim.tertiary_payer_index = claim_payer.payer_index;

-- Determine charge errors
UPDATE C
SET is_charge_error = 'Y'
FROM analytics.charge C
JOIN analytics.claim_transaction T ON C.charge_id = T.charge_id and T.is_charge_error = 'Y';

-- Summarize payments/adjustments by charge
UPDATE C
SET guarantor_payment_amount = S.guarantor_payment_amount,
primary_payer_payment_amount = S.primary_payer_payment_amount,
secondary_payer_payment_amount = S.secondary_payer_payment_amount,
contractual_adjustment_amount = S.contractual_adjustment_amount,
non_contractual_adjustment_amount = S.non_contractual_adjustment_amount
FROM analytics.charge C
JOIN
(SELECT charge_id,
SUM(guarantor_payment_amount) AS guarantor_payment_amount,
SUM(primary_payer_payment_amount) AS primary_payer_payment_amount,
SUM(secondary_payer_payment_amount) AS secondary_payer_payment_amount,
SUM(contractual_adjustment_amount) AS contractual_adjustment_amount,
SUM(non_contractual_adjustment_amount) AS non_contractual_adjustment_amount
FROM
(SELECT charge_id,
CASE
  WHEN is_guarantor_payment = 'Y' THEN transaction_amount
  ELSE 0
END AS guarantor_payment_amount,
CASE
  WHEN is_primary_payer_payment = 'Y' THEN transaction_amount
  ELSE 0
END AS primary_payer_payment_amount,
CASE
  WHEN is_secondary_payer_payment = 'Y' THEN transaction_amount
  ELSE 0
END AS secondary_payer_payment_amount,
CASE
  WHEN is_disallowance_adjustment = 'Y' THEN transaction_amount
  ELSE 0
END AS contractual_adjustment_amount,
CASE
  WHEN is_adjustment = 'Y' and is_disallowance_adjustment = 'N' THEN transaction_amount
  ELSE 0
END AS non_contractual_adjustment_amount
FROM analytics.claim_transaction
WHERE is_charge_error = 'N') T
GROUP BY charge_id) S
ON C.charge_id = S.charge_id;

-- calculate outstanding amount / credit amount
UPDATE analytics.charge
SET outstanding_amount = charged_amount - 
	(guarantor_payment_amount + primary_payer_payment_amount + secondary_payer_payment_amount +
	contractual_adjustment_amount + non_contractual_adjustment_amount);


-- Roll up outstanding to claim
UPDATE claim
SET outstanding_amount = charge_summary.outstanding_amount
FROM analytics.claim
JOIN
(SELECT claim_id,
SUM(outstanding_amount) AS outstanding_amount
FROM analytics.charge
GROUP BY claim_id) charge_summary
ON claim.claim_id = charge_summary.claim_id;


-- update for credit balances
UPDATE analytics.charge
SET credit_amount = outstanding_amount,
outstanding_amount = 0
where outstanding_amount < 0;





--select count(*) from analytics.charge
--where outstanding_amount = 0;

--select count(*) from analytics.charge
--where outstanding_amount > 0;

--select count(*) from analytics.charge
--where outstanding_amount < 0;

--select * from analytics.charge
--where outstanding_amount > 0;
