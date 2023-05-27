CREATE TABLE IF NOT EXISTS analytics.transaction_records(
    txnno INT,
    txndate STRING,
    custno INT,
    amount DOUBLE,
    category STRING,
    product STRING,
    city STRING,
    state STRING,
    spendby STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TextFile;

LOAD DATA LOCAL INPATH
'/home/${env:USER}/hands_on/hive_scripts/Transactions.txt'
INTO TABLE analytics.transaction_records;


CREATE TABLE IF NOT EXISTS analytics.transaction_records_partitioned(
    txnno INT,
    txndate STRING,
    custno INT,
    amount DOUBLE,
    product STRING,
    city STRING,
    state STRING,
    spendby STRING
)
PARTITIONED BY (CATEGORY STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TextFile;

FROM analytics.transaction_records txn
INSERT INTO TABLE analytics.transaction_records_partitioned PARTITION(category='Exercise & Fitness')
select
    txn.txnno,
    txn.txndate,
    txn.custno,
    txn.amount,
    txn.product,
    txn.city,
    txn.state,
    txn.spendby
where category='Exercise & Fitness';


FROM analytics.transaction_records txn
INSERT INTO TABLE analytics.transaction_records_partitioned PARTITION(category='Gymnastics')
select
    txn.txnno,
    txn.txndate,
    txn.custno,
    txn.amount,
    txn.product,
    txn.city,
    txn.state,
    txn.spendby
where category='Gymnastics';
