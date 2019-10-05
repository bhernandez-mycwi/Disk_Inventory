/********************************************************************************************/
/*																							*/
/*	Author					Date				Log											*/
/*------------------------------------------------------------------------------------------*/
/*	Brian Hernandez		10/3/2019			Initial deployment of database					*/
/*											'disk_inventoryBH								*/
/*																							*/
/********************************************************************************************/
use master;
GO

DROP DATABASE IF EXISTS disk_inventoryBH;
CREATE DATABASE disk_inventoryBH;
GO

use disk_inventoryBH;
GO



--THIS TABLE HOLDS THE GENRE INFORMATION
CREATE TABLE genre(
	genre_id INT NOT NULL IDENTITY PRIMARY KEY,
	description NVARCHAR(255) NOT NULL
);



--THIS TABLE HOLDS THE STATUS INFORMATION
CREATE TABLE disk_status(
	status_id INT NOT NULL IDENTITY PRIMARY KEY,
	description NVARCHAR(255) NOT NULL
);



--THIS TABLE HOLDS THE DISK TYPE INFORMATION
CREATE TABLE disk_type(
	disk_type_id INT NOT NULL IDENTITY PRIMARY KEY,
	description NVARCHAR(255) NOT NULL
);



--THIS TABLE HOLDS THE DISK TYPE INFORMATION
CREATE TABLE artist_type(
	artist_type_id INT NOT NULL IDENTITY PRIMARY KEY,
	description NVARCHAR(255) NOT NULL
);



--THIS TABLE HOLDS THE ARTIST INFORMATION
CREATE TABLE artist(
	artist_id		INT NOT NULL PRIMARY KEY,
	artist_first	VARCHAR(100) NOT NULL,
	artist_last		VARCHAR(100) NULL,
	artist_type_id	INT NOT NULL REFERENCES artist_type(artist_type_id)
);
GO



--THIS TABLE HOLDS THE CD INFORMATION
CREATE TABLE disk_info(
	disk_id					INT NOT NULL PRIMARY KEY IDENTITY,
	disk_name				VARCHAR(50) NOT NULL,
	disk_status				INT NOT NULL REFERENCES disk_status(status_id),
	disk_type				INT NOT NULL REFERENCES disk_type(disk_type_id),
	genre_id				int NOT NULL REFERENCES genre(genre_id),
	release_date			DATETIME NOT NULL
);
GO



--THIS TABLE IS AN INTERSCTION OF THE 'disk_info' AND 'artist' tables
CREATE TABLE cd_artist(
	disk_id					INT NOT NULL REFERENCES disk_info(disk_id),
	artist_id				INT NOT NULL REFERENCES artist(artist_id)
);
create index pk_cd_artist on cd_artist(disk_id, artist_id) ;
GO



--THIS TABLE HOLDS THE BORROWER INFORMATION
CREATE TABLE borrower(
	borrower_id				INT NOT NULL PRIMARY KEY IDENTITY,
	borrower_first			NVARCHAR(30) NOT NULL,
	borrower_last			NVARCHAR(30) NOT NULL,
	borrower_phone_number	NVARCHAR(20) NOT NULL
	--borrowed_date			DATETIME NOT NULL 
);



--THIS TABLE IS AN INTERSCTION OF THE 'disk' AND 'borrower' tables
CREATE TABLE disk_borrower(
	disk_id					INT NOT NULL REFERENCES disk_info(disk_id),
	borrower_id				INT NOT NULL REFERENCES borrower(borrower_id),
	borrow_date				DATETIME NOT NULL,
	return_date				DATETIME NULL,

	PRIMARY KEY (borrower_id, disk_id, borrow_date)
);



--Create login for disk
if SUSER_ID('diskbh') is null
create login diskbh WITH PASSWORD = 'MSPress#1',  DEFAULT_DATABASE = disk_inventoryBH;



--create user for disk
if USER_ID('diskbh') is null
create user diskbh;



--add permissions to user
alter role db_datareader add member diskbh;
