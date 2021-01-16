CREATE TABLE board (
       num int not null auto_increment,
       subject varchar(100) not null,
       id varchar(20) not null,  
       name varchar(20) not null,
       regist_day varchar(30),
       hit int,
       content text not null,
       thumbnail text,
       ip varchar(20),
       PRIMARY KEY (num)
)default CHARSET=utf8;

select * from board;
desc board;
drop table board;
