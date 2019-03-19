/*
use master
drop database ProjektBazyFirmyTelekom
*/

create database ProjektBazyFirmyTelekom

use ProjektBazyFirmyTelekom

create table Region															
(
RegionID int not null primary key,
[Name] varchar(20) not null
);
create table Client										
(																							
ID int not null primary key,
[Name] Varchar(20),
Surename Varchar(30),
[Second Name] Varchar(20),
City varchar(40),
Adress varchar (40),
StreetNo int,
FlatNo int,
RegionID int foreign key references Region(RegionID)
);																							
	Create table Promotion																	 
	(
	ID int not null primary key,										
	Promotion_Name varchar(50),																
	[DTV Act] bit check ([DTV Act] in (0, 1)),																	
	[ATV Act] bit check ([ATV Act] in (0, 1)),																
	[INT Act] bit check ([INT Act] in (0, 1)),																
	[TEL Act] bit check ([TEL Act] in (0, 1)),																
	[PLA Act] bit check ([PLA Act] in (0, 1)),			
	[TMo Act] bit check ([TMo Act] in (0, 1)),																	
	[IMo Act] bit check ([IMo Act] in (0, 1)),
	Multiplier float																						
	);
alter table Client
add PromotionID int foreign key references Promotion(ID);	

		Create Table Products
		(
		ProductID int primary key not null,
		Product varchar(3),
		Price float,
		Home_Only int check (Home_Only in(1,0)),
		Time_Avaible int check(Time_Avaible in(6,12,24)),
		UpgradeAvaible bit check(UpgradeAvaible in (0,1)),
		DiscountAvaible bit check(DiscountAvaible in (0,1)),
		);
			Create Table Device
			(
			ID int primary key,
			[Name] varchar(15) unique,
			ProductsOn varchar (10),
			PowerSource int,
			Sockets varchar(30),
			InStock bit check(InStock in (1,0)),
			ExtraPayment int check(ExtraPayment in (0, 50, 110))
			);
		alter table Products 
		add Device int references device(ID);
	alter table Promotion
	add DeviceID int foreign key references Device(ID);
	alter table Promotion
	add Device2ID int foreign key references Device(ID);
	alter table Promotion 
	add Device3ID int foreign key references Device(ID);
	alter table Promotion
	add Device4ID int foreign key references Device(ID);
				Create Table Failure
				(
				[No] int primary key not null identity(1,1),
				RegionID int foreign key references Region(RegionID),
				FailureType varchar(3) check(FailureType in ('atv', 'dtv', 'int', 'tel', 'pla', 'tmo', 'imo', 'all', 'mob', 'sta')) not null,	
				Recognised smalldatetime not null,
				Expected smalldatetime,
				Repaired smalldatetime,
				DeviceID int foreign key references Device(ID),
				Device2ID int foreign key references Device(ID),
				Device3ID int foreign key references Device(ID),
				Device4ID int foreign key references Device(ID),
				Device5ID int foreign key references Device(ID)
				);
						Create Table Workers
						(
						WorkerID int not null primary key,
						HiredDate date,
						[Name] Varchar(20),
						Surename Varchar(30),
						Title Varchar(10),
						Occupation varchar(20),
						BornDate date
						);
					Create Table Visits
					(
					[No] int primary key not null identity(1,1),
					ClientID int foreign key references Client(ID),
					WorkerID int foreign key references Workers(WorkerID),
					[Date] smalldatetime,
					Finished  bit check (Finished in (0, 1)),
					[DTV Act] bit check ([DTV Act] in (0, 1)),																	
					[ATV Act] bit check ([ATV Act] in (0, 1)),																
					[INT Act] bit check ([INT Act] in (0, 1)),																
					[TEL Act] bit check ([TEL Act] in (0, 1)),																
					[PLA Act] bit check ([PLA Act] in (0, 1)),			
					[TMo Act] bit check ([TMo Act] in (0, 1)),																	
					[IMo Act] bit check ([IMo Act] in (0, 1)),
					);
						
