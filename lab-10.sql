--36.	
SELECT MASP, COUNT(DISTINCT MASP) AS TONGSO
FROM SANPHAM
WHERE MASP IN(SELECT MASP
FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
WHERE MONTH(NGHD) = 10 AND YEAR(NGHD) = 2006)
GROUP BY MASP
--37.	
SELECT MONTH(NGHD) AS THANG, SUM(TRIGIA) AS DOANHTHU
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
--38.	
SELECT *
FROM HOADON
WHERE SOHD IN(SELECT SOHD
FROM CTHD
WHERE SL >= 4)
--39.	
SELECT *
FROM HOADON
WHERE SOHD IN(SELECT SOHD
FROM CTHD C INNER JOIN SANPHAM S
ON C.MASP = S.MASP
WHERE NUOCSX = 'VIET NAM' AND SL >= 3)
--40.	 
SELECT MAKH, HOTEN
FROM KHACHHANG
WHERE MAKH = (SELECT TOP 1 MAKH
FROM HOADON
GROUP BY MAKH
ORDER BY COUNT(DISTINCT SOHD) DESC)
--41.	
SELECT TOP 1 MONTH(NGHD) AS THANG_DOANHSO_MAX
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC
--42.	
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP = (SELECT TOP 1 MASP
FROM CTHD
GROUP BY MASP
ORDER BY SUM(SL) DESC)
--43.	*M?i n??c s?n xu?t, t?m s?n ph?m (MASP,TENSP) c? gi? b?n cao nh?t.

--CAU NAY KHO. DAU TIEN TIM MAX GIA CUA NUOCSX
SELECT NUOCSX, MAX(GIA) AS MAX
FROM SANPHAM
GROUP BY NUOCSX

--SAU DO DAT TEN BANG VUA ROI LA B, ROI THUC HIEN KET TRAI. OI HK THANH' VAI~ :))

SELECT B.NUOCSX, MASP, TENSP
FROM (SELECT NUOCSX, MAX(GIA) AS MAX
FROM SANPHAM
GROUP BY NUOCSX) AS B LEFT JOIN SANPHAM S 
ON S.GIA = B.MAX 
WHERE B.NUOCSX = S.NUOCSX
--44.

--45.	
-- DAU TIEN LA TIM 10 KHACH HANG CO DOANH SO CAO NHAT
SELECT TOP 10 MAKH
FROM KHACHHANG
ORDER BY DOANHSO DESC

--DAY LA BANG KHACH HANG VA SO LAN MUA
SELECT MAKH, COUNT(SOHD)
FROM HOADON
GROUP BY MAKH
