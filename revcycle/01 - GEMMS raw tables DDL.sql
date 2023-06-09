DROP TABLE  [GEMMS].[claim];
CREATE TABLE [GEMMS].[claim] (
    [COMPANY] varchar(10),
    [CLAIMID] int,
    [INCIDENTNO] int,
    [ACCOUNT] varchar(10),
    [ADMDATE] datetime,
    [DIAG1] varchar(10),
    [DIAG2] varchar(10),
    [DIAG3] varchar(10),
    [DIAG4] varchar(10),
    [DIAGDESC1] varchar(60),
    [DIAGDESC2] varchar(60),
    [DIAGDESC3] varchar(60),
    [DIAGDESC4] varchar(60),
    [REFERRAL] varchar(15),
    [FACCODE] varchar(15),
    [PINUM] smallint,
    [SINUM] smallint,
    [TINUM] smallint
);

DROP TABLE  [GEMMS].[charge];
CREATE TABLE [GEMMS].[charge] (
    [COMPANY] varchar(10),
    [CLAIMID] int,
    [INCIDENTNO] int,
    [ACCOUNT] varchar(10),
    [CHGID] int,
    [XACDATE] datetime,
    [XACDATE2] datetime,
    [LINESEQNO] int,
    [BILLDATE] datetime,
    [BILLDATE2] datetime,
    [BILLED] varchar(1),
    [XACCODE] varchar(5),
    [CPT] varchar(10),
    [CPTPRINT] varchar(15),
    [MODIFIER] varchar(10),
    [PROCDESC] varchar(60),
    [ICD9] varchar(10),
    [DIAGNOSIS] varchar(60),
    [DIAGPTR1] varchar(2),
    [DIAGPTR2] varchar(2),
    [DIAGPTR3] varchar(2),
    [CUNITS] numeric(6,1),
    [PROVIDER] varchar(10),
    [RDOC] varchar(10),
    [STATUS] varchar(1),
    [FACILITY] varchar(15),
    [BATCHID] int,
    [ASSIGN] varchar(1),
    [CHGAMOUNT] money,
    [CHGALLOWED] money,
    [PAYINS1] money,
    [PAYINS2] money,
    [PAYINS3] money,
    [PAYGUAR] money,
    [ADJUST] money,
    [WRITEOFF] money,
    [COPAY] money,
    [ONACCT] money,
    [DEDUCTIBLE] money,
    [PSMODIFIER] varchar(4),
    [PSUNITS] int,
    [ELAPSED] varchar(20),
    [ELAPSEDUNITS] numeric(6,1),
    [BASEUNITS] int,
    [LASTPAID] datetime,
    [OUTSIDELAB] varchar(1),
    [LABAMOUNT] money,
    [ERRORCODE] varchar(10),
    [PURGECODE] varchar(1),
    [USERCODE] varchar(10),
    [PATDATE] datetime,
    [BILLINS] varchar(1),
    [DENYCODE] varchar(80),
    [DENYDATE] datetime,
    [FEETYPE] varchar(10),
    [PTYPE] varchar(10),
    [NOTEFLAG] varchar(1),
    [ENTRYDATE] datetime,
    [REMARK] varchar(255),
    [RESPONSIBLE] varchar(1)
);

DROP TABLE  [GEMMS].[transaction];
CREATE TABLE [GEMMS].[transaction] (
    [COMPANY] varchar(10),
    [PAYID] int,
    [CHGID] int,
    [SSNO] varchar(15),
    [ACCOUNT] varchar(10),
    [CLAIMID] int,
    [BATCHID] int,
    [PAYDATE] datetime,
    [XACDATE] datetime,
    [PAYORCODE] varchar(5),
    [DC] varchar(2),
    [XACAMOUNT] money,
    [STATUS] varchar(1),
    [PURGECODE] varchar(1),
    [CHECKID] int,
    [USERCODE] varchar(10),
    [ENTRYDATE] datetime,
    [PLOCATION] varchar(10),
    [USERPAYCODE] varchar(10),
    [DELETED] datetime,
    [DELUSER] varchar(10),
    [INSCODE] varchar(15)
)

DROP TABLE [GEMMS].[remittance];
CREATE TABLE [GEMMS].[remittance] (
    [COMPANY] varchar(10),
    [ACCOUNT] varchar(10),
    [CHGID] int,
    [RECID] int,
    [MSGTYPE] varchar(1),
    [CHECKID] varchar(50),
    [PAYDATE] datetime,
    [REASON] varchar(15),
    [XACAMOUNT] money,
    [CDESC] varchar(255)
)

DROP TABLE  [GEMMS].[payment_detail];
CREATE TABLE [GEMMS].[payment_detail] (
    [COMPANY] varchar(10),
    [CHECKID] int,
    [PAYDATE] datetime,
    [PAYTYPE] varchar(3),
    [DESCRIPTION] varchar(50),
    [CHECKAMOUNT] money,
    [USERCODE] varchar(10),
    [ENTRYDATE] datetime,
    [STATUS] varchar(1),
    [PURGECODE] varchar(1),
    [PAYSOURCE] varchar(1)
)

DROP TABLE [gemms].[claim_payer]
CREATE TABLE [gemms].[claim_payer] (
    [COMPANY] varchar(10),
    [ACCOUNT] varchar(10),
    [INUM] smallint,
    [POLICYNO] varchar(30),
    [INSCODE] varchar(15),
    [RELATION] varchar(1),
    [IPRIMARY] varchar(1)
)

DROP TABLE [gemms].[insurer]
CREATE TABLE [gemms].[insurer] (
    [COMPANY] varchar(10),
    [SKEY] varchar(1),
    [CODE] varchar(15),
    [NAME] varchar(40),
    [FEETYPE] varchar(10)
)

DROP TABLE [gemms].[claim_history]
CREATE TABLE [gemms].[claim_history] (
    [COMPANY] varchar(10),
    [RUNDATE] datetime,
    [RUNID] int,
    [PLANTYPE] varchar(15),
    [PROVID] varchar(30),
    [RDOC] varchar(10),
    [ACCOUNT] varchar(10),
    [INCIDENTNO] int,
    [CHGID] int,
    [XACDATE] datetime,
    [CLAIMID] int,
    [INUM] smallint,
    [INSCODE] varchar(15),
    [FORM] varchar(3),
    [CPTPRINT] varchar(15),
    [RECID] uniqueidentifier
)