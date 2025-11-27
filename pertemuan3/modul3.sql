--Menampilkan semua data pada tabel product
SELECT *
FROM Production.product;

--Menampilkan Name, ProductNumber, dan ListPrice
SELECT Name, ProductNumber, ListPrice
FROM Production.product;

--menampilkan data menggunakan alias kolom
SELECT Name AS [Nama Barang], ListPrice AS 'Harga Jual'
FROM Production.product;

--menampilkan HargaBaru = ListPrice * 1.1
SELECT Name, ListPrice, (Listprice * 1.1) AS HargaBaru
FROM Production.product;

--menampilkan data dengan menggabungkan string
SELECT Name + '(' + ProductNumber + ')' AS ProdukLengkap
FROM Production.product;

--Filterisasi Data
--menampilkan produk yang berwarna 'red'
SELECT Name, Color, ListPrice
FROM Production.product
WHERE Color = 'red';

--menampilkan produk yang ListPricenya lebih dari 1000
SELECT Name,ListPrice
FROM Production.Product
WHERE ListPrice < 1000;

--menampilkan produk yang bernama balck dan list pricenya lebih dari 500
SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color = 'black' AND ListPrice > 500;

--menapilkan procuk yang berwarna red,blue, atau black
SELECT Name, Color
FROM Production.Product
WHERE Color IN ('red', 'blue', 'black')

--menampilkan produk yang namanya mengandung kata 'Road'
SELECT Name, ProductNumber
FROM Production.Product
WHERE Name LIKE '%Bike%';

--Agresasi dan Pengelompokan
--menghitung total baris
SELECT COUNT(*) AS TotalProduk
FROM Production.Product;

--Menampilkan warna produk dan jumlahnnya
SELECT Color, COUNT(*) AS JumlahProduk
FROM Production.Product
GROUP BY Color;

--menampilkan ProductID, jumlah orderQTY, dan rata2 UnitPrice
SELECT ProductID, SUM(OrderQty) AS TotalTerjual, AVG(UnitPrice) AS RataRataHarga 
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

SELECT *
FROM Sales.SalesOrderDetail

--menampilkan data dengan grouping lebih dari satu kolom
SELECT Color,Size, COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color, Size;

SELECT *
FROM Production.Product

--Filter Hasil Agregasi
--menampilkan warna produk yang jumlahnya lebih dari 20
SELECT Color, COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color
HAVING COUNT(*) > 2;

--menampilkan warna produk yang ListPricenya > 500 dan jumlahnya > 10
SELECT Color, COUNT(*) AS Jumlah
FROM Production.Product
WHERE ListPrice > 500
GROUP BY Color
HAVING COUNT(*) < 10;


--menampilkan ProductID yang jumlah OrderQTYnya lebih dari 100
SELECT ProductID, SUM(OrderQty) AS RataRataBeli
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 10;


--menampilkan SpecialofferID yang rata2 orderQtynya kurang dari 2
SELECT SpecialOfferID, AVG(OrderQty) AS RataRataBeli
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID
HAVING AVG(OrderQty) > 2;

--menampilkan warna yang ListPricenya lebih dari 3000 menggunakan MAX
SELECT Color
FROM Production.Product
GROUP BY Color HAVING MAX(ListPrice) > 3000;

--Advance Select dan Order By
--menampilkan Jobtitle tanpa duplikat
SELECT DISTINCT JobTitle
FROM HumanResources.Employee;

--menampilkan 5 nama produk termahal
SELECT TOP 5 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

--OFFSET FETCH
SELECT Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC
OFFSET 2 ROWS
FETCH NEXT 4 ROWS ONLY;

SELECT Name ListPrice
FROM Production.Product
ORDER BY ListPrice DESC

SELECT TOP 3 Color, SUM(ListPrice) AS TotalNilaiStok
FROM Production.Product
WHERE ListPrice > 0
GROUP BY Color
ORDER BY TotalNilaiStok DESC;

--TUGAS MANDIRI
--1
--menampilkan ProductID & LineTotal AS TotalUang dan setiap kelompok produk, melakukan SUM(LineTotal).
SELECT ProductID, SUM(LineTotal) AS TotalUang
-- SQL mengambil semua data dari kolom SalesOrderDetail.
FROM Sales.SalesOrderDetail
--Mengelompok kan baris berdasarkan ProductID.
GROUP BY ProductID;

--2
--Menampilkan ProductID dan total uangnya, lalu menghitung total uang per produk dari baris yang sudah lolos filter.
SELECT ProductID, SUM(LineTotal) AS TotalUang
-- Ambil semua data dari SalesOrderDetail.
FROM Sales.SalesOrderDetail
--menyaring baris – hanya transaksi dengan OrderQty minimal 2 yang diproses.
WHERE(OrderQty) >= 2
-- Setelah disaring, data dikelompokkan berdasarkan ProductID.
GROUP BY ProductID
	

--3
-- Menampilkan total uang dari tiap produk.
SELECT ProductID, SUM(LineTotal) AS TotalUang
-- Mengambil data dariy SalesOrderDetail.
FROM Sales.SalesOrderDetail
-- Filter: hanya transaksi dengan jumlah beli minimal 2.
WHERE(OrderQty) >= 2
--Mengelompokkan berdasarkan ProductID 
GROUP BY ProductID;

--4
-- Menampilkan ProductID & total pendapatan.
SELECT ProductID, SUM(LineTotal) AS TotalUang
 -- Mengambil data dari tabel SalesOrderDetail.
FROM Sales.SalesOrderDetail
-- Filter awal: hanya transaksi OrderQty >= 2.
WHERE(OrderQty) >= 2
--mengelompokkan baris berdasarkan ProductID.
GROUP BY ProductID
 -- Filter hasil agregasi: hanya produk dengan total > 50.000.
HAVING SUM(LineTotal)> 50000;

--5
 -- Menampilkan ProductID & total pendapatan.
SELECT ProductID, SUM(LineTotal) AS TotalUang
-- Sumber data SalesOrderDetail.
FROM Sales.SalesOrderDetail
-- Kelompokkan per produk.
GROUP BY ProductID
-- Mengurutkan dari pendapatan terbesar ke terkecil.
ORDER BY TotalUang DESC;

--6
-- Menampilkan 10 produk dengan pendapatan tertinggi.
SELECT TOP 10 ProductID, SUM(LineTotal) AS TotalUang
-- Mengambil semua data transaksi.
FROM Sales.SalesOrderDetail
-- Mengelompokkan baris berdasarkan ProductID.
GROUP BY ProductID
-- Urutkan dari total pendapatan tertinggi.
ORDER BY TotalUang DESC;
