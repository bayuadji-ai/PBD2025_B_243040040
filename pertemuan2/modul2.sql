--Buat Database TokoRetailDB
CREATE DATABASE TokoRetailDB;

--Gunakan DB TokoRetailDB
USE TokoRetailDB;

--Membuat tabel kategori produk
CREATE TABLE KategoriProduk (
	KategoriID INT IDENTITY(1,1) PRIMARY KEY,
	NamaKategori VARCHAR(100) NOT NULL UNIQUE
);

--Membuat tabel Produk
CREATE TABLE Produk(
	ProdukID  INT IDENTITY(1001,1) PRIMARY KEY,
	SKU VARCHAR(20) NOT NULL UNIQUE,
	NamaProduk VARCHAR(150) NOT NULL,
	Harga DECIMAL(10,2) NOT NULL,
	Stok INT NOT NULL,
	KategoriID INT NULL,

	--Hargannya gaboleh negatif
	CONSTRAINT CHK_HargaPositif CHECK (Harga >=0),
	--stoknya gaboleh negatif
	CONSTRAINT CHK_StokPositif CHECK (Stok >=0),
	--relasikan dengan tabel KategoriProduk melalui kategoriID
	CONSTRAINT FK_Produk_Kategori
		FOREIGN KEY (KategoriID)
		REFERENCES KategoriProduk(KategoriID)
);

--memasukkan data ke tabel KategoriProduk
INSERT INTO KategoriProduk (NamaKategori)
VALUES
('Elektronik');

INSERT INTO KategoriProduk (NamaKategori)
VALUES
('Pakaian'),
('Buku');

--Menampilkan tabel KategoriProduk
SELECT *
FROM KategoriProduk;

--Hanya menampilkan NamaKategori
SELECT NamaKategori
FROM KategoriProduk;

--Menambahkan data ke tabel Produk
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('ELEC-001', 'Laptop Gaming', 15000000.00, 50, 2);

INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('ELEC-002', 'HP Gaming', 50000000.00, 50, 1);

--menampilkan produk
SELECT *
FROM Produk;

--Mengubah data stok laptop gaming menjadi 30
UPDATE Produk
SET Stok = 30
WHERE ProdukID = 1001;

--Menghapus data HP Gaming
BEGIN TRANSACTION;

DELETE FROM Produk
WHERE ProdukID = 1004;

COMMIT TRANSACTION;

--menambahkan data baru ke Produk
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('BAJU-001', 'Kaos Putih', 50000.00, 30, 2);

INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('BAJU-002', 'Kaos Hitam', 50000.00, 30, 2);

--Menghapus kaos putih
BEGIN TRANSACTION;

DELETE FROM Produk
WHERE ProdukID = 1005;

ROLLBACK TRANSACTION;