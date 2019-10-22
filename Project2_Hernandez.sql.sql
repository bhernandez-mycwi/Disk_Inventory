/********************************************************************************/
/*																				*/
/*	Author			Date			Log											*/
/*------------------------------------------------------------------------------*/
/*	Brian Hernandez	10/3/2019	Initial deployment of database					*/
/*									'disk_inventoryBH							*/
/*------------------------------------------------------------------------------*/
/*	Brian Hernandez	10/10/2019	Project 3: Insert/delete/update rows;			*/
/*									begins on line 145							*/	
/*------------------------------------------------------------------------------*/
/*	Brian Hernandez	10/17/2019	Project 4: Create a view and run multiple selects*/
/*									begins on line 340							*/
/*------------------------------------------------------------------------------*/
/*	Brian Hernandez	10/22/2019	Project 5: Create and Exec stored procedures		*/
/*									begins on line 400							*/
/*------------------------------------------------------------------------------*/
/********************************************************************************/
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
	release_date			DATE NOT NULL
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







/************************************************/

/*          	Begin Project 3 	    		*/

/************************************************/





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
('Solo'),
('Band')

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
	,('The Cars', null, 2)
	,('Black Sabbath',null, 2)
	,('Stone Temple Pilots', null, 2)
	,('Seether', NULL, 2)
	,('Disturbed',NULL, 2)
	,('Paul', 'McCartney', 1)
	,('The White Stripes', NULL, 2)
	,('The Rolling Stones', null, 2)
	,('Creedence Clearwater Revival',Null, 2)
	,('The Beatles', null, 2)
	,('R.E.M', null, 2)
	,('Lynyrd Skynyrd',null, 2)
	,('Serj', 'Tankian', 1)
	,('Avenged Sevenfold', null, 2)
	,('Gratefull Dead', null, 2)
	,('Metallica', NULL, 2);
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
SELECT borrower_id, disk_id, convert(date,borrow_date,23) as [Borrow Date], convert(date,return_date, 23) as [Return Date]
FROM disk_borrower
WHERE return_date IS NULL;

/************************************************/

/*          	Begin Project 4 	    		*/

/************************************************/

--3. Show the disks in your database and any associated Individual artists only. Sort by Artist Last Name, First Name & Disk Name.
select disk_name as [Disk Name], release_date as [Release Date], artist_first as [Artist First Name], artist_last as [Artist Last Name]
from disk_info
join cd_artist on cd_artist.disk_id = disk_info.disk_id
join artist on artist.artist_id = cd_artist.artist_id
join artist_type on artist.artist_type_id = artist_type.artist_type_id
where artist_type.artist_type_id = 1
order by 4, 3, 1
GO

--4. Create a view called View_Individual_Artist that shows the artists’ names and not group names. Include the artist id in the view definition but do not display the id in your output.
drop view if exists View_Individual_Artist
go
create view View_Individual_Artist AS
select artist_first, artist_last, artist_id
from artist

where artist.artist_type_id = 1
go

select artist_first as [Artist First], artist_last as [Artist Last] from View_Individual_Artist

--5. Show the disks in your database and any associated Group artists only. Use the View_Individual_Artist view. Sort by Group Name & Disk Name.

select disk_name as [Disk Name], release_date as [Release Date], artist_first as [Group Name]
from disk_info
join cd_artist on cd_artist.disk_id = disk_info.disk_id
join artist on artist.artist_id = cd_artist.artist_id
where artist.artist_id not in 
	(select artist_id from View_Individual_Artist)
order by 3, 1

--6. Show which disks have been borrowed and who borrowed them. Sort by Borrower’s Last Name, then First Name, then Disk Name, then Borrowed Date, then Returned Date.

select borrower_first as [First], borrower_last as [Last], disk_name as [Disk Name], convert(date, borrow_date, 120) as [Check Out Date], ISNULL(convert(varchar, return_date,23), 'NOT YET RETURNED') AS [Return Date]
from borrower
join disk_borrower on disk_borrower.borrower_id = borrower.borrower_id
join disk_info on disk_info.disk_id = disk_borrower.disk_id
order by 2, 1, 3, 4, 5

--7. In disk_id order, show the number of times each disk has been borrowed.

select disk_borrower.disk_id, disk_name, count(*) as [Times Borrowed] 
from disk_borrower
join disk_info on disk_info.disk_id = disk_borrower.disk_id
group by disk_borrower.disk_id, disk_name
order by 1


--8. Show the disks outstanding or on-loan and who has each disk. Sort by disk name.
--select disk_name, borrow_date as [Borrowed], return_date AS Returned, borrower_last as [Last Name]

select disk_name as [Disk Name], convert(date,borrow_date) as [Borrowed], ISNULL(convert(varchar, return_date,23), 'NOT YET RETURNED') AS Returned, borrower_last as [Last Name]
from disk_borrower
join borrower as b on b.borrower_id = disk_borrower.borrower_id
join disk_info as di on di.disk_id = disk_borrower.disk_id
where return_date IS NULL



---------Project 5----------

--2. Create Insert, Update, and Delete stored procedures for the artist table. Update procedure accepts a primary key value and the artist’s names for update. Insert accepts all columns as input parameters except for identity fields. Delete accepts a primary key value for delete.


--Insert Artist Stored Procedure
drop proc if exists sp_Insert_Artist
go

create PROC sp_Insert_Artist
	@artist_first	nvarchar(100),
	@artist_type_id	int,
	@artist_last	nvarchar(100) = NULL
as
begin try
	INSERT INTO [dbo].[artist]
			   ([artist_first]
			   ,[artist_last]
			   ,[artist_type_id])
		 VALUES
			   (@artist_first
			   ,@artist_last
			   ,@artist_type_id)
end try
begin catch
	print 'An error has occurred. Row was not inserted';
	print 'Error Number: ' +  convert(varchar, ERROR_NUMBER());
	print 'Error Message: ' + ERROR_MESSAGE();

end catch
GO


--Update Artist Stored Procedure
drop proc if exists sp_Update_Artist
go
create proc sp_Update_Artist
	@artist_id int,
	@artist_first nvarchar(100),
	@artist_last nvarchar(100),
	@artist_type_id int
as
begin try
	UPDATE [dbo].[artist]
	   SET [artist_first] = @artist_first
		  ,[artist_last] = @artist_last
		  ,[artist_type_id] = @artist_type_id
	 WHERE artist_id = @artist_id
end try
begin catch
	print 'An error has occurred. Row was not inserted';
	print 'Error Number: ' + convert(varchar, ERROR_NUMBER());
	print 'Error Message: ' + ERROR_MESSAGE();
end catch
GO

--Delete Artist Stored Procedure
drop proc if exists sp_Delete_Artist
go
Create proc sp_Delete_Artist
	@artist_id int
as
begin try
	DELETE FROM [dbo].[artist]
		  WHERE artist_id = @artist_id;
end try
begin catch
	print 'An error has occurred. Row was not inserted';
	print 'Error Number: ' + convert(varchar, ERROR_NUMBER());
	print 'Error Message: ' + ERROR_MESSAGE();
end catch

GO

--execute statements for stored procedures
exec sp_Update_Artist 22, 'Bruno', 'Mars', 1
exec sp_Insert_Artist 'Cher', 1
exec sp_Delete_Artist 23
select * from artist