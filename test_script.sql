create database quanlyhocvien;

create table Address(
id int auto_increment primary key,
address varchar(50)
);

create table Class(
id int auto_increment primary key ,
name varchar(20),
language varchar(20),
description varchar(255)
);

create table Course(
    id int auto_increment primary key ,
    name varchar(20),
    description varchar(255)
);

create table Students(
    id int auto_increment primary key ,
    full_name varchar(20),
    age int ,
    phone varchar(11) unique ,
    address_id int,
    class_id int,
    foreign key (address_id) references Address(id),
    foreign key (class_id) references Students(id)
);

create table Point(
    id int auto_increment primary key ,
    course_id int,
    student_id int,
    point float,
    foreign key (course_id) references Course(id),
    foreign key (student_id) references Students(id)
);


select * from students where (right(full_name, 3) = 'anh');
alter table students drop constraint students_ibfk_2;
select * from students where (substring_index(full_name, ' ', 1) = 'Nguyen');
select * from students where (left(full_name, 6) = 'Nguyen');

select * from students where (age >= 18 and age <=25);

select * from students where (id = 12 or id = 13);

select class_id, count(class_id)
from students
group by class_id;

select address_id, count(address_id)
from students
group by address_id;

select course_id, avg(point) as avg_point
from point
group by course_id;

select course_id, name, avg(point) as avg_point
from (select point.course_id, course.name, point.point
      from point
               join course on point.course_id = course.id) as somthing
group by course_id;

select *
from (select course_id, course.name as course_name, avg(point) as avg_point
      from point
               join course on point.course_id = course.id
      group by course_id) as  max_avg_point
where avg_point = (select max(avg_point)
from (select course_id, course.name as course_name, avg(point) as avg_point
      from point
               join course on point.course_id = course.id
      group by course_id)
    as max_avg_point);

create table course_avg_point(
    select course_id, course.name, avg(point) as avg_point
    from point
             join course on point.course_id = course.id
    group by course_id
);

select * from course_avg_point
         where avg_point = (select max(avg_point) from course_avg_point);