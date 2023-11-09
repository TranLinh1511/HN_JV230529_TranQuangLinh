create database QUANLYDIEMTHI;
use QUANLYDIEMTHI;

-- todo Bài 1. Tạo bảng
create table student
(
    studentId   varchar(4) primary key not null,
    studentName varchar(100)           not null,
    birthDay    date                   not null,
    gender      bit                    not null,
    address     text                   not null,
    phoneNumber varchar(45),
    check ( gender = 0 or gender = 1 )
);

create table subject
(
    subjectId   varchar(4) primary key not null,
    subjectName varchar(100)           not null,
    priority    int(11)                not null
);

create table mark
(
    studentId varchar(4) not null,
    subjectId varchar(4) not null,
    point     float(11),
    constraint s_fk foreign key (studentId) references student (studentId),
    constraint sj_fk foreign key (subjectId) references subject (subjectId)
);

-- todo Thêm dữ liệu
insert into student
values ('S001', 'Nguyễn Thế Anh', '1999-1-11', 1, 'Hà Nội', '984678082'),
       ('S002', 'Đặng Bảo Trâm', '1998-12-22', 0, 'Lào Cai', '904982654'),
       ('S003', 'Trần Hà Phương', '2000-5-5', 0, 'Nghệ An', '947645363'),
       ('S004', 'Đỗ Tiến Mạnh', '1999-3-26', 1, 'Hà Nội', '983665353'),
       ('S005', 'Phạm Duy Nhất', '1998-10-4', 1, 'Tuyên Quang', '987242678'),
       ('S006', 'Mai Văn Thái', '2002-6-22', 1, 'Nam Định', '982654268'),
       ('S007', 'Hoàng Gia Hân', '1996-11-10', 0, 'Phú Thọ', '982364753'),
       ('S008', 'Nguyễn Ngọc Bảo My', '1999-1-22', 0, 'Hà Nam', '927867453'),
       ('S009', 'Nguyễn Tiến Đạt', '1998-8-7', 1, 'Tuyên Quang', '989274673'),
       ('S010', 'Nguyễn Thiều Quang', '2000-9-18', 1, 'Hà Nội', '984378291');

insert into subject
values ('MH01', 'Toán', 2),
       ('MH02', 'Vật Lý', 2),
       ('MH03', 'Hóa Học', 1),
       ('MH04', 'Ngữ Văn', 1),
       ('MH05', 'Tiếng Anh', 2);

insert into mark
values ('S001', 'MH01', 8.5),
       ('S001', 'MH02', 7),
       ('S001', 'MH03', 9),
       ('S001', 'MH04', 9),
       ('S001', 'MH05', 5);

insert into mark
values ('S002', 'MH01', 9),
       ('S002', 'MH02', 8),
       ('S002', 'MH03', 6.5),
       ('S002', 'MH04', 8),
       ('S002', 'MH05', 6);
insert into mark
values ('S003', 'MH01', 7.5),
       ('S003', 'MH02', 6.5),
       ('S003', 'MH03', 8),
       ('S003', 'MH04', 7),
       ('S003', 'MH05', 7);
insert into mark
values ('S004', 'MH01', 6),
       ('S004', 'MH02', 7),
       ('S004', 'MH03', 5),
       ('S004', 'MH04', 6.5),
       ('S004', 'MH05', 8);
insert into mark
values ('S005', 'MH01', 5.5),
       ('S005', 'MH02', 8),
       ('S005', 'MH03', 7.5),
       ('S005', 'MH04', 8.5),
       ('S005', 'MH05', 9);
insert into mark
values ('S006', 'MH01', 8),
       ('S006', 'MH02', 10),
       ('S006', 'MH03', 9),
       ('S006', 'MH04', 7.5),
       ('S006', 'MH05', 6.5);
insert into mark
values ('S007', 'MH01', 9.5),
       ('S007', 'MH02', 9),
       ('S007', 'MH03', 6),
       ('S007', 'MH04', 9),
       ('S007', 'MH05', 4);
insert into mark
values ('S008', 'MH01', 10),
       ('S008', 'MH02', 8.5),
       ('S008', 'MH03', 8.5),
       ('S008', 'MH04', 6),
       ('S008', 'MH05', 9.5);
insert into mark
values ('S009', 'MH01', 7.5),
       ('S009', 'MH02', 7),
       ('S009', 'MH03', 9),
       ('S009', 'MH04', 5),
       ('S009', 'MH05', 10);
