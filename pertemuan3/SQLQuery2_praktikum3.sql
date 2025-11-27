--Menampilkan semua data pada tabel product
SELECT *
FROM Production.Product;

--Menampilkan Nama,ProductNumber,dan ListPrice
SELECT Name,ProductNumber,ListPrice
FROM Production.Product;

--Menampilkan data menggunakan alias kolom
SELECT Name AS [Nama Barang],ListPrice AS 'Harga Jual'
FROM Production.Product;

--Menampilkan HargaBaru = ListPrice * 1.1
SELECT Name,ListPrice,(ListPrice * 1.1) AS HargaBaru
FROM Production.Product;

--Menampilkan data dengan menggabungkan string
SELECT Name + '(' + ProductNumber + ')' AS ProdukLengkap
FROM Production.Product;

--Filterisasi data 
--Menampilkan produk yang berwarna 'red'
SELECT Name,Color,ListPrice
FROM Production.Product
WHERE Color = 'red';

--menampilkan produk yang ListPricenya lebih dari 1000
SELECT Name,ListPrice
FROM Production.Product
WHERE ListPrice < 1000;

--Menampilkan produk yang bewarna black dan list pricenya lebih dari 500
SELECT Name,Color,ListPrice
FROM Production.Product
WHERE Color = 'black' AND ListPrice > 500;

--Menampilkan produk yang berwarna red,blue,black
SELECT Name,Color
FROM Production.Product
WHERE Color IN ('red','blue','black');

--Menaampilkan produk yang namanya mengandung kata 'Road'
SELECT Name,ProductNumber
FROM Production.Product
WHERE Name LIKE '%Road%';

--Agregasi dan pengelompokkan
--menghitung total baris
SELECT COUNT(*) AS TotalProduk
FROM Production.Product;

--Menampilkan warna produk dan jumlahnya
SELECT Color,COUNT(*) AS JumlahProduk
FROM Production.Product
GROUP BY Color;

--Menampilkan ProductID,jumlah OrderQty,dan rata rata UnitPrice
SELECT ProductID,SUM(OrderQty) AS TotalTerjual,AVG(UnitPrice) AS RataRataHarga
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

SELECT *
FROM Sales.SalesOrderDetail;

--Menampilkan data dengan grouping lebih dari satu kolom
SELECT Color,Size,COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color,Size;

SELECT *
From Production.Product;

--Filter Hasil Agregasi
--Menampilkan warna produk yang jumlahnya lebih dari 20
SELECT Color,COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color
HAVING COUNT(*) > 2;

--menampilkan warna produk yang ListPricenya > 500 dan jumlahnya > 10
SELECT Color,COUNT(*) AS Jumlah
From Production.Product
WHERE ListPrice > 500
GROUP BY Color
HAVING COUNT(*) > 1;

--Menampilkan ProductID yang jumlahnya lebih dari 100
SELECT ProductID,SUM(OrderQty) AS RataRataBeli
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 10;

--Menampilkan SpecialOfferID yang rata rata OrderQty-nya kurang dari 2
SELECT SpecialOfferID,AVG(OrderQty) AS RataRataBeli
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID
HAVING AVG(OrderQty) > 2;

--Menampilkan warna yang ListPricenya lebih dari 3000 menggunakan MAX
SELECT Color
FROM Production.Product
GROUP BY Color
HAVING MAX(ListPrice) > 3000;

--Advanced Select dan Order By
--Menampilkan JobTitle tanpa duplikat
SELECT DISTINCT JobTitle
FROM HumanResources.Employee;

SELECT JobTitle
FROM HumanResources.Employee;

--menampilkan 5 nama produk termahal
SELECT TOP 5 Name,ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

--OFFSET FETCH
SELECT Name,ListPrice
FROM Production.Product
ORDER BY ListPrice DESC
OFFSET 2 ROWS
FETCH NEXT 4 ROWS ONLY;

SELECT Name,ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

SELECT TOP 3 Color,SUM(ListPrice) AS TotalNilaiStok
FROM Production.Product
WHERE ListPrice > 0
GROUP BY Color
ORDER BY TotalNilaiStok DESC;




--TUGAS MANDIRI

--1
SELECT ProductID,SUM(LineTotal) AS TotalUang --Menampilkan ProductID & LineTotal AS TotalUang dan setiap kelompok produk,SQL Melakukan SUM(LineTotal)
FROM Sales.SalesOrderDetail --SQL mengambil semua data dari kolom SalesOrderDetail
GROUP BY ProductID; --Mengelompokkan baris berdasarkan ProductID

--2
SELECT ProductID,SUM(OrderQty) AS JumlahBeli --Menampilkan ProductID dan total uangnya, lalu menghitung total uang per produk dari baris yang sudah lolos filter.
FROM Sales.SalesOrderDetail -- -- Ambil semua data dari SalesOrderDetail.
WHERE (OrderQty) >= 2 --hanya transaksi dengan OrderQty minimal 2 yang diproses.
GROUP BY ProductID; --Setelah disaring, data dikelompokkan berdasarkan ProductID.


--3
SELECT ProductID,SUM(LineTotal) AS TotalUang --Menampilkan total uang dari tiap produk.
FROM Sales.SalesOrderDetail --Mengambil data dari SalesOrderDetail.
GROUP BY ProductID; --Mengelompokkan berdasarkan ProductID (tahap inti dari nomor 3).

--4
SELECT ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan ProductID & total pendapatan.
FROM Sales.SalesOrderDetail --Mengambil data dari tabel SalesOrderDetail.
GROUP BY ProductID --SQL mengelompokkan baris berdasarkan ProductID.
HAVING SUM(LineTotal) > 50000; -- Filter hasil agregasi: hanya produk dengan total > 50.000.

--5
SELECT ProductID, SUM(LineTotal) AS TotalUang --Menampilkan ProductID & total pendapatan.
FROM Sales.SalesOrderDetail --Sumber data SalesOrderDetail.
GROUP BY ProductID --Kelompokkan per produk.
ORDER BY TotalUang DESC; --Mengurutkan dari pendapatan terbesar ke terkecil

--6
SELECT TOP 10 ProductID,SUM(LineTotal) AS TotalUang --Menampilkan 10 produk dengan pendapatan tertinggi.
FROM Sales.SalesOrderDetail --Mengambil semua data transaksi.
GROUP BY ProductID --Mengelompokkan baris berdasarkan ProductID.
ORDER BY TotalUang DESC; --Urutkan dari total pendapatan tertinggi.

