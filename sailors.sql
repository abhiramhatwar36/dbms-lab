create database sailor;
use sailor;

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

desc sailors;
desc boat;
desc reserves;

--inserting into sailors table

insert into sailors values
(22,"dustin",7,45),
(31,"lubber",8,55),
(29,"brutus",1,33),
(58,"rusty",10,35),
(64,"horatio",7,35),
(71,"zorba",10,16),
(74,"horatio",9,35),
(85,"art",3,25),
(95,"bob",3,63);

-- inserting into boat

insert into boat values
(101,"interlake","blue"),
(102,"interlake","red"),
(103,"clipper","green"),
(104,"marine","red");

--inserting into reserves

insert into reserves values
(22,101,"1998-10-10"),
(22,102,"1998-10-10"),
(22,103,"1998-08-10"),
(22,104,"1998-07-10"),
(31,102,"1998-10-11"),
(31,103,"1998-06-11"),
(31,104,"1998-12-11"),
(64,102,"1998-05-09"),
(64,102,"1998-08-09"),
(74,103,"1998-08-09");

--find the names of all sailors who have reserved boat number 103
select s.sname from sailors s,reserves r where s.sid=r.sid and r.bid=103;

-- find the sid of all sailors who have reserved a red boat
select distinct r.sid from reserves r,boat b where r.bid=b.bid and b.color="red";

--find the colors of boats reserved by lubber
select distinct b.color from sailors s,boat b, reserves r where s.sid=r.sid and b.bid=r.bid and s.sname="lubber";

--select the names of all sailors who have reserved atleast 1 boat
select distinct s.sname from sailors s,reserves r where s.sid=r.sid;

--select the name and age of all sailors
select sname,age from sailors;

--find the sailors with rating above 7
select sname from sailors where rating>7;

--compute the increments of rating of a person who have reserved 2 different boats on the same day
select distinct s.sname,s.rating+1 from sailors s,boat b,reserves r1,reserves r2 where r1.sid=s.sid and r2.sid=s.sid and r1.sdate=r2.sdate and r1.bid!=r2.bid;

--find the ages of all sailors whose name begins and ends with b and have atleast 3 characters
select sname,age from sailors where sname like "b%b";

--find the name of sailors who have sailed red or green boats
select distinct s.sid,s.sname from sailors s,boat b,reserves r where s.sid=r.sid and b.bid=r.bid and b.color in("red","green");

--find the sids of all the sailors who have reserved red boat but not green boat
select r.sid from reserves r,boat b where r.bid=b.bid and b.color="red"
except
select r.sid from reserves r,boat b where r.bid=b.bid and b.color="green";

-- find all the sailors who have a rating of 10 or reserved boat number 104
select sid from sailors where rating=10
union
select r.sid from sailors s,reserves r where s.sid=r.sid and r.bid=104;

--find all the sailors whose rating is better than some sailor named horatio
select * from sailors s where rating > any(select rating from sailors where sname="horatio");

--find the sailor with maximum rating
 select * from sailors order by rating desc limit 1;

 select * from sailors where rating=(select max(rating) from sailors);

--find the average age of all sailors with rating 10
select avg(age) from sailors where rating=10;

--find the name and age of the oldest sailor
select sname,age from sailors order by age desc limit 1;

-- find the age of youngest sailor for each rating level
select rating,min(age) from sailors group by rating order by rating;
