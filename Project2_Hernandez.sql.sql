/********************************************************************************************/
/*																							*/
/*	Author					Date				Log											*/
/*------------------------------------------------------------------------------------------*/
/*	Brian Hernandez		10/3/2019			Initial deployment of database					*/
/*											'disk_inventoryBH								*/
/*------------------------------------------------------------------------------------------*/
/*	Brian Hernandez		10/10/2019			Project 3: Insert/delete/update rows;			*/
/*														begins on line 145					*/
/*------------------------------------------------------------------------------------------*/
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
	artist_id		INT NOT NULL IDENTITY PRIMARY KEY,
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







/********************************************************************************************************/

/*											Begin Project 3 											*/

/********************************************************************************************************/





--Creates status' for the disk. Is it borrowed or in stock?
INSERT INTO disk_status(
	description
)
VALUES
	('borrowed')
	,('in stock')
	,('damaged')
	,('missing');

GO
--Creates disk type descriptions (CD/DVD/Blue-Ray)
INSERT INTO disk_type(
	description
)
VALUES
	('CD'),
	('DVD'),
	('Blue-Ray');
GO
--Creates genre descriptions for disks
INSERT INTO genre(
	description
)
VALUES
	('Classic Rock'),
	('Country'),
	('Alternative Rock'),
	('Heavy Metal');
GO

--creates artist_type table for the genre of the artist
INSERT INTO artist_type
([description])
Values
('Country'),
('Alternative Rock'),
( 'Heavy Metal'), 
('Classic Rock'),
 ('Pop')
go

--c. Disk table
INSERT INTO disk_info
 (disk_name, disk_status, disk_type, genre_id, release_date)
VALUES
	('Core', 1, 1, 1, 'September 29, 1992')
	,('Abbey Road', 1, 1, 1, 'September 29, 1992')
	,('Im Him', 2, 2, 2, 'September 29, 1992')
	,('Lover', 1, 2, 1, 'September 29, 1992')
	,('The White Stripes', 1, 1, 1, 'September 29, 1992')
	,('Harakiri', 2, 1, 1, 'September 29, 1992')
	,('Out of Time', 2, 1, 1, 'September 29, 1992')
	,('Bayou Country', 1, 2, 1, 'September 29, 1992')
	,('Street Survivors', 1, 2, 2, 'September 29, 1992')
	,('Nightmare', 1, 1, 1, 'September 29, 1992')
	,('Ride The Lightning', 3, 1, 1, 'September 29, 1992')
	,('Master of Puppets', 1, 1, 2, 'September 29, 1992')
	,('St. Anger', 1, 3, 3, 'September 29, 1992')
	,('Death Magnetic', 1, 1, 1, 'September 29, 1992')
	,('Karma and Effect', 1, 1, 1, 'September 29, 1992')
	,('Panorama', 2, 2, 1, 'September 29, 1992')
	,('Indestructible', 1, 1, 1, 'September 29, 1992')
	,('Nightmare', 1, 1, 1, 'September 29, 1992')
	,('Paranoid', 1, 1, 1, 'September 29, 1992')
	,('Ride Me Back Home', 1, 1, 1, 'September 29, 1992')
	;

	--c.2. Update only 1 row using a where clause
	update disk_info
	SET release_date = 'July 21, 1990' 
	where disk_id = 9

--d. Borrower table:
INSERT INTO borrower
(borrower_first, borrower_last, borrower_phone_number)
Values
	('Mickey', 'Mouse' , '1111111111')
	,('Minne', 'Mouse' , '2222222222')
	,('Donald', 'Duck' , '33333333333')
	,('Jim', 'Halpert' , '4444444444')
	,('Pamela', 'Halpert' , '5555555555')
	,('Dwight', 'Schrute' , '6666666666')
	,('Michael', 'Scott' , '7777777777')
	,('Lance', 'Camacho' , '8888888888')
	,('Daniel', 'Yorgey' , '9999999999')
	,('Chris', 'Hill' , '1999999999')
	,('Bruce', 'Wayne' , '2999999999')
	,('Damien', 'Wayne' , '3999999999')
	,('Bruce', 'Banner' , '4999999999')
	,('Peter', 'Parker' , '5999999999')
	,('Tony', 'Stark' , '6999999999')
	,('Bugs', 'Bunny' , '7999999999')
	,('Wile', 'Coyote' , '8999999999')
	,('Speedy', 'Gonzolez' , '2299999999')
	,('Slowpoke', 'Rodriguez' , '3399999999')
	,('Stanley', 'Hudson' , '4499999999')
	;
	--d.2. Delete only 1 row using a where clause
	DELETE borrower
	WHERE borrower_id = 19;

