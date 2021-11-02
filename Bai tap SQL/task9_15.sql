use  On_tap_SQL;
/*
Task 2: Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” 
và có tối đa 15 ký tự.
*/
SELECT 
    *
FROM
    nhan_vien
WHERE
    (substring_index(ho_ten, " ", - 1) LIKE 'T%'
        OR substring_index(ho_ten, " ", - 1) LIKE 'H%'
        OR substring_index(ho_ten, " ", - 1) LIKE 'K%')
        AND CHAR_LENGTH(ho_ten) <= 15;
        
       /* Task 3: Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
*/

SELECT 
    *
FROM
    khach_hang
WHERE
    (TIMESTAMPDIFF(YEAR,
        ngay_sinh,
        CURDATE()) BETWEEN 18 AND 50)
        AND (dia_chi = 'Đà Nẵng'
        OR dia_chi = 'Quảng Trị');
        
        /*
Task4: Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần 
đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
*/
SELECT 
    kh.ho_ten,
    lk.ten_loai_khach,
    COUNT(hd.ma_dich_vu) AS so_lan_dat_phong
FROM
    khach_hang kh
        JOIN
    loai_khach lk ON kh.ma_loai_khach = lk.ma_loai_khach
        JOIN
    hop_dong hd ON kh.ma_khach_hang = hd.ma_khach_hang
        JOIN
    dich_vu dv ON dv.ma_dich_vu = hd.ma_dich_vu
WHERE
    lk.ten_loai_khach = 'Diamond'
GROUP BY kh.ma_khach_hang
ORDER BY so_lan_dat_phong;

/*
Task5: Hiển thị IDKhachHang, HoTen, TenLoaiKhach, maHopDong, TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien 
(Với TongTien được tính theo công thức như sau: ChiPhiThue + SoLuong*Gia, với SoLuong và Giá là từ bảng DichVuDiKem) 
cho tất cả các Khách hàng đã từng đặt phỏng. (Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
*/
 SELECT 
    kh.ma_khach_hang,
    kh.ho_ten,
    lk.ten_loai_khach,
    hd.ma_hop_dong,
    dv.ten_dich_vu,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    SUM(dv.chi_phi_thue + dvdk.gia * dvdk.don_vi) AS tong_tien
FROM
    khach_hang kh
        LEFT JOIN
    hop_dong hd ON kh.ma_khach_hang = hd.ma_khach_hang
        LEFT JOIN
    dich_vu dv ON dv.ma_dich_vu = hd.ma_dich_vu
        LEFT JOIN
    loai_khach lk ON lk.ma_loai_khach = kh.ma_loai_khach
        LEFT JOIN
    hop_dong_chi_tiet hdct ON hdct.ma_hop_dong = hd.ma_hop_dong
        LEFT JOIN
    dich_vu_di_kem dvdk ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
    GROUP BY kh.ma_khach_hang;
    
   /* Task6: Hiển thị maDichVu, TenDichVu, DienTich, ChiPhiThue, TenLoaiDichVu của tất cả các loại Dịch vụ chưa từng được 
Khách hàng thực hiện đặt từ quý 1 của năm 2019 (Quý 1 là tháng 1, 2, 3).
*/

SELECT DISTINCT
    dv.ma_dich_vu,
    dv.ten_dich_vu,
    dv.dien_tich,
    dv.chi_phi_thue,
    ldv.ten_loai_dich_vu
FROM
    dich_vu dv
        JOIN
    loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
        JOIN
    hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
WHERE
    dv.ma_dich_vu NOT IN (SELECT
            dv.ma_dich_vu
        FROM
            dich_vu dv
                JOIN
            hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
        WHERE
            (QUARTER(hd.ngay_lam_hop_dong) = 1)
                AND (YEAR(hd.ngay_lam_hop_dong) = 2019));
    
  /*
Task 7: Hiển thị thông tin maDichVu, TenDichVu, DienTich, SoNguoiToiDa, ChiPhiThue, TenLoaiDichVu của tất cả các loại dịch vụ 
đã từng được Khách hàng đặt phòng trong năm 2018 nhưng chưa từng được Khách hàng đặt phòng trong năm 2019.
*/

SELECT DISTINCT
    dv.ma_dich_vu,
    dv.ten_dich_vu,
    dv.dien_tich,
    dv.so_nguoi_toi_da,
    dv.chi_phi_thue,
    ldv.ten_loai_dich_vu