insert into mark
values ('S010', 'MH01', 6.5),
       ('S010', 'MH02', 8),
       ('S010', 'MH03', 5.5),
       ('S010', 'MH04', 4),
       ('S010', 'MH05', 7);

-- todo Bài 2. Cập nhật dữ liệu [10 điểm]:
# - Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh”.
update student
set studentName = 'Đỗ Đức Mạnh'
where studentId = 'S004';

# - Sửa tên và hệ số môn học có mã `MH05` thành “NgoạiNgữ” và hệ số là 1.
update subject
set subjectName = 'Ngoại ngữ',
    priority    = 1
where subjectId = 'MH05';

# - Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6, MH05 : 9
update mark
set point = case
                when subjectId = 'MH01' then 8.5
                when subjectId = 'MH02' then 7
                when subjectId = 'MH03' then 5.5
                when subjectId = 'MH04' then 6
                when subjectId = 'MH05' then 9
                else point
    end
where studentId = 'S009';

-- Xoá dữ liệu[10 điểm]:
# - Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh này ở bảng STUDENT.
delete
from mark
where studentId = 'S010';
delete
from student
where studentId = 'S010';

-- todo Bài 3: Truy vấn dữ liệu [25 điểm]:

# 1. Lấy ra tất cả thông tin của sinh viên trong bảng Student . [4 điểm]
select *
from student;

# 2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1. [4 điểm]
select subjectId, subjectName
from subject
where priority = 1;

# 3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh. [4 điểm]
select studentId, studentName, (2023 - year(birthDay)) as age, case gender when 0 then 'Nam' else 'Nữ' end, address
from student c;

# 4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn Toán và sắp xếp theo điểm giảm dần. [4 điểm]
select s.studentName, sj.subjectName, m.point
from mark m
         join student s on m.studentId = s.studentId
         join subject sj on m.subjectId = sj.subjectId
where m.subjectId = 'MH01'
order by m.point desc;

# 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng). [4 điểm]
select case
           when gender = 0 then 'Nam'
           when gender = 1 then 'Nữ'
           end  as gender,
       COUNT(*) as quantity
from student
group by gender;

# 6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình. [5 điểm]

select s.studentId, s.studentName, sum(m.point) as sum, avg(m.point) as avg
from mark m
         join student s on m.studentId = s.studentId
group by s.studentId, s.studentName;

-- todo Bài 4: Tạo View, Index, Procedure [20 điểm]:

# 1. Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học sinh, giới tính , quê quán . [3 điểm]
create view STUDENT_VIEW as
select studentId, studentName, case gender when 0 then 'Nam' else 'Nữ' end as gender, address
from student;
# 2. Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh, điểm trung bình các môn học . [3 điểm]

create view AVERAGE_MARK_VIEW as
select mark.studentId, s.studentName, avg(point)
from mark
         join student s on mark.studentId = s.studentId
group by s.studentName, mark.studentId;
# 3. Đánh Index cho trường `phoneNumber` của bảng STUDENT. [2 điểm]
alter table student
    add index student (phoneNumber);

# 4. Tạo các PROCEDURE:
delimiter //
# - Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học sinh, giới tính , quê quán . [3 điểm]
create procedure PROC_INSERTSTUDENT(in _studentId varchar(4), in _studentName varchar(100), in _birthDay date,
                                    in _gender bit, in _address text, in _phoneNumber varchar(45))
begin
    insert into student
        value (_studentId, _studentName, _birthDay, _gender, _address, _phoneNumber);
end //

# - Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học. [4 điểm]
create procedure PROC_UPDATESUBJECT(in _subjectId varchar(4), in _subjectName varchar(100))
begin
    update subject set subjectName = _subjectName where subjectId = _subjectId;
end //

# - Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh và trả về số bản ghi đã xóa. [4 điểm]
create procedure PROC_DELETEMARK(in _studentId varchar(4), out _count int)
begin
    declare count_ int default 0;
    select COUNT(*) into count_ from mark where studentId = _studentId;
    if count_ > 0 then
        delete from mark where studentId = _studentId;
    end if;
    set _count = count_;
end //
delimiter ;

call PROC_DELETEMARK('S009', @count);
select @count as `Số hàng đã xóa`;
-- call

call PROC_INSERTSTUDENT('S011', 'Trần Linh', '2000-11-15', 1, 'Bắc Ninh', 098523423);
drop database QUANLYDIEMTHI;