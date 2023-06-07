DROP database IF EXISTS SE;
create database SE;
use SE;

DROP table IF EXISTS 分店基本資料表;
create table 分店基本資料表(
	store_id varchar(4) PRIMARY KEY, 
	store_address varchar(512), 
    store_createtime DATETIME, 
    store_member INTEGER
);

DROP table IF EXISTS 業務基本資料表;
create table 業務基本資料表(
	Sp_id varchar(5) PRIMARY KEY, 
    Sp_bonus INTEGER,
    Sp_formula INTEGER,
	Sp_salary INTEGER,
    Sp_store varchar(4),
    Sp_address varchar(512), 
    Sp_tel varchar(12), 
    Sp_name varchar(15),
    Sp_lv varchar(10),
    FOREIGN KEY(Sp_id) REFERENCES 分店基本資料表(store_id)
);


DROP table IF EXISTS 產品基本資料表;
create table 產品基本資料表(
	product_id varchar(4) PRIMARY KEY, 
	product_name varchar(512), 
    product_price INTEGER, 
    product_status INTEGER,
    product_discript TEXT(512),
    product_type varchar(32),
    product_size FLOAT
);

DROP table IF EXISTS APP客戶資料表;
create table APP客戶資料表(
	Cus_id varchar(18) PRIMARY KEY, 
	Cus_date DATETIME,
    Cus_user varchar(512),
    Cus_pwd varchar(32),
    Voucher_count INTEGER,
    Cus_status INT,
    Referrer_id VARCHAR(18)
);

DROP table IF EXISTS 客戶業務資料表;
create table 客戶業務資料表(
	Cus_id varchar(18), 
    Sp_id varchar(5),
	Cus_FamilyNum INT,
    Cus_eld INT,
    Chair_status INT,
    Chair_floor INT,
    Chair_ceiling INT,
    Chair_position varchar(50),
    Chair_color varchar(50),
    Cus_PastItem varchar(520),
    Chair_power INT,
    product_past varchar(4),
    Cus_job varchar(50),
    PRIMARY KEY(Cus_id, Sp_id),
    FOREIGN KEY(Sp_id) REFERENCES 業務基本資料表(Sp_id),
    FOREIGN KEY(product_past) REFERENCES 產品基本資料表(product_id),
    FOREIGN KEY(Cus_id) REFERENCES APP客戶資料表(Cus_id)
);

DROP table IF EXISTS 儀錶板帳密資料表;
create table 儀錶板帳密資料表(
	storeboard_id varchar(18) PRIMARY KEY, 
    storeboard_time DATETIME,
	store_id VARCHAR(4),
    store_username VARCHAR(512),
    store_pwd VARCHAR(32),
    store_status INT,
    FOREIGN KEY(store_id) REFERENCES 分店基本資料表(store_id)
);

DROP table IF EXISTS 產品販售資料表;
create table 產品販售資料表(
	order_id varchar(22)PRIMARY KEY, 
	Sp_id varchar(5), 
    Cus_id varchar(18),
    FOREIGN KEY(Sp_id) REFERENCES 業務基本資料表(Sp_id),
    FOREIGN KEY(Cus_id) REFERENCES APP客戶資料表(Cus_id)
);

DROP table IF EXISTS 產品販售詳細資料表;
create table 產品販售詳細資料表(
	order_id varchar(22), 
	product_id varchar(4),
    order_time DATETIME,
    totalprice INTEGER,
    order_addr varchar(512),
    PRIMARY KEY(order_id, product_id),
	FOREIGN KEY(order_id) REFERENCES 產品販售資料表(order_id),
    FOREIGN KEY(product_id) REFERENCES 產品基本資料表(product_id)
);


DROP table IF EXISTS 業務行銷回報資料表;
create table 業務行銷回報資料表(
	Marketing_id varchar(19) PRIMARY KEY, 
	Marketing_clerk VARCHAR(5),
    Marketing_client VARCHAR(18),
    Marketing_reserve DATETIME,
    Marketing_discount TEXT,
    Marketing_remark TEXT,
	Marketing_date DATETIME,
    FOREIGN KEY(Marketing_client) REFERENCES APP客戶資料表(Cus_id),
    FOREIGN KEY(Marketing_clerk) REFERENCES 業務基本資料表(Sp_id)
);

DROP table IF EXISTS 客戶聯絡紀錄資料表;
create table 客戶聯絡紀錄資料表(
	Cus_id varchar(22), 
	Marketing_id varchar(5),
	PRIMARY KEY(Cus_id, Marketing_id),
    FOREIGN KEY(Cus_id) REFERENCES APP客戶資料表(Cus_id),
    FOREIGN KEY(Marketing_id) REFERENCES 業務行銷回報資料表(Marketing_id)
);

