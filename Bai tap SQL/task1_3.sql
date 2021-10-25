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