insert into Region values 
(1, 'Slaskie'), (2, 'Malopolskie'), (3, 'Dolnoslaskie'), (4, 'Mazowieckie'), (5, 'Pomorskie'), (6, 'Lodzkie'), (7, 'Wielkopolskie')
insert into device values
(111, 'Dekoder', 'Dtv', 220, 'hdmi, scart', 1, 0), 
(211, 'Modem', 'Int', 220, 'Ethernet', 1, 50), 
(311, 'ModemTel', 'Tel', 220, 'rj', 1, 0),
(221, 'SIM', 'TMo/IMo', 220, 'Socket', 1, 50),
(231, 'Allin1', 'dtv', 220, 'hdmi, scart, Ethernet, rj', 1, 110),
(000, 'None', 'atv', 0, 'None', 1, 110);
insert into Products values
(1, 'DTV', 60, 1, 12, 0, 0, 111),
(2, 'INT', 50, 1, 12, 0, 0, 211),
(3, 'ATV', 30, 1, 6, 0, 0, 000),
(4, 'TMO', 70, 0, 24, 0, 0, 221),
(5, 'IMO', 70, 0, 24, 0, 0, 221),
(6, 'TEL', 10, 1, 12, 0, 0, 311);
insert into Promotion values 
(12498,  'Super Internet', 0, 0, 1, 0, 0, 0, 0, 1, 211, null, null, null),
(12353,  'Super Telefon', 0, 0, 0, 1, 0, 1, 0, 0.9, 311, 221, null, null),
(10975,  'Zwykla Telewizja', 0, 1, 0, 0, 0, 0, 0, 1, 000, null, null, null),
(15014,  'Super Pakiet Multi', 1, 0, 1, 0, 1, 0, 0, 0.85, 111, 211, null, null),
(10031,  'Pakiet DOM', 1, 1, 1, 1, 0, 0, 0, 0.75, 111, 211, 000, 311),
(9874,  'Pakiet Bussines', 0, 0, 1, 0, 1, 1, 1, 0.87, 211, 221, null, null),
(14990,  'Super Telewizja', 1, 0, 0, 0, 0, 0, 0, 1, 111, null, null, null);
insert into Client values
(4891749, 'Michal', 'Cop', 'Tomasz', 'Ruda', 'Jakastam', 5, null, 1, 15014),
(8654896, 'Halo', 'Aloha', 'Hola', 'Loha', 'Holaa', 3, 14, 4, 15014),
(4353733, 'Imie3', '3', 'a', 'aasd', 'Holaa', 44, 1, 3, 9874),
(5827902, 'Imie4', '4', 'b', 'sada', 'Holasd', 82, 14, 2, 15014),
(2342224, 'Imie5', '5', 'c', 'aasd', 'Hodfga', 44, 2, 3, 10031),
(2348357, 'Imie6', '6', 'd', 'asdf', 'Hgdfga', 111, null, 7, 10031),
(7445664, 'Imie7', '7', 'e', 'dfgr', 'Hofgha', 6, 14, 5, 10975),
(1231235, 'Imie8', '8', 'f', 'iukq', 'gdfgdf', 8, 17, 6, 12353);
insert into failure values
(1, 'dtv', '2018-05-15 14:56', '2018-05-15 19:00', '2018-05-16 15:44', 111, null, null, null, null),
(4, 'all', '2018-05-15 14:56', '2018-05-15 19:00', '2018-05-16 15:44', 111, 211, 221, 231, 311),
(4, 'mob', '2018-05-15 14:57', '2018-05-15 19:01', '2018-05-16 15:44', 221, null, null, null, null),
(3, 'dtv', '2018-05-15 14:58', '2018-05-15 19:02', '2018-05-16 15:44', 111, null, null, null, null),
(6, 'dtv', '2018-05-15 14:59', '2018-05-15 19:03', '2018-05-16 15:44', 111, null, null, null, null),
(2, 'dtv', '2018-05-15 14:53', '2018-05-15 19:04', '2018-05-16 15:44', 111, null, null, null, null),
(1, 'dtv', '2018-05-15 14:50', '2018-05-15 19:05', '2018-05-16 15:44', 111, null, null, null, null);
insert into workers values
(8392, '2018-05-13', 'Stefan', 'Halko', 'Junior', 'Servisant', '1988-03-14'),
(8323, '2018-05-13', 'Antek', 'Halko', 'Senior', 'Servisant', '1988-03-14'),
(8324, '2018-05-13', 'Stefan2', 'Halko2', 'Junior', 'Servisant', '1988-03-14'),
(7888, '2018-05-13', 'Stefan3', 'Halko3', 'Junior', 'Analyst', '1988-03-14'),
(6177, '2018-05-13', 'Stefan4', 'Halko4', 'Senior', 'Salesman', '1988-03-14'),
(7128, '2018-05-13', 'Stefan5', 'Halko5', 'CE', 'Analyst', '1988-03-14'),
(5666, '2018-05-13', 'Stefan6', 'Halko6', 'Junior', 'Accountant', '1988-03-14');
insert into Visits values
(1231235, 8392, '2018-05-13', 1, 0, 0, 0, 1, 0, 0, 0),
(8654896, 8392, '2018-05-13', 1, 1, 0, 1, 0, 0, 0, 0),
(4891749, 8323, '2018-05-13', 0, 1, 0, 0, 0, 0, 0, 0),
(4891749, 8324, '2018-05-13', 1, 0, 0, 0, 0, 1, 0, 0),
(4891749, 8323, '2018-05-13', 0, 0, 0, 0, 0, 0, 1, 0),
(1231235, 8392, '2018-05-13', 1, 0, 0, 0, 1, 0, 0, 0),
(2342224, 8324, '2018-05-13', 1, 1, 1, 1, 0, 0, 0, 0);
/*DO TEGO MIEJSCA MOZNA ZAZNACZYC CALOSC*/


alter table Failure add [Ready?] bit check([Ready?] in (1,0))
update Failure 
set [Ready?] = ( 
case when (Repaired=null) then 0
else 1
end
);



/*Confirm its working*/

select * from client
select * from Device
select * from Failure
select * from Products
select * from Promotion
select * from Workers
select * from Visits
select * from region





select c.ID from
Workers w inner join visits v on w.workerID=v.workerID
  join client c on v.ClientID=c.client_id
  join region r on c.RegionID=r.RegionID
  join Failure f on r.regionID=f.regionID
  join device d on f.deviceID=d.ID
  join products p on d.ID=p.Device