FROM
    dich_vu dv
        JOIN
    loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
        JOIN
    hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
WHERE
    dv.ma_dich_vu IN (SELECT 
            dv.ma_dich_vu
        FROM
            dich_vu dv
                JOIN
            hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
        WHERE
            YEAR(hd.ngay_lam_hop_dong) = 2018)
        AND dv.ma_dich_vu NOT IN (SELECT 
            dv.ma_dich_vu
        FROM
            dich_vu dv
                JOIN
            hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
        WHERE
            YEAR(hd.ngay_lam_hop_dong) = 2019);
            
            /*
Task 8: Hiển thị thông tin HoTenKhachHang có trong hệ thống, với yêu cầu HoTenKhachHang không trùng nhau. 
Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên
*/
-- Cách 1: Sử dụng DISTINCT
SELECT DISTINCT
    ho_ten
FROM
    khach_hang;

-- Cách 2: Sử dụng UNION
SELECT 
    ho_ten
FROM
    khach_hang 
UNION SELECT 
    ho_ten
FROM
    khach_hang;

-- Cách 3: Sử dụng GROUP BY
SELECT 
    ho_ten
FROM
    khach_hang
GROUP BY ho_ten;

/*
Task 9: Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2019 thì 
sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
*/
SELECT 
    MONTH(hd.ngay_lam_hop_dong) AS thang,
    SUM(dv.chi_phi_thue + dvdk.gia * dvdk.don_vi) AS doanh_thu,
    COUNT(hd.ma_khach_hang) AS so_luong_khach_hang
FROM
    hop_dong hd
        JOIN
    dich_vu dv ON hd.ma_dich_vu = dv.ma_dich_vu
        JOIN
    hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
        JOIN
    dich_vu_di_kem dvdk ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
WHERE
    YEAR(hd.ngay_lam_hop_dong) = 2019
GROUP BY MONTH(hd.ngay_lam_hop_dong)
ORDER BY MONTH(hd.ngay_lam_hop_dong);

/*
Task 10: Hiển thị thông tin tương ứng với từng Hợp đồng thì đã sử dụng bao nhiêu Dịch vụ đi kèm. 
Kết quả hiển thị bao gồm maHopDong, NgayLamHopDong, NgayKetthuc, TienDatCoc, SoLuongDichVuDiKem 
(được tính dựa trên việc count các IDHopDongChiTiet).
*/
SELECT 
    hd.ma_hop_dong,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    hd.tien_dat_coc,
    COUNT(hdct.ma_dich_vu_di_kem) AS so_luong_dich_vu_di_kem
FROM
    hop_dong hd
        JOIN
    hop_dong_chi_tiet hdct ON hdct.ma_hop_dong = hd.ma_hop_dong
        JOIN
    dich_vu_di_kem dvdk ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
GROUP BY hdct.ma_hop_dong
ORDER BY hd.ma_hop_dong;

/*
Task 11: Hiển thị thông tin các Dịch vụ đi kèm đã được sử dụng bởi những Khách hàng có TenLoaiKhachHang là “Diamond” và 
có địa chỉ là “Vinh” hoặc “Quảng Ngãi”.
*/
SELECT 
    dvdk.ma_dich_vu_di_kem,
    dvdk.ten_dich_vu_di_kem,
    dvdk.gia,
    dvdk.don_vi
FROM
    dich_vu_di_kem dvdk
        JOIN
    hop_dong_chi_tiet hdct ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
        JOIN
    hop_dong hd ON hd.ma_hop_dong = hdct.ma_hop_dong
        JOIN
    khach_hang kh ON kh.ma_khach_hang = hd.ma_khach_hang
        JOIN
    loai_khach lk ON lk.ma_loai_khach = kh.ma_loai_khach
WHERE
    lk.ten_loai_khach = 'Diamond'
        AND (kh.dia_chi = 'Vinh'
        OR kh.dia_chi = 'Quảng Ngãi');
        
        /*
Task 12: Hiển thị thông tin maHopDong, TenNhanVien, TenKhachHang, SoDienThoaiKhachHang, TenDichVu, SoLuongDichVuDikem 
(được tính dựa trên tổng Hợp đồng chi tiết), TienDatCoc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2019 
nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2019.
*/
SELECT 
    hd.ma_hop_dong,
    dv.ma_dich_vu,
    hd.ngay_lam_hop_dong,
    nv.ho_ten,
    kh.ho_ten,
    kh.SDT,
    COUNT(hdct.ma_dich_vu_di_kem) AS so_luong_dich_vu_di_kem
