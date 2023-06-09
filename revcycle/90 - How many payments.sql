SELECT TOP 5 COUNT(*) AS [Number of Payments]
FROM analytics.claim_transaction
WHERE is_payment = 'Y'
