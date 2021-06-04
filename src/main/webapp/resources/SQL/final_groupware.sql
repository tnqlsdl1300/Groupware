select * from tbl_my_calendar;
select * from tbl_schedule;
select * from tbl_schedule
where fk_calendar_no = 117;
select * from tbl_todo;
select * from tbl_employee;
select * from tbl_schedule_attendee;
select * from tab;
desc tbl_schedule_attendee;

create sequence groupid_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 컬럼 추가
alter table tbl_schedule_attendee add groupid number not null;

-- 테이블 컬럼 크기 변경
alter table tbl_schedule modify(CONTENT varchar2(4000));


-- 자원분류 테이블
create table tbl_resource_category
(resource_no number(8) not null
,name varchar2(200) not null
,constraint PK_resource_no primary key(resource_no)
);

create sequence resource_category_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 자원 테이블
drop table tbl_reservation_resource purge;
create table tbl_reservation_resource
(reservation_resource_no number(8) not null
,fk_resource_no number(8) not null
,name varchar2(1000) not null
,info varchar2(4000) not null
,constraint PK_reservation_resource_no primary key(reservation_resource_no)
,constraint FK_fk_resource_no foreign key(fk_resource_no) references tbl_resource_category(resource_no) on delete cascade
);

drop sequence reservation_resource_no_seq;
create sequence reservation_resource_no_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 예약 테이블
create table tbl_reservation
(reservation_no number(8) not null
,fk_resource_no number(8) not null
,fk_reservation_resource_no number(8) not null
,fk_emp_no number(8) not null
,startday date not null
,endday date not null
,reason varchar2(4000) not null
,constraint PK_reservation_no primary key(reservation_no)
,constraint FK_resource_no foreign key(fk_resource_no) references tbl_resource_category(resource_no) on delete cascade
,constraint FK_fk_reservation_resource_no foreign key(fk_reservation_resource_no) references tbl_reservation_resource(reservation_resource_no) on delete cascade
,constraint FK_fk_emp_no foreign key(fk_emp_no) references tbl_employee(emp_no) on delete cascade
);

create sequence reservation_no_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_reservation_resource;
desc tbl_reservation_resource;

select reservation_resource_no, fk_resource_no, name, info
from tbl_reservation_resource
order by reservation_resource_no;

select *
from tbl_reservation;

select fk_resource_no
from tbl_reservation_resource
where reservation_resource_no = 3;

-- 선택한 자원에 따라 중복된 날짜가 있는지 검사하는 sql문
select count(*)
from 
(
SELECT reservation_no
FROM tbl_reservation
WHERE to_char(endday, 'yyyy-mm-dd hh24:mi:ss') > '2020-12-28 20:00:00'
AND to_char(startday, 'yyyy-mm-dd hh24:mi:ss') < '2020-12-29 23:59:59'
and fk_reservation_resource_no = 3
); 
  
-- 날짜를 비교할 때는 꼭 to_char()로 할 것

-- 예약기간이 지나지 않은 예약목록 보여주기(endday 기준)
select reservation_no, fk_resource_no, fk_reservation_resource_no, fk_emp_no
        , S.name as Rname, RS.name as RSname, E.emp_name, info
        , fk_emp_no, to_char(startday, 'yyyy-mm-dd hh24:mi:ss') as startday
        , to_char(endday, 'yyyy-mm-dd hh24:mi:ss') as endday
        , reason
from tbl_reservation V
left join
(
    select resource_no, name
    from tbl_resource_category
) S
on V.fk_resource_no = S.resource_no
left join
(
    select reservation_resource_no, name, info
    from tbl_reservation_resource
) RS
on V.fk_reservation_resource_no = RS.reservation_resource_no
left join
(
    select emp_no, emp_name
    from tbl_employee
) E
on V.fk_emp_no = E.emp_no
where to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') < to_char(endday, 'yyyy-mm-dd hh24:mi:ss')
and fk_reservation_resource_no = 4
order by reservation_no;

select *
from tbl_reservation;

delete from tbl_reservation
where reservation_no = 7


-- 예약 넣기
insert into tbl_reservation(reservation_no, fk_resource_no, fk_reservation_resource_no, fk_emp_no, startday, endday, reason)
values(reservation_no_seq.nextval, '1' , '2', '2020009', to_date('2020-12-30 13:00:00','yyyy-mm-dd hh24:mi:ss'), to_date('2020-12-30 15:30:00','yyyy-mm-dd hh24:mi:ss'), '2 회의실 잠깐 빌릴게요.');
commit;



-- 일정 삭제 시 해당하는 참가자 목록도 자동으로 삭제 됨
select *
from tbl_schedule_attendee
where groupid = (select groupid from tbl_schedule_attendee where fk_schedule_no = 84);


select schedule_no, fk_emp_no, fk_calendar_no, title, to_char(startday, 'yyyy-mm-dd hh24:mi:ss') as startday
    , to_char(endday, 'yyyy-mm-dd hh24:mi:ss') as  endday
    , content
from tbl_schedule
where schedule_no = 66;

-- groupid로 참가자 이름 받아오기(atd)
select fk_emp_no, emp_name
from tbl_employee E right join
(
    select fk_emp_no
    from
    tbl_schedule_attendee
    where groupid = (select groupid
    from tbl_schedule_attendee
    where fk_schedule_no = 60)
) F
on E.emp_no = F.fk_emp_no;


