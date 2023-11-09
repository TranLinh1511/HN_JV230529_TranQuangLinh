create database QUANLYBANHANG;
use QUANLYBANHANG;
-- create table

create table customers
(
    customerId   varchar(4) primary key not null,
    customerName varchar(100)           not null,
    email        varchar(100)           not null,
    phoneNumber  varchar(45)            not null,
    address      text                   not null
);

create table orders
(
    orderId      varchar(4) primary key not null,
    customerId   varchar(4)             not null,
    order_date   date                   not null,
    total_amount double                 not null,
    constraint c_pk foreign key (customerId) references customers (customerId)
);

create table products
(
    productId   varchar(4) primary key not null,
    productName varchar(255)           not null,
    description text,
    price       double                 not null,
    status      bit(1)                 not null
);

create table orderDetail
(
    orderId    varchar(4) not null,
    productId  varchar(4) not null,
    quantity   int(11)    not null default 0,
    totalPrice double     not null,
    constraint o_pk foreign key (orderId) references orders (orderId),
    constraint p_pk foreign key (productId) references products (productId),
    primary key (orderId, productId)
);

-- Thêm dữ liệu

insert into customers
values ('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '984756322', 'Cầu giấy, Hà Nội'),
       ('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '984875926', 'Ba Vì, Hà Nội'),
       ('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', '904725784', 'Mộc Châu. Sơn La'),
       ('C004', 'Phạm Ngọc Anh', 'anhpn@gmail.com', '984635365', 'Vinh, Nghệ An'),
       ('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '989735624', 'Hai Bà Trưng, Hà Nội');

insert into products
values ('P001', 'Iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999, 1),
       ('P002', 'Dell Vostro V3510', 'Core i5, RAM 8GB', 14999999, 1),
       ('P003', 'Macbook Pro M2', '8CPU 10GPU 8GB 256GB', 28999999, 1),
       ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small', 18999999, 1),
       ('P005', 'Airpods 2 2022', 'Spatial Audio', 4090000, 1);

insert into orders
values ('H001', 'C001', '2023-2-22', 52999997),
       ('H002', 'C001', '2023-3-11', 80999997),
       ('H003', 'C002', '2023-1-22', 54359998),
       ('H004', 'C003', '2023-3-14', 102999995),
       ('H005', 'C003', '2022-2-12', 80999997),
       ('H006', 'C004', '2023-2-1', 110449994),
       ('H007', 'C004', '2023-3-29', 799999996),
       ('H008', 'C005', '2023-2-14', 29999998),
       ('H009', 'C005', '2023-1-10', 28999999),
       ('H010', 'C005', '2023-1-4', 149999994);

insert into orderDetail
values ('H001', 'P002', 1, 14999999),
       ('H001', 'P004', 2, 18999999),
       ('H002', 'P001', 1, 22999999),
       ('H002', 'P003', 2, 28999999),
       ('H003', 'P004', 2, 18999999),
       ('H003', 'P005', 4, 4090000),
       ('H004', 'P002', 3, 14999999),
       ('H004', 'P003', 2, 28999999),
       ('H005', 'P002', 1, 22999999),
       ('H005', 'P003', 2, 28999999),
       ('H006', 'P005', 5, 4090000),
       ('H006', 'P003', 6, 14999999),
       ('H007', 'P004', 3, 18999999),
       ('H007', 'P002', 1, 22999999),
       ('H008', 'P002', 2, 14999999),
       ('H009', 'P003', 1, 28999999),
       ('H010', 'P003', 2, 28999999),
       ('H010', 'P001', 4, 22999999);

-- todo Bài 3: Truy vấn dữ liệu [30 điểm]:

# 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers .[4 điểm]
select customerName, email, phoneNumber, address
from customers;

# 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện thoại và địa chỉ khách hàng). [4 điểm]
select c.customerName, c.phoneNumber, c.address
from orders o
         join customers c on c.customerId = o.customerId
where year(o.order_date) = 2023
  and month(o.order_date) = 3;

# 3. Thống kê doanh thu theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm tháng và tổng doanh thu ). [4 điểm]
select month(order_date) as month, sum(total_amount) as 'total revenue'
from orders
where year(order_date) = 2023
group by month(order_date)
order by month(order_date);

# 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách hàng, địa chỉ , email và số điên thoại). [4 điểm]
select c.customerName, c.address, c.email, c.phoneNumber
from customers c
         left join orders o on c.customerId = o.customerId
where o.customerId is null
  and year(o.order_date) = 2023
  and month(o.order_date) = 2;

# 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã sản phẩm, tên sản phẩm và số lượng bán ra). [4 điểm]
select p.productId, productName, sum(quantity)
from orderDetail
         join orders o on o.orderId = orderDetail.orderId
         join products p on p.productId = orderDetail.productId
where year(o.order_date) = 2023
  and month(o.order_date) = 3
group by p.productId, p.productName;

# 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu). [5 điểm]
select c.customerName, c.address, sum(o.total_amount) as 'total spending'
from orders o
         join customers c on c.customerId = o.customerId
group by c.customerName, c.address
order by `total spending` desc;

# 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) . [5 điểm]
select c.customerName,
       sum(o.total_amount) as 'Amount spent',
       o.order_date,
       sum(od.quantity)    as 'Quantity purchased'
from orderDetail od
         join orders o on o.orderId = od.orderId
         join customers c on c.customerId = o.customerId
group by c.customerName, o.order_date
having sum(od.quantity) > 4;

-- todo Bài 4: Tạo View, Procedure [30 điểm]:


# 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng tiền và ngày tạo hoá đơn . [3 điểm]
create view ORDERS_VIEW as
select c.customerName, c.phoneNumber, c.address, o.total_amount as 'Total amount', o.order_date
from orders o
         join customers c on c.customerId = o.customerId
group by c.customerName, c.phoneNumber, c.address, o.order_date;

# 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng số đơn đã đặt. [3 điểm]
create view CUSTOMERS_INFORMATION_VIEW as
select c.customerName, c.address, c.phoneNumber, count(o.orderId) as 'Orders placed'
from orders o
         join customers c on c.customerId = o.customerId
group by c.customerName, c.phoneNumber, c.address;

# 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã bán ra của mỗi sản phẩm.[3 điểm]
create view PRODUCT_SOLD_VIEW as
select p.productName, p.description, p.price, sum(od.quantity) as 'Quantity sold'
from orderDetail od
         join orders o on o.orderId = od.orderId
         join products p on p.productId = od.productId
group by p.productName, p.description, p.price;

# 4. Đánh Index cho trường `phone` và `email` của bảng Customer. [3 điểm]
alter table customers
    add index idx_phone (phoneNumber);
alter table customers
    add index idx_email (email);

delimiter //
# 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.[3 điểm]
create procedure PROC_GETCUSTOMERBYID(in customerId_ varchar(4))
begin
    select * from customers where customerId = customerId_;
end //

# 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm. [3 điểm]
create procedure PROC_GETALLPRODUCT()
begin
    select * from products;
end //

# 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng. [3 điểm]
create procedure PROC_GETALLORDERBYCUSTOMERID(in customerId_ varchar(4))
begin
    select * from orders where customerId = customerId_;
end //
call PROC_GETALLORDERBYCUSTOMERID('C003');

# 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo. [3 điểm]
create procedure PROC_CREATEORDER(in customID_ varchar(4), in order_date_ date,
                                  in total_Price_ double)
begin
    declare last_id int;
    declare new_id varchar(4);
    set last_id = (select max(cast(substring(orderId, 2) as signed))
                   from orders
                   where orderId like 'H%');
    set new_id = (case
                      when (last_id + 1) < 10 then concat('H00', (last_id + 1))
                      when (last_id + 1) < 100 then concat('H0', (last_id + 1))
                      else concat('H', (last_id + 1))
        end
        );
    insert into orders
    values (new_id, customID_, order_date_, total_Price_);
    select * from orders where orderId = new_id;
end //
call PROC_CREATEORDER('C001', '2023-2-13', 2000000);

# 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc. [3 điểm]
create procedure PROC_GETORDERBYTIME(in start_date date, in end_date date)
begin
    select p.productName, p.description, sum(oD.quantity) as 'Quantity sold'
    from orders o
             join orderDetail oD on o.orderId = oD.orderId
             join products p on p.productId = oD.productId
    where o.order_date between start_date and end_date
    group by p.productName, p.description, p.price;
end //;
call PROC_GETORDERBYTIME( '2023-02-21',  '2023-02-28');

# 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê. [3 điểm]

create procedure PROC_SHOWSOLDPRODUCTBYMONTH(in month_ int, in year_ int)
begin
    select p.productName, p.description, p.price, sum(od.quantity) as 'Quantity sold'
    from orders o
             join orderDetail oD on o.orderId = oD.orderId
             join products p on p.productId = oD.productId
    where year(order_date) = year_
      and month(order_date) = month_
    group by p.productName, p.description, p.price
    order by `Quantity sold` desc;
end //;
call PROC_SHOWSOLDPRODUCTBYMONTH(2, 2023);

delimiter ;