DROP table IF EXISTS 按摩椅基本資料表;
create table 按摩椅基本資料表(
	Chair_id varchar(4) PRIMARY KEY, 
	Chair_place varchar(4), 
    Chair_cost INT,
    Chair_frequency INT,
    Chair_state INT,
    Chair_years INT,
    Chair_pid VARCHAR(4),
    FOREIGN KEY(Chair_pid) REFERENCES 產品基本資料表(product_id)
);

DROP table IF EXISTS 按摩椅使用狀況表;
create table 按摩椅使用狀況表(
	Cu_exID varchar(18) PRIMARY KEY, 
	Cu_id varchar(4), 
	Cu_userid varchar(4), 
    Cu_date DATE,
    FOREIGN KEY(Cu_id) REFERENCES 按摩椅基本資料表(Chair_id),
    FOREIGN KEY(Cu_userid) REFERENCES APP客戶資料表(Cus_id)
);

DROP table IF EXISTS 按摩卷進貨資料表;
create table 按摩卷進貨資料表(
	Cp_NUM INT, 
    Cp_ID varchar(19) PRIMARY KEY,
    Cp_DATE DATETIME
);

DROP table IF EXISTS 按摩卷基本資料表;
create table 按摩卷基本資料表(
	Cou_ID varchar(8)PRIMARY KEY,
	Cou_DATE DATE,
    Cou_STATUS INT,
    Cou_COST INT,
    Cp_ID varchar(18),
    FOREIGN KEY(Cp_ID) REFERENCES 按摩卷進貨資料表(Cp_ID)
);

DROP table IF EXISTS 按摩卷交易資料表;
create table 按摩卷交易資料表(
	Trade_id varchar(18) PRIMARY KEY, 
	Cus_id varchar(18), 
    Voucher_id varchar(8),
    Voucher_date DATETIME,
    Voucher_provider varchar(18),
    Voucher_status INT,
    FOREIGN KEY(Cus_id) REFERENCES APP客戶資料表(Cus_id),
    FOREIGN KEY(Voucher_id) REFERENCES 按摩卷基本資料表(Cou_ID),
    FOREIGN KEY(Voucher_provider) REFERENCES 業務基本資料表(Sp_id),
    FOREIGN KEY(Voucher_provider) REFERENCES APP客戶資料表(Cus_id)
);

DROP table IF EXISTS 客戶引薦資料表;
create table 客戶引薦資料表(
	Referrer_ID varchar(18), 
	Bref_id varchar(18), 
    ref_date DATE,
    PRIMARY KEY(Referrer_ID, Bref_id),
    FOREIGN KEY(Referrer_ID) REFERENCES APP客戶資料表(Cus_id),
    FOREIGN KEY(Bref_id) REFERENCES APP客戶資料表(Cus_id)
);

DROP table IF EXISTS 出勤資料表;
create table 出勤資料表(
	Ab_ID varchar(5)  PRIMARY KEY, 
	Ab_ON INT, 
    Ab_OFF INT,
    Ab_DATE DATE, 
    Ab_REASON TEXT, 
    FOREIGN KEY(Ab_ID) REFERENCES 業務基本資料表(Sp_id)
);

DROP table IF EXISTS 店家成本資料表;
create table 店家成本資料表(
	store_id varchar(4), 
	physical_cost INT, 
    rent_cost INT,
    voucher_cost INT, 
    upper_cost INT, 
    other_cost INT, 
    cost_month DATETIME, 
    PRIMARY KEY(store_id, cost_month),
    FOREIGN KEY(store_id) REFERENCES 分店基本資料表(store_id)
);

DROP table IF EXISTS 按摩椅意見回饋資料表;
create table 按摩椅意見回饋資料表(
	feedback_id varchar(18) PRIMARY KEY, 
	feedbackCu_id varchar(4), 
    Feedcus_id varchar(18),
    feedback_text TEXT, 
    feedback_date DATE, 
    FOREIGN KEY(feedbackCu_id) REFERENCES 按摩椅基本資料表(Chair_id),
    FOREIGN KEY(Feedcus_id) REFERENCES APP客戶資料表(Cus_id)
);

DROP table IF EXISTS 公告訊息資料表;
create table 公告訊息資料表(
	An_id varchar(19) PRIMARY KEY, 
	An_text TEXT, 
    An_dateON DATE,
    An_dateOFF INT
);