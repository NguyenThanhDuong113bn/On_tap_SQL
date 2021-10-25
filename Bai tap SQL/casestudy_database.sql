drop database On_tap_SQL;
create database On_tap_SQL;
use  On_tap_SQL;
create table vi_tri (
ma_vi_tri int auto_increment primary key,
ten_vi_tri varchar(45)
);
create table trinh_do (
ma_trinh_do int auto_increment primary key,
trinh_do varchar(45)
);
create table bo_phan (
ma_bo_phan int auto_increment primary key,
ten_bo_phan varchar(45)
);
create table nhan_vien (
ma_nhan_vien int auto_increment primary key,
ho_ten varchar(45),
ngay_sinh date,
so_CMTND varchar(45),
luong double,
SDT varchar(45),
email varchar(45),
dia_chi varchar(45),
ma_vi_tri int,foreign key(ma_vi_tri) references vi_tri(ma_vi_tri)on update cascade on delete cascade,
ma_trinh_do int,foreign key(ma_trinh_do) references trinh_do(ma_trinh_do) on update cascade on delete cascade,
ma_bo_phan int,foreign key(ma_bo_phan) references bo_phan(ma_bo_phan)on update cascade on delete cascade
);
create table loai_khach (
ma_loai_khach int auto_increment primary key,
ten_loai_khach varchar(45)
);
create table khach_hang (
ma_khach_hang int auto_increment primary key,
ma_loai_khach int,foreign key(ma_loai_khach) references loai_khach(ma_loai_khach) on update cascade on delete cascade,
ho_ten varchar(45),
ngay_sinh date,
gioi_tinh bit(1),
so_CMTND varchar(45),
SDT varchar(45),
email varchar(45),
dia_chi varchar(45)
);
create table kieu_thue (
ma_kieu_thue int auto_increment primary key,
ten_kieu_thue varchar(45),
gia_thue double
);
create table loai_dich_vu (
ma_loai_dich_vu int auto_increment primary key,
ten_loai_dich_vu varchar(45)
);
create table dich_vu (
ma_dich_vu int auto_increment primary key,
ten_dich_vu varchar(45),
dien_tich int,
chi_phi_thue double,
so_nguoi_toi_da int,
ma_kieu_thue int,foreign key(ma_kieu_thue) references kieu_thue(ma_kieu_thue) on update cascade on delete cascade,
ma_loai_dich_vu int,foreign key(ma_loai_dich_vu) references loai_dich_vu(ma_loai_dich_vu)on update cascade on delete cascade,
tieu_chuan_phong varchar (45),
mo_ta_tien_nghi_khac varchar(45),
dien_tich_ho_boi double,
so_tang int
);
create table hop_dong (
ma_hop_dong int auto_increment primary key,
ngay_lam_hop_dong date,
ngay_ket_thuc date,
tien_dat_coc int,
tong_tien int,
ma_nhan_vien int,foreign key(ma_nhan_vien) references nhan_vien(ma_nhan_vien)on update cascade on delete cascade,
ma_khach_hang int,foreign key(ma_khach_hang) references khach_hang(ma_khach_hang)on update cascade on delete cascade,
ma_dich_vu int,foreign key(ma_dich_vu) references dich_vu(ma_dich_vu)on update cascade on delete cascade
);
create table dich_vu_di_kem (
ma_dich_vu_di_kem int auto_increment primary key,
ten_dich_vu_di_kem varchar(45),
gia double,
don_vi int,
trang_thai varchar(45)
);
create table hop_dong_chi_tiet (
ma_hop_dong_chi_tiet int auto_increment primary key,
ma_hop_dong int,foreign key(ma_hop_dong) references hop_dong(ma_hop_dong)on update cascade on delete cascade,
ma_dich_vu_di_kem int,foreign key(ma_dich_vu_di_kem) references dich_vu_di_kem(ma_dich_vu_di_kem)on update cascade on delete cascade,
so_luong int
);
-- Task 1:
/* Thêm mới thông tin cho tất cả các bảng trong CSDL */
insert into vi_tri
values
(1,'Le Tan'),
(2,'Phuc Vu'),
(3,'Chuyen Vien'),
(4,'Giam Sat'),
(5,'Quan Li'),
(6,'Giam Doc');
insert into trinh_do
values
(1,'Cao Dang'),
(2,'Dai Hoc'),
(3,'Trung Cap'),
(4,'Sau Dai Hoc');
insert into bo_phan
values
(1,'Sale – Marketing'),
(2,'Hanh Chinh'),
(3,'Phuc Vu'),
(4,'Quan Li');
insert into nhan_vien
values
(1,'Huynh Thi Ha','1994/08/10','297354920',7000000,'0392065098','hahuynh@gmail.com','Quang Tri',1,3,1),
(2,'Truong Van Quang','1991/11/15','234586038',12000000,'0394908776','truongquang@gmail.com','Hue',5,4,4),
(3,'Nguyen Thi Thanh','1997/10/25','239876509',8500000,'0987987098','thanhnguyen@gmail.com','Da Nang',2,1,3),
(4,'Nguyen Van Kiet','1998/07/09','357354920',8000000,'0392065234','vankiet@gmail.com','Quang Nam',1,2,1);
insert into loai_khach
values
(1,'Diamond'),
(2,'Platinium'),
(3,'Gold'),
(4,'Silver'),
(5,'Member');
insert into khach_hang
values
(1,2,'Nguyen Van An','1989/02/19',1,'276086789','0971098789','nguyenan@gmail.com','Da Nang'),
(2,5,'Tran Nhu ngoc','1975/12/07',1,'297479674','0989098765','tranngoc@gmail.com','Nha Trang'),
(3,1,'Nguyen Van Nhat','1995/10/04',1,'298057336','0396098779','nhatnguyen@gmail.com','Vinh');
insert into kieu_thue
values
(1,'Ngay',300000),
(2,'Tuan',1000000),
(3,'Thang',2500000);
insert into loai_dich_vu
values
(1,'Thuong'),
(2,'Vip');
insert into dich_vu 
/*(ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, so_nguoi, ma_kieu_thue, ma_loai_dich_vu,
						tieu_chuan_phong, mo_ta_tien_nghi, dien_tich_ho_boi, so_tang)*/
values
(1,'Villa1',500,5000000,10, 1,1, 'Diamond', 'Massage',50,4),
(2,'House1',400,4000000, 7,1,2, 'Platinum' ,'Karaoke',40, 3),
(3,'Room',300, 3000000, 5, 2, 2, 'Gold', ' Thuc an', 30, 2),
(4,'Villa2',500,7000000, 10,2, 2, 'Diamond', 'Karaoke', 50,4);
insert into hop_dong
values
(1,'2018/04/12','2018/05/12',5000000,0, 1,2,2),
(2,'2019/02/22','2019/02/23',3000000,0, 3,1,1),
(3,'2019/11/05','2019/11/11',4000000,0, 2,3,3),
(4,'2019/12/12','2019/12/13',6000000,0, 4,4,4);
insert into dich_vu_di_kem
values
(1,'Massage',500000,1,'Mo'),
(2,'Karaoke',700000,2,'Mo'),
(3,'Thuc An',500000,1,'Mo'),
(4,'Nuoc Uong',200000,2,'Mo'),
(5,'Thue Xe',400000,1,'Mo');
insert into hop_dong_chi_tiet
values
(1,2,3,2),
(2,3,1,1),
(3,1,2,5);
