CREATE TABLE IF NOT EXISTS product(
	p_id VARCHAR(10) NOT NULL,
	p_name VARCHAR(50),
	p_unitPrice INTEGER,
	p_size VARCHAR(30),
	p_color VARCHAR(30),
	p_description TEXT,
   	p_category VARCHAR(20),
	p_unitsInStock LONG,
	p_condition VARCHAR(20),
	p_thumbnail TEXT,
	p_fileName_detail1 TEXT,
	p_fileName_detail2 TEXT,
	p_fileName_detail3 TEXT,
	p_fileName_detail4 TEXT,
	PRIMARY KEY (p_id)
)default CHARSET=utf8;

desc product;