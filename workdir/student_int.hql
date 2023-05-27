CREATE  DATABASE IF NOT EXISTS analytics COMMENT 'Holds anlaytical tables'
WITH DBPROPERTIES ('edited-by' = 'Naveen');

CREATE TABLE analytics.student_int(
    id INT,
    name STRING,
    dob DATE,
	hobbies ARRAY<STRING>,
	10_11_12_subject_marks ARRAY<STRING>,
	entrance_exams_scores MAP<String,INT>,
    address STRUCT<state:STRING,city:STRING,pincode:BIGINT>    
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
COLLECTION ITEMS TERMINATED BY '$'
MAP KEYS TERMINATED BY ':'
STORED AS TextFile
tblproperties (
"skip.header.line.count"="1",
"skip.footer.line.count"="1"
);


LOAD DATA LOCAL INPATH '/home/${env:USER}/workdir/student1.dat'
INTO TABLE analytics.student_int;


dfs -put -f /home/${env:USER}/workdir/student2.dat /;

LOAD DATA INPATH '/student2.dat' INTO TABLE analytics.student_int;