--e. Artist table:
INSERT INTO artist
	(artist_first, artist_last, artist_type_id)
VALUES
	('Ozzy', 'Osbourne', 1)
	,('Willie', 'Nelson', 1)
	,('Taylor', 'Swift', 1)
	,('Alanis', 'Morrisette', 1)
	,('Chris', 'Daughtry', 1)
	,('The Cars', null, 1)
	,('Black', 'Sabbath', 1)
	,('Stone Temple Pilots', null, 1)
	,('Seether', NULL, 1)
	,('Disturbed',NULL, 1)
	,('Willie', 'nelson', 1)
	,('The White Stripes', NULL, 1)
	,('The Rolling Stones', null, 1)
	,('Creedence Clearwater Revival',Null, 1)
	,('The', 'Beatles', 1)
	,('R.E.M', null, 1)
	,('Lynyrd','Skynyrd', 1)
	,('Serj', 'Tankian', 1)
	,('Avenged', 'Sevenfold', 1)
	,('Gratefull', 'Dead', 1)
	,('Metallica', NULL, 1);
GO


--f. DiskHasBorrower table:
INSERT INTO disk_borrower
	(borrower_id, disk_id, borrow_date, return_date)
VALUES
	(2,20, 'July 10, 2012', 'August 15, 2012')
	,(5,2, 'December 10, 2012', 'January 15, 2013')
	,(1,3, 'December 10, 2012', 'January 15, 2013')
	,(7,4, 'October 10, 2012', 'November 15, 2012')
	,(8,5, 'July 10, 2012', 'August 15, 2013')
	,(6, 6, 'October 10, 2012', 'October 15, 2013')
	,(10,7, 'January 10, 2012', 'January 15, 2013')
	,(7,8, 'October 10, 2012', 'October 15, 2013')
	,(9,9, 'January 10, 2012', 'January 15, 2013')
	,(2,10, 'October 10, 2012', 'October 15, 2013')
	,(2,11, 'October 10, 2012', 'October 15, 2013')
	,(2,12, 'October 10, 2012', 'October 15, 2013')
	,(1, 14, 'January 10, 2012', 'January 15, 2013')
	,(5,15, 'September 10, 2019', NULL)
	,(5,16, 'September 10, 2019', NULL)
	,(5,20, 'September 10, 2019', NULL)
	,(5,2, 'September 10, 2019', NULL)
	,(18,3, 'January 16, 2013', 'February 15, 2013')
	,(15,4, 'December 10, 2012', 'December 15, 2013')
	,(9,5, 'September 10, 2012', 'September 15, 2013');
GO

--g. DiskHasArtist table:
INSERT INTO [dbo].[cd_artist]
           ([disk_id],[artist_id])
     VALUES
           (2,2)
		   ,(3,3)
		   ,(4,4)
		   ,(5,5)
		   ,(6,6)
		   ,(7,7)
		   ,(8,8)
		   ,(9,9)
		   ,(19,1)
		   ,(19,7)
		   ,(12,12)
		   ,(13,13)
		   ,(14,14)
		   ,(15,15)
		   ,(16,16)
		   ,(17,17)
		   ,(18,18)
		   ,(19,19)
		   ,(12,21)
		   ,(13,21)
		   ,(14,21);

GO

--h. Create a query to list the disks that are on loan and have not been returned.
SELECT borrower_id, disk_id, borrow_date, return_date
FROM disk_borrower
WHERE return_date IS NULL;