FROM
    dich_vu dv
        JOIN
    hop_dong hd ON dv.ma_dich_vu = hd.ma_dich_vu
        JOIN
    khach_hang kh ON hd.ma_khach_hang = kh.ma_khach_hang
        JOIN
    nhan_vien nv ON nv.ma_nhan_vien = hd.ma_nhan_vien
        JOIN
    hop_dong_chi_tiet hdct ON hdct.ma_hop_dong = hd.ma_hop_dong
        JOIN
    dich_vu_di_kem dvdk ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
WHERE
    dv.ma_dich_vu IN (SELECT 
            dv.ma_dich_vu
        FROM
            dich_vu dv
                JOIN
            hop_dong hd ON dv.ma_dich_vu = hd.ma_dich_vu
        WHERE
            (QUARTER(hd.ngay_lam_hop_dong) = 4)
                AND (YEAR(hd.ngay_lam_hop_dong) = 2019))
        AND dv.ma_dich_vu NOT IN (SELECT 
            dv.ma_dich_vu
        FROM
            dich_vu dv
                JOIN
            hop_dong hd ON dv.ma_dich_vu = hd.ma_dich_vu
        WHERE
            (QUARTER(hd.ngay_lam_hop_dong) = 1
                OR QUARTER(hd.ngay_lam_hop_dong) = 2)
                AND (YEAR(hd.ngay_lam_hop_dong) = 2019))
GROUP BY hdct.ma_hop_dong
HAVING YEAR(hd.ngay_lam_hop_dong) = 2019;

/*
Task 13: Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. 
(Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
*/

SELECT 
    hdct.ma_dich_vu_di_kem,
    dvdk.ten_dich_vu_di_kem,
    COUNT(hdct.ma_dich_vu_di_kem) AS so_luong_dich_vu_di_kem
FROM
    hop_dong_chi_tiet hdct
        JOIN
    dich_vu_di_kem dvdk ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
GROUP BY hdct.ma_dich_vu_di_kem
HAVING COUNT(hdct.ma_dich_vu_di_kem) >= ALL (SELECT 
        COUNT(hdct.ma_dich_vu_di_kem)
    FROM
        hop_dong_chi_tiet hdct
    GROUP BY hdct.ma_dich_vu_di_kem);
    
    
    /*
Task 14: Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. 
Thông tin hiển thị bao gồm maHopDong, TenLoaiDichVu, TenDichVuDiKem, SoLanSuDung.
*/
SELECT 
    hd.ma_hop_dong,
    ldv.ten_loai_dich_vu,
    dvdk.ten_dich_vu_di_kem,
    COUNT(hdct.ma_dich_vu_di_kem) AS so_lan_su_dung
FROM
    hop_dong hd
        JOIN
    dich_vu dv ON hd.ma_dich_vu = dv.ma_dich_vu
        JOIN
    loai_dich_vu ldv ON ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
        JOIN
    hop_dong_chi_tiet hdct ON hdct.ma_hop_dong = hd.ma_hop_dong
        JOIN
    dich_vu_di_kem dvdk ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
GROUP BY dvdk.ma_dich_vu_di_kem
HAVING COUNT(hdct.ma_dich_vu_di_kem) = 1;
    
    
    /*
Task 15: Hiển thi thông tin của tất cả nhân viên bao gồm maNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai, DiaChi 
mới chỉ lập được tối đa 3 hợp đồng từ năm 2018 đến 2019.
*/
SELECT 
    nv.ma_nhan_vien,
    nv.ho_ten,
    td.trinh_do,
    bp.ten_bo_phan,
    nv.SDT,
    nv.dia_chi,
    COUNT(hd.ma_hop_dong) AS so_luong_lap_hop_dong
FROM
    nhan_vien nv
        JOIN
    hop_dong hd ON nv.ma_nhan_vien = hd.ma_nhan_vien
        JOIN
    trinh_do td ON nv.ma_trinh_do = td.ma_trinh_do
        JOIN
    bo_phan bp ON nv.ma_bo_phan = bp.ma_bo_phan
WHERE
    YEAR(hd.ngay_lam_hop_dong) BETWEEN 2018 AND 2019
GROUP BY nv.ma_nhan_vien
HAVING COUNT(hd.ma_hop_dong) <= 3;