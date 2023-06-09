-- Load gemms tables from CSV files

truncate table POC.gemms.claim;

bulk insert POC.gemms.claim
from '\\dev02\Public\CADV\RevCycle\Data\claim.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

truncate table POC.gemms.charge;

bulk insert POC.gemms.charge
from '\\dev02\Public\CADV\RevCycle\Data\charge.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

truncate table POC.gemms.[transaction];

bulk insert POC.gemms.[transaction]
from '\\dev02\Public\CADV\RevCycle\Data\transaction.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

truncate table POC.gemms.remittance;

bulk insert POC.gemms.remittance
from '\\dev02\Public\CADV\RevCycle\Data\remittance.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

truncate table POC.gemms.payment_detail;

bulk insert POC.gemms.payment_detail
from '\\dev02\Public\CADV\RevCycle\Data\check.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

truncate table POC.gemms.claim_payer;

bulk insert POC.gemms.claim_payer
from '\\dev02\Public\CADV\RevCycle\Data\claim_payer.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

truncate table POC.gemms.insurer;

bulk insert POC.gemms.insurer
from '\\dev02\Public\CADV\RevCycle\Data\insurer.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)

truncate table POC.gemms.claim_history;

bulk insert POC.gemms.claim_history
from '\\dev02\Public\CADV\RevCycle\Data\claim_history.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)