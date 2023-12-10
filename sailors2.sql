create table sailors(
sid varchar(20) primary key,
sname varchar(20) not null,
rating int not null,
age int not null
);

create table boat(
bid varchar(20) primary key,
bname varchar(20) not null,
color varchar(20) not null
);

create table reserves(
sid varchar(20) not null,
bid varchar(20) not null,
sdate date not null,
foreign key(sid) references sailors(sid),
foreign key(bid) references boat(bid)
);

insert into sailors values
("s001","Albert",4,23),
("s002","sailor1",2,20),
("s003","sailor2",5,26),
("s004","sailor3",4,30),
("s005","sailor4",5,25),
("s006","astrom hatwar",4,19),
("s007","abhiastrom fury",5,29);

insert into boat values
("b001","boat1","green"),
("b002","boat2","red"),
("b003","boat3","blue");

insert into reserves values
("s001","b003","2023-01-01"),
("s001","b002","2023-02-01"),
("s002","b001","2023-03-06"),
("s003","b002","2023-03-06"),
("s005","b003","2023-03-06"),
("s001","b001","2023-03-06"),
("s006","b002","2023-06-03"),
("s006","b001","2023-06-03"),
("s006","b003","2023-06-03"),
("s007","b001","2023-07-01"),
("s007","b002","2023-06-03");

select * from sailors;
select * from boat;
select * from reserves;

--find the color of boats reserved by albert 
select b.color from sailors s,boat b,reserves r where s.sid=r.sid and b.bid=r.bid and s.sname="albert";

--find all the sailors sids who have rating of atleast 4 or reserved boat number b003
select sid from sailors where rating>=4
union
select sid from reserves where bid="b003";

--find the names of the sailors who have not reserved a boat whose name contains the string "strom".order the name in ascending order

insert into sailors values
("s008","strom cold austin",3,35);

select s.sname from sailors s where s.sid not in(select s.sid from reserves r where s.sid=r.sid) and s.sname like "%strom%" order by s.sname asc;


--find the name of all sailors who have reserved all the boats
select s.sname from sailors s where not exists(select * from boat b where not exists(select * from reserves r where s.sid=r.sid and b.bid=r.bid));

--find the name of the oldest sailor
select sname,age from sailors order by age desc limit 1;
select sname,age from sailors where age=(select max(age) from sailors);

--for each boat which was reserved by atleast 2 sailors with age>=28,find the bid and average age of the sailors

select b.bid,avg(s.age) from sailors s,boat b,reserves r where r.sid=s.sid and r.bid=b.bid and s.age>=28 
group by bid having 2>=count(distinct r.sid);

--a view that shows the names of the sailors who have reserved a boat on a given date 

create view reservation_on_a_perticulardate as
select s.sname from sailors s,reserves r where s.sid=r.sid and r.sdate="2023-03-06";

select * from reservation_on_a_perticulardate;

--a view that shows the names and rating of all the sailors sorted by rating in descending order

create view rating_of_sailors as 
select sname,rating from sailors order by rating desc;

select * from rating_of_sailors;

--create a view that shows the names and colors of all the boats that have been reserved by a sailor with a specific rating

create view sailor_with_specificrating as
select s.sname,b.color from sailors s,boat b,reserves r where 
r.sid=s.sid and b.bid=r.bid and s.rating=5;

select * from sailor_with_specificrating;

 