-- 캘린더 테이블
drop table tbl_my_calendar purge;
create table tbl_my_calendar
(calendar_no number(8) not null
,fk_emp_no number(8) not null
,name VARCHAR2(50) not null
,color VARCHAR2(50) not null
,constraint PK_calendar_no primary key(calendar_no)
,constraint FK_cal_emp_no foreign key(fk_emp_no) references tbl_employee(emp_no) on delete cascade
);


drop sequence calendar_no_seq;
create sequence calendar_no_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 캘린더 넣기
insert into tbl_my_calendar(calendar_no, fk_emp_no, name, color)
values(calendar_no_seq.nextval, '2020002', '다른사람 캘린더', 'black');
commit;

-- 캘린더 변경
update tbl_my_calendar set color = 'black'
where fk_emp_no = '2020001' and calendar_no = '10';

-- 캘린더 삭제
delete from tbl_my_calendar
where calendar_no in();

select calendar_no, fk_emp_no, name, color
from tbl_my_calendar
order by calendar_no;

-- 일정 테이블
drop table tbl_schedule purge;
create table tbl_schedule
(schedule_no number(8) not null
,fk_emp_no number(8) not null
,fk_calendar_no number(8) not null
,title VARCHAR2(50) not null
,startday date not null
,endday date not null
,content VARCHAR2(500) not null
,constraint PK_schedule_no primary key(schedule_no)
,constraint FK_sch_emp_no foreign key(fk_emp_no) references tbl_employee(emp_no) on delete cascade
,constraint FK_calendar_no foreign key(fk_calendar_no) references tbl_my_calendar(calendar_no) on delete cascade
);

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')
from dual;

drop sequence schedule_no_seq;
create sequence schedule_no_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 일정 넣기
insert into tbl_schedule(schedule_no, fk_emp_no, fk_calendar_no, title, startday, endday, content)
values(schedule_no_seq.nextval, '2020001', 8, '10월 종일ㅈㅁㅎㅁㅈㅎㅁㅈㅎㅁㅈㅎ', to_date('2020-10-20 00:00:00','yyyy-mm-dd hh24:mi:ss'), to_date('2020-10-20 23:59:59','yyyy-mm-dd hh24:mi:ss'), '캘린더3 내용');
commit;

select schedule_no, fk_emp_no, fk_calendar_no, title,  to_char(startday, 'yyyy-mm-dd hh24:mi:ss'),  to_char(endday, 'yyyy-mm-dd hh24:mi:ss'), content
from tbl_schedule
where fk_emp_no = 2020001;


-- 일정 참석자 테이블 생성
create table tbl_schedule_attendee
(fk_schedule_no number(8) not null
,fk_emp_no number(8) not null
,constraint FK_att_schedule_no foreign key(fk_schedule_no) references tbl_schedule(schedule_no) on delete cascade
,constraint FK_att_emp_no foreign key(fk_emp_no) references tbl_employee(emp_no) on delete cascade
);

insert into tbl_schedule_attendee(fk_schedule_no, fk_emp_no)
values(1, 2020001);
commit;



---------------------------- 예약 테이블에 endday 는 null 허용해줘야 함!!!!!!!!!!! allDay 때문
-- select 해서 view 단에 뿌려줄 때도 고려해야 함


-- 할일 불러오기
select schedule_no, fk_emp_no, fk_calendar_no, title, startday, endday, content, color
from tbl_schedule S
left join
(
    select calendar_no, color
    from tbl_my_calendar
) C
on S.fk_calendar_no = C.calendar_no
where fk_emp_no = 2020001 and fk_calendar_no in(6); -- 여기! jsp에서는 로컬스토리지에 체크박스 담아서 백단으로 보내고, 캘린더 체크박스 클릭했을때 이걸로 하면 될듯(xml에서 if문으로 나누기)


create table tbl_todo
(todo_no number(8) not null
,fk_emp_no number(8) not null
,subject VARCHAR(50) not null
,content VARCHAR(500) not null
,bookmark number(3) default 0 not null
,constraint PK_todo_no primary key(todo_no)
,constraint FK_emp_no foreign key(fk_emp_no) references tbl_employee(emp_no)
);
-- Table PURCHASEDETAIL이(가) 생성되었습니다.
drop sequence todo_no_seq;
create sequence todo_no_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 할일 추가
insert into tbl_todo(todo_no, fk_emp_no, subject, content)
values(todo_no_seq.nextval, '2020001', '제목', '내용');

select todo_no, fk_emp_no, subject, content, bookmark
from tbl_todo
where fk_emp_no = 2020001 and bookmark = 1
order by todo_no;

select todo_no, fk_emp_no, subject, content, bookmark
from tbl_todo
where fk_emp_no = 2020001 and bookmark = 1
order by todo_no;

delete from tbl_todo
where todo_no = ;

update tbl_todo set bookmark = 1
where todo_no = '76';
commit;
delete from tbl_todo;

desc tbl_todo


---- *** 원격데이터베이스의 자료(데이터)를 로컬데이터베이스로 복사(백업)하기 *** ----

show user;

---세미 프로젝트 ---
211.238.142.89

create user logitech identified by cclass;
grant connect, resource, create view, unlimited tablespace to logitech;


---파이널 프로젝트 ---

-- 디비가 미완성이라 나중에 업데이트 해야할 때 계정을 지우고 다시 밑에 create부터 해서 처음부터 다시 받기
-- 접속에 local_groupware를 우클릭해서 접속해제 해준 뒤 sys로 접속하고서 삭제해야 함
drop user groupware cascade;
groupware
211.238.142.97

create user groupware identified by cclass default tablespace users;

grant connect, resource, create view, unlimited tablespace to groupware;

select *
from tbl_resource_category;
