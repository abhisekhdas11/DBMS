create table if not exists USER (user_id int primary key,first_name varchar(50),last_name varchar(50),adhar_no varchar(20) ,gender enum('m','f'),age tinyint, mobile_no varchar(12),email varchar(50),city varchar(50), state varchar(50),pincode varchar(6),_password varchar(50),security_ques varchar(50),security_ans varchar(50);

create table if not exists TRAIN(train_no int primary key,train_name varchar(50),arrival_time time,departure_time time,availability_of_seats char(10), d date);

create table if not exists STATION(no int ,name varchar(50),hault int, arrival_time time,train_no int, primary key(no,train_no), constarint foreign key(train_no) references TRAIN(train_No));

create table if not exists TRAIN_STATUS(train_no int primary key, b_seats1 int,b_seats2 int,a_seats1 int,a_seats2 int, w_seats1 int, w_seats2 int,fare1 float,fare2 float);

create table if not exists TICKET(id int primary key,user_id int,status char,no_of_passengers int,train_no int,constraint foreign key(user_id) references USER(user_id),constraint foreign key(train_no) references TRAIN(train_no));

create table if not exists PASSENGER(passenger_id int primary key,pnr_no int,age int,gender char,user_id int,reservation_status char,seat_number varchar(5),name varchar(50),ticket_id int,constraint foreign key(user_id) references USER(user_id),constraint foreign key(ticket_id) references TICKET(id));

create table if not exists STARTS(train_no int, station_no int, constraint foreign key(train_no) references TRAIN(train_no), constraint foreign key(station_no) references STATION(no));

create table if not exists STOPS_AT(train_no int,station_no int,constraint foreign key(train_no) references TRAIN(train_no),constraint foreign key(station_no) references STATION(no));

create table if not exists REACHES(train_no int,station_no int,time time,constraint foreign key(train_no) references TRAIN(train_no),constraint foreign key(station_no) references STATION(no));

create table if not exists BOOKS( user_id int,id int,constraint foreign key(user_id) references USER(user_id),constraint foreign key(id) references TICKET(id));

create table if not exists CANCEL(user_id int,id int,passenger_id int,constraint foreign key(id) references TICKET(id),constraint foreign key (passenger_id) references PASSENGER(passenger_id),constraint foreign key(user_id) references USER(user_id));

###insertions


insert into USER(user_id, first_name,last_name,adhar_no, gender, age,mobile_no,email,city,state, pincode,_password, security_ques, security_ans) values(1701, 'vijay','sharma','309887340843', 'M',34,'9887786655','vijay1@gmail.com','vijayawada', 'andhrapradesh','520001','12345@#','favouritecolour','red'),(1702, 'rohith','kumar', '456709871234', 'M',45,'9809666555', 'rohith Ikumar@gmail.com','guntur', 'andhrapradesh','522004','12@#345', 'favouritebike', 'bmw'), (1703,'manasvi', 'sree','765843210987','F',20,'9995550666','manas vi57@gmail.com','guntur', 'andhra pradesh', '522004', '0987hii', 'favourite flower', 'rose');

insert into TRAIN(train_no,train_name,arrival_time, departure_time,availability_of_seats,d) values(12711, 'pinakini exp','113000', '114000','A',20170410), (12315,'cormandel exp','124500','125000', 'NA' ,20170410);

insert into STATION(no,name,hault, arrival_time,train_no) values(111, 'vijayawada',10,'113000',12711),(222, 'tirupathi',5,'114500',12315);

insert into TRAIN_STATUS(train_no,w_seats1,b_seats1,b_seats2,a_seats1,a_seats2,w_seats2,fare1,fare2) values(12711,10,4,0,1,1,0,100,450),(12315,10,5,0,0,2,1,300,600);

insert into TICKET(id,user_id, status,no_of_passengers,train_no) values(4001,1701,'C',1,12711),(4002,1702,'N',1,12315);

insert into PASSENGER(passenger_id,pnr_no,age, gender,user_id,reservation_status,seat_number,name,ticket_id) values(5001,78965,45,'M',1701,'C' ,'B645','ramesh',4001),(5002,54523,54, 'F',1701, 'W','B321','surekha',4002);
insert into STARTS(train_no,station_no) values(12711,111),(12315,222);
insert into STOPS_AT(train_no,station_no) values(12711,222),(12315,111);
insert into REACHES(train_no,station_no,time) values(12711,222,'040000'), (12315,111,'053500');

insert into BOOKS(user_id,id) values(1701,4001),(1702,4002);
insert into CANCEL(user_id,id, passenger_id) values(1701,4001,5001);

select * from PASSENGER where ticket_id like 4001;

select t.* from TRAIN t,STATION s,REACHES r where t.train_no=r.train_no and r.station_no=s.no and s.name like 'vijayawada';

select r.*,s.name from REACHES r,STATION s where r.station_no=s.no;

select u.* from USER u,CANCEL c,TICKET t where c.user_id=u.user_id and c.id=t.id and t.train_no like 12711;

select ts.train_no,ts.fare1,t.train_name from TRAIN_STATUS ts,TRAIN t where t.train_no=ts.train_no order by fare1 asc;

select p.* from PASSENGER p,TRAIN t,TICKET tc where tc.train_no=t.train_no and tc.id=p.ticket_id and t.train_name like 'pinakini exp';

select distinct t.* from TRAIN t,STATION s,STARTS st,STOPS_AT sa where st.station_no=(select no from STATION where name like 'tirupathi') and sa.station_no=(select no from STATION where name like 'vijayawada') order by d;

select train_no from STATION group by train_no having max(hault);

select t.* from TICKET t where t.status like 'c' and t.train_no=12711;


###########Roles

CREATE USER 'jhon'@'localhost' IDENTIFIED BY 'jhon';
CREATE USER 'raj'@'localhost' IDENTIFIED BY 'raj';

GRANT ALL ON rms.* TO 'jhon'@'localhost';
GRANT SELECT ON rms.* TO 'raj'@'localhost';
GRANT INSERT, DELETE ON rms.BOOKS TO 'raj'@'localhost';
GRANT DELETE ON rms.CANCEL TO 'raj'@'localhost';

#####Backup
#####in dba

select * from BOOKS;
insert into BOOKS(user_id,id) values(1701,4002);
COMMIT;

##in user###

delete from BOOKS where user_id = 1701;

#####in dba
ROLLBACK;

