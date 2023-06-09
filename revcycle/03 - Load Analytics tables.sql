use POC
go

-- Load claim table
truncate table analytics.claim;
insert into analytics.claim
(claim_id,
patient_id,
incident_number,
admit_date,
diagnosis1_code,
diagnosis2_code,
diagnosis3_code,
diagnosis4_code,
facility_code,
primary_payer_index,
secondary_payer_index,
tertiary_payer_index)
SELECT COMPANY + '::' + ACCOUNT + '::' + CAST(INCIDENTNO as varchar(20)) AS claim_id,
ACCOUNT as patient_id,
INCIDENTNO as incident_number,
ADMDATE as admit_date,
ISNULL(DIAG1,'') as diagnosis1_code,
ISNULL(DIAG2,'') as diagnosis2_code,
ISNULL(DIAG3,'') as diagnosis3_code,
ISNULL(DIAG4,'') as diagnosis4_code,
ISNULL(FACCODE,'') as facility_code,
PINUM as primary_payer_index,
SINUM as secondary_payer_index,
TINUM as tertiary_payer_index
FROM POC.gemms.claim;

-- Load charge table
truncate table analytics.charge;
insert into analytics.charge
(claim_id,
line_number,
charge_id,
patient_id,
service_date,
posted_date,
procedure_code,
modifier1,
service_units,
charged_amount,
approved_amount
--copay_amount,
--deductible_amount,
--coinsurance_amount,
)
SELECT COMPANY + '::' + ACCOUNT + '::' + CAST(INCIDENTNO as varchar(20)) AS claim_id,
LINESEQNO as line_number,
COMPANY + '::' + CAST(CHGID as varchar(20)) AS charge_id,
ACCOUNT as patient_id,
ISNULL(XACDATE,'1/1/1900') as service_date,
ISNULL(ENTRYDATE,'1/1/1900') as posted_date,
ISNULL(CPT,'') as procedure_code,
ISNULL(MODIFIER,'') as modifier1,
ISNULL(CUNITS,0) as service_units,
ISNULL(CHGAMOUNT,0) as charged_amount,
ISNULL(CHGALLOWED,0) as approved_amount
FROM POC.gemms.charge;

-- Load transaction table
truncate table analytics.claim_transaction;
insert into analytics.claim_transaction
(transaction_id,
charge_id,
posted_date,
type_code,
payer_code,
is_adjustment,
is_disallowance_adjustment,
is_payment,
is_guarantor_payment,
is_payer_payment,
is_primary_payer_payment,
is_secondary_payer_payment,
is_charge_error,
is_deleted,
transaction_amount
)
SELECT PAYID as transaction_id,
COMPANY + '::' + CAST(CHGID as varchar(20)) AS charge_id,
ISNULL(ENTRYDATE,'1/1/1900') as posted_date,
PAYORCODE as type_code,
ISNULL(INSCODE,'') as payer_code,
CASE
  WHEN PAYORCODE IN ('GUAR','INS1','INS2','INS3','WCHEE') THEN 'N'
  ELSE 'Y'
END AS is_adjustment,
CASE
  WHEN PAYORCODE IN ('WDAL') THEN 'Y'
  ELSE 'N'
END AS is_disallowance_adjustment,
CASE
  WHEN PAYORCODE IN ('GUAR','INS1','INS2','INS3') THEN 'Y'
  ELSE 'N'
END AS is_payment,
CASE
  WHEN PAYORCODE IN ('GUAR') THEN 'Y'
  ELSE 'N'
END AS is_guarantor_payment,
CASE
  WHEN PAYORCODE IN ('INS1','INS2','INS3') THEN 'Y'
  ELSE 'N'
END AS is_payer_payment,
CASE
  WHEN PAYORCODE IN ('INS1') THEN 'Y'
  ELSE 'N'
END AS is_primary_payer_payment,
CASE
  WHEN PAYORCODE IN ('INS2','INS3') THEN 'Y'
  ELSE 'N'
END AS is_secondary_payer_payment,
CASE
  WHEN PAYORCODE IN ('WCHEE') THEN 'Y'
  ELSE 'N'
END AS is_charge_error,
CASE
  WHEN DELETED = '1/1/1900' THEN 'N'
  ELSE 'Y'
END as is_deleted,
ISNULL(XACAMOUNT,0) as transaction_amount
FROM POC.gemms.[transaction];

-- Load claim payer
truncate table analytics.claim_payer;
insert into analytics.claim_payer
(claim_id,
patient_id,
payer_index,
policy_number,
payer_code,
relationship_code,
primary_code)
SELECT COMPANY + '::' + ACCOUNT + '::' + CAST(INUM as varchar(20)) AS claim_id,
ACCOUNT as patient_id,
INUM as payer_index,
ISNULL(POLICYNO,'') as policy_number,
ISNULL(INSCODE,'') as payer_code,
ISNULL(RELATION,'') as relationship_code,
ISNULL(IPRIMARY,'') as primary_code
FROM POC.gemms.claim_payer;

truncate table analytics.claim_history;
insert into analytics.claim_history
(claim_id,
run_at,
run_id,
plan_type_code,
patient_id,
incident_number,
charge_id,
claim_seq_id,
payer_index,
payer_code,
form_code,
cpt_code,
record_id)
SELECT COMPANY + '::' + ACCOUNT + '::' + CAST(INCIDENTNO as varchar(20)) AS claim_id,
RUNDATE as run_at,
RUNID as run_id,
PLANTYPE as plan_type_code,
ACCOUNT as patient_id,
INCIDENTNO as incident_number,
COMPANY + '::' + CAST(CHGID as varchar(20)) AS charge_id,
CLAIMID as claim_seq_id,
INUM as payer_index,
INSCODE as payer_code,
FORM as form_code,
CPTPRINT as cpt_code,
RECID as record_id
FROM gemms.claim_history;

truncate table analytics.remittance;
insert into analytics.remittance
(charge_id,
patient_id,
record_id,
message_type_code,
payment_id,
payment_date,
ansi_reason_code,
amount)
SELECT COMPANY + '::' + CAST(CHGID as varchar(20)) AS charge_id,
ACCOUNT as patient_id,
RECID as record_id,
MSGTYPE as message_type_code,
CHECKID as payment_id,
PAYDATE as payment_date,
REASON ansi_reason_code,
XACAMOUNT as amount
FROM gemms.remittance;