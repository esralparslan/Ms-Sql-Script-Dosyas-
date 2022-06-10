USE [tempdb];
GO
DECLARE @SQL nvarchar(max);
DECLARE @DB nvarchar(max);
set @DB = 'UrunSatis'
IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = @DB)
	BEGIN
		SET @SQL = ' USE '+@DB+';
					 ALTER DATABASE '+@DB+' SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
			         USE [tempdb];
					 DROP DATABASE '+@DB+';
					 CREATE DATABASE '+@DB+';
					 ';
		EXEC (@SQL);
	END
	ELSE
	BEGIN
		SET @SQL = '
					 CREATE DATABASE '+@DB+';
					 ';
		EXEC (@SQL);
END;
--DB Kontrol� Bitti.
GO
USE [UrunSatis]
GO


--Tan�mlar Tablolar�
Create Table PersonelTip(
Tip_ID int Primary Key identity(1,1),
Ad nvarchar(100) NOT NULL,
Maas money not null
)

Create Table Bolge(
Bolge_ID int Primary Key identity(1,1),
Ad nvarchar(100) NOT NULL,
)

Create Table Sirket(
Sirket_ID int Primary Key identity(1,1),
Ad nvarchar(100) NOT NULL,
)

Create Table Il(
Il_ID int Primary Key identity(1,1),
Ad nvarchar(50),
PlakaKod tinyint
)

Create Table Ilce(
Ilce_ID int Primary Key identity(1,1),
Ad nvarchar(50) NOT NULL,
IlID int Not Null,
FOREIGN KEY (IlID) REFERENCES Il(Il_ID)
)


GO

Create Table Personel(
Per_ID int identity(1,1),
SicilNo int Primary Key NOT NULL,
Tc char(11) unique,
Ad nvarchar(100) NOT NULL,
Soyad nvarchar(100) NOT NULL,
PersonelTipi int not null,
Telefon nvarchar(max),
Prim decimal DEFAULT 1,
FOREIGN KEY (PersonelTipi) REFERENCES PersonelTip(Tip_ID));
GO

Create Table Adres(
Adres_ID int identity(1,1),
SicilNo int Not NULL,
IlceID int NOT NULL,
FOREIGN KEY (IlceID) REFERENCES Ilce(Ilce_ID),
FOREIGN KEY (SicilNo) REFERENCES Personel(SicilNo));


Create Table Danisman(
Per_ID int identity(1,1),
SicilNo int NOT NULL,
SirketID int NOT NULL
FOREIGN KEY (SirketID) REFERENCES Sirket(Sirket_ID),
FOREIGN KEY (SicilNo) REFERENCES Personel(SicilNo)
);
GO

Create Table SatisTemsilcisi(
Temsilci_ID int identity(1,1),
SicilNo int NOT NULL,
BolgeID int NOT NULL
FOREIGN KEY (SicilNo) REFERENCES Personel(SicilNo),
FOREIGN KEY (BolgeID) REFERENCES Bolge(Bolge_ID),
);

GO
--Veri Giri�i ba�lad�.

--�l Ekleme.
INSERT INTO Il
(Ad,PlakaKod)
VALUES
('ADANA',01),
('ADIYAMAN',02),
('AFYON',3),
('A�RI',4),
('AMASYA',5),
('ANKARA',6),
('ANTALYA',7),
('ARTV�N',8),
('AYDIN',9),
('BALIKES�R',10),
('B�LEC�K',11),
('B�NG�L',12),
('B�TL�S',13),
('BOLU',14),
('BURDUR',15),
('BURSA',16),
('�ANAKKALE',17),
('�ANKIRI',18),
('�ORUM',19),
('DEN�ZL�',20),
('D�YARBAKIR',21),
('ED�RNE',22),
('ELAZI�',23),
('ERZ�NCAN',24),
('ERZURUM',25),
('ESK��EH�R',26),
('GAZ�ANTEP',27),
('G�RESUN',28),
('G�M��HANE',29),
('HAKKAR�',30),
('HATAY',31),
('ISPARTA',32),
('MERS�N',33),
('�STANBUL',34),
('�ZM�R',35),
('KARS',36),
('KASTAMONU',37),
('KAYSER�',38),
('KIRKLAREL�',39),
('KIR�EH�R',40),
('KOCAEL�',41),
('KONYA',42),
('K�TAHYA',43),
('MALATYA',44),
('MAN�SA',45),
('KAHRAMANMARA�',46),
('MARD�N',47),
('MU�LA',48),
('MU�',49),
('NEV�EH�R',50),
('N��DE',51),
('ORDU',52),
('R�ZE',53),
('SAKARYA',54),
('SAMSUN',55),
('S��RT',56),
('S�NOP',57),
('S�VAS',58),
('TEK�RDA�',59),
('TOKAT',60),
('TRABZON',61),
('TUNCEL�',62),
('�ANLIURFA',63),
('U�AK',64),
('VAN',65),
('YOZGAT',66),
('ZONGULDAK',67),
('AKSARAY',68),
('BAYBURT',69),
('KARAMAN',70),
('KIRIKKALE',71),
('BATMAN',72),
('�IRNAK',73),
('BARTIN',74),
('ARDAHAN',75),
('I�DIR',76),
('YALOVA',77),
('KARAB�K',78),
('K�L�S',79),
('OSMAN�YE',80),
('D�ZCE',81);

---�l�eler
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALADA�',1),
('CEYHAN',1),
('�UKUROVA',1),
('FEKE',1),
('�MAMO�LU',1),
('KARA�SALI',1),
('KARATA�',1),
('KOZAN',1),
('POZANTI',1),
('SA�MBEYL�',1),
('SARI�AM',1),
('SEYHAN',1),
('TUFANBEYL�',1),
('YUMURTALIK',1),
('Y�RE��R',1);

INSERT INTO Ilce(Ad, IlID) VALUES 
('BESN�',2),
('�EL�KHAN',2),
('GERGER',2),
('G�LBA�I',2),
('KAHTA',2),
('MERKEZ',2),
('SAMSAT',2),
('S�NC�K',2),
('TUT',2);

INSERT INTO Ilce(Ad, IlID) VALUES 
('BA�MAK�I',3),
('BAYAT',3),
('BOLVAD�N',3),
('�AY',3),
('�OBANLAR',3),
('DAZKIRI',3),
('D�NAR',3),
('EM�RDA�',3),
('EVC�LER',3),
('HOCALAR',3),
('�HSAN�YE',3),
('�SCEH�SAR',3),
('KIZIL�REN',3),
('MERKEZ',3),
('SANDIKLI',3),
('S�NANPA�A',3),
('SULTANDA�I',3),
('�UHUT',3);

INSERT INTO Ilce(Ad, IlID) VALUES 
('D�YAD�N',4),
('DO�UBAYAZIT',4),
('ELE�K�RT',4),
('HAMUR',4),
('MERKEZ',4),
('PATNOS',4),
('TA�LI�AY',4),
('TUTAK',4);

INSERT INTO Ilce(Ad, IlID) VALUES 
('A�A��REN',68),
('ESK�L',68),
('G�LA�A�',68),
('G�ZELYURT',68),
('MERKEZ',68),
('ORTAK�Y',68),
('SARIYAH��',68),
('SULTANHANI',68);

INSERT INTO Ilce(Ad, IlID) VALUES 
('G�YN�CEK',5),
('G�M��HACIK�Y',5),
('HAMAM�Z�',5),
('MERKEZ',5),
('MERZ�FON',5),
('SULUOVA',5),
('TA�OVA',5);

INSERT INTO Ilce(Ad, IlID) VALUES 
('AKYURT',6),
('ALTINDA�',6),
('AYA�',6),
('BALA',6),
('BEYPAZARI',6),
('�AMLIDERE',6),
('�ANKAYA',6),
('�UBUK',6),
('ELMADA�',6),
('ET�MESGUT',6),
('EVREN',6),
('G�LBA�I',6),
('G�D�L',6),
('HAYMANA',6),
('KAHRAMANKAZAN',6),
('KALEC�K',6),
('KE���REN',6),
('KIZILCAHAMAM',6),
('MAMAK',6),
('NALLIHAN',6),
('POLATLI',6),
('PURSAKLAR',6),
('S�NCAN',6),
('�EREFL�KO�H�SAR',6),
('YEN�MAHALLE',6);

INSERT INTO Ilce(Ad, IlID) VALUES 
('AKSEK�',7),
('AKSU',7),
('ALANYA',7),
('DEMRE',7),
('D��EMEALTI',7),
('ELMALI',7),
('F�N�KE',7),
('GAZ�PA�A',7),
('G�NDO�MU�',7),
('�BRADI',7),
('KA�',7),
('KEMER',7),
('KEPEZ',7),
('KONYAALTI',7),
('KORKUTEL�',7),
('KUMLUCA',7),
('MANAVGAT',7),
('MURATPA�A',7),
('SER�K',7);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('�ILDIR',75),
('DAMAL',75),
('G�LE',75),
('HANAK',75),
('MERKEZ',75),
('POSOF',75);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ARDANU�',8),
('ARHAV�',8),
('BOR�KA',8),
('HOPA',8),
('KEMALPA�A',8),
('MERKEZ',8),
('MURGUL',8),
('�AV�AT',8),
('YUSUFEL�',8);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BOZDO�AN',9),
('BUHARKENT',9),
('��NE',9),
('D�D�M',9),
('EFELER',9),
('GERMENC�K',9),
('�NC�RL�OVA',9),
('KARACASU',9),
('KARPUZLU',9),
('KO�ARLI',9),
('K��K',9),
('KU�ADASI',9),
('KUYUCAK',9),
('NAZ�LL�',9),
('S�KE',9),
('SULTANH�SAR',9),
('YEN�PAZAR',9);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALTIEYL�L',10),
('AYVALIK',10),
('BALYA',10),
('BANDIRMA',10),
('B�GAD��',10),
('BURHAN�YE',10),
('DURSUNBEY',10),
('EDREM�T',10),
('ERDEK',10),
('G�ME�',10),
('G�NEN',10),
('HAVRAN',10),
('�VR�ND�',10),
('KARES�',10),
('KEPSUT',10),
('MANYAS',10),
('MARMARA',10),
('SAVA�TEPE',10),
('SINDIRGI',10),
('SUSURLUK',10);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AMASRA',74),
('KURUCA��LE',74),
('MERKEZ',74),
('ULUS',74);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BE��R�',72),
('GERC��',72),
('HASANKEYF',72),
('KOZLUK',72),
('MERKEZ',72),
('SASON',72);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AYDINTEPE',69),
('DEM�R�Z�',69),
('MERKEZ',69);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BOZ�Y�K',11),
('G�LPAZARI',11),
('�NH�SAR',11),
('MERKEZ',11),
('OSMANEL�',11),
('PAZARYER�',11),
('S���T',11),
('YEN�PAZAR',11);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ADAKLI',12),
('GEN�',12),
('KARLIOVA',12),
('K��I',12),
('MERKEZ',12),
('SOLHAN',12),
('YAYLADERE',12),
('YED�SU',12);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AD�LCEVAZ',13),
('AHLAT',13),
('G�ROYMAK',13),
('H�ZAN',13),
('MERKEZ',13),
('MUTK�',13),
('TATVAN',13);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('D�RTD�VAN',14),
('GEREDE',14),
('G�YN�K',14),
('KIBRISCIK',14),
('MENGEN',14),
('MERKEZ',14),
('MUDURNU',14),
('SEBEN',14),
('YEN��A�A',14);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('A�LASUN',15),
('ALTINYAYLA',15),
('BUCAK',15),
('�AVDIR',15),
('�ELT�K��',15),
('G�LH�SAR',15),
('KARAMANLI',15),
('KEMER',15),
('MERKEZ',15),
('TEFENN�',15),
('YE��LOVA',15);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('B�Y�KORHAN',16),
('GEML�K',16),
('G�RSU',16),
('HARMANCIK',16),
('�NEG�L',16),
('�ZN�K',16),
('KARACABEY',16),
('KELES',16),
('KESTEL',16),
('MUDANYA',16),
('MUSTAFAKEMALPA�A',16),
('N�L�FER',16),
('ORHANEL�',16),
('ORHANGAZ�',16),
('OSMANGAZ�',16),
('YEN��EH�R',16),
('YILDIRIM',16);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AYVACIK',17),
('BAYRAM��',17),
('B�GA',17),
('BOZCAADA',17),
('�AN',17),
('ECEABAT',17),
('EZ�NE',17),
('GEL�BOLU',17),
('G�K�EADA',17),
('LAPSEK�',17),
('MERKEZ',17),
('YEN�CE',17);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ATKARACALAR',18),
('BAYRAM�REN',18),
('�ERKE�',18),
('ELD�VAN',18),
('ILGAZ',18),
('KIZILIRMAK',18),
('KORGUN',18),
('KUR�UNLU',18),
('MERKEZ',18),
('ORTA',18),
('�ABAN�Z�',18),
('YAPRAKLI',18);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALACA',19),
('BAYAT',19),
('BO�AZKALE',19),
('DODURGA',19),
('�SK�L�P',19),
('KARGI',19),
('LA��N',19),
('MEC�T�Z�',19),
('MERKEZ',19),
('O�UZLAR',19),
('ORTAK�Y',19),
('OSMANCIK',19),
('SUNGURLU',19),
('U�URLUDA�',19);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ACIPAYAM',20),
('BABADA�',20),
('BAKLAN',20),
('BEK�LL�',20),
('BEYA�A�',20),
('BOZKURT',20),
('BULDAN',20),
('�AL',20),
('�AMEL�',20),
('�ARDAK',20),
('��VR�L',20),
('G�NEY',20),
('HONAZ',20),
('KALE',20),
('MERKEZEFEND�',20),
('PAMUKKALE',20),
('SARAYK�Y',20),
('SER�NH�SAR',20),
('TAVAS',20);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BA�LAR',21),
('B�SM�L',21),
('�ERM�K',21),
('�INAR',21),
('��NG��',21),
('D�CLE',21),
('E��L',21),
('ERGAN�',21),
('HAN�',21),
('HAZRO',21),
('KAYAPINAR',21),
('KOCAK�Y',21),
('KULP',21),
('L�CE',21),
('S�LVAN',21),
('SUR',21),
('YEN��EH�R',21);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AK�AKOCA',81),
('CUMAYER�',81),
('��L�ML�',81),
('G�LYAKA',81),
('G�M��OVA',81),
('KAYNA�LI',81),
('MERKEZ',81),
('YI�ILCA',81);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ENEZ',22),
('HAVSA',22),
('�PSALA',22),
('KE�AN',22),
('LALAPA�A',22),
('MER��',22),
('MERKEZ',22),
('S�LO�LU',22),
('UZUNK�PR�',22);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('A�IN',23),
('ALACAKAYA',23),
('ARICAK',23),
('BASK�L',23),
('KARAKO�AN',23),
('KEBAN',23),
('KOVANCILAR',23),
('MADEN',23),
('MERKEZ',23),
('PALU',23),
('S�VR�CE',23);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('�AYIRLI',24),
('�L��',24),
('KEMAH',24),
('KEMAL�YE',24),
('MERKEZ',24),
('OTLUKBEL�',24),
('REFAH�YE',24),
('TERCAN',24),
('�Z�ML�',24);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('A�KALE',25),
('AZ�Z�YE',25),
('�AT',25),
('HINIS',25),
('HORASAN',25),
('�SP�R',25),
('KARA�OBAN',25),
('KARAYAZI',25),
('K�PR�K�Y',25),
('NARMAN',25),
('OLTU',25),
('OLUR',25),
('PALAND�KEN',25),
('PAS�NLER',25),
('PAZARYOLU',25),
('�ENKAYA',25),
('TEKMAN',25),
('TORTUM',25),
('UZUNDERE',25),
('YAKUT�YE',25);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALPU',26),
('BEYL�KOVA',26),
('��FTELER',26),
('G�NY�Z�',26),
('HAN',26),
('�N�N�',26),
('MAHMUD�YE',26),
('M�HALGAZ�',26),
('M�HALI��IK',26),
('ODUNPAZARI',26),
('SARICAKAYA',26),
('SEY�TGAZ�',26),
('S�VR�H�SAR',26),
('TEPEBA�I',26);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ARABAN',27),
('�SLAH�YE',27),
('KARKAMI�',27),
('N�Z�P',27),
('NURDA�I',27),
('O�UZEL�',27),
('�AH�NBEY',27),
('�EH�TKAM�L',27),
('YAVUZEL�',27);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALUCRA',28),
('BULANCAK',28),
('�AMOLUK',28),
('�ANAK�I',28),
('DEREL�',28),
('DO�ANKENT',28),
('ESP�YE',28),
('EYNES�L',28),
('G�RELE',28),
('G�CE',28),
('KE�AP',28),
('MERKEZ',28),
('P�RAZ�Z',28),
('�EB�NKARAH�SAR',28),
('T�REBOLU',28),
('YA�LIDERE',28);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('KELK�T',29),
('K�SE',29),
('K�RT�N',29),
('MERKEZ',29),
('��RAN',29),
('TORUL',29);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('�UKURCA',30),
('DEREC�K',30),
('MERKEZ',30),
('�EMD�NL�',30),
('Y�KSEKOVA',30);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALTIN�Z�',31),
('ANTAKYA',31),
('ARSUZ',31),
('BELEN',31),
('DEFNE',31),
('D�RTYOL',31),
('ERZ�N',31),
('HASSA',31),
('�SKENDERUN',31),
('KIRIKHAN',31),
('KUMLU',31),
('PAYAS',31),
('REYHANLI',31),
('SAMANDA�',31),
('YAYLADA�I',31);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ARALIK',76),
('KARAKOYUNLU',76),
('MERKEZ',76),
('TUZLUCA',76);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AKSU',32),
('ATABEY',32),
('E��RD�R',32),
('GELENDOST',32),
('G�NEN',32),
('KE��BORLU',32),
('MERKEZ',32),
('SEN�RKENT',32),
('S�T��LER',32),
('�ARK�KARAA�A�',32),
('ULUBORLU',32),
('YALVA�',32),
('YEN��ARBADEML�',32);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ADALAR',34),
('ARNAVUTK�Y',34),
('ATA�EH�R',34),
('AVCILAR',34),
('BA�CILAR',34),
('BAH�EL�EVLER',34),
('BAKIRK�Y',34),
('BA�AK�EH�R',34),
('BAYRAMPA�A',34),
('BE��KTA�',34),
('BEYKOZ',34),
('BEYL�KD�Z�',34),
('BEYO�LU',34),
('B�Y�K�EKMECE',34),
('�ATALCA',34),
('�EKMEK�Y',34),
('ESENLER',34),
('ESENYURT',34),
('EY�PSULTAN',34),
('FAT�H',34),
('GAZ�OSMANPA�A',34),
('G�NG�REN',34),
('KADIK�Y',34),
('KA�ITHANE',34),
('KARTAL',34),
('K���K�EKMECE',34),
('MALTEPE',34),
('PEND�K',34),
('SANCAKTEPE',34),
('SARIYER',34),
('S�L�VR�',34),
('SULTANBEYL�',34),
('SULTANGAZ�',34),
('��LE',34),
('���L�',34),
('TUZLA',34),
('�MRAN�YE',34),
('�SK�DAR',34),
('ZEYT�NBURNU',34);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AL�A�A',35),
('BAL�OVA',35),
('BAYINDIR',35),
('BAYRAKLI',35),
('BERGAMA',35),
('BEYDA�',35),
('BORNOVA',35),
('BUCA',35),
('�E�ME',35),
('���L�',35),
('D�K�L�',35),
('FO�A',35),
('GAZ�EM�R',35),
('G�ZELBAH�E',35),
('KARABA�LAR',35),
('KARABURUN',35),
('KAR�IYAKA',35),
('KEMALPA�A',35),
('KINIK',35),
('K�RAZ',35),
('KONAK',35),
('MENDERES',35),
('MENEMEN',35),
('NARLIDERE',35),
('�DEM��',35),
('SEFER�H�SAR',35),
('SEL�UK',35),
('T�RE',35),
('TORBALI',35),
('URLA',35);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AF��N',46),
('ANDIRIN',46),
('�A�LAYANCER�T',46),
('DULKAD�RO�LU',46),
('EK�N�Z�',46),
('ELB�STAN',46),
('G�KSUN',46),
('NURHAK',46),
('ON�K��UBAT',46),
('PAZARCIK',46),
('T�RKO�LU',46);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('EFLAN�',78),
('ESK�PAZAR',78),
('MERKEZ',78),
('OVACIK',78),
('SAFRANBOLU',78),
('YEN�CE',78);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AYRANCI',70),
('BA�YAYLA',70),
('ERMENEK',70),
('KAZIMKARABEK�R',70),
('MERKEZ',70),
('SARIVEL�LER',70);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AKYAKA',36),
('ARPA�AY',36),
('D�GOR',36),
('KA�IZMAN',36),
('MERKEZ',36),
('SARIKAMI�',36),
('SEL�M',36),
('SUSUZ',36);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ABANA',37),
('A�LI',37),
('ARA�',37),
('AZDAVAY',37),
('BOZKURT',37),
('C�DE',37),
('�ATALZEYT�N',37),
('DADAY',37),
('DEVREKAN�',37),
('DO�ANYURT',37),
('HAN�N�',37),
('�HSANGAZ�',37),
('�NEBOLU',37),
('K�RE',37),
('MERKEZ',37),
('PINARBA�I',37),
('SEYD�LER',37),
('�ENPAZAR',37),
('TA�K�PR�',37),
('TOSYA',37);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AKKI�LA',38),
('B�NYAN',38),
('DEVEL�',38),
('FELAH�YE',38),
('HACILAR',38),
('�NCESU',38),
('KOCAS�NAN',38),
('MEL�KGAZ�',38),
('�ZVATAN',38),
('PINARBA�I',38),
('SARIO�LAN',38),
('SARIZ',38),
('TALAS',38),
('TOMARZA',38),
('YAHYALI',38),
('YE��LH�SAR',38);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BAH�ILI',71),
('BALI�EYH',71),
('�ELEB�',71),
('DEL�CE',71),
('KARAKE��L�',71),
('KESK�N',71),
('MERKEZ',71),
('SULAKYURT',71),
('YAH��HAN',71);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BABAESK�',39),
('DEM�RK�Y',39),
('KOF�AZ',39),
('L�LEBURGAZ',39),
('MERKEZ',39),
('PEHL�VANK�Y',39),
('PINARH�SAR',39),
('V�ZE',39);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AK�AKENT',40),
('AKPINAR',40),
('BOZTEPE',40),
('���EKDA�I',40),
('KAMAN',40),
('MERKEZ',40),
('MUCUR',40);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ELBEYL�',79),
('MERKEZ',79),
('MUSABEYL�',79),
('POLATEL�',79);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BA��SKELE',41),
('�AYIROVA',41),
('DARICA',41),
('DER�NCE',41),
('D�LOVASI',41),
('GEBZE',41),
('G�LC�K',41),
('�ZM�T',41),
('KANDIRA',41),
('KARAM�RSEL',41),
('KARTEPE',41),
('K�RFEZ',41);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AHIRLI',42),
('AK�REN',42),
('AK�EH�R',42),
('ALTINEK�N',42),
('BEY�EH�R',42),
('BOZKIR',42),
('C�HANBEYL�',42),
('�ELT�K',42),
('�UMRA',42),
('DERBENT',42),
('DEREBUCAK',42),
('DO�ANH�SAR',42),
('EM�RGAZ�',42),
('ERE�L�',42),
('G�NEYSINIR',42),
('HAD�M',42),
('HALKAPINAR',42),
('H�Y�K',42),
('ILGIN',42),
('KADINHANI',42),
('KARAPINAR',42),
('KARATAY',42),
('KULU',42),
('MERAM',42),
('SARAY�N�',42),
('SEL�UKLU',42),
('SEYD��EH�R',42),
('TA�KENT',42),
('TUZLUK�U',42),
('YALIH�Y�K',42),
('YUNAK',42);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALTINTA�',43),
('ASLANAPA',43),
('�AVDARH�SAR',43),
('DOMAN��',43),
('DUMLUPINAR',43),
('EMET',43),
('GED�Z',43),
('H�SARCIK',43),
('MERKEZ',43),
('PAZARLAR',43),
('S�MAV',43),
('�APHANE',43),
('TAV�ANLI',43);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AK�ADA�',44),
('ARAPG�R',44),
('ARGUVAN',44),
('BATTALGAZ�',44),
('DARENDE',44),
('DO�AN�EH�R',44),
('DO�ANYOL',44),
('HEK�MHAN',44),
('KALE',44),
('KULUNCAK',44),
('P�T�RGE',44),
('YAZIHAN',44),
('YE��LYURT',44);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AHMETL�',45),
('AKH�SAR',45),
('ALA�EH�R',45),
('DEM�RC�',45),
('G�LMARMARA',45),
('G�RDES',45),
('KIRKA�A�',45),
('K�PR�BA�I',45),
('KULA',45),
('SAL�HL�',45),
('SARIG�L',45),
('SARUHANLI',45),
('SELEND�',45),
('SOMA',45),
('�EHZADELER',45),
('TURGUTLU',45),
('YUNUSEMRE',45);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ARTUKLU',47),
('DARGE��T',47),
('DER�K',47),
('KIZILTEPE',47),
('MAZIDA�I',47),
('M�DYAT',47),
('NUSAYB�N',47),
('�MERL�',47),
('SAVUR',47),
('YE��LL�',47);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AKDEN�Z',33),
('ANAMUR',33),
('AYDINCIK',33),
('BOZYAZI',33),
('�AMLIYAYLA',33),
('ERDEML�',33),
('G�LNAR',33),
('MEZ�TL�',33),
('MUT',33),
('S�L�FKE',33),
('TARSUS',33),
('TOROSLAR',33),
('YEN��EH�R',33);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BODRUM',48),
('DALAMAN',48),
('DAT�A',48),
('FETH�YE',48),
('KAVAKLIDERE',48),
('K�YCE��Z',48),
('MARMAR�S',48),
('MENTE�E',48),
('M�LAS',48),
('ORTACA',48),
('SEYD�KEMER',48),
('ULA',48),
('YATA�AN',48);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BULANIK',49),
('HASK�Y',49),
('KORKUT',49),
('MALAZG�RT',49),
('MERKEZ',49),
('VARTO',49);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ACIG�L',50),
('AVANOS',50),
('DER�NKUYU',50),
('G�L�EH�R',50),
('HACIBEKTA�',50),
('KOZAKLI',50),
('MERKEZ',50),
('�RG�P',50);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALTUNH�SAR',51),
('BOR',51),
('�AMARDI',51),
('��FTL�K',51),
('MERKEZ',51),
('ULUKI�LA',51);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AKKU�',52),
('ALTINORDU',52),
('AYBASTI',52),
('�AMA�',52),
('�ATALPINAR',52),
('�AYBA�I',52),
('FATSA',52),
('G�LK�Y',52),
('G�LYALI',52),
('G�RGENTEPE',52),
('�K�ZCE',52),
('KABAD�Z',52),
('KABATA�',52),
('KORGAN',52),
('KUMRU',52),
('MESUD�YE',52),
('PER�EMBE',52),
('ULUBEY',52),
('�NYE',52);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BAH�E',80),
('D�Z���',80),
('HASANBEYL�',80),
('KAD�RL�',80),
('MERKEZ',80),
('SUMBAS',80),
('TOPRAKKALE',80);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ARDE�EN',53),
('�AMLIHEM��N',53),
('�AYEL�',53),
('DEREPAZARI',53),
('FINDIKLI',53),
('G�NEYSU',53),
('HEM��N',53),
('�K�ZDERE',53),
('�Y�DERE',53),
('KALKANDERE',53),
('MERKEZ',53),
('PAZAR',53);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ADAPAZARI',54),
('AKYAZI',54),
('AR�F�YE',54),
('ERENLER',54),
('FER�ZL�',54),
('GEYVE',54),
('HENDEK',54),
('KARAP�R�EK',54),
('KARASU',54),
('KAYNARCA',54),
('KOCAAL�',54),
('PAMUKOVA',54),
('SAPANCA',54),
('SERD�VAN',54),
('S���TL�',54),
('TARAKLI',54);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('19 MAYIS',55),
('ALA�AM',55),
('ASARCIK',55),
('ATAKUM',55),
('AYVACIK',55),
('BAFRA',55),
('CAN�K',55),
('�AR�AMBA',55),
('HAVZA',55),
('�LKADIM',55),
('KAVAK',55),
('LAD�K',55),
('SALIPAZARI',55),
('TEKKEK�Y',55),
('TERME',55),
('VEZ�RK�PR�',55),
('YAKAKENT',55);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BAYKAN',56),
('ERUH',56),
('KURTALAN',56),
('MERKEZ',56),
('PERVAR�',56),
('��RVAN',56),
('T�LLO',56);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AYANCIK',57),
('BOYABAT',57),
('D�KMEN',57),
('DURA�AN',57),
('ERFELEK',57),
('GERZE',57),
('MERKEZ',57),
('SARAYD�Z�',57),
('T�RKEL�',57);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AKINCILAR',58),
('ALTINYAYLA',58),
('D�VR���',58),
('DO�AN�AR',58),
('GEMEREK',58),
('G�LOVA',58),
('G�R�N',58),
('HAF�K',58),
('�MRANLI',58),
('KANGAL',58),
('KOYULH�SAR',58),
('MERKEZ',58),
('SU�EHR�',58),
('�ARKI�LA',58),
('ULA�',58),
('YILDIZEL�',58),
('ZARA',58);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AK�AKALE',63),
('B�REC�K',63),
('BOZOVA',63),
('CEYLANPINAR',63),
('EYY�B�YE',63),
('HALFET�',63),
('HAL�L�YE',63),
('HARRAN',63),
('H�LVAN',63),
('KARAK�PR�',63),
('S�VEREK',63),
('SURU�',63),
('V�RAN�EH�R',63);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BEYT���EBAP',73),
('C�ZRE',73),
('G��L�KONAK',73),
('�D�L',73),
('MERKEZ',73),
('S�LOP�',73),
('ULUDERE',73);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('�ERKEZK�Y',59),
('�ORLU',59),
('ERGENE',59),
('HAYRABOLU',59),
('KAPAKLI',59),
('MALKARA',59),
('MARMARAERE�L�S�',59),
('MURATLI',59),
('SARAY',59),
('S�LEYMANPA�A',59),
('�ARK�Y',59);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALMUS',60),
('ARTOVA',60),
('BA���FTL�K',60),
('ERBAA',60),
('MERKEZ',60),
('N�KSAR',60),
('PAZAR',60),
('RE�AD�YE',60),
('SULUSARAY',60),
('TURHAL',60),
('YE��LYURT',60),
('Z�LE',60);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AK�AABAT',61),
('ARAKLI',61),
('ARS�N',61),
('BE��KD�Z�',61),
('�AR�IBA�I',61),
('�AYKARA',61),
('DERNEKPAZARI',61),
('D�ZK�Y',61),
('HAYRAT',61),
('K�PR�BA�I',61),
('MA�KA',61),
('OF',61),
('ORTAH�SAR',61),
('S�RMENE',61),
('�ALPAZARI',61),
('TONYA',61),
('VAKFIKEB�R',61),
('YOMRA',61);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('�EM��GEZEK',62),
('HOZAT',62),
('MAZG�RT',62),
('MERKEZ',62),
('NAZIM�YE',62),
('OVACIK',62),
('PERTEK',62),
('P�L�M�R',62);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BANAZ',64),
('E�ME',64),
('KARAHALLI',64),
('MERKEZ',64),
('S�VASLI',64),
('ULUBEY',64);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('BAH�ESARAY',65),
('BA�KALE',65),
('�ALDIRAN',65),
('�ATAK',65),
('EDREM�T',65),
('ERC��',65),
('GEVA�',65),
('G�RPINAR',65),
('�PEKYOLU',65),
('MURAD�YE',65),
('�ZALP',65),
('SARAY',65),
('TU�BA',65);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALTINOVA',77),
('ARMUTLU',77),
('�INARCIK',77),
('��FTL�KK�Y',77),
('MERKEZ',77),
('TERMAL',77);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('AKDA�MADEN�',66),
('AYDINCIK',66),
('BO�AZLIYAN',66),
('�ANDIR',66),
('�AYIRALAN',66),
('�EKEREK',66),
('KADI�EHR�',66),
('MERKEZ',66),
('SARAYKENT',66),
('SARIKAYA',66),
('SORGUN',66),
('�EFAATL�',66),
('YEN�FAKILI',66),
('YERK�Y',66);
 
INSERT INTO Ilce(Ad, IlID) VALUES 
('ALAPLI',67),
('�AYCUMA',67),
('DEVREK',67),
('ERE�L�',67),
('G�K�EBEY',67),
('K�L�ML�',67),
('KOZLU',67),
('MERKEZ',67);

INSERT INTO Bolge(Ad) VALUES 
('Akdeniz B�lgesi'),
('Do�u Anadolu B�lgesi'),
('Ege B�lgesi'),
('G�neydo�u Anadolu B�lgesi'),
('�� Anadolu B�lgesi'),
('Karadeniz B�lgesi'),
('Marmara B�lgesi');

INSERT INTO PersonelTip(Ad,Maas) VALUES
('Genel M�d�r',20000),
('M�d�r',15000),
('�of�r',12000),
('Temizlik G�revlisi',4250),
('Kasiyer',4000),
('Memur',8000);

INSERT INTO Sirket(Ad) VALUES
('Ar�elik'),
('Vestel'),
('Sunny'),
('Bosch'),
('Finlux'),
('LG'),
('Samsung'),
('Apple'),
('Xioami'),
('Motorola'),
('Nokia'),
('Huawei'),
('Opet'),
('Petrol Ofisi'),
('Lukoil'),
('Yozgat Bozok �niversitesi'),
('Gittigidiyor'),
('Facebook'),
('Twitter'),
('Linkedin'),
('S�rmeligaz'),
('T�rk Telekom'),
('T�rk Hava Yollar�'),
('Vaillant');

-----

INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (477245,76775194195,'Delal Abdullatif','Abzak',3,05516237258);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (358094,17732541499,'Fatma �zlem','Acar',5,05321591567);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (698064,76537431273,'�zde','Acarkan',4,05538889616);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (189315,85151143619,'Atahan','Adan�r',1,05526936469);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (204847,11379365878,'Hac� Mehmet','Ad�g�zel',4,05454372893);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (830076,58824555184,'M�kerrem Zeynep','A�ca',3,05438265159);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (820002,44415469771,'Bestami','A��ra�a�',6,05413738741);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (824795,28239178841,'Aykanat','A��ro�lu',5,05327967961);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (398309,86472494723,'�ennur','A�nar',4,05323127675);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (571275,29888261637,'Tutkum','Ahmad� Asl',3,05458336665);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (394503,83145261682,'M�genur','Ahmet',2,05455797254);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (511034,71967959667,'Sevin�','Ak',2,05333495234);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (397647,42969173417,'Kay�han Nedim','Akarcal�',2,05458524211);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (962653,75829825585,'Lemi','Akar�ay',1,05441999614);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (522381,53426342356,'Cihan','Akarp�nar',5,05342783359);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (804742,65165134165,'Rafi','Aka�',1,05556347627);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (354223,28419941538,'Mehmetcan','Akay',4,05458358784);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (923430,56185259388,'Nuhaydar','Akbilmez',1,05514643251);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (506165,86191993969,'Emine M�nevver','Akca',5,05539257561);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (293007,21188318352,'Servet','Ak�agunay',6,05433896783);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (446380,68148518597,'�ilem','Ak�ay',5,05414215631);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (583780,43861235284,'Recep Ali Samet','Akdo�an',2,05415944552);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (832832,65293632624,'Emre Ayberk','Akf�rat',2,05319249917);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (114998,77891178868,'Kerime Hacer','Ak�ll�',2,05455159536);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (368571,55938566873,'Erc�ment','Ak�nc�lar',1,05333462821);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (269303,99265515519,'Sarper','Ak��',2,05353291845);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (600393,77411511235,'Berker','Akkiray',6,05318438793);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (729177,72544827676,'�clal','Akkoyun',3,05437595533);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (560692,39521154869,'Lemis','Akk�t',2,05524652953);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (664750,96798693169,'Ahmet Polat','Aklar ��rek�i',6,05327427485);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (457923,45711648789,'Ata Kerem','Akman',3,05333363569);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (309974,11793937165,'Ahmet Ra�it','Ako�uz',2,05533822911);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (590199,65728228947,'Ecem Hatice','Akova',4,05353974746);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (642695,52658731558,'N�ket','Aksan',4,05446874947);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (426861,78297217461,'Senem','Aksevim',2,05524339651);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (201678,47138341965,'Ay�en','Aksoy',4,05347183744);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (863474,96565536946,'Pekcan','Aks�z',3,05429749861);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (388256,14663865117,'Bedirhan L�tf�','Ak�amo�lu',1,05524761843);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (810259,37572125933,'Semina','Aktuna',3,05334846738);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (110995,17141439423,'Eda Sena','Aky�ld�z',4,05416451652);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (835713,11118916651,'M�yesser','Akyildirim',1,05412229761);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (325906,39312628513,'Selinti','Al',5,05422133378);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (868867,16562715654,'Bahar �zlem','Alba�',1,05432544549);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (451968,64824114262,'�lma','Alda�',4,05415177645);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (583733,89311592281,'Kutlu','Alibeyo�lu',4,05313789917);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (488742,87968492492,'Nesibe Nuref�an','Alkan',6,05328649648);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (490136,18192436785,'�mer Bu�ra','Alparslan',5,05316319131);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (996822,83622332112,'Hiba','Alpu�an',1,05315925223);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (922508,57323798761,'Mazlum','Altan',5,05311517356);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (270469,37896889195,'Elif Tu��e','Alta�',5,05329841166);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (726014,58975184673,'Ahmet Ruken','Altay',6,05526439161);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (372430,43486411439,'Ya�ar Utku An�l','Alt�n',1,05421947465);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (692283,42956544671,'Rana','Alt�noklu',5,05454176197);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (437726,34957159146,'Fethullah','Alt�n�z',1,05354257654);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (596147,59176168781,'Burak Tatkan','Alt�nta�',1,05539295283);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (351705,41944955245,'Merve Ece','Alt�ok',5,05514683492);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (473547,54557573922,'Rima','Alt�parmak',1,05321911756);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (611321,96539653145,'Elif Dilay','Altinkaya',1,05553179172);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (909848,29726697158,'S�rma Beg�m','Altunba�',5,05358777383);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (630374,64994486647,'Nefse','Altunbulak',6,05557141631);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (509163,79877977524,'B��ra G�l','Altundal',4,05425655562);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (997524,27771519191,'Erna','Alu�',4,05448849357);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (848481,65366735615,'Hikmet Nazl�','Alver',1,05525127586);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (784666,83589237458,'�smail Umut','An�k',2,05423948226);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (367260,58124143746,'�lkay Ramazan','Ankara',1,05555175557);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (317330,78144999729,'Nebahat','Ansen',1,05429361996);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (246244,36574174157,'�lyas Umut','Apul',5,05538667375);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (541729,74963466615,'Halim','Aral',1,05411289383);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (243967,37719858227,'Yasin ��kr�','Arap',5,05448859881);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (356159,33169122839,'Cansev','Arat',5,05418431367);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (958673,57613579793,'Memet Ali','Ard��',5,05334665533);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (542329,58873225746,'Deniz Dilay','Ar�can',6,05558798115);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (305045,14791528821,'�zlem','Ar�n�',3,05317796683);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (559414,87426236888,'�get','Arif',5,05323259783);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (163679,57317933515,'�eyda Nur','Arikan',5,05447297442);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (335962,51223917327,'Zeki Yi�ithan','Armutcu',6,05454437421);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (646250,91679818845,'Nunazl�','Arpac�',4,05512462362);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (540070,61318991245,'Ferdacan','Aruca',6,05453381415);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (324392,39441547637,'�erife','Asil',3,05359165733);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (576126,77219275456,'Mustafa Burhan','Ask�n',3,05531798477);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (482602,84487916288,'Il�m','Aslant�rk',1,05413867232);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (562734,86199924781,'Sevginur','A�c�',1,05446716644);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (402118,59571486163,'Hayrunnisa','A�veren',1,05313353945);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (353328,96768764688,'Hanife Duygu','Ata',6,05441395557);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (426028,24548745754,'Sevtap','Atan',5,05436168925);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (431471,11199251779,'Paksoy','Ate�',6,05434648518);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (982696,19122884754,'�lkim','Ate�can',5,05426485317);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (329933,37468993829,'Rubabe G�k�en','Atl�',4,05453294236);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (587791,13517164197,'Saba','Atmaca',3,05329629343);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (348642,75893455466,'�isem','Atok',2,05356268448);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (251050,16398512923,'Sabiha Elvan','Atol',2,05449574997);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (100121,62915829498,'Edip','Attila',6,05552373457);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (465847,74835731621,'Almina','Avc� �zsoy',3,05445255262);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (967548,11684595355,'Saime','Av�and�',5,05351961223);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (426153,73444918517,'Nehar','Av�ar',5,05423855386);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (229150,34296712325,'Kaan Muharrem','Ay',4,05456114175);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (852035,15895688296,'Murat Kaan','Ayanoglu',4,05359538684);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (616147,18611242743,'Murat Sinan','Ayaz',4,05524785494);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (194284,99146352537,'Ate�','Ayc�',3,05559249328);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (206455,95964336475,'Zeynep Nihan','Ayd�nl�o�lu',4,05521772522);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (443722,33563979324,'Kerime','Aydo�an Yozgat',5,05323533695);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (576302,92634876339,'Hami','Aydo�du',4,05315362661);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (400166,85688271693,'Thomas','Aygen',2,05423971136);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (939041,11666957535,'G�ne�','Aykan',6,05446782386);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (759937,36335714677,'Elif Feyza','Ayr�m',6,05519393948);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (151738,65299194171,'U�ur Ali','Aysal',3,05529624516);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (639804,89193797196,'Osman Yasin','Aysan',1,05424874437);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (594864,91241219718,'Adem','Ayvac�k',2,05538935798);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (786196,36375797449,'Sera Cans�n','Azbay',5,05553331734);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (356688,58758457552,'Ali �smail','Babacan',5,05524663839);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (270227,84184429961,'Ruhug�l','Babadostu',3,05555692665);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (428129,89119527479,'Al�i�ek','Bad',3,05331439162);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (903997,19396254998,'Memet','Ba�c�',4,05317741288);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (849584,11366292597,'Mercan','Ba��ivan',3,05354719522);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (553630,43775122275,'G�kay','Ba���',4,05526473318);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (880151,76843659638,'P�r�lt�','Bah�eli',1,05339136769);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (258829,49231856229,'�zg�n','Baht�yar',1,05558284136);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (518991,38624484386,'�zgen','Baka',1,05551187958);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (740058,17786843629,'Seung Hun','Baki',5,05532442757);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (725548,51578598388,'G�lser','Bal',6,05327139918);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (575667,49615848347,'Y�ksel','Balc�',1,05531486968);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (863696,31198484734,'Ecren','Baldo',1,05354199836);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (793131,99428769395,'Muhammet Ra�it','Bal�',2,05513413623);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (170878,31853199952,'Sak�p','Bal�o�lu',5,05356251195);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (581238,32941265995,'Kaz�m','Balta',6,05421935312);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (602235,94997875821,'Abdullah Atakan','Baluken',5,05525922679);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (618722,71216768218,'Co�kun','Baran',2,05423137324);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (886405,48695484698,'Serdar Kaan','Barbaros',4,05318289928);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (451295,55981566133,'Ezel','Bargan',3,05437182899);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (784255,65596789157,'Ay�eg�l','Barut�uo�lu',3,05322885728);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (164288,65838762498,'Sefa Kadir','Ba�ar',4,05528777313);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (477240,26989378519,'Elif Etga','Ba�e�mez',4,05514281642);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (706968,64633836496,'Bal�n','Ba�tepe',1,05548721349);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (851317,94483559194,'Mahperi','Ba�top�u',3,05452791199);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (859350,39436551298,'Erol �zg�r','Ba�tu�',4,05356238678);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (834016,93752792796,'Atak','Batar',1,05542929945);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (867852,62877939216,'Safa','Batga',6,05335933127);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (377331,88969884939,'G�kmen','Battal',2,05436779954);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (563864,85521347716,'Faz�l Erem','Batuk',6,05547256781);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (197545,39712185522,'Bensu','Batur',4,05446537584);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (496879,42766945919,'Naz�m Orhun','Baturalp',4,05356161472);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (284481,66445149266,'Safa Ahmet','Baydar',5,05441384689);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (184948,97865992295,'Demircan','Baydil',6,05553562463);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (847209,38166985189,'Bur�in K�bra','Baykal',5,05415444919);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (945807,56176964556,'Dervi� Haluk','Baykan',4,05417512161);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (398327,89165712612,'Taylan Remzi','Bayku�',1,05318329747);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (926574,35978799913,'Abdulvahap','Bayrako�lu',4,05347341696);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (600943,28357438344,'Ayg�n','Bayram',4,05441684899);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (818670,93872718398,'Ayla','Bayt�n',2,05428227731);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (110709,48315368563,'Kubilay Bar��','Begi�',1,05344511696);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (116581,99433697464,'Mustafa Samed','Be�enilmi�',4,05455349182);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (503985,27758138533,'Berfin Dilay','Bekaro�lu',5,05427993318);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (599767,72113996543,'�brahim Onat','Belge',3,05442824155);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (539991,26173265811,'Jutenya','Benan',1,05451371211);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (764315,99994161538,'Hulki','Bent',6,05554858274);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (820731,73214461447,'Mustafa Do�ukan','Berbero�lu',6,05554243714);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (569175,52871937762,'H�ner','Berk',6,05414955367);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (334909,19811697487,'Buse Gizem','Berker',3,05544223658);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (338341,34332949671,'Halime','Beyda�',2,05517826375);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (616717,53456924319,'Didem','B��aks�z',5,05316559498);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (554510,68462218132,'Mihrinaz','Bilal',1,05349739359);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (955728,38719573713,'Lal','Bilge�',2,05316525514);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (205913,96727443527,'Senay','Bilgen',5,05456959955);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (643423,88276859778,'Remzi','Bilgi',6,05415194456);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (688121,41891284346,'Arma�an','Bilgi�',2,05555129592);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (727803,57596835781,'�elik','Bilgir',1,05332833493);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (422218,46553911187,'K�bra Tansu','Bilgit',3,05548644288);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (210942,31547714551,'Ulu� Emre','Binbay',1,05442868411);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (680994,15569168165,'Mehmet Bu�rahan','Birgili',4,05551936452);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (285867,25879885373,'Do�u�can','Biriz',5,05342239314);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (797019,22331895875,'Altan','Boy',5,05443572171);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (151745,31672587112,'Bengisu','Boya',1,05327151442);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (738896,42975212628,'Onur Taylan','Boylu',6,05548438599);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (731938,63448242236,'Ayseren','Boyukta�',6,05325499213);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (298801,28784621986,'Pekin','Boz',5,05352581664);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (471663,91693379372,'Aksu','Bozda�',4,05547379396);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (903063,56199699631,'Arkan','Bozdemir',4,05442837296);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (542907,99361215814,'�ltem','Boztepe',6,05438499679);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (105265,13524962189,'Bet�l','Bozyer',6,05327745248);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (632995,38665269442,'Og�n','B�lge',1,05432174953);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (226345,21121645742,'�brahim Hakk�','Bugey',5,05523527227);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (295942,17693241758,'Onay','Bu�dayp�nar�',2,05423844344);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (592450,88574345957,'Cank�z','Bulgan',4,05558275427);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (797559,63871936184,'Arzucan','Bulgur',6,05412959264);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (845173,35641673856,'Asiye','Burabak',2,05432378132);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (742288,84328588715,'Ahmet Yasin','Burak',1,05549418784);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (417022,67399312251,'Yaprak','Bural',5,05342376973);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (270850,97275154551,'Aleda','Buyuran',2,05347954617);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (852213,25915791257,'Can G�ney','B�lb�l',5,05535427117);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (720258,32433477556,'Mahmut Bilal','B�lend',3,05555366673);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (591308,72155874911,'Saliha Zeynep','B�lent',5,05556722563);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (598088,17228255131,'Melike Dilara','B�y�kf�rat',2,05327971823);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (200391,55582176468,'Hayriye','B�y�kg�ng�r',6,05559179385);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (347589,55491779228,'Sebiha','B�y�k�zt�rk',2,05458546773);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (344515,29666996451,'Mehmet','Can Ak�a�zo�lu',4,05326648876);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (862869,45636451339,'Mehmet Enes','Canan',4,05527938333);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (299958,79483172124,'Kurtbey','Canba��',4,05345166619);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (377440,82161372267,'Mustafa Taha','Canbek',4,05459185158);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (191973,53378125892,'Sena Nur','Candan',6,05412571481);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (415841,65175732656,'Abdullah Emirhan','Caner',6,05334496561);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (734013,15825826291,'Mustafa Kerem','Cansu',6,05511831821);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (793550,15331126574,'Doktora','Canuyar',4,05357997555);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (839352,45131833118,'Seyit','Ceran',6,05555232757);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (998152,14423283572,'Selma Simge','Ceylan',3,05426996952);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (413655,17815865719,'A�k�m','Chiklyaukova',2,05519176494);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (659286,61867155739,'�zg�r','Choi',3,05421888268);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (636969,84655474398,'Tu�ce','Ciboo�lu',2,05327787494);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (656211,54151142669,'�zer Se�kin','Ciddi',1,05458827179);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (559252,53948824757,'Balk�n','Cigerlio�lu',5,05414324161);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (143365,77711382952,'Y�cel','Civan',3,05539636652);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (309133,24665998135,'�ansal','Co�an',2,05556158629);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (714122,28593216421,'O�uzcan','Co�andal',3,05556588295);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (965156,34877221845,'May�s','Cumal�',6,05312139319);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (910708,97897664264,'B��ra','C�ce',2,05539856894);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (510934,44922218741,'Afra Selcen','�a�an',4,05414517762);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (522413,47539924467,'G�n�l','�a�atay',6,05457182625);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (137088,42273441652,'Do�ang�n','�a�lar',3,05312343411);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (888133,93838282998,'Elif Ege','�a�layan',1,05331367578);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (935029,63622449634,'�zen','�akan',6,05312653316);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (963254,51129834126,'Dilhan','�akanel',4,05354578557);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (309474,31792347121,'Maral','�ak�c�',6,05343787815);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (145159,38844446992,'Mahire','�al�m',6,05335299267);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (583873,68799152278,'Hac� Bayram Ufuk','�ama�',6,05322468438);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (723020,43228167714,'Oltun','�anga',6,05434433756);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (780445,73746272575,'�nel','�apa',6,05554547789);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (743230,23119238192,'Bay�lken','�aprak',5,05325613683);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (176483,58763874193,'Dilseren','�ar�c�',2,05333737529);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (503163,91239483456,'Elif Beyza','�ark',3,05519478148);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (583852,25372696773,'Elvan','�atal',4,05523392679);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (719179,95883867899,'Esim','�aylar',2,05514194872);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (716500,44758337999,'Sena','�ekmecelio�lu',4,05556376244);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (239661,44951751835,'Muhammed �zeyir','�ekmeci',4,05427357472);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (927145,52999736553,'Ayd�n Mert','�elebican',5,05529842588);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (974723,54693649723,'�a�kan','�elenlio�lu',5,05425268851);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (837282,85765374529,'Z�mra','�el�k',5,05326672621);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (846035,85389385173,'Bayar','�elik',3,05448995843);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (161320,91917262492,'G�n�lg�l','�elika��',2,05545332962);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (337633,74318447225,'Ece P�nar','�eliker',1,05536841918);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (982168,18482548338,'Mehmet Tar�k','�elikkol',2,05329342943);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (569121,46352541376,'Elife','�er�i',1,05436661894);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (284399,67115137169,'Efecan','�etinta�',6,05555329795);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (823080,11683612249,'R�dvan','��k�kc�',4,05434397992);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (574856,58331725356,'Hatice Gamze','��nar',1,05538386856);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (699713,83273535354,'Yans� Hilal','��naro�lu',4,05338185484);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (763316,66723382823,'Oma�','��ng�r',1,05559374787);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (582924,91554873494,'Erhan','��ray',5,05441532448);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (531673,19457278158,'��heda','�i�ekli',4,05344163566);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (580026,33142736813,'�nkan','�ini',3,05353975453);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (695173,37544232471,'Ahmet Gazi','�intan',1,05449874199);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (243213,34265557355,'Seher �rem','�itf�i',3,05337487785);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (590208,28376386835,'G�rb�z','�ivici',5,05557866414);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (688708,94966986313,'Z�lal','�olak',1,05423359339);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (154826,61354237849,'Ozan Ege','�omu',4,05436669953);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (628045,24179196264,'Hilal Ebru','�onay',3,05326918914);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (339203,43662532472,'Ayben','�orumlu',2,05543671163);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (954287,96367594971,'Abdulbaki','�otur',6,05453628512);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (440494,25131488522,'Neva','�uhadar',1,05519664397);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (259770,29616659663,'�znur','�ulhao�lu',3,05411798171);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (384205,85351826723,'Olgun','Dadal�o�lu',6,05353836541);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (885343,84883791599,'�a�r� Atahan','Da�ar',6,05332862339);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (376259,11784731886,'�zalp','Da�ba�',4,05442574812);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (455708,25364375959,'H�sne Aysun','Dal',2,05556558784);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (410357,18162683329,'Aydonat','Dalk�l��',1,05337655436);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (586559,19268864527,'Ezgin','Dall�',1,05547517137);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (700078,62854497377,'Refiye Seda','Dalyaprak',4,05543332837);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (695642,61788234922,'Esat Erdem','Dani�',4,05313357564);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (501723,84517815369,'Ay�e Neslihan','Da�demir',4,05358717236);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (951454,65722241773,'Fetullah','Davuto�lu',6,05531664982);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (328446,22751772563,'Mert G�rkem','Day�o�lu',5,05412578315);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (747788,34951282725,'Erg�n','De�irmendereli',5,05417463943);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (789173,67761225536,'H�lya','Del� Chasan',6,05322585763);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (569394,37125331745,'Doga Elif','Delice',2,05419815549);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (474213,62753329962,'Muhammed Bazit','Delilo�lu',4,05448221783);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (923814,14563135794,'Mira�','Dem�r�ren',1,05424548239);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (607854,67479457772,'H�rel','Demiriz',4,05448698624);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (871987,73487125383,'S�mer','Demiro�lu',3,05458615349);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (462457,61491988335,'Aysel Aysu','Demirsatan',2,05442732549);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (547938,34544982829,'Mehmet Kemal','Dengizek',2,05311131428);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (933794,18236642447,'Alya','Denizg�n�',1,05538453948);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (501740,75957372875,'Zeynep B��ra','Derdemez',5,05428445123);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (317608,98315826525,'Tubanur','Dereli',2,05534132734);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (608506,86466435857,'Dalay','Derya',1,05521349932);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (993482,32256635136,'Bedir','Destereci',6,05418628414);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (247529,76556274271,'R�meysa �rem','Devecel',4,05437873116);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (477641,78327919278,'Osman Sinan','Devrim',2,05449898598);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (864975,55863257487,'Saliha Canan','D�varc�',5,05538898797);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (467598,22418725651,'Samet Emre','Dikba�',3,05318347577);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (434516,74691582974,'Haldun','Din�t�rk',4,05412337957);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (213064,88787666192,'Goncag�l','Diri',1,05548897257);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (792024,36815262376,'Ziya','Do�ramac�',3,05539974213);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (806512,42591844988,'Zehra Pelin','D�ger',1,05422168785);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (798708,88633576995,'Seli M Sharef','D�k�lmez',5,05413828946);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (450139,89334129493,'Firuze','D�nder',1,05554124613);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (452430,28331312281,'Doruk Deniz','D�ner',4,05429681455);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (372588,52718776181,'�isil Zeynep','D�nmez',5,05348498363);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (878952,41343269913,'Tugce','Dudu',3,05448545161);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (121606,55522745483,'Enver','Dur',3,05437674448);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (984276,99468821112,'Sanber','Durak',3,05411257164);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (124768,72857553171,'Birsen','Durmu�',5,05548453136);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (210363,85437394228,'Ta�min','Durmu�o�lu',3,05551156897);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (722458,16635793914,'Karanalp','Dursun',5,05421493681);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (351939,81911634116,'�ktem','Duymu�',1,05431943754);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (249129,25963616791,'Elanaz','D�lgerbaki',1,05526549824);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (415310,25316661998,'Fidan','D�ndar',2,05353474493);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (819107,38479141515,'Bar�n','D��enkalkar',5,05519644223);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (174337,99849734447,'Mehmet Erman','D�zbay�r',6,05514436489);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (461207,64418835833,'Cem Efe','Ede�',4,05444817585);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (504673,81372677115,'Erem','Edibali Mp',3,05339592635);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (724985,34293452834,'Volkan Ey�p','Ef�in',4,05323537197);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (136245,14598398152,'�brahim Alp Tekin','Ege',1,05541233174);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (502652,25629967625,'G�ng�r Erkin','Egeli',4,05352194878);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (326487,83464695165,'�a��n','Egin',4,05531922273);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (903193,55861426365,'Alphan','Ekercan',6,05318719876);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (312655,85555618928,'Lale','Ekrem',4,05416544191);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (665865,32328816581,'Ba��� Can','Elba��',5,05423725379);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (420345,24335913124,'Mert Cem','Eli�in',1,05418653861);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (452681,48539548382,'Ahmet Sencer','Emiko�lu',6,05353753864);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (530826,83123695339,'Akife','Erbay',5,05326984628);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (333877,91745162767,'Bur�','Erbil',3,05541361388);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (841487,38369331411,'Nadire','Erbul',5,05335432854);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (555614,86476844381,'H�seyin Zeyd','Erco�kun',3,05329317964);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (688719,51669554766,'Aynur G�l','Erc�ment',1,05347656719);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (714538,92321541965,'Samed','Erek',4,05313856329);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (658893,75819234564,'Cem Ozan','Erim',2,05419377924);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (217920,94227742874,'Bahar Cemre','Erin',5,05441848342);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (873679,47141122871,'Rekin','Erkek',3,05331744133);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (725743,76611657997,'H�seyin Serkan','Erkekli',6,05538327174);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (661444,43754847867,'�brahim Canda�','Erki',2,05355498926);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (898266,13578797818,'Beniz','Erkmen',5,05539692444);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (311622,12358188516,'Hasan Burak','Erko�',1,05549185436);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (864871,55933988111,'Selman','Erko�an',2,05423533886);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (972055,71444622644,'Hanife Nur','Erkovan',4,05458673972);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (380697,51386853764,'Alper Emin','Erku�',1,05454829517);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (970367,38974562137,'Elif Kevser','Ero�lu',5,05522296666);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (981863,24555266263,'Abdullah Mert','Erol',5,05553222386);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (195398,16659782156,'�isel','Ersin',4,05522715461);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (602505,83737521241,'�lkin','Ers�z',4,05343463252);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (231571,98684178441,'Cantekin','Erten',3,05358461692);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (619840,48683288923,'Onur Kerem','Ertep�nar',3,05311891985);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (187687,91148211525,'�smail Enes','Eruzun',1,05533353673);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (308891,19819248745,'Ham�d','Ery�ld�z',5,05336476822);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (353444,92187988875,'Tunca','Ery�lmaz',6,05545485531);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (819505,76525924725,'Arslan','Erzurumlu',6,05425945665);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (802780,29719316444,'Neslihan Bu�ra','Esat',2,05443593222);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (385564,67552879716,'L�tfiye Sena','Esen',3,05558781553);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (680466,28278948621,'Belin','Esendemir',5,05323234869);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (947621,15172515844,'Rukiye','Esgin',3,05511993255);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (384492,12976899199,'�slam','Eshaqzada',1,05416952476);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (847061,56347665148,'Bat�ray','Eski',1,05346792639);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (302562,77881475251,'S�heyl','Esvap',3,05545834432);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (741349,65613485686,'Yarg� Yekta','E�e',1,05459312715);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (316156,23791132635,'Elzem','Evrenos',2,05356942196);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (794933,51265912496,'Ilgaz','Eyipi�iren',2,05423582787);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (422430,77826675346,'Ongar','Eyyupo�lu',3,05434126467);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (615111,23641692723,'Faik','Ezber',1,05526513387);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (460932,25818843721,'Turan','Fahri',2,05538997228);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (886661,15249936716,'Okbay','Fatih',2,05527621929);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (358435,32666499945,'Latife','Fatin',6,05437522314);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (392717,91417291527,'Ey�p Orhun','F�nd�k',1,05316515818);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (330885,55367679281,'�rfan An�l','F�nd�k��',6,05447533231);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (623732,82288796977,'Ertu�','Furuncuo�lu',2,05359883382);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (683453,57279912756,'Berhudan','Garip',2,05444977181);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (629708,45669273213,'Nihan','Gazitepe',3,05313151256);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (822722,65293859449,'Menek�e','Geben',5,05426835929);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (391735,52653921717,'�eniz','Gebolo�lu',2,05345838898);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (199105,24535237812,'Zeynep Senahan','Ge�io�lu',4,05333779114);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (709199,31537491344,'Hayri An�l','Ge�kin',5,05535567136);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (651210,41535986414,'Muazzez Ece','Gemalmaz',1,05545636161);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (521544,49661551334,'Kerem Cahit','Gen�o�lu',6,05446594574);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (878308,68929469821,'Sad�k Can','Gezmi�',1,05444112654);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (733352,52546938799,'Resmiye Elif','G�rg�n',3,05517985917);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (153455,89646955882,'Nergiz','Gilim',3,05319647335);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (849021,74827177728,'Mehmet G�kalp','Ginovi�',4,05345949383);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (955382,44233256626,'Mehmetali','Girgin',5,05436515552);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (513507,47795865111,'Abdullah Halit','Golba',3,05341698145);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (360445,18875968987,'Tilbe','G��',5,05537732789);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (258602,39848941952,'Kubra','G��men',2,05555559251);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (369590,12735755374,'Kubilay','G�dek',5,05413314697);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (939979,75789896534,'Busem','G�k�easlan',6,05451112221);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (221582,93948474282,'Banuhan','G�k�ek',6,05349754717);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (300500,58194653345,'�rg�n','G�khan',1,05528449399);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (286884,37281561845,'Melike','G�ksoy',4,05415499347);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (305495,67924286399,'Ye�im','G�lmes',6,05335794821);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (662016,49233271186,'Nil�fer','G�nay',3,05325271727);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (628585,66314495593,'Denizhan','G�n�l',4,05351653553);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (946492,28557457999,'�ueda','G�reke',4,05533218387);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (706413,95267347489,'Ersin','G�rg�l�',1,05352585134);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (410514,87858923514,'�ahabettin','G�rg�ner',6,05533622863);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (887442,73261371998,'Ay�e Elif','G�r�r',6,05315871293);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (559697,88484611774,'Naz�m Berke','G�ven',6,05312569137);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (284266,66125694766,'Meltem','G�ymen',5,05516118463);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (624225,82619458588,'Abdulhalim','Guguk',2,05428261894);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (832357,88656661213,'G�lten','G�d�c�',4,05338495136);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (921661,96833132583,'I��nb�ke','G�lcan',1,05333221117);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (840674,89574923954,'Vedia','G�l�in',6,05352823163);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (412435,42893877889,'Fatma Sena','G�ldo�u�',1,05546376818);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (628730,35661365221,'�mer Okan','G�lebakan',4,05331496455);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (523847,18357827383,'Aybike','G�le�',1,05515833421);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (782934,99548237136,'Bekta�','G�len�',5,05312856955);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (392826,67338331219,'Emircan','G�lery�z',3,05413617121);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (914428,51224628389,'Merter','G�lkan',3,05343539454);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (190626,11918661472,'Sevgi Tutku','G�ll�ce',2,05557285688);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (353279,22799476915,'Denkta�','G�l�en',5,05328869638);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (669592,64748647323,'K�ksal','G�lta�',3,05338169866);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (539882,31217842766,'Hasan Fahri','G�ltepe',2,05516584319);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (766204,52218181753,'�ymen','G�m��soy',1,05452843343);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (367990,98781579847,'Eylem','G�nd�z',2,05512182352);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (263036,95123998552,'Melek Diler','G�nel',6,05512123855);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (693612,55754929261,'Argun','G�neri',6,05428967925);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (809800,92961747764,'Mehmet Yekta','G�neyi',6,05537859748);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (484821,28481329462,'Yasemin Erva','G�ntek',5,05556786455);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (180398,99767498274,'G�nan','G�ral',3,05515977935);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (576017,49632586993,'Osman Cihan','G�rdemir',5,05532929941);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (662599,91739733689,'Okyanus','G�rel',6,05434765474);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (288988,37934981664,'Mert Alican','G�re�',1,05554112122);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (214408,94513417496,'Zeynep Do�a','G�rses',1,05336967395);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (689562,62183227675,'Tar�k','G�ven',1,05525656438);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (948335,13385358515,'Birgen','G�vener',4,05455292259);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (366356,32912254371,'Ahmet Korhan','G�zel',4,05353927477);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (241938,54559899183,'Manolya','G�zeller',5,05535768112);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (384313,43398647734,'Mustafa Berkay','G�zelo�lu',1,05531732268);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (838031,53714813358,'Mehmet An�l','Hac�alio�lu',6,05415793633);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (350930,74828115831,'Ahmet Furkan','Hac�lar',1,05412127315);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (328080,72145362352,'Fazilet','Hac�o�lu',6,05519177532);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (462994,31956654338,'K�v�lc�m','Hadi',5,05344382336);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (552902,98187841693,'�isil Hazal','Haf�z',3,05453142714);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (828402,72153365664,'Feray','Hakverdi',3,05552723167);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (977566,52881231669,'B��ranur','Hala�o�lu',1,05413619653);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (556621,24465224669,'Selin S�la','Hal�c�lar',5,05333949246);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (169628,31583255188,'Yeter','Hamamc�o�lu',5,05357624124);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (597633,65821911674,'Ramazan Tar�k','Hamarat',6,05339711483);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (731065,52582625347,'Boran','Hamidi',1,05445688677);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (929562,32822572671,'Tazika Hilal','Hamzao�lu',1,05559697535);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (247243,51336789872,'Aynur Dilan','Hanc�',1,05417123698);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (440529,14267536667,'Ayman','Hang�l',3,05356633896);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (762429,93757545859,'Berrak','Harman',6,05511492925);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (181156,55784741665,'Erk Deha','Harmankaya',6,05341744658);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (528496,25784132493,'Perihan','Hayk�r',2,05543239362);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (870891,38667199445,'Turhan Onur','H�rlak',2,05424177235);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (607103,53928198996,'Furkan','H�zarc�o�lu',4,05453116688);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (620854,91462168344,'Mustafa Ali','Hi�y�lmam',5,05532843882);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (349788,39959462645,'Muhammed Sefa','Hilal',6,05416318389);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (795885,42615162935,'Arg�n','Hilmi',3,05318335965);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (369973,65649635321,'Fadik','Himo�lu',6,05436622685);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (787122,76536334737,'Ahmet Hakk�','Hirik',5,05548654924);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (417854,46647377666,'Mustafa Sefa','Hopac�',2,05451768324);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (973575,59857934166,'Toykan','Horata',3,05358317483);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (647228,47926165467,'Selime','H�ner',5,05335971818);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (987203,15814265216,'Denizcan','Il�k',5,05445979871);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (946102,72111153159,'Ay�e Zeyneb','Ir�c�o�lu',2,05541978342);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (129799,78647556792,'Mustafa Furkan','I��nay',6,05531796167);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (703017,79756725967,'Sude','�brahim',2,05346623858);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (427768,49634489437,'G��l�','��ten',5,05346439364);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (738296,32821785613,'Katya','�lgezdi',3,05357157149);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (336357,97477839231,'Halid','�lhan',4,05512858796);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (448322,31518946126,'Nihal','�l�su',2,05441592425);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (694505,96191811189,'Elif Nisan','�mamo�lu',6,05428748736);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (167680,24228357499,'Emine Selcen','�mre',1,05534586984);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (691557,64286937334,'Tevfik','�nal',2,05442427836);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (574180,77323194317,'�brahim Ka�an','�ncekara',6,05336621376);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (345368,55472554554,'Sidar','�nceo�lu',4,05547657264);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (319297,35495866268,'Nesli','�p�izade',4,05557754794);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (775956,61438257533,'�hsan Vehbi','�peko�lu',4,05422153666);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (933462,66221982821,'Necati','�rsoy',5,05354636279);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (384149,58117573977,'Zerin','�shako�lu',4,05436429365);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (630382,51685192758,'Dursun Korel','��g�ren',5,05448646463);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (965934,82231541861,'Ahu�en','��g�zar',3,05527825556);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (890316,73516488491,'Uzel','Kabata�',3,05439731272);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (376207,25499198929,'Melis Ezgi','Kabayuka',3,05322165835);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (928971,55677875419,'�aziye','Kabuk�u',5,05458583676);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (881073,12884797359,'Berg�zar','Ka�arano�lu',3,05455381216);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (291830,12655935328,'�mer Faruk','Kad�',4,05332935872);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (184579,97939355214,'Da�han','Kado�lu',4,05416961834);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (156295,36951715395,'�nzile','Kalfao�lu',3,05435346756);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (410324,49296438628,'Sezer','Kals�n',5,05514451625);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (376802,56653833395,'�ensoy','Kalyoncu',3,05337798434);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (169852,99624543526,'Necat�','Kam��l�',4,05328222579);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (987077,76135384149,'�ahan','Kanda�o�lu',3,05444672216);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (954271,27739569778,'Necip Faz�l','Kanl�',4,05518843266);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (724716,56176126436,'Muharrem','Kanmaz',1,05524547214);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (256259,87655323381,'Zeynep Figen','Kantarc�',5,05518369528);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (301870,72244522919,'�ilay','Kaps�z',4,05545561213);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (807509,95771835296,'Suna','Karaaslanl�',4,05358917726);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (398858,33393675265,'Ahmet Can','Karabacak',2,05549621817);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (749812,79363846113,'Asya Sema','Karaba�',2,05451878983);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (118078,67847485161,'G�l Sena','Karab�y�k',1,05529342195);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (962548,54488649429,'Fatma B��ra','Karab�y�kl�',5,05445672186);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (958251,71558794697,'Arca','Karabulut',1,05527635523);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (964626,16398141268,'Abdullatif','Karacabey',6,05439483526);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (725936,26181757998,'Tu�ra','Karacan',1,05548493814);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (547117,14431193195,'Emir Do�an','Kara�ay',1,05451641948);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (845551,34368554664,'Haluk Bar��','Kara�e�me',5,05344892245);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (390363,15739118554,'Seyit Ahmet','Karada�',3,05529828719);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (640435,41616681461,'Cevza','Karadalan',6,05416877992);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (535155,38398726362,'Mustafa Emir','Karademir',4,05334215862);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (618057,95694168716,'Ilgar Pamir','Karaismail',3,05338968444);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (175895,68963314755,'Seren','Karakan',1,05452118334);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (311256,35862457955,'B��ra Hazal','Karakaplan',6,05434484376);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (416917,31943123958,'Naci','Karakaya',1,05436496254);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (912022,85883598944,'O�uz Selim','Karakelle',2,05519638761);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (647707,32254886826,'Faik Altu�','Karakoca',4,05533934488);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (573662,92467966388,'Din�ol','Karalar',6,05545972387);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (489410,94653855426,'Ceyhun Kadir','Karamollao�lu',5,05335469264);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (116872,62584725988,'Tayyibe','Karaniso�lu',5,05527754857);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (674802,86485583712,'Hayriye G�l','Karart�',4,05354341916);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (362794,86311396263,'G�lsanem','Karasapan',3,05335633555);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (573480,81772451824,'Yelda','Karda�',4,05433369592);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (372525,48468572877,'Kuntay Yi�it','Karga',6,05448945131);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (650779,32471221465,'Ahmet Berke','Karg�n',2,05515395192);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (949900,11644333944,'K�van�','Kasac�',2,05355338267);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (236798,52527481268,'Vira','Kasemllar',2,05455294821);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (130529,69561679435,'�rsel','Ka�ka',5,05316647937);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (955295,41224282289,'Esma Ece','Kavak',3,05515394244);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (230409,74782753948,'Benek','Kavas',6,05352487666);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (329728,31816551438,'Hale Nur','Kavaso�lu',1,05444512382);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (336222,19498832229,'�m�t','Kavuk�u',1,05315185354);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (967470,85444779935,'�shak','Kayacan',3,05533385383);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (363850,94685215691,'Ibrah�m','Kayahan',2,05556235839);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (870855,92544447654,'�d�l','Kayal�',2,05433738645);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (660752,13467469913,'Ege Sarp','Kayar',2,05427233665);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (349247,56287234285,'Mahmut Onur','Kayhan',1,05436825183);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (898830,97771664367,'Mimoza','Kaynam��',2,05425947729);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (436979,44346667645,'Cemile','Kazici',4,05322878173);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (877407,84349743367,'Belit','Ke�e',2,05324993284);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (859144,34335248962,'Asl� Nur','Kefal',4,05436994181);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (521850,15887744757,'Acun','Kele�',2,05534914733);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (879079,72793565668,'Beh�et Kutay','Kerem',2,05323448128);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (843105,63993755996,'Ay�e Merve','Kerigan',2,05419514865);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (751914,55231999125,'Behin','Kerimov',4,05347548926);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (756226,97542291641,'Fatma Hilal','Kesbi�',4,05341396788);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (136043,12691742795,'Nun','Kesgin',5,05535117433);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (280852,24293229981,'Ahmet Mehdi','Keskin',1,05442894481);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (963429,19513666341,'Mehpare','Keteci',2,05432418795);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (267159,17167425121,'Muhammed �kbal','Kevkir',1,05445142152);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (471914,11168734786,'Alaatin','K�l�ad�r',6,05319711251);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (928575,94978865428,'Hamit','K�ld�r',3,05415189583);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (994220,34784357841,'Muktedir','K�l�n�arslan',3,05549672966);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (656260,27363459343,'Onur Abdi','K�na',6,05543519889);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (677175,35243195554,'Lokman','K�rb�y�k',4,05551734874);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (971456,87125118555,'Mert','K�rg�z',1,05337189988);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (586338,99463876231,'G�lenay','K�r��',4,05322283864);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (537307,68852224525,'M�r�ide','K�rkp�nar',1,05413827933);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (373987,68497371312,'Furkan Fatih','K�rm�z�',4,05548321417);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (873765,22142563412,'Hatice B��ra','K�rta�',4,05347619267);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (299997,58368699538,'Ya�ar Fatih Enes','K�rtay',6,05418478358);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (443538,76485371934,'Parla','K�ryayla',1,05451865822);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (888841,72576757227,'G�l�e','K�v�lc�m',1,05558146236);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (727858,36316531429,'Yasin Burak','K�z�l',1,05519342343);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (994545,37855827795,'Alim','K�z�lbo�a',4,05346672528);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (326675,29379728848,'���an','K�z�lca',2,05339718762);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (366360,61961825255,'Evren Burak','K�z�l�rmak',3,05319896847);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (764954,51477245748,'�zge Gizem','K�z�lkaya',3,05428322424);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (659476,13972411269,'Dil�ad Nur','K�z�ltu�',6,05315291244);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (582544,56431823393,'Enes','K�zmaz',6,05352667416);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (920161,71593954623,'Yal��n','Kilmen',5,05328349969);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (215921,17777976714,'Ali Ayd�n','Kirez�ik',1,05335518975);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (991739,93817463569,'S.Kaancan','Ki�ial',4,05338786716);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (211592,48536921955,'Maisam','Ki�in',2,05555262311);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (636509,13747876322,'Mehmet Han','Kocaba�',4,05357964439);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (154195,92525877979,'Irazhakk�na','Kocab�y�k',1,05338462998);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (599350,78113563896,'Yi�ithan','Kocademir',2,05529385961);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (594684,27246527332,'�rem Ceren','Ko�ak',5,05318296171);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (529692,91784379652,'Yusuf S�ha','Ko�baba',1,05525535254);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (864050,85819131773,'�ptal','Ko�soy',2,05351645854);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (560731,92389621123,'Abdulsamet','Konako�lu',5,05336824519);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (568558,14481452839,'Mehmet Bar��','Kondakc�o�lu',4,05324691167);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (775468,14787648176,'Ahenk','Kontac�',3,05448396335);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (485180,59375698375,'Hayat','Konyar',4,05532975236);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (729374,27125531697,'Yi�it Alperen','Koparan',4,05334483627);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (817521,54518954311,'G�ner','Korkmazcan',6,05419221791);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (442011,63951296548,'Berfu �rem','Ko�kulu',3,05349817493);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (180799,54839547187,'�lke','Kotan',4,05544349775);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (952976,64494427251,'Ali Ozan','Kovanc�',6,05527224153);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (258774,69336329959,'Fatmanur','Koytak',1,05555747192);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (336309,47516741827,'�brahim Fehmi','Koyunsev',1,05418896641);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (218502,33753918577,'Asl�naz','Kozak��o�lu',4,05432157379);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (521465,68287721483,'Ataalp','K��er',2,05341784735);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (353738,31281667271,'Macide','K�kc�',3,05346645435);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (902404,77864766644,'Mustafa','K�ken',4,05546269731);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (224471,63983513299,'Aybar','K�rm�k��',5,05532862287);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (211770,61183633659,'Sah�n','K�se',6,05539219295);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (531875,44954644535,'Tun�','K�yba��',6,05431927764);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (248963,88978442217,'Ruveyda','Kuday',6,05539934956);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (229009,64295884163,'G�rol','Kudu',6,05342855916);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (808255,45367216555,'Chakan','Kukarac�',2,05455427637);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (626176,39725842556,'Elis','Kul',3,05517789314);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (329392,31331755741,'Selma','Kulo�lu',6,05543579465);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (193057,67631877193,'H�seyin','Kumru',6,05347815392);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (207301,64377153638,'Acar O�uztan','Kundak��',5,05444369547);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (413146,51235529587,'G�ney','Kunter',6,05333241536);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (916734,41192273726,'�zge S�la','Kuntman',5,05354752819);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (124859,43324225488,'Seval','Kurtan',4,05355795355);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (272626,28186626323,'Berna','Kurtulu�',2,05336922596);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (683266,75458763917,'�erif Erkam','Kutanoglu',1,05546938186);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (328423,71655486157,'Melike Tamara','Kutlay',5,05544463254);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (632930,45114423688,'Ay�a�','K���kbey',6,05313415252);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (266565,18185383372,'Sadiye','K���kkase',5,05422695591);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (508823,87881687618,'Ali','K���kler',3,05428751776);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (510122,28622166773,'Nigar','K�lahl�oglu',4,05342538225);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (510895,79833628937,'G�lben','K�rk',3,05322276515);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (115919,68528966199,'Ay�e Ferhunde','K�rkc�',1,05347177131);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (611057,59947735417,'Eralp','K�r�m',2,05537134649);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (321729,69239111696,'Alperen','K�sk�',6,05539575936);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (297406,42551618828,'Zehra Sena','Madran',6,05413536445);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (831458,42187727518,'G�nd�z','Ma�den',3,05333314281);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (273344,82683281711,'Osman Emre','Maldar',6,05524697182);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (987847,51971526745,'Kubat','Malek� Ravasan',2,05418663846);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (682945,15226961184,'Bahar El�in','Mammadov',2,05451151951);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (116943,63414197469,'Nuelif','Mardanlou',5,05531331454);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (459442,94791764149,'Mehmet Eren','Masarac�',4,05529277915);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (276937,26144653653,'Melis','Mas�r',1,05421818688);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (318129,11745729133,'Fat�ma','Matur',4,05551759296);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (292054,73583366295,'Karaca','Maydagil',4,05443411887);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (246519,49339211424,'Zafer Engin','Memi�ler',3,05514719353);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (382680,27649515821,'Duygun','Meng��',4,05353739947);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (319687,34788396611,'Havag�l','Mercimek�i',1,05548114696);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (773444,48852646956,'Arif Furkan','Merdan',4,05451748146);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (360433,98653587483,'Halit Can','Mert',6,05548616245);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (175089,58331475948,'Pertev','Metin',1,05445538238);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (274817,85141476314,'Selis','Mezarc�',3,05526969128);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (186402,92586163687,'Galip','Mirzanl�',4,05452692517);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (910117,95761377994,'T�lay Tu��e','Miso�lu',5,05436854764);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (403782,66236148956,'Ahuse','Mohamed',2,05514681562);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (801997,14687839146,'Barbaros','Molla Ametal�',5,05339269331);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (426989,79683537996,'Lawrence Tezoh','Morbenli',6,05521995813);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (612670,93325299368,'G�rkem','Morelli',3,05555531426);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (206178,61945965979,'Abdurahman','Morg�l',5,05511381723);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (474174,46661831179,'Z�lcenah','Mortepe',1,05356489882);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (420426,59494654676,'Saadetnur','Mumcu',2,05417145736);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (129029,94427166943,'Hasan G�rkan','Murato�lu',3,05431678666);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (547973,46712124724,'Sehmus','Mursal',3,05426581916);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (835630,52914999771,'Berkan','Musao�lu',5,05431558623);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (220849,59798756235,'Ersel','Muslu',5,05357147587);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (425056,78638333425,'Batu�','Mutman',5,05543884782);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (833974,55431979538,'Dilsu','M�nif',3,05434163972);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (122953,56226888519,'Erdo�an','Nalbant',5,05511787217);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (763136,39276386899,'Bat�','Nalbanto�lu',4,05558183564);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (599170,93287487968,'T�rkan','Nal�ac�',1,05511857331);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (771634,42161913579,'G�lp�nar','Namdar',6,05358863559);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (522109,73135184534,'G�k�in','Naml�',4,05359873511);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (910236,86585464115,'�lker','Nayman',3,05344575781);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (148865,15624477962,'E�lem','Nerkis',5,05328185958);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (615804,15567232868,'Nazl� �z�m','Ni�anc�',1,05442559756);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (663179,14679333289,'Alk�z','Numano�lu',2,05523864888);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (474129,25466653557,'Nimet','Ocalan',4,05345482997);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (669362,52962759736,'�smail Egecan','O�ar',4,05351634365);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (811611,12779252287,'Kamer','Oduncu',5,05547576254);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (389571,84658786859,'Gencal','Oguz',5,05445475592);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (820128,22757161918,'K�r�at','O�uz Fp',5,05418579231);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (929866,64884324862,'�rem Ba�ak','O�uzhan',6,05324899493);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (416154,75695378966,'Ula� Can','Okan',5,05427678515);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (603432,73962214634,'Tunahan','Okatan',3,05332417688);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (766275,35728828726,'�zel','Okcu',6,05334925688);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (294078,99398799674,'Eliz','Okkaya',6,05426449657);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (159300,16638514126,'�isil','Okumu�',6,05425955374);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (469627,14825225766,'Kerem Can','Onu�',5,05515634588);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (812905,19131699898,'Keremcan','Oralo�lu',5,05549567474);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (855079,89841156777,'Talip','Orhan',5,05531193411);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (678452,16397898998,'Beste','Orhon',6,05518599318);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (133197,67855784149,'Ismet','Orman',4,05326854565);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (617226,75684212684,'Mustafa Bora','Ozgun',4,05545332668);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (590931,94691944875,'O�an','�cal',1,05356424459);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (840200,42541336389,'Ahmet Cihat','��redik',5,05335113297);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (789164,53172575717,'Vahide','�kmen',1,05533432143);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (795473,56888931789,'Murtaza','�lmezler',6,05551454163);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (917191,29127563797,'G�nen','�nder',5,05558251257);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (507171,74532599316,'Zeynep Tuba','�nen',2,05547942311);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (462609,58838718685,'G�nkut','�no�lu',6,05553768275);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (417041,27147581413,'Faruk Do�ukan','�rero�lu',3,05559815738);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (791698,18511796954,'G�nyol Ufuk','�rge',3,05445449743);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (394363,51631422649,'Selimcan','�rs',3,05315876798);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (855164,22948736868,'Raif An�l','�ter',2,05412829888);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (577057,79296674346,'Okan Deniz','�v�l',2,05446147333);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (200696,51485359175,'Mustafa Selman','�y��',1,05528767313);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (544399,51152841231,'Aysel','�z',6,05559251543);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (607766,96118732899,'Ajlan','�zakyol',4,05522486489);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (688754,53714656277,'Ayhan Furkan','�zar',2,05426218837);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (337764,39151247686,'Ebru Ece','�zata',1,05348233248);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (233082,16521546532,'Berfin Elif','�zay',6,05333145378);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (653994,16776911643,'Muhammet','�zayd�n',1,05333773163);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (276422,96931844753,'Arda Alan','�zayral',1,05442677463);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (153420,81487678945,'I��lay','�zbey',3,05315761935);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (754495,68212179478,'�elale','�zbir',4,05521781149);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (139066,27664666726,'Oktay Emir','�zcan',4,05318359221);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (350233,54317821685,'G�niz','�zdel',6,05323452162);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (864364,35154479828,'Murathan','�zdil',5,05453549586);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (756290,64245324385,'Kadirr','�zdin�er',4,05318127225);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (653726,74849597345,'An�l Se�kin','�zel�i',2,05412535517);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (436818,27893693673,'Dilay Nur','�zer',2,05329778978);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (778268,86337369654,'�emsi Yi�it','�zev',1,05515883581);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (276366,85488175834,'�lay','�zgen�',6,05437613181);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (910288,32246914512,'Bedia','�zgeno�lu',6,05318587593);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (666248,39741899753,'Kadir An�l','�zgezgin',3,05525647188);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (111226,63165519548,'Ecem','�zg�l',4,05526493568);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (581249,69759946641,'Giray','�zg�m��',1,05546296152);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (845392,47295489741,'Abdulsamed','�zg�r',3,05332543919);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (777332,71533431678,'Tend�','�zg�r�n',4,05328192933);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (914768,15427475344,'Emine Tu��e','�z�rk',2,05344638453);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (666643,11433313961,'Mehmet Y��a','�zkol',2,05349669317);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (209421,88187419329,'Egehan','�zk�k',5,05515762127);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (679125,99592791829,'Mustafa Eren','�zkul',1,05344947984);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (561038,88356729722,'�remnur','�zmez',2,05439154922);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (818211,47561743549,'Fahir','�zpak',4,05437594679);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (804316,63426754159,'Ali Ahmet','�zper�in',5,05445268419);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (637511,57614414594,'Ey�pcan','�zperk',3,05531734271);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (833264,45618622488,'Merve Nur','�zpolat',4,05551587538);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (750052,46437947937,'Muhammer','�zsoydan',3,05358183217);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (570066,54744782453,'Arkada� Necati','�zta�',1,05544344993);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (147659,85339121757,'G�nayd�n','�zteker',3,05342145156);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (518469,13484912796,'Zuleyha','�ztemel',2,05315699633);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (103301,17741551661,'Mustafa O�uzhan','�ztun�',5,05341659199);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (863364,28658498911,'Okcan','�zt�rk',2,05517584185);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (229263,33656746438,'Muhammed Emin','�z�berk',2,05452433381);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (870871,96517934749,'Gamzenur','Padak',5,05347864444);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (370921,11929815562,'Muhammed Kerem','Pak',3,05412475773);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (981126,69482887938,'Zeynep Ecehan','Pakdemirli',4,05332942976);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (157625,47199623321,'�afak','Pakdil',5,05333365418);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (177166,24391613727,'��kran','Pakkan',5,05344986384);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (442739,76352575464,'Altay','Paksoy',6,05429878499);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (874510,48822325669,'Hicret','Palanko',3,05328363544);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (745140,21171633511,'Nusret','Palut',3,05319599338);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (992185,77646173199,'�mer','Pamuk�u',1,05538534622);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (745593,13464691647,'Mehmet Ziya','Pan�ar',4,05532487415);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (593116,96454687511,'Aysu','Parlak',5,05435362847);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (587421,89159441566,'Cenap','Pa�olar',3,05446925191);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (626537,25732437539,'Ata','Pazar',6,05431764786);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (723529,18235834835,'�aban','Pehlevan',2,05344843968);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (443031,84121269694,'H�ma','Pehlivan',1,05352469958);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (899894,87786256815,'Ekin Esme','Pehlivanl�',5,05442392943);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (679192,55437594112,'Mehtap','Pehlivano�lu',4,05447578329);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (798187,64432853948,'Mehmet Said','Pekdogdu',6,05328583765);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (216845,46436933254,'Cihad','Pektemek',5,05311952819);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (389488,98534725955,'�enay','Piri�tina',1,05423995925);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (903487,72355342799,'�mran','Po�an',5,05341782537);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (824807,55769479683,'Evren','Pomay',6,05431528627);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (276505,96947857165,'Kevser','Portakal',5,05431968566);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (959901,78918635244,'Ziynet','Posb�y�k',6,05451188163);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (895372,52783192286,'Muhammed Kutay','Poslu',4,05529389717);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (214684,88657335795,'Efgan','Puca',5,05422672962);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (847156,69143432789,'Bahar Merve','Pur�u',4,05455585172);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (784868,14153374185,'Dilara Ay�im','Ramis',4,05521419572);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (958552,28254668618,'Tomurcuk','Rauf',1,05311731891);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (723288,79376173643,'Simavi','Remzi',2,05356527711);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (461617,47848925314,'Esma Eda','Revan',6,05559865977);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (766615,78395313718,'Utku','Rona',3,05432167443);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (557290,45821933612,'Nurseli','Ru�an',2,05434858244);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (575770,77952823678,'Ur�uk','Saat�iler',5,05533262475);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (702411,27281822325,'�a�atay','Sabah',6,05352463961);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (412712,81645215528,'Niyazi Umut','Sabri',3,05436458158);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (650893,59646976323,'�a�la','Sa�ak',3,05554391244);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (465287,78138596143,'Ay�e Berre','Sadak',6,05327927921);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (608924,18948939715,'Ali G�rel','Sad�klar',6,05447497933);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (227848,42387412264,'Tayyip','Sad�ko�lu',6,05516497776);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (937058,65861974194,'Ne�at','Sadri',1,05344741661);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (881817,17421937642,'Ferudun','Saf',4,05518752572);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (528570,22211355321,'Ay�e Saliha','Sakarya',3,05444165186);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (841657,94273663722,'Emre Can','Sakaryal�',1,05328684283);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (519587,11872238783,'�mer Sefa','Saltuk',3,05556452214);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (423750,35742678449,'Ahmet Enes','Samanc�',6,05532329682);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (453334,79592531577,'Ali �zzeddin','Samar',3,05441151495);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (814558,98725814672,'Fatma Serra','Sami',2,05337325677);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (116836,99172494626,'Arcan','Saparca',1,05455253243);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (357765,67683423214,'G�nnaz','Sar',2,05343177998);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (910730,62562191287,'Simge Nur','Sara�gil',2,05354382538);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (714469,87783232948,'Nesrin G�k�e','Sara�lar',5,05434827157);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (124379,37926669213,'Ay�e I��l','Saray',4,05321669337);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (379525,29496984275,'Nuece','Sar�altun',5,05546487985);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (426530,81839875231,'Muhterem','Sar�o�lu',3,05414241138);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (470828,99167639114,'Eseng�l','Sar�teke',3,05447242939);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (646887,21186367618,'Cansunur','Savca',6,05324612235);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (128271,35998224955,'Necmettin','Saydam',1,05349651711);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (681019,45176898487,'Melike Nursultan','Saydan',3,05532654178);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (983049,73565562225,'Ay�i�ek','Sayg�n',1,05324699113);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (557615,97684118985,'Muhammet Fatih','Say�c�',6,05458456472);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (377518,64279311329,'Orkide','Say�l',5,05525721345);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (546788,61284129863,'�zge Elif','Sayra�',3,05428251316);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (203380,43374565684,'Refia','Sazak',2,05525857862);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (159224,96155944269,'Yasemin Bahar','Schmitz',1,05351471891);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (323495,81159891929,'Mina','Sel',3,05522352371);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (951998,33376125447,'Servet Ecenaz','Selcuk',4,05431393891);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (562455,51561495459,'Sevde Nur','Selvi',5,05551571663);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (686869,12858547342,'Abdullah Furkan','Sent�rk',3,05452952311);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (999019,35765253444,'Olca','Sevcan',2,05542161229);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (696088,21448497847,'Nebi','Sever',1,05422282297);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (804328,95131443621,'Yasemin','Sevigen',1,05411558668);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (180716,45233961583,'G�nay','Seydao�lu',5,05343321946);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (718212,89616622391,'Z�leyha','Seyfi',1,05442515484);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (576800,71621185584,'T�nay','Seyhan',2,05514281373);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (742064,53546874953,'Tanju','Seymen',1,05547124947);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (481696,56368798771,'Muhammed Sait','Seytin',3,05352573835);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (641538,16125721982,'Mehmet Akif','S�ra�',6,05546322713);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (943861,92936831938,'Kaan Kubilay','Simavl�',6,05345227356);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (737554,22652218319,'Ay�e G�l','Sobac�',4,05537935642);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (614788,53816313296,'Canel','Sofyal�o�lu',4,05425764519);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (117844,31885478614,'Rabia K�bra','Solak',4,05314667817);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (332731,19389448477,'�kbal','Songur',6,05347937797);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (764198,16339884624,'Esat','Soyad�',3,05419176571);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (384498,69838614883,'Yunus G�ker','Soylu',1,05344462269);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (523540,19158464784,'Kanaat','Soyulmaz',2,05315257467);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (265055,31521515881,'Cengizhan','S�kel',6,05442492139);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (545305,24982812113,'Gencay','S�ker',2,05353382283);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (728153,27519178718,'Gazanfer','S�ylemez',6,05332521978);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (540779,66348199251,'Dorukhan','S�zeri',4,05355715752);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (704399,83833367859,'Hesna Ezgi','S�z�er',1,05457331983);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (639474,58241634512,'�lknur','S�z�m�etin',2,05433152569);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (579043,98456719191,'Firuz','Su',5,05538978432);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (423425,47722269385,'Hasan G�kay','Sug�t�ren',5,05432772771);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (927266,33458255273,'G�zay','Sular',1,05315593542);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (502895,93331718496,'�zg�n Mert','Suna',4,05442162316);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (476838,75435756357,'�par','Suyunu',5,05559878424);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (956885,44722182868,'G�ral','S�han',3,05548978385);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (564292,61526281996,'Naz Beril','S�leymanzade',1,05413725644);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (457080,38723211192,'�ris','S�reyya',6,05316649956);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (434169,59816966343,'G�lselin','S�rmeli',1,05429186727);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (878413,35536716742,'Alper','�adi',3,05454169265);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (379440,69378726817,'Abbas','�ahabettino�lu',3,05423677751);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (251394,17411378118,'Nugaye','�ahin',2,05551342626);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (218701,47487186574,'Buraktan','�ahing�z',4,05454973429);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (212772,14198829856,'Efe Mustafa','�akarcan',4,05347839718);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (837265,81427488845,'Behiye','�aml�o�lu',2,05342328895);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (438705,86543138477,'Ya�mur Helin','�ark��la',3,05521532623);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (178557,83329168888,'Asl�can','�ekercio�lu',3,05441749615);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (579884,15665235654,'�i�dem','�ekeryan',3,05529796244);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (373073,41162725376,'Taykut','�en �zen',2,05314631178);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (473610,59129335933,'Fehime �uheda','�enba�',1,05319148253);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (530677,89243135482,'���n�','�encan',2,05427634444);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (405479,86966562231,'G�rkan','�enda�',2,05524953187);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (537183,54731174743,'Sezanur','�endiller',5,05332334562);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (489173,41658363623,'Seher','�eng�l',6,05333561114);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (534931,61611147398,'Nejat','�enocak',1,05327492141);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (340736,55959575772,'Yeliz','�enyurd',2,05554318324);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (646225,88999273989,'Ali Tar�k','�erbet�i',1,05532262531);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (801031,94384977359,'Ada','�eref',1,05326277236);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (224183,73787725311,'Yunus Emre','�erifo�lu',2,05345735768);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (383265,41594227613,'Melike Deniz','�evkin',2,05335318762);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (135756,64451834683,'Mehve�','Tabak',6,05552122267);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (651643,81587636693,'Furkan Ali Can','Tabanl�',4,05427994795);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (219304,13249241721,'Aykan','Tabir',4,05457197873);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (173754,28337883942,'Ahmet Utku','Ta�',1,05425566917);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (130290,31645775166,'Dilara','Ta�g�n',1,05458762232);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (873915,92911883752,'Mira� Ayberk','Tahir',5,05514793655);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (401513,46825529885,'Kardelen','Tahmazo�lu',5,05531776833);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (101798,33638152929,'P�nar G�l','Talantemur',2,05438247494);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (713208,48375915367,'Arel','Tala�',6,05349884586);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (221613,89732819962,'Ay�eg�l Beg�m','Tanba��',3,05427957193);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (911911,58789914589,'Farshad','Tan��',3,05312881213);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (920153,79754517678,'G�zin Duygu','Tanr�kulu',5,05437156199);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (304669,74258562518,'Ebru �mm�han','Tarak��',1,05349463429);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (661339,55533932217,'Numan','Tarhan',3,05336693148);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (118023,26739842898,'�eliker','Tarlakazan',6,05456188193);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (104092,88616273378,'Seven','Ta�',3,05433861972);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (119231,48847513813,'Bala','Ta�ak',4,05341965374);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (670401,43343812674,'K�ker','Ta�c�o�lu',4,05356341312);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (565304,35975735633,'Batu�han','Ta���n',6,05542423929);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (184445,56944739796,'G�ven','Ta�l�',3,05454156852);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (206645,27772599587,'Eceg�l','Ta�y�rek',2,05457281862);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (845377,58275199745,'Beyzanur','Tatl�',6,05531492177);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (488053,11415382824,'Kerem Arda','Tatl�su',2,05519451935);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (542971,65275351197,'Abd�ssamet','Tayan',6,05358178215);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (693558,72778437739,'Tilbe Sunay','Tayfun',5,05342529643);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (969106,84558483976,'�smail','Tazeg�l',1,05547968761);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (357145,81247492173,'O�ur','Tecer',3,05415588574);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (444942,75219324969,'Aktan','Teker',6,05422395591);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (733049,39395994135,'Ahmet Bu�ra','Tekin',5,05444252198);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (515509,67667958116,'Deniz Hale','Tek�an',6,05442936421);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (217122,65192217622,'Umut Salih','Tekta�',3,05343669287);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (602075,51241624512,'I��ltan','Tekten',4,05516242625);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (903122,14365792987,'Erdem','Temizer',3,05459267191);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (268191,97468413683,'Atalay Furkan','Tenim',5,05539579434);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (340600,38637315559,'Ali Alp','Tercan',3,05452725451);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (221411,67899518613,'Sabiha Esra','Terzi',4,05337584329);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (643309,82284725374,'Yakup Can','Tetik',5,05416669669);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (256949,53999559575,'Talya','Tezmen',3,05358444671);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (830041,29994477814,'Tu�banur','Tiftikci',1,05329677657);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (238121,52525228346,'Akta�','Togay',2,05349989325);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (843528,58895498728,'Ahucan','To�an',3,05559228847);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (563637,53886774844,'Saime �ura','Toka�',3,05414974621);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (688257,57137666443,'Do�can','Tokal�',3,05519419286);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (923460,73342285952,'Bilhan','Tokatl�o�lu',6,05535459167);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (172556,25846368231,'Muhammed Bilal','Tokdo�an',5,05416655989);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (957489,64684798567,'��kr� �z�mcan','Toker',4,05518711831);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (698922,94236422797,'Ecenur','Tokg�z',4,05521743294);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (853375,84762664994,'Baysal','Tolunay',3,05514425997);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (419044,21482197483,'M�ge','Topal',6,05536565634);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (677174,28827993555,'Dil�ah','Topalan',1,05423585398);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (136783,99455149536,'Saliha','Topoyan',5,05311468468);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (878611,85764978157,'Tarcan','Toptan',5,05433654213);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (515134,16235635248,'R�ya Su','Tor�utalp',1,05435385895);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (986174,73182651485,'G�l�en Dilan','Torol',6,05546563879);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (923454,86828425239,'Velit','Toygar',3,05559479883);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (414031,78954222114,'Perker','Tufan',4,05339472786);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (678349,53333677997,'Lerzan','Tugrul',4,05419472424);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (455623,91528315677,'Nue','Tu�men',3,05431212218);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (195201,76861685669,'Ya�ar Emre','Tun�ay',6,05313736497);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (167114,85954428138,'Ayb�ke Ay�a','Turna',4,05546933243);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (240164,22966967549,'Muhammet Mustafa','Turul',1,05512565478);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (702136,85323379724,'Lalezar','Turun�',5,05535343129);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (907958,56618585116,'�yilem','T�de�',2,05551189161);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (513274,44127823949,'�stemi Furkan','T�fekci',3,05324671194);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (165037,31845218388,'�lsel','T�fek�io�lu',1,05359942397);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (708025,14837242381,'Muhammed Can','T�rkmeno�lu',4,05326712365);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (231772,19163666482,'Mebruke','T�rko�lu',5,05317374933);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (726647,63921239582,'�mm� G�ls�m','T�t',1,05515195312);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (339701,88342823132,'G�kb�ri Mert','Ubay',6,05535937154);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (861321,57788689498,'Zeynep Neslihan','U�anok',1,05452936433);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (860202,73767419545,'Malik','U�ar',4,05455132376);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (116124,71976627613,'Umut Mert','U�ma',4,05552969291);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (206284,81415161995,'Enginsu','U�ur',1,05539652656);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (220572,77249794157,'Merveg�l','Ula�',6,05528263362);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (526365,15985236368,'U�ur','Ulu�',3,05545212358);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (217935,66388347251,'Caner Hazar','Uluhan',2,05553236228);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (754793,36953331788,'Ay�im','Ulup�nar',3,05433284942);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (474924,59741562167,'Arife G�lbiz','Ulusoy',3,05311747626);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (552895,33714922212,'Hatice Berna','Uluta�',2,05549234716);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (545016,94392793542,'Kuntay','Urganc�',2,05446811171);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (534700,42533928873,'Berra','Urganc�o�lu',1,05334813942);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (928350,65843296763,'Zehranaz','Usanmaz',2,05449649188);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (465204,99574534854,'Ahuela','Usluer',1,05447229134);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (894268,13914644273,'Bedriye Seray','Usta',2,05338438278);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (531880,29676788791,'Alp Dora','Ustaba��',2,05316447576);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (555490,58354557776,'G�l�mse','Usumi',2,05535541979);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (265162,26428228739,'Engin U�ur','U�ak',4,05426944531);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (730912,14597189972,'Gizemnur','Uyu',2,05354694159);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (398844,91268282644,'Kemal Tolga','Uz',4,05557788514);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (152201,82314157946,'Tahsin','Uzun',6,05434955318);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (458758,36892594688,'Ugur Can','Uzund�neko�lu',2,05351326471);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (364892,63821422218,'Arsun','Uzun�rmak',2,05552449119);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (427722,79978714623,'�zgecan','��ler',6,05333323887);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (960103,21924943117,'S�dd�ka','��ta�',1,05351854377);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (254065,64283168544,'�mran Musavi','�lgey',2,05428599345);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (150076,91941419384,'Ebrar','�nay',5,05335465245);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (341122,95669818293,'A��lay','�nl �',4,05312829857);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (981628,43699186558,'M�zehher Zeynep','�nl�',6,05536429837);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (439879,65921636621,'Aybirgen','�rkmezt�rk',5,05346927422);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (618215,93458829126,'Akif','�skent',4,05457251532);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (470368,13579718825,'Volkan','�stba�',4,05452659991);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (991243,79632537565,'�zmen','�st�nel',6,05524161711);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (967879,55231968516,'G�lender','��enmez',4,05353427196);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (551237,28193456973,'Muzaffer','�zar',3,05349664933);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (724264,94445588225,'Mediha Burcu','Vanl�',4,05552537361);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (436036,55741484831,'Sulhadin','Varl�',4,05423392677);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (900797,21819524834,'Buket','Y I L D I Z',2,05516828951);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (738359,72892748779,'�erif','Yakupo�lu',1,05345997822);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (756484,48672285553,'Sena Simay','Yal��nkaya',3,05441991259);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (883836,84455852225,'M�m�ne Nihan','Yal��nta�',6,05331955937);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (511711,48947653924,'Edis','Yalma�',2,05422676699);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (508950,64751613734,'Alag�l','Yalman',2,05426479812);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (418439,94248266668,'Naz�m Bircan','Yalova',6,05442588699);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (429384,46235314774,'Ekin Ege','Yamano�lu',5,05315791979);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (184992,67824714922,'Ay�e Melisa','Yan�k',3,05458436639);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (605271,93523241941,'An�l G�rkem','Yapar',4,05539274338);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (106817,48932697844,'Cavit','Yaprak',1,05312357432);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (776721,72171794878,'G�l�ah','Yarbas',1,05437743511);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (538691,69429595169,'I��lt�','Yard�mc�',6,05315882839);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (348737,22312596689,'Ay�e Cansu','Ya�a',5,05522779974);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (741693,29737718615,'Muhammed Ali Duran','Ya��n',4,05338513556);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (864331,85193537768,'Nurullah','Ya�in',5,05434619288);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (250062,57126162378,'N�vit','Yava�er',3,05456228444);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (252003,11619426871,'Taner','Yay',2,05335761748);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (346389,64911681786,'Sezen','Yayla',3,05341359487);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (413535,57675819934,'Tuna Han Salih','Yaz�c�gil',1,05441325695);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (487544,94653781195,'Raif','Yaz�c�o�lu',6,05332929353);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (746886,25458311335,'Dilara Zeynep','Yeksan',5,05319491384);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (498569,39664811554,'Muhammed Enes','Yel',3,05551436248);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (990281,25756368733,'B��ra Hilal','Yelegen',5,05452158648);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (703758,69751981186,'Meryem S�meyye','Yeniceli',5,05343929571);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (754525,69716418864,'�ayan','Yeniev',5,05519453758);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (605959,65916718213,'Aykut','Yerlikaya',3,05517629995);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (245373,55781439263,'�lkyaz','Yerliyurt',3,05522478378);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (202632,38278764441,'G�l�en','Yerzhan',5,05429684556);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (506541,99676489415,'Nurettin Hazar','Ye�il�imen',6,05542621434);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (765731,27659195159,'Ali Furkan','Ye�ilova',5,05526211498);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (901651,14641266467,'Kol�ak','Y�k�lmazsoy',1,05437366925);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (260282,32455241762,'Selen Elif','Y�ld�r�mer',2,05333117546);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (808640,41999744826,'Azelya','Y�ld�zd�ken',4,05558734482);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (617832,37955382792,'�brahim Engin','Y�ld�zo�lu',3,05449864884);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (647685,31123678614,'Sadri','Yirmibe�cik',6,05422915615);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (453600,27888477932,'Enes Said','Yolcu',5,05536913483);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (456993,45535845844,'Eser','Yorgun',6,05415887927);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (935362,17737987762,'Selcen','Yorulmaz',5,05537811328);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (210320,13328277269,'Alaaddin','Y�ndem',2,05553732945);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (888621,26317163586,'Jiyan','Y�r�ten',2,05545861834);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (105614,77284569689,'Buse','Yudulmaz',1,05425759911);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (394833,23782997593,'Ali Berk','Yumurtac�',5,05516486382);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (579206,23216755891,'Yusuf Ozan','Yurteri',4,05536649661);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (826087,84557718464,'Yi�it','Yurtsever',5,05345511115);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (951186,41991288425,'Ahmet Berk','Y�cekayal�',6,05538338174);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (860889,88681754854,'Tanberk','Y�kselen',2,05455439275);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (211810,51852844553,'Zarife Beg�m','Y�r�k',5,05311883977);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (913661,51751532158,'Ay�e Aylin','Y�r�kgil',6,05418122783);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (845310,22369751977,'Emre Mira�','Y�zba��o�lu G�r',5,05325799315);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (197741,91113629918,'�pek Nazl�','Zabun',3,05448238196);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (945184,57156923389,'M�tesir','Za�l�',2,05539393786);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (739305,66431515179,'Nurfer','Zaptiye',6,05317152382);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (753616,82445661781,'B��ra G�lin','Zeybek',5,05333592799);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (446424,14282298514,'Bernanur','Zeybekci',1,05337281579);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (542688,45128771928,'Nur Dilay','Zilan',6,05443167714);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (478552,78171734974,'Ali Tunahan','Ziyade',2,05454284592);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (210775,56695676936,'Paker','Zorkiri��i',3,05319396372);
INSERT INTO Personel(SicilNo, Tc, Ad, Soyad, PersonelTipi, Telefon) VALUES (922207,21471474217,'Beyda','Z��',3,05341478499);
----
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (741693,1)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (186402,3)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (537183,3)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (982696,2)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (465287,6)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (319297,6)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (200391,7)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (917191,6)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (377518,4)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (562734,6)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (382680,2)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (886405,2)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (935029,6)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (347589,5)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (802780,2)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (798187,1)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (714469,4)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (501740,3)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (419044,6)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (947621,2)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (502652,3)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (576800,4)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (413655,6)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (270469,3)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (510934,3)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (252003,1)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (681019,6)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (804328,6)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (899894,5)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (114998,6)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (590199,1)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (443031,7)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (725936,5)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (405479,7)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (139066,3)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (879079,4)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (933794,3)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (647707,1)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (233082,7)
INSERT INTO SatisTemsilcisi (SicilNo, BolgeID) VALUES (719179,2)

---
INSERT INTO Danisman (SicilNo, SirketID) VALUES (984276,15)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (392826,18)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (828402,23)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (304669,23)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (530826,3)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (849021,17)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (795885,7)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (301870,10)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (474213,16)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (356688,7)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (987077,2)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (481696,20)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (860202,24)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (745593,19)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (959901,19)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (974723,5)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (121606,24)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (530677,11)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (835630,13)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (586338,19)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (574180,14)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (172556,9)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (754793,18)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (394363,18)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (309974,24)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (337764,10)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (745140,5)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (460932,15)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (841487,6)
INSERT INTO Danisman (SicilNo, SirketID) VALUES (299997,7)
---


INSERT INTO Adres (SicilNo, IlceID) VALUES (835713,1)
INSERT INTO Adres (SicilNo, IlceID) VALUES (471914,2)
INSERT INTO Adres (SicilNo, IlceID) VALUES (431471,3)
INSERT INTO Adres (SicilNo, IlceID) VALUES (849584,4)
INSERT INTO Adres (SicilNo, IlceID) VALUES (204847,5)
INSERT INTO Adres (SicilNo, IlceID) VALUES (488053,6)
INSERT INTO Adres (SicilNo, IlceID) VALUES (666643,7)
INSERT INTO Adres (SicilNo, IlceID) VALUES (252003,8)
INSERT INTO Adres (SicilNo, IlceID) VALUES (949900,9)
INSERT INTO Adres (SicilNo, IlceID) VALUES (939041,10)
INSERT INTO Adres (SicilNo, IlceID) VALUES (823080,11)
INSERT INTO Adres (SicilNo, IlceID) VALUES (967548,12)
INSERT INTO Adres (SicilNo, IlceID) VALUES (318129,13)
INSERT INTO Adres (SicilNo, IlceID) VALUES (376259,14)
INSERT INTO Adres (SicilNo, IlceID) VALUES (309974,15)
INSERT INTO Adres (SicilNo, IlceID) VALUES (519587,16)
INSERT INTO Adres (SicilNo, IlceID) VALUES (190626,17)
INSERT INTO Adres (SicilNo, IlceID) VALUES (370921,18)
INSERT INTO Adres (SicilNo, IlceID) VALUES (311622,19)
INSERT INTO Adres (SicilNo, IlceID) VALUES (291830,20)
INSERT INTO Adres (SicilNo, IlceID) VALUES (136043,21)
INSERT INTO Adres (SicilNo, IlceID) VALUES (369590,22)
INSERT INTO Adres (SicilNo, IlceID) VALUES (811611,23)
INSERT INTO Adres (SicilNo, IlceID) VALUES (686869,24)
INSERT INTO Adres (SicilNo, IlceID) VALUES (881073,25)
INSERT INTO Adres (SicilNo, IlceID) VALUES (384492,26)
INSERT INTO Adres (SicilNo, IlceID) VALUES (219304,27)
INSERT INTO Adres (SicilNo, IlceID) VALUES (210320,28)
INSERT INTO Adres (SicilNo, IlceID) VALUES (948335,29)
INSERT INTO Adres (SicilNo, IlceID) VALUES (745593,30)
INSERT INTO Adres (SicilNo, IlceID) VALUES (660752,31)
INSERT INTO Adres (SicilNo, IlceID) VALUES (518469,32)
INSERT INTO Adres (SicilNo, IlceID) VALUES (587791,33)
INSERT INTO Adres (SicilNo, IlceID) VALUES (105265,34)
INSERT INTO Adres (SicilNo, IlceID) VALUES (898266,35)
INSERT INTO Adres (SicilNo, IlceID) VALUES (470368,36)
INSERT INTO Adres (SicilNo, IlceID) VALUES (636509,37)
INSERT INTO Adres (SicilNo, IlceID) VALUES (894268,38)
INSERT INTO Adres (SicilNo, IlceID) VALUES (659476,39)
INSERT INTO Adres (SicilNo, IlceID) VALUES (784868,40)
INSERT INTO Adres (SicilNo, IlceID) VALUES (212772,41)
INSERT INTO Adres (SicilNo, IlceID) VALUES (440529,42)
INSERT INTO Adres (SicilNo, IlceID) VALUES (446424,43)
INSERT INTO Adres (SicilNo, IlceID) VALUES (903122,44)
INSERT INTO Adres (SicilNo, IlceID) VALUES (998152,45)
INSERT INTO Adres (SicilNo, IlceID) VALUES (547117,46)
INSERT INTO Adres (SicilNo, IlceID) VALUES (568558,47)
INSERT INTO Adres (SicilNo, IlceID) VALUES (923814,48)
INSERT INTO Adres (SicilNo, IlceID) VALUES (730912,49)
INSERT INTO Adres (SicilNo, IlceID) VALUES (136245,50)
INSERT INTO Adres (SicilNo, IlceID) VALUES (901651,51)
INSERT INTO Adres (SicilNo, IlceID) VALUES (388256,52)
INSERT INTO Adres (SicilNo, IlceID) VALUES (663179,53)
INSERT INTO Adres (SicilNo, IlceID) VALUES (801997,54)
INSERT INTO Adres (SicilNo, IlceID) VALUES (775468,55)
INSERT INTO Adres (SicilNo, IlceID) VALUES (305045,56)
INSERT INTO Adres (SicilNo, IlceID) VALUES (469627,57)
INSERT INTO Adres (SicilNo, IlceID) VALUES (708025,58)
INSERT INTO Adres (SicilNo, IlceID) VALUES (947621,59)
INSERT INTO Adres (SicilNo, IlceID) VALUES (682945,60)
INSERT INTO Adres (SicilNo, IlceID) VALUES (886661,61)
INSERT INTO Adres (SicilNo, IlceID) VALUES (793550,62)
INSERT INTO Adres (SicilNo, IlceID) VALUES (914768,63)
INSERT INTO Adres (SicilNo, IlceID) VALUES (615804,64)
INSERT INTO Adres (SicilNo, IlceID) VALUES (680994,65)
INSERT INTO Adres (SicilNo, IlceID) VALUES (148865,66)
INSERT INTO Adres (SicilNo, IlceID) VALUES (579884,67)
INSERT INTO Adres (SicilNo, IlceID) VALUES (390363,68)
INSERT INTO Adres (SicilNo, IlceID) VALUES (987203,69)
INSERT INTO Adres (SicilNo, IlceID) VALUES (734013,70)
INSERT INTO Adres (SicilNo, IlceID) VALUES (521850,71)
INSERT INTO Adres (SicilNo, IlceID) VALUES (852035,72)
INSERT INTO Adres (SicilNo, IlceID) VALUES (526365,73)
INSERT INTO Adres (SicilNo, IlceID) VALUES (641538,74)
INSERT INTO Adres (SicilNo, IlceID) VALUES (515134,75)
INSERT INTO Adres (SicilNo, IlceID) VALUES (764198,76)
INSERT INTO Adres (SicilNo, IlceID) VALUES (678452,77)
INSERT INTO Adres (SicilNo, IlceID) VALUES (964626,78)
INSERT INTO Adres (SicilNo, IlceID) VALUES (251050,79)
INSERT INTO Adres (SicilNo, IlceID) VALUES (233082,80)
INSERT INTO Adres (SicilNo, IlceID) VALUES (868867,81)
INSERT INTO Adres (SicilNo, IlceID) VALUES (722458,82)
INSERT INTO Adres (SicilNo, IlceID) VALUES (159300,83)
INSERT INTO Adres (SicilNo, IlceID) VALUES (195398,84)
INSERT INTO Adres (SicilNo, IlceID) VALUES (653994,85)
INSERT INTO Adres (SicilNo, IlceID) VALUES (110995,86)
INSERT INTO Adres (SicilNo, IlceID) VALUES (267159,87)
INSERT INTO Adres (SicilNo, IlceID) VALUES (598088,88)
INSERT INTO Adres (SicilNo, IlceID) VALUES (251394,89)
INSERT INTO Adres (SicilNo, IlceID) VALUES (881817,90)
INSERT INTO Adres (SicilNo, IlceID) VALUES (295942,91)
INSERT INTO Adres (SicilNo, IlceID) VALUES (358094,92)
INSERT INTO Adres (SicilNo, IlceID) VALUES (935362,93)
INSERT INTO Adres (SicilNo, IlceID) VALUES (103301,94)
INSERT INTO Adres (SicilNo, IlceID) VALUES (215921,95)
INSERT INTO Adres (SicilNo, IlceID) VALUES (740058,96)
INSERT INTO Adres (SicilNo, IlceID) VALUES (413655,97)
INSERT INTO Adres (SicilNo, IlceID) VALUES (410357,98)
INSERT INTO Adres (SicilNo, IlceID) VALUES (266565,99)
INSERT INTO Adres (SicilNo, IlceID) VALUES (490136,100)
INSERT INTO Adres (SicilNo, IlceID) VALUES (723529,101)
INSERT INTO Adres (SicilNo, IlceID) VALUES (933794,102)
INSERT INTO Adres (SicilNo, IlceID) VALUES (523847,103)
INSERT INTO Adres (SicilNo, IlceID) VALUES (982168,104)
INSERT INTO Adres (SicilNo, IlceID) VALUES (791698,105)
INSERT INTO Adres (SicilNo, IlceID) VALUES (616147,106)
INSERT INTO Adres (SicilNo, IlceID) VALUES (360445,107)
INSERT INTO Adres (SicilNo, IlceID) VALUES (608924,108)
INSERT INTO Adres (SicilNo, IlceID) VALUES (982696,109)
INSERT INTO Adres (SicilNo, IlceID) VALUES (812905,110)
INSERT INTO Adres (SicilNo, IlceID) VALUES (523540,111)
INSERT INTO Adres (SicilNo, IlceID) VALUES (231772,112)
INSERT INTO Adres (SicilNo, IlceID) VALUES (586559,113)
INSERT INTO Adres (SicilNo, IlceID) VALUES (332731,114)
INSERT INTO Adres (SicilNo, IlceID) VALUES (903997,115)
INSERT INTO Adres (SicilNo, IlceID) VALUES (531673,116)
INSERT INTO Adres (SicilNo, IlceID) VALUES (336222,117)
INSERT INTO Adres (SicilNo, IlceID) VALUES (963429,118)
INSERT INTO Adres (SicilNo, IlceID) VALUES (334909,119)
INSERT INTO Adres (SicilNo, IlceID) VALUES (308891,120)
INSERT INTO Adres (SicilNo, IlceID) VALUES (226345,121)
INSERT INTO Adres (SicilNo, IlceID) VALUES (745140,122)
INSERT INTO Adres (SicilNo, IlceID) VALUES (646887,123)
INSERT INTO Adres (SicilNo, IlceID) VALUES (293007,124)
INSERT INTO Adres (SicilNo, IlceID) VALUES (696088,125)
INSERT INTO Adres (SicilNo, IlceID) VALUES (922207,126)
INSERT INTO Adres (SicilNo, IlceID) VALUES (419044,127)
INSERT INTO Adres (SicilNo, IlceID) VALUES (900797,128)
INSERT INTO Adres (SicilNo, IlceID) VALUES (960103,129)
INSERT INTO Adres (SicilNo, IlceID) VALUES (873765,130)
INSERT INTO Adres (SicilNo, IlceID) VALUES (528570,131)
INSERT INTO Adres (SicilNo, IlceID) VALUES (348737,132)
INSERT INTO Adres (SicilNo, IlceID) VALUES (797019,133)
INSERT INTO Adres (SicilNo, IlceID) VALUES (845310,134)
INSERT INTO Adres (SicilNo, IlceID) VALUES (467598,135)
INSERT INTO Adres (SicilNo, IlceID) VALUES (737554,136)
INSERT INTO Adres (SicilNo, IlceID) VALUES (328446,137)
INSERT INTO Adres (SicilNo, IlceID) VALUES (820128,138)
INSERT INTO Adres (SicilNo, IlceID) VALUES (353279,139)
INSERT INTO Adres (SicilNo, IlceID) VALUES (855164,140)
INSERT INTO Adres (SicilNo, IlceID) VALUES (240164,141)
INSERT INTO Adres (SicilNo, IlceID) VALUES (743230,142)
INSERT INTO Adres (SicilNo, IlceID) VALUES (579206,143)
INSERT INTO Adres (SicilNo, IlceID) VALUES (615111,144)
INSERT INTO Adres (SicilNo, IlceID) VALUES (394833,145)
INSERT INTO Adres (SicilNo, IlceID) VALUES (316156,146)
INSERT INTO Adres (SicilNo, IlceID) VALUES (628045,147)
INSERT INTO Adres (SicilNo, IlceID) VALUES (167680,148)
INSERT INTO Adres (SicilNo, IlceID) VALUES (280852,149)
INSERT INTO Adres (SicilNo, IlceID) VALUES (420345,150)
INSERT INTO Adres (SicilNo, IlceID) VALUES (177166,151)
INSERT INTO Adres (SicilNo, IlceID) VALUES (556621,152)
INSERT INTO Adres (SicilNo, IlceID) VALUES (199105,153)
INSERT INTO Adres (SicilNo, IlceID) VALUES (426028,154)
INSERT INTO Adres (SicilNo, IlceID) VALUES (981863,155)
INSERT INTO Adres (SicilNo, IlceID) VALUES (309133,156)
INSERT INTO Adres (SicilNo, IlceID) VALUES (545305,157)
INSERT INTO Adres (SicilNo, IlceID) VALUES (440494,158)
INSERT INTO Adres (SicilNo, IlceID) VALUES (415310,159)
INSERT INTO Adres (SicilNo, IlceID) VALUES (455708,160)
INSERT INTO Adres (SicilNo, IlceID) VALUES (583852,161)
INSERT INTO Adres (SicilNo, IlceID) VALUES (746886,162)
INSERT INTO Adres (SicilNo, IlceID) VALUES (474129,163)
INSERT INTO Adres (SicilNo, IlceID) VALUES (376207,164)
INSERT INTO Adres (SicilNo, IlceID) VALUES (502652,165)
INSERT INTO Adres (SicilNo, IlceID) VALUES (626537,166)
INSERT INTO Adres (SicilNo, IlceID) VALUES (990281,167)
INSERT INTO Adres (SicilNo, IlceID) VALUES (528496,168)
INSERT INTO Adres (SicilNo, IlceID) VALUES (460932,169)
INSERT INTO Adres (SicilNo, IlceID) VALUES (172556,170)
INSERT INTO Adres (SicilNo, IlceID) VALUES (285867,171)
INSERT INTO Adres (SicilNo, IlceID) VALUES (852213,172)
INSERT INTO Adres (SicilNo, IlceID) VALUES (249129,173)
INSERT INTO Adres (SicilNo, IlceID) VALUES (276937,174)
INSERT INTO Adres (SicilNo, IlceID) VALUES (539991,175)
INSERT INTO Adres (SicilNo, IlceID) VALUES (725936,176)
INSERT INTO Adres (SicilNo, IlceID) VALUES (888621,177)
INSERT INTO Adres (SicilNo, IlceID) VALUES (265162,178)
INSERT INTO Adres (SicilNo, IlceID) VALUES (118023,179)
INSERT INTO Adres (SicilNo, IlceID) VALUES (477240,180)
INSERT INTO Adres (SicilNo, IlceID) VALUES (729374,181)
INSERT INTO Adres (SicilNo, IlceID) VALUES (417041,182)
INSERT INTO Adres (SicilNo, IlceID) VALUES (594684,183)
INSERT INTO Adres (SicilNo, IlceID) VALUES (702411,184)
INSERT INTO Adres (SicilNo, IlceID) VALUES (656260,185)
INSERT INTO Adres (SicilNo, IlceID) VALUES (728153,186)
INSERT INTO Adres (SicilNo, IlceID) VALUES (382680,187)
INSERT INTO Adres (SicilNo, IlceID) VALUES (765731,188)
INSERT INTO Adres (SicilNo, IlceID) VALUES (139066,189)
INSERT INTO Adres (SicilNo, IlceID) VALUES (954271,190)
INSERT INTO Adres (SicilNo, IlceID) VALUES (503985,191)
INSERT INTO Adres (SicilNo, IlceID) VALUES (997524,192)
INSERT INTO Adres (SicilNo, IlceID) VALUES (206645,193)
INSERT INTO Adres (SicilNo, IlceID) VALUES (453600,194)
INSERT INTO Adres (SicilNo, IlceID) VALUES (436818,195)
INSERT INTO Adres (SicilNo, IlceID) VALUES (272626,196)
INSERT INTO Adres (SicilNo, IlceID) VALUES (551237,197)
INSERT INTO Adres (SicilNo, IlceID) VALUES (824795,198)
INSERT INTO Adres (SicilNo, IlceID) VALUES (958552,199)
INSERT INTO Adres (SicilNo, IlceID) VALUES (680466,200)
INSERT INTO Adres (SicilNo, IlceID) VALUES (452430,201)
INSERT INTO Adres (SicilNo, IlceID) VALUES (173754,202)
INSERT INTO Adres (SicilNo, IlceID) VALUES (600943,203)
INSERT INTO Adres (SicilNo, IlceID) VALUES (590208,204)
INSERT INTO Adres (SicilNo, IlceID) VALUES (354223,205)
INSERT INTO Adres (SicilNo, IlceID) VALUES (484821,206)
INSERT INTO Adres (SicilNo, IlceID) VALUES (946492,207)
INSERT INTO Adres (SicilNo, IlceID) VALUES (714122,208)
INSERT INTO Adres (SicilNo, IlceID) VALUES (510122,209)
INSERT INTO Adres (SicilNo, IlceID) VALUES (863364,210)
INSERT INTO Adres (SicilNo, IlceID) VALUES (298801,211)
INSERT INTO Adres (SicilNo, IlceID) VALUES (677174,212)
INSERT INTO Adres (SicilNo, IlceID) VALUES (917191,213)
INSERT INTO Adres (SicilNo, IlceID) VALUES (326675,214)
INSERT INTO Adres (SicilNo, IlceID) VALUES (379525,215)
INSERT INTO Adres (SicilNo, IlceID) VALUES (259770,216)
INSERT INTO Adres (SicilNo, IlceID) VALUES (344515,217)
INSERT INTO Adres (SicilNo, IlceID) VALUES (531880,218)
INSERT INTO Adres (SicilNo, IlceID) VALUES (802780,219)
INSERT INTO Adres (SicilNo, IlceID) VALUES (909848,220)
INSERT INTO Adres (SicilNo, IlceID) VALUES (741693,221)
INSERT INTO Adres (SicilNo, IlceID) VALUES (571275,222)
INSERT INTO Adres (SicilNo, IlceID) VALUES (830041,223)
INSERT INTO Adres (SicilNo, IlceID) VALUES (647685,224)
INSERT INTO Adres (SicilNo, IlceID) VALUES (863696,225)
INSERT INTO Adres (SicilNo, IlceID) VALUES (539882,226)
INSERT INTO Adres (SicilNo, IlceID) VALUES (353738,227)
INSERT INTO Adres (SicilNo, IlceID) VALUES (329392,228)
INSERT INTO Adres (SicilNo, IlceID) VALUES (448322,229)
INSERT INTO Adres (SicilNo, IlceID) VALUES (265055,230)
INSERT INTO Adres (SicilNo, IlceID) VALUES (709199,231)
INSERT INTO Adres (SicilNo, IlceID) VALUES (210942,232)
INSERT INTO Adres (SicilNo, IlceID) VALUES (169628,233)
INSERT INTO Adres (SicilNo, IlceID) VALUES (130290,234)
INSERT INTO Adres (SicilNo, IlceID) VALUES (151745,235)
INSERT INTO Adres (SicilNo, IlceID) VALUES (309474,236)
INSERT INTO Adres (SicilNo, IlceID) VALUES (329728,237)
INSERT INTO Adres (SicilNo, IlceID) VALUES (165037,238)
INSERT INTO Adres (SicilNo, IlceID) VALUES (170878,239)
INSERT INTO Adres (SicilNo, IlceID) VALUES (117844,240)
INSERT INTO Adres (SicilNo, IlceID) VALUES (416917,241)
INSERT INTO Adres (SicilNo, IlceID) VALUES (462994,242)
INSERT INTO Adres (SicilNo, IlceID) VALUES (910288,243)
INSERT INTO Adres (SicilNo, IlceID) VALUES (647707,244)
INSERT INTO Adres (SicilNo, IlceID) VALUES (993482,245)
INSERT INTO Adres (SicilNo, IlceID) VALUES (665865,246)
INSERT INTO Adres (SicilNo, IlceID) VALUES (720258,247)
INSERT INTO Adres (SicilNo, IlceID) VALUES (260282,248)
INSERT INTO Adres (SicilNo, IlceID) VALUES (650779,249)
INSERT INTO Adres (SicilNo, IlceID) VALUES (358435,250)
INSERT INTO Adres (SicilNo, IlceID) VALUES (738296,251)
INSERT INTO Adres (SicilNo, IlceID) VALUES (929562,252)
INSERT INTO Adres (SicilNo, IlceID) VALUES (366356,253)
INSERT INTO Adres (SicilNo, IlceID) VALUES (581238,254)
INSERT INTO Adres (SicilNo, IlceID) VALUES (580026,255)
INSERT INTO Adres (SicilNo, IlceID) VALUES (356159,256)
INSERT INTO Adres (SicilNo, IlceID) VALUES (951998,257)
INSERT INTO Adres (SicilNo, IlceID) VALUES (398858,258)
INSERT INTO Adres (SicilNo, IlceID) VALUES (927266,259)
INSERT INTO Adres (SicilNo, IlceID) VALUES (443722,260)
INSERT INTO Adres (SicilNo, IlceID) VALUES (101798,261)
INSERT INTO Adres (SicilNo, IlceID) VALUES (229263,262)
INSERT INTO Adres (SicilNo, IlceID) VALUES (552895,263)
INSERT INTO Adres (SicilNo, IlceID) VALUES (218502,264)
INSERT INTO Adres (SicilNo, IlceID) VALUES (243213,265)
INSERT INTO Adres (SicilNo, IlceID) VALUES (724985,266)
INSERT INTO Adres (SicilNo, IlceID) VALUES (229150,267)
INSERT INTO Adres (SicilNo, IlceID) VALUES (338341,268)
INSERT INTO Adres (SicilNo, IlceID) VALUES (859144,269)
INSERT INTO Adres (SicilNo, IlceID) VALUES (845551,270)
INSERT INTO Adres (SicilNo, IlceID) VALUES (547938,271)
INSERT INTO Adres (SicilNo, IlceID) VALUES (994220,272)
INSERT INTO Adres (SicilNo, IlceID) VALUES (319687,273)
INSERT INTO Adres (SicilNo, IlceID) VALUES (965156,274)
INSERT INTO Adres (SicilNo, IlceID) VALUES (747788,275)
INSERT INTO Adres (SicilNo, IlceID) VALUES (437726,276)
INSERT INTO Adres (SicilNo, IlceID) VALUES (864364,277)
INSERT INTO Adres (SicilNo, IlceID) VALUES (677175,278)
INSERT INTO Adres (SicilNo, IlceID) VALUES (319297,279)
INSERT INTO Adres (SicilNo, IlceID) VALUES (878413,280)
INSERT INTO Adres (SicilNo, IlceID) VALUES (845173,281)
INSERT INTO Adres (SicilNo, IlceID) VALUES (628730,282)
INSERT INTO Adres (SicilNo, IlceID) VALUES (766275,283)
INSERT INTO Adres (SicilNo, IlceID) VALUES (423750,284)
INSERT INTO Adres (SicilNo, IlceID) VALUES (999019,285)
INSERT INTO Adres (SicilNo, IlceID) VALUES (311256,286)
INSERT INTO Adres (SicilNo, IlceID) VALUES (565304,287)
INSERT INTO Adres (SicilNo, IlceID) VALUES (926574,288)
INSERT INTO Adres (SicilNo, IlceID) VALUES (128271,289)
INSERT INTO Adres (SicilNo, IlceID) VALUES (727858,290)
INSERT INTO Adres (SicilNo, IlceID) VALUES (759937,291)
INSERT INTO Adres (SicilNo, IlceID) VALUES (786196,292)
INSERT INTO Adres (SicilNo, IlceID) VALUES (246244,293)
INSERT INTO Adres (SicilNo, IlceID) VALUES (792024,294)
INSERT INTO Adres (SicilNo, IlceID) VALUES (458758,295)
INSERT INTO Adres (SicilNo, IlceID) VALUES (156295,296)
INSERT INTO Adres (SicilNo, IlceID) VALUES (754793,297)
INSERT INTO Adres (SicilNo, IlceID) VALUES (569394,298)
INSERT INTO Adres (SicilNo, IlceID) VALUES (286884,299)
INSERT INTO Adres (SicilNo, IlceID) VALUES (329933,300)
INSERT INTO Adres (SicilNo, IlceID) VALUES (695173,301)
INSERT INTO Adres (SicilNo, IlceID) VALUES (810259,302)
INSERT INTO Adres (SicilNo, IlceID) VALUES (243967,303)
INSERT INTO Adres (SicilNo, IlceID) VALUES (994545,304)
INSERT INTO Adres (SicilNo, IlceID) VALUES (270469,305)
INSERT INTO Adres (SicilNo, IlceID) VALUES (124379,306)
INSERT INTO Adres (SicilNo, IlceID) VALUES (288988,307)
INSERT INTO Adres (SicilNo, IlceID) VALUES (617832,308)
INSERT INTO Adres (SicilNo, IlceID) VALUES (847209,309)
INSERT INTO Adres (SicilNo, IlceID) VALUES (202632,310)
INSERT INTO Adres (SicilNo, IlceID) VALUES (841487,311)
INSERT INTO Adres (SicilNo, IlceID) VALUES (535155,312)
INSERT INTO Adres (SicilNo, IlceID) VALUES (819107,313)
INSERT INTO Adres (SicilNo, IlceID) VALUES (518991,314)
INSERT INTO Adres (SicilNo, IlceID) VALUES (340600,315)
INSERT INTO Adres (SicilNo, IlceID) VALUES (632995,316)
INSERT INTO Adres (SicilNo, IlceID) VALUES (870891,317)
INSERT INTO Adres (SicilNo, IlceID) VALUES (955728,318)
INSERT INTO Adres (SicilNo, IlceID) VALUES (457080,319)
INSERT INTO Adres (SicilNo, IlceID) VALUES (145159,320)
INSERT INTO Adres (SicilNo, IlceID) VALUES (970367,321)
INSERT INTO Adres (SicilNo, IlceID) VALUES (337764,322)
INSERT INTO Adres (SicilNo, IlceID) VALUES (763136,323)
INSERT INTO Adres (SicilNo, IlceID) VALUES (325906,324)
INSERT INTO Adres (SicilNo, IlceID) VALUES (733049,325)
INSERT INTO Adres (SicilNo, IlceID) VALUES (859350,326)
INSERT INTO Adres (SicilNo, IlceID) VALUES (324392,327)
INSERT INTO Adres (SicilNo, IlceID) VALUES (560692,328)
INSERT INTO Adres (SicilNo, IlceID) VALUES (498569,329)
INSERT INTO Adres (SicilNo, IlceID) VALUES (197545,330)
INSERT INTO Adres (SicilNo, IlceID) VALUES (626176,331)
INSERT INTO Adres (SicilNo, IlceID) VALUES (666248,332)
INSERT INTO Adres (SicilNo, IlceID) VALUES (258602,333)
INSERT INTO Adres (SicilNo, IlceID) VALUES (349788,334)
INSERT INTO Adres (SicilNo, IlceID) VALUES (373073,335)
INSERT INTO Adres (SicilNo, IlceID) VALUES (916734,336)
INSERT INTO Adres (SicilNo, IlceID) VALUES (955295,337)
INSERT INTO Adres (SicilNo, IlceID) VALUES (878952,338)
INSERT INTO Adres (SicilNo, IlceID) VALUES (651210,339)
INSERT INTO Adres (SicilNo, IlceID) VALUES (383265,340)
INSERT INTO Adres (SicilNo, IlceID) VALUES (640435,341)
INSERT INTO Adres (SicilNo, IlceID) VALUES (489173,342)
INSERT INTO Adres (SicilNo, IlceID) VALUES (688121,343)
INSERT INTO Adres (SicilNo, IlceID) VALUES (351705,344)
INSERT INTO Adres (SicilNo, IlceID) VALUES (951186,345)
INSERT INTO Adres (SicilNo, IlceID) VALUES (808640,346)
INSERT INTO Adres (SicilNo, IlceID) VALUES (771634,347)
INSERT INTO Adres (SicilNo, IlceID) VALUES (831458,348)
INSERT INTO Adres (SicilNo, IlceID) VALUES (137088,349)
INSERT INTO Adres (SicilNo, IlceID) VALUES (227848,350)
INSERT INTO Adres (SicilNo, IlceID) VALUES (534700,351)
INSERT INTO Adres (SicilNo, IlceID) VALUES (840200,352)
INSERT INTO Adres (SicilNo, IlceID) VALUES (297406,353)
INSERT INTO Adres (SicilNo, IlceID) VALUES (806512,354)
INSERT INTO Adres (SicilNo, IlceID) VALUES (795885,355)
INSERT INTO Adres (SicilNo, IlceID) VALUES (496879,356)
INSERT INTO Adres (SicilNo, IlceID) VALUES (412435,357)
INSERT INTO Adres (SicilNo, IlceID) VALUES (692283,358)
INSERT INTO Adres (SicilNo, IlceID) VALUES (397647,359)
INSERT INTO Adres (SicilNo, IlceID) VALUES (738896,360)
INSERT INTO Adres (SicilNo, IlceID) VALUES (723020,361)
INSERT INTO Adres (SicilNo, IlceID) VALUES (124859,362)
INSERT INTO Adres (SicilNo, IlceID) VALUES (670401,363)
INSERT INTO Adres (SicilNo, IlceID) VALUES (203380,364)
INSERT INTO Adres (SicilNo, IlceID) VALUES (384313,365)
INSERT INTO Adres (SicilNo, IlceID) VALUES (372430,366)
INSERT INTO Adres (SicilNo, IlceID) VALUES (339203,367)
INSERT INTO Adres (SicilNo, IlceID) VALUES (981628,368)
INSERT INTO Adres (SicilNo, IlceID) VALUES (661444,369)
INSERT INTO Adres (SicilNo, IlceID) VALUES (553630,370)
INSERT INTO Adres (SicilNo, IlceID) VALUES (583780,371)
INSERT INTO Adres (SicilNo, IlceID) VALUES (513274,372)
INSERT INTO Adres (SicilNo, IlceID) VALUES (955382,373)
INSERT INTO Adres (SicilNo, IlceID) VALUES (436979,374)
INSERT INTO Adres (SicilNo, IlceID) VALUES (820002,375)
INSERT INTO Adres (SicilNo, IlceID) VALUES (956885,376)
INSERT INTO Adres (SicilNo, IlceID) VALUES (716500,377)
INSERT INTO Adres (SicilNo, IlceID) VALUES (510934,378)
INSERT INTO Adres (SicilNo, IlceID) VALUES (239661,379)
INSERT INTO Adres (SicilNo, IlceID) VALUES (531875,380)
INSERT INTO Adres (SicilNo, IlceID) VALUES (632930,381)
INSERT INTO Adres (SicilNo, IlceID) VALUES (542688,382)
INSERT INTO Adres (SicilNo, IlceID) VALUES (839352,383)
INSERT INTO Adres (SicilNo, IlceID) VALUES (681019,384)
INSERT INTO Adres (SicilNo, IlceID) VALUES (180716,385)
INSERT INTO Adres (SicilNo, IlceID) VALUES (808255,386)
INSERT INTO Adres (SicilNo, IlceID) VALUES (456993,387)
INSERT INTO Adres (SicilNo, IlceID) VALUES (833264,388)
INSERT INTO Adres (SicilNo, IlceID) VALUES (862869,389)
INSERT INTO Adres (SicilNo, IlceID) VALUES (629708,390)
INSERT INTO Adres (SicilNo, IlceID) VALUES (457923,391)
INSERT INTO Adres (SicilNo, IlceID) VALUES (557290,392)
INSERT INTO Adres (SicilNo, IlceID) VALUES (429384,393)
INSERT INTO Adres (SicilNo, IlceID) VALUES (569121,394)
INSERT INTO Adres (SicilNo, IlceID) VALUES (216845,395)
INSERT INTO Adres (SicilNo, IlceID) VALUES (750052,396)
INSERT INTO Adres (SicilNo, IlceID) VALUES (422218,397)
INSERT INTO Adres (SicilNo, IlceID) VALUES (417854,398)
INSERT INTO Adres (SicilNo, IlceID) VALUES (474174,399)
INSERT INTO Adres (SicilNo, IlceID) VALUES (547973,400)
INSERT INTO Adres (SicilNo, IlceID) VALUES (401513,401)
INSERT INTO Adres (SicilNo, IlceID) VALUES (201678,402)
INSERT INTO Adres (SicilNo, IlceID) VALUES (873679,403)
INSERT INTO Adres (SicilNo, IlceID) VALUES (157625,404)
INSERT INTO Adres (SicilNo, IlceID) VALUES (845392,405)
INSERT INTO Adres (SicilNo, IlceID) VALUES (218701,406)
INSERT INTO Adres (SicilNo, IlceID) VALUES (336309,407)
INSERT INTO Adres (SicilNo, IlceID) VALUES (522413,408)
INSERT INTO Adres (SicilNo, IlceID) VALUES (818211,409)
INSERT INTO Adres (SicilNo, IlceID) VALUES (423425,410)
INSERT INTO Adres (SicilNo, IlceID) VALUES (513507,411)
INSERT INTO Adres (SicilNo, IlceID) VALUES (461617,412)
INSERT INTO Adres (SicilNo, IlceID) VALUES (647228,413)
INSERT INTO Adres (SicilNo, IlceID) VALUES (110709,414)
INSERT INTO Adres (SicilNo, IlceID) VALUES (713208,415)
INSERT INTO Adres (SicilNo, IlceID) VALUES (372525,416)
INSERT INTO Adres (SicilNo, IlceID) VALUES (211592,417)
INSERT INTO Adres (SicilNo, IlceID) VALUES (452681,418)
INSERT INTO Adres (SicilNo, IlceID) VALUES (756484,419)
INSERT INTO Adres (SicilNo, IlceID) VALUES (619840,420)
INSERT INTO Adres (SicilNo, IlceID) VALUES (886405,421)
INSERT INTO Adres (SicilNo, IlceID) VALUES (874510,422)
INSERT INTO Adres (SicilNo, IlceID) VALUES (119231,423)
INSERT INTO Adres (SicilNo, IlceID) VALUES (773444,424)
INSERT INTO Adres (SicilNo, IlceID) VALUES (106817,425)
INSERT INTO Adres (SicilNo, IlceID) VALUES (511711,426)
INSERT INTO Adres (SicilNo, IlceID) VALUES (258829,427)
INSERT INTO Adres (SicilNo, IlceID) VALUES (662016,428)
INSERT INTO Adres (SicilNo, IlceID) VALUES (410324,429)
INSERT INTO Adres (SicilNo, IlceID) VALUES (246519,430)
INSERT INTO Adres (SicilNo, IlceID) VALUES (575667,431)
INSERT INTO Adres (SicilNo, IlceID) VALUES (576017,432)
INSERT INTO Adres (SicilNo, IlceID) VALUES (427768,433)
INSERT INTO Adres (SicilNo, IlceID) VALUES (521544,434)
INSERT INTO Adres (SicilNo, IlceID) VALUES (963254,435)
INSERT INTO Adres (SicilNo, IlceID) VALUES (544399,436)
INSERT INTO Adres (SicilNo, IlceID) VALUES (335962,437)
INSERT INTO Adres (SicilNo, IlceID) VALUES (914428,438)
INSERT INTO Adres (SicilNo, IlceID) VALUES (413146,439)
INSERT INTO Adres (SicilNo, IlceID) VALUES (602075,440)
INSERT INTO Adres (SicilNo, IlceID) VALUES (794933,441)
INSERT INTO Adres (SicilNo, IlceID) VALUES (247243,442)
INSERT INTO Adres (SicilNo, IlceID) VALUES (380697,443)
INSERT INTO Adres (SicilNo, IlceID) VALUES (764954,444)
INSERT INTO Adres (SicilNo, IlceID) VALUES (200696,445)
INSERT INTO Adres (SicilNo, IlceID) VALUES (562455,446)
INSERT INTO Adres (SicilNo, IlceID) VALUES (725548,447)
INSERT INTO Adres (SicilNo, IlceID) VALUES (394363,448)
INSERT INTO Adres (SicilNo, IlceID) VALUES (688719,449)
INSERT INTO Adres (SicilNo, IlceID) VALUES (630382,450)
INSERT INTO Adres (SicilNo, IlceID) VALUES (913661,451)
INSERT INTO Adres (SicilNo, IlceID) VALUES (211810,452)
INSERT INTO Adres (SicilNo, IlceID) VALUES (987847,453)
INSERT INTO Adres (SicilNo, IlceID) VALUES (766204,454)
INSERT INTO Adres (SicilNo, IlceID) VALUES (238121,455)
INSERT INTO Adres (SicilNo, IlceID) VALUES (236798,456)
INSERT INTO Adres (SicilNo, IlceID) VALUES (733352,457)
INSERT INTO Adres (SicilNo, IlceID) VALUES (731065,458)
INSERT INTO Adres (SicilNo, IlceID) VALUES (391735,459)
INSERT INTO Adres (SicilNo, IlceID) VALUES (642695,460)
INSERT INTO Adres (SicilNo, IlceID) VALUES (372588,461)
INSERT INTO Adres (SicilNo, IlceID) VALUES (895372,462)
INSERT INTO Adres (SicilNo, IlceID) VALUES (569175,463)
INSERT INTO Adres (SicilNo, IlceID) VALUES (977566,464)
INSERT INTO Adres (SicilNo, IlceID) VALUES (835630,465)
INSERT INTO Adres (SicilNo, IlceID) VALUES (669362,466)
INSERT INTO Adres (SicilNo, IlceID) VALUES (927145,467)
INSERT INTO Adres (SicilNo, IlceID) VALUES (789164,468)
INSERT INTO Adres (SicilNo, IlceID) VALUES (678349,469)
INSERT INTO Adres (SicilNo, IlceID) VALUES (191973,470)
INSERT INTO Adres (SicilNo, IlceID) VALUES (522381,471)
INSERT INTO Adres (SicilNo, IlceID) VALUES (616717,472)
INSERT INTO Adres (SicilNo, IlceID) VALUES (742064,473)
INSERT INTO Adres (SicilNo, IlceID) VALUES (688754,474)
INSERT INTO Adres (SicilNo, IlceID) VALUES (838031,475)
INSERT INTO Adres (SicilNo, IlceID) VALUES (614788,476)
INSERT INTO Adres (SicilNo, IlceID) VALUES (563637,477)
INSERT INTO Adres (SicilNo, IlceID) VALUES (607103,478)
INSERT INTO Adres (SicilNo, IlceID) VALUES (559252,479)
INSERT INTO Adres (SicilNo, IlceID) VALUES (256949,480)
INSERT INTO Adres (SicilNo, IlceID) VALUES (656211,481)
INSERT INTO Adres (SicilNo, IlceID) VALUES (350233,482)
INSERT INTO Adres (SicilNo, IlceID) VALUES (962548,483)
INSERT INTO Adres (SicilNo, IlceID) VALUES (817521,484)
INSERT INTO Adres (SicilNo, IlceID) VALUES (473547,485)
INSERT INTO Adres (SicilNo, IlceID) VALUES (241938,486)
INSERT INTO Adres (SicilNo, IlceID) VALUES (974723,487)
INSERT INTO Adres (SicilNo, IlceID) VALUES (537183,488)
INSERT INTO Adres (SicilNo, IlceID) VALUES (570066,489)
INSERT INTO Adres (SicilNo, IlceID) VALUES (180799,490)
INSERT INTO Adres (SicilNo, IlceID) VALUES (967879,491)
INSERT INTO Adres (SicilNo, IlceID) VALUES (751914,492)
INSERT INTO Adres (SicilNo, IlceID) VALUES (330885,493)
INSERT INTO Adres (SicilNo, IlceID) VALUES (833974,494)
INSERT INTO Adres (SicilNo, IlceID) VALUES (679192,495)
INSERT INTO Adres (SicilNo, IlceID) VALUES (345368,496)
INSERT INTO Adres (SicilNo, IlceID) VALUES (347589,497)
INSERT INTO Adres (SicilNo, IlceID) VALUES (121606,498)
INSERT INTO Adres (SicilNo, IlceID) VALUES (661339,499)
INSERT INTO Adres (SicilNo, IlceID) VALUES (200391,500)
INSERT INTO Adres (SicilNo, IlceID) VALUES (928971,501)
INSERT INTO Adres (SicilNo, IlceID) VALUES (436036,502)
INSERT INTO Adres (SicilNo, IlceID) VALUES (693612,503)
INSERT INTO Adres (SicilNo, IlceID) VALUES (824807,504)
INSERT INTO Adres (SicilNo, IlceID) VALUES (245373,505)
INSERT INTO Adres (SicilNo, IlceID) VALUES (181156,506)
INSERT INTO Adres (SicilNo, IlceID) VALUES (903193,507)
INSERT INTO Adres (SicilNo, IlceID) VALUES (864975,508)
INSERT INTO Adres (SicilNo, IlceID) VALUES (864871,509)
INSERT INTO Adres (SicilNo, IlceID) VALUES (368571,510)
INSERT INTO Adres (SicilNo, IlceID) VALUES (340736,511)
INSERT INTO Adres (SicilNo, IlceID) VALUES (451295,512)
INSERT INTO Adres (SicilNo, IlceID) VALUES (724716,513)
INSERT INTO Adres (SicilNo, IlceID) VALUES (945807,514)
INSERT INTO Adres (SicilNo, IlceID) VALUES (923430,515)
INSERT INTO Adres (SicilNo, IlceID) VALUES (903063,516)
INSERT INTO Adres (SicilNo, IlceID) VALUES (122953,517)
INSERT INTO Adres (SicilNo, IlceID) VALUES (349247,518)
INSERT INTO Adres (SicilNo, IlceID) VALUES (847061,519)
INSERT INTO Adres (SicilNo, IlceID) VALUES (481696,520)
INSERT INTO Adres (SicilNo, IlceID) VALUES (582544,521)
INSERT INTO Adres (SicilNo, IlceID) VALUES (907958,522)
INSERT INTO Adres (SicilNo, IlceID) VALUES (376802,523)
INSERT INTO Adres (SicilNo, IlceID) VALUES (210775,524)
INSERT INTO Adres (SicilNo, IlceID) VALUES (795473,525)
INSERT INTO Adres (SicilNo, IlceID) VALUES (184445,526)
INSERT INTO Adres (SicilNo, IlceID) VALUES (250062,527)
INSERT INTO Adres (SicilNo, IlceID) VALUES (688257,528)
INSERT INTO Adres (SicilNo, IlceID) VALUES (945184,529)
INSERT INTO Adres (SicilNo, IlceID) VALUES (683453,530)
INSERT INTO Adres (SicilNo, IlceID) VALUES (163679,531)
INSERT INTO Adres (SicilNo, IlceID) VALUES (922508,532)
INSERT INTO Adres (SicilNo, IlceID) VALUES (727803,533)
INSERT INTO Adres (SicilNo, IlceID) VALUES (958673,534)
INSERT INTO Adres (SicilNo, IlceID) VALUES (637511,535)
INSERT INTO Adres (SicilNo, IlceID) VALUES (413535,536)
INSERT INTO Adres (SicilNo, IlceID) VALUES (861321,537)
INSERT INTO Adres (SicilNo, IlceID) VALUES (384149,538)
INSERT INTO Adres (SicilNo, IlceID) VALUES (367260,539)
INSERT INTO Adres (SicilNo, IlceID) VALUES (300500,540)
INSERT INTO Adres (SicilNo, IlceID) VALUES (639474,541)
INSERT INTO Adres (SicilNo, IlceID) VALUES (845377,542)
INSERT INTO Adres (SicilNo, IlceID) VALUES (175089,543)
INSERT INTO Adres (SicilNo, IlceID) VALUES (574856,544)
INSERT INTO Adres (SicilNo, IlceID) VALUES (555490,545)
INSERT INTO Adres (SicilNo, IlceID) VALUES (299997,546)
INSERT INTO Adres (SicilNo, IlceID) VALUES (356688,547)
INSERT INTO Adres (SicilNo, IlceID) VALUES (176483,548)
INSERT INTO Adres (SicilNo, IlceID) VALUES (911911,549)
INSERT INTO Adres (SicilNo, IlceID) VALUES (830076,550)
INSERT INTO Adres (SicilNo, IlceID) VALUES (462609,551)
INSERT INTO Adres (SicilNo, IlceID) VALUES (542329,552)
INSERT INTO Adres (SicilNo, IlceID) VALUES (843528,553)
INSERT INTO Adres (SicilNo, IlceID) VALUES (726014,554)
INSERT INTO Adres (SicilNo, IlceID) VALUES (473610,555)
INSERT INTO Adres (SicilNo, IlceID) VALUES (596147,556)
INSERT INTO Adres (SicilNo, IlceID) VALUES (485180,557)
INSERT INTO Adres (SicilNo, IlceID) VALUES (420426,558)
INSERT INTO Adres (SicilNo, IlceID) VALUES (402118,559)
INSERT INTO Adres (SicilNo, IlceID) VALUES (650893,560)
INSERT INTO Adres (SicilNo, IlceID) VALUES (474924,561)
INSERT INTO Adres (SicilNo, IlceID) VALUES (220849,562)
INSERT INTO Adres (SicilNo, IlceID) VALUES (434169,563)
INSERT INTO Adres (SicilNo, IlceID) VALUES (973575,564)
INSERT INTO Adres (SicilNo, IlceID) VALUES (611057,565)
INSERT INTO Adres (SicilNo, IlceID) VALUES (211770,566)
INSERT INTO Adres (SicilNo, IlceID) VALUES (546788,567)
INSERT INTO Adres (SicilNo, IlceID) VALUES (540070,568)
INSERT INTO Adres (SicilNo, IlceID) VALUES (154826,569)
INSERT INTO Adres (SicilNo, IlceID) VALUES (775956,570)
INSERT INTO Adres (SicilNo, IlceID) VALUES (462457,571)
INSERT INTO Adres (SicilNo, IlceID) VALUES (564292,572)
INSERT INTO Adres (SicilNo, IlceID) VALUES (534931,573)
INSERT INTO Adres (SicilNo, IlceID) VALUES (695642,574)
INSERT INTO Adres (SicilNo, IlceID) VALUES (659286,575)
INSERT INTO Adres (SicilNo, IlceID) VALUES (206178,576)
INSERT INTO Adres (SicilNo, IlceID) VALUES (366360,577)
INSERT INTO Adres (SicilNo, IlceID) VALUES (689562,578)
INSERT INTO Adres (SicilNo, IlceID) VALUES (910730,579)
INSERT INTO Adres (SicilNo, IlceID) VALUES (116872,580)
INSERT INTO Adres (SicilNo, IlceID) VALUES (474213,581)
INSERT INTO Adres (SicilNo, IlceID) VALUES (700078,582)
INSERT INTO Adres (SicilNo, IlceID) VALUES (867852,583)
INSERT INTO Adres (SicilNo, IlceID) VALUES (100121,584)
INSERT INTO Adres (SicilNo, IlceID) VALUES (111226,585)
INSERT INTO Adres (SicilNo, IlceID) VALUES (116943,586)
INSERT INTO Adres (SicilNo, IlceID) VALUES (804316,587)
INSERT INTO Adres (SicilNo, IlceID) VALUES (731938,588)
INSERT INTO Adres (SicilNo, IlceID) VALUES (935029,589)
INSERT INTO Adres (SicilNo, IlceID) VALUES (364892,590)
INSERT INTO Adres (SicilNo, IlceID) VALUES (797559,591)
INSERT INTO Adres (SicilNo, IlceID) VALUES (726647,592)
INSERT INTO Adres (SicilNo, IlceID) VALUES (442011,593)
INSERT INTO Adres (SicilNo, IlceID) VALUES (224471,594)
INSERT INTO Adres (SicilNo, IlceID) VALUES (843105,595)
INSERT INTO Adres (SicilNo, IlceID) VALUES (756290,596)
INSERT INTO Adres (SicilNo, IlceID) VALUES (377518,597)
INSERT INTO Adres (SicilNo, IlceID) VALUES (254065,598)
INSERT INTO Adres (SicilNo, IlceID) VALUES (691557,599)
INSERT INTO Adres (SicilNo, IlceID) VALUES (229009,600)
INSERT INTO Adres (SicilNo, IlceID) VALUES (207301,601)
INSERT INTO Adres (SicilNo, IlceID) VALUES (461207,602)
INSERT INTO Adres (SicilNo, IlceID) VALUES (798187,603)
INSERT INTO Adres (SicilNo, IlceID) VALUES (135756,604)
INSERT INTO Adres (SicilNo, IlceID) VALUES (952976,605)
INSERT INTO Adres (SicilNo, IlceID) VALUES (706968,606)
INSERT INTO Adres (SicilNo, IlceID) VALUES (957489,607)
INSERT INTO Adres (SicilNo, IlceID) VALUES (669592,608)
INSERT INTO Adres (SicilNo, IlceID) VALUES (508950,609)
INSERT INTO Adres (SicilNo, IlceID) VALUES (451968,610)
INSERT INTO Adres (SicilNo, IlceID) VALUES (929866,611)
INSERT INTO Adres (SicilNo, IlceID) VALUES (346389,612)
INSERT INTO Adres (SicilNo, IlceID) VALUES (630374,613)
INSERT INTO Adres (SicilNo, IlceID) VALUES (804742,614)
INSERT INTO Adres (SicilNo, IlceID) VALUES (415841,615)
INSERT INTO Adres (SicilNo, IlceID) VALUES (217122,616)
INSERT INTO Adres (SicilNo, IlceID) VALUES (542971,617)
INSERT INTO Adres (SicilNo, IlceID) VALUES (832832,618)
INSERT INTO Adres (SicilNo, IlceID) VALUES (822722,619)
INSERT INTO Adres (SicilNo, IlceID) VALUES (151738,620)
INSERT INTO Adres (SicilNo, IlceID) VALUES (848481,621)
INSERT INTO Adres (SicilNo, IlceID) VALUES (784255,622)
INSERT INTO Adres (SicilNo, IlceID) VALUES (741349,623)
INSERT INTO Adres (SicilNo, IlceID) VALUES (369973,624)
INSERT INTO Adres (SicilNo, IlceID) VALUES (951454,625)
INSERT INTO Adres (SicilNo, IlceID) VALUES (590199,626)
INSERT INTO Adres (SicilNo, IlceID) VALUES (597633,627)
INSERT INTO Adres (SicilNo, IlceID) VALUES (164288,628)
INSERT INTO Adres (SicilNo, IlceID) VALUES (928350,629)
INSERT INTO Adres (SicilNo, IlceID) VALUES (937058,630)
INSERT INTO Adres (SicilNo, IlceID) VALUES (605959,631)
INSERT INTO Adres (SicilNo, IlceID) VALUES (439879,632)
INSERT INTO Adres (SicilNo, IlceID) VALUES (284266,633)
INSERT INTO Adres (SicilNo, IlceID) VALUES (933462,634)
INSERT INTO Adres (SicilNo, IlceID) VALUES (403782,635)
INSERT INTO Adres (SicilNo, IlceID) VALUES (628585,636)
INSERT INTO Adres (SicilNo, IlceID) VALUES (540779,637)
INSERT INTO Adres (SicilNo, IlceID) VALUES (217935,638)
INSERT INTO Adres (SicilNo, IlceID) VALUES (739305,639)
INSERT INTO Adres (SicilNo, IlceID) VALUES (284481,640)
INSERT INTO Adres (SicilNo, IlceID) VALUES (763316,641)
INSERT INTO Adres (SicilNo, IlceID) VALUES (284399,642)
INSERT INTO Adres (SicilNo, IlceID) VALUES (392826,643)
INSERT INTO Adres (SicilNo, IlceID) VALUES (417022,644)
INSERT INTO Adres (SicilNo, IlceID) VALUES (607854,645)
INSERT INTO Adres (SicilNo, IlceID) VALUES (385564,646)
INSERT INTO Adres (SicilNo, IlceID) VALUES (193057,647)
INSERT INTO Adres (SicilNo, IlceID) VALUES (515509,648)
INSERT INTO Adres (SicilNo, IlceID) VALUES (357765,649)
INSERT INTO Adres (SicilNo, IlceID) VALUES (789173,650)
INSERT INTO Adres (SicilNo, IlceID) VALUES (184992,651)
INSERT INTO Adres (SicilNo, IlceID) VALUES (118078,652)
INSERT INTO Adres (SicilNo, IlceID) VALUES (133197,653)
INSERT INTO Adres (SicilNo, IlceID) VALUES (221411,654)
INSERT INTO Adres (SicilNo, IlceID) VALUES (305495,655)
INSERT INTO Adres (SicilNo, IlceID) VALUES (446380,656)
INSERT INTO Adres (SicilNo, IlceID) VALUES (754495,657)
INSERT INTO Adres (SicilNo, IlceID) VALUES (521465,658)
INSERT INTO Adres (SicilNo, IlceID) VALUES (554510,659)
INSERT INTO Adres (SicilNo, IlceID) VALUES (373987,660)
INSERT INTO Adres (SicilNo, IlceID) VALUES (115919,661)
INSERT INTO Adres (SicilNo, IlceID) VALUES (583873,662)
INSERT INTO Adres (SicilNo, IlceID) VALUES (537307,663)
INSERT INTO Adres (SicilNo, IlceID) VALUES (878308,664)
INSERT INTO Adres (SicilNo, IlceID) VALUES (175895,665)
INSERT INTO Adres (SicilNo, IlceID) VALUES (847156,666)
INSERT INTO Adres (SicilNo, IlceID) VALUES (321729,667)
INSERT INTO Adres (SicilNo, IlceID) VALUES (258774,668)
INSERT INTO Adres (SicilNo, IlceID) VALUES (379440,669)
INSERT INTO Adres (SicilNo, IlceID) VALUES (538691,670)
INSERT INTO Adres (SicilNo, IlceID) VALUES (981126,671)
INSERT INTO Adres (SicilNo, IlceID) VALUES (130529,672)
INSERT INTO Adres (SicilNo, IlceID) VALUES (754525,673)
INSERT INTO Adres (SicilNo, IlceID) VALUES (703758,674)
INSERT INTO Adres (SicilNo, IlceID) VALUES (581249,675)
INSERT INTO Adres (SicilNo, IlceID) VALUES (384498,676)
INSERT INTO Adres (SicilNo, IlceID) VALUES (618722,677)
INSERT INTO Adres (SicilNo, IlceID) VALUES (972055,678)
INSERT INTO Adres (SicilNo, IlceID) VALUES (777332,679)
INSERT INTO Adres (SicilNo, IlceID) VALUES (958251,680)
INSERT INTO Adres (SicilNo, IlceID) VALUES (920161,681)
INSERT INTO Adres (SicilNo, IlceID) VALUES (576800,682)
INSERT INTO Adres (SicilNo, IlceID) VALUES (328423,683)
INSERT INTO Adres (SicilNo, IlceID) VALUES (511034,684)
INSERT INTO Adres (SicilNo, IlceID) VALUES (116124,685)
INSERT INTO Adres (SicilNo, IlceID) VALUES (946102,686)
INSERT INTO Adres (SicilNo, IlceID) VALUES (599767,687)
INSERT INTO Adres (SicilNo, IlceID) VALUES (328080,688)
INSERT INTO Adres (SicilNo, IlceID) VALUES (828402,689)
INSERT INTO Adres (SicilNo, IlceID) VALUES (591308,690)
INSERT INTO Adres (SicilNo, IlceID) VALUES (776721,691)
INSERT INTO Adres (SicilNo, IlceID) VALUES (301870,692)
INSERT INTO Adres (SicilNo, IlceID) VALUES (903487,693)
INSERT INTO Adres (SicilNo, IlceID) VALUES (729177,694)
INSERT INTO Adres (SicilNo, IlceID) VALUES (888841,695)
INSERT INTO Adres (SicilNo, IlceID) VALUES (693558,696)
INSERT INTO Adres (SicilNo, IlceID) VALUES (879079,697)
INSERT INTO Adres (SicilNo, IlceID) VALUES (124768,698)
INSERT INTO Adres (SicilNo, IlceID) VALUES (738359,699)
INSERT INTO Adres (SicilNo, IlceID) VALUES (522109,700)
INSERT INTO Adres (SicilNo, IlceID) VALUES (986174,701)
INSERT INTO Adres (SicilNo, IlceID) VALUES (820731,702)
INSERT INTO Adres (SicilNo, IlceID) VALUES (887442,703)
INSERT INTO Adres (SicilNo, IlceID) VALUES (923460,704)
INSERT INTO Adres (SicilNo, IlceID) VALUES (426153,705)
INSERT INTO Adres (SicilNo, IlceID) VALUES (871987,706)
INSERT INTO Adres (SicilNo, IlceID) VALUES (890316,707)
INSERT INTO Adres (SicilNo, IlceID) VALUES (983049,708)
INSERT INTO Adres (SicilNo, IlceID) VALUES (292054,709)
INSERT INTO Adres (SicilNo, IlceID) VALUES (780445,710)
INSERT INTO Adres (SicilNo, IlceID) VALUES (860202,711)
INSERT INTO Adres (SicilNo, IlceID) VALUES (224183,712)
INSERT INTO Adres (SicilNo, IlceID) VALUES (603432,713)
INSERT INTO Adres (SicilNo, IlceID) VALUES (304669,714)
INSERT INTO Adres (SicilNo, IlceID) VALUES (337633,715)
INSERT INTO Adres (SicilNo, IlceID) VALUES (507171,716)
INSERT INTO Adres (SicilNo, IlceID) VALUES (434516,717)
INSERT INTO Adres (SicilNo, IlceID) VALUES (230409,718)
INSERT INTO Adres (SicilNo, IlceID) VALUES (849021,719)
INSERT INTO Adres (SicilNo, IlceID) VALUES (350930,720)
INSERT INTO Adres (SicilNo, IlceID) VALUES (465847,721)
INSERT INTO Adres (SicilNo, IlceID) VALUES (653726,722)
INSERT INTO Adres (SicilNo, IlceID) VALUES (541729,723)
INSERT INTO Adres (SicilNo, IlceID) VALUES (444942,724)
INSERT INTO Adres (SicilNo, IlceID) VALUES (476838,725)
INSERT INTO Adres (SicilNo, IlceID) VALUES (683266,726)
INSERT INTO Adres (SicilNo, IlceID) VALUES (617226,727)
INSERT INTO Adres (SicilNo, IlceID) VALUES (416154,728)
INSERT INTO Adres (SicilNo, IlceID) VALUES (939979,729)
INSERT INTO Adres (SicilNo, IlceID) VALUES (658893,730)
INSERT INTO Adres (SicilNo, IlceID) VALUES (962653,731)
INSERT INTO Adres (SicilNo, IlceID) VALUES (348642,732)
INSERT INTO Adres (SicilNo, IlceID) VALUES (501740,733)
INSERT INTO Adres (SicilNo, IlceID) VALUES (987077,734)
INSERT INTO Adres (SicilNo, IlceID) VALUES (442739,735)
INSERT INTO Adres (SicilNo, IlceID) VALUES (443538,736)
INSERT INTO Adres (SicilNo, IlceID) VALUES (819505,737)
INSERT INTO Adres (SicilNo, IlceID) VALUES (787122,738)
INSERT INTO Adres (SicilNo, IlceID) VALUES (698064,739)
INSERT INTO Adres (SicilNo, IlceID) VALUES (247529,740)
INSERT INTO Adres (SicilNo, IlceID) VALUES (725743,741)
INSERT INTO Adres (SicilNo, IlceID) VALUES (477245,742)
INSERT INTO Adres (SicilNo, IlceID) VALUES (880151,743)
INSERT INTO Adres (SicilNo, IlceID) VALUES (195201,744)
INSERT INTO Adres (SicilNo, IlceID) VALUES (576126,745)
INSERT INTO Adres (SicilNo, IlceID) VALUES (220572,746)
INSERT INTO Adres (SicilNo, IlceID) VALUES (105614,747)
INSERT INTO Adres (SicilNo, IlceID) VALUES (574180,748)
INSERT INTO Adres (SicilNo, IlceID) VALUES (600393,749)
INSERT INTO Adres (SicilNo, IlceID) VALUES (992185,750)
INSERT INTO Adres (SicilNo, IlceID) VALUES (143365,751)
INSERT INTO Adres (SicilNo, IlceID) VALUES (422430,752)
INSERT INTO Adres (SicilNo, IlceID) VALUES (902404,753)
INSERT INTO Adres (SicilNo, IlceID) VALUES (302562,754)
INSERT INTO Adres (SicilNo, IlceID) VALUES (114998,755)
INSERT INTO Adres (SicilNo, IlceID) VALUES (575770,756)
INSERT INTO Adres (SicilNo, IlceID) VALUES (599350,757)
INSERT INTO Adres (SicilNo, IlceID) VALUES (465287,758)
INSERT INTO Adres (SicilNo, IlceID) VALUES (317330,759)
INSERT INTO Adres (SicilNo, IlceID) VALUES (478552,760)
INSERT INTO Adres (SicilNo, IlceID) VALUES (426861,761)
INSERT INTO Adres (SicilNo, IlceID) VALUES (477641,762)
INSERT INTO Adres (SicilNo, IlceID) VALUES (766615,763)
INSERT INTO Adres (SicilNo, IlceID) VALUES (425056,764)
INSERT INTO Adres (SicilNo, IlceID) VALUES (129799,765)
INSERT INTO Adres (SicilNo, IlceID) VALUES (959901,766)
INSERT INTO Adres (SicilNo, IlceID) VALUES (414031,767)
INSERT INTO Adres (SicilNo, IlceID) VALUES (577057,768)
INSERT INTO Adres (SicilNo, IlceID) VALUES (749812,769)
INSERT INTO Adres (SicilNo, IlceID) VALUES (723288,770)
INSERT INTO Adres (SicilNo, IlceID) VALUES (299958,771)
INSERT INTO Adres (SicilNo, IlceID) VALUES (453334,772)
INSERT INTO Adres (SicilNo, IlceID) VALUES (991243,773)
INSERT INTO Adres (SicilNo, IlceID) VALUES (426989,774)
INSERT INTO Adres (SicilNo, IlceID) VALUES (920153,775)
INSERT INTO Adres (SicilNo, IlceID) VALUES (703017,776)
INSERT INTO Adres (SicilNo, IlceID) VALUES (510895,777)
INSERT INTO Adres (SicilNo, IlceID) VALUES (509163,778)
INSERT INTO Adres (SicilNo, IlceID) VALUES (427722,779)
INSERT INTO Adres (SicilNo, IlceID) VALUES (323495,780)
INSERT INTO Adres (SicilNo, IlceID) VALUES (357145,781)
INSERT INTO Adres (SicilNo, IlceID) VALUES (504673,782)
INSERT INTO Adres (SicilNo, IlceID) VALUES (206284,783)
INSERT INTO Adres (SicilNo, IlceID) VALUES (837265,784)
INSERT INTO Adres (SicilNo, IlceID) VALUES (153420,785)
INSERT INTO Adres (SicilNo, IlceID) VALUES (651643,786)
INSERT INTO Adres (SicilNo, IlceID) VALUES (412712,787)
INSERT INTO Adres (SicilNo, IlceID) VALUES (573480,788)
INSERT INTO Adres (SicilNo, IlceID) VALUES (426530,789)
INSERT INTO Adres (SicilNo, IlceID) VALUES (351939,790)
INSERT INTO Adres (SicilNo, IlceID) VALUES (377440,791)
INSERT INTO Adres (SicilNo, IlceID) VALUES (965934,792)
INSERT INTO Adres (SicilNo, IlceID) VALUES (643309,793)
INSERT INTO Adres (SicilNo, IlceID) VALUES (623732,794)
INSERT INTO Adres (SicilNo, IlceID) VALUES (152201,795)
INSERT INTO Adres (SicilNo, IlceID) VALUES (753616,796)
INSERT INTO Adres (SicilNo, IlceID) VALUES (624225,797)
INSERT INTO Adres (SicilNo, IlceID) VALUES (273344,798)
INSERT INTO Adres (SicilNo, IlceID) VALUES (530826,799)
INSERT INTO Adres (SicilNo, IlceID) VALUES (394503,800)
INSERT INTO Adres (SicilNo, IlceID) VALUES (699713,801)
INSERT INTO Adres (SicilNo, IlceID) VALUES (178557,802)
INSERT INTO Adres (SicilNo, IlceID) VALUES (326487,803)
INSERT INTO Adres (SicilNo, IlceID) VALUES (784666,804)
INSERT INTO Adres (SicilNo, IlceID) VALUES (996822,805)
INSERT INTO Adres (SicilNo, IlceID) VALUES (602505,806)
INSERT INTO Adres (SicilNo, IlceID) VALUES (704399,807)
INSERT INTO Adres (SicilNo, IlceID) VALUES (443031,808)
INSERT INTO Adres (SicilNo, IlceID) VALUES (270227,809)
INSERT INTO Adres (SicilNo, IlceID) VALUES (742288,810)
INSERT INTO Adres (SicilNo, IlceID) VALUES (877407,811)
INSERT INTO Adres (SicilNo, IlceID) VALUES (883836,812)
INSERT INTO Adres (SicilNo, IlceID) VALUES (482602,813)
INSERT INTO Adres (SicilNo, IlceID) VALUES (501723,814)
INSERT INTO Adres (SicilNo, IlceID) VALUES (826087,815)
INSERT INTO Adres (SicilNo, IlceID) VALUES (969106,816)
INSERT INTO Adres (SicilNo, IlceID) VALUES (636969,817)
INSERT INTO Adres (SicilNo, IlceID) VALUES (389571,818)
INSERT INTO Adres (SicilNo, IlceID) VALUES (853375,819)
INSERT INTO Adres (SicilNo, IlceID) VALUES (885343,820)
INSERT INTO Adres (SicilNo, IlceID) VALUES (274817,821)
INSERT INTO Adres (SicilNo, IlceID) VALUES (189315,822)
INSERT INTO Adres (SicilNo, IlceID) VALUES (864331,823)
INSERT INTO Adres (SicilNo, IlceID) VALUES (702136,824)
INSERT INTO Adres (SicilNo, IlceID) VALUES (147659,825)
INSERT INTO Adres (SicilNo, IlceID) VALUES (384205,826)
INSERT INTO Adres (SicilNo, IlceID) VALUES (846035,827)
INSERT INTO Adres (SicilNo, IlceID) VALUES (210363,828)
INSERT INTO Adres (SicilNo, IlceID) VALUES (967470,829)
INSERT INTO Adres (SicilNo, IlceID) VALUES (276366,830)
INSERT INTO Adres (SicilNo, IlceID) VALUES (563864,831)
INSERT INTO Adres (SicilNo, IlceID) VALUES (312655,832)
INSERT INTO Adres (SicilNo, IlceID) VALUES (400166,833)
INSERT INTO Adres (SicilNo, IlceID) VALUES (878611,834)
INSERT INTO Adres (SicilNo, IlceID) VALUES (837282,835)
INSERT INTO Adres (SicilNo, IlceID) VALUES (864050,836)
INSERT INTO Adres (SicilNo, IlceID) VALUES (912022,837)
INSERT INTO Adres (SicilNo, IlceID) VALUES (167114,838)
INSERT INTO Adres (SicilNo, IlceID) VALUES (506165,839)
INSERT INTO Adres (SicilNo, IlceID) VALUES (562734,840)
INSERT INTO Adres (SicilNo, IlceID) VALUES (362794,841)
INSERT INTO Adres (SicilNo, IlceID) VALUES (778268,842)
INSERT INTO Adres (SicilNo, IlceID) VALUES (608506,843)
INSERT INTO Adres (SicilNo, IlceID) VALUES (398309,844)
INSERT INTO Adres (SicilNo, IlceID) VALUES (555614,845)
INSERT INTO Adres (SicilNo, IlceID) VALUES (674802,846)
INSERT INTO Adres (SicilNo, IlceID) VALUES (438705,847)
INSERT INTO Adres (SicilNo, IlceID) VALUES (910236,848)
INSERT INTO Adres (SicilNo, IlceID) VALUES (923454,849)
INSERT INTO Adres (SicilNo, IlceID) VALUES (405479,850)
INSERT INTO Adres (SicilNo, IlceID) VALUES (971456,851)
INSERT INTO Adres (SicilNo, IlceID) VALUES (559414,852)
INSERT INTO Adres (SicilNo, IlceID) VALUES (256259,853)
INSERT INTO Adres (SicilNo, IlceID) VALUES (714469,854)
INSERT INTO Adres (SicilNo, IlceID) VALUES (899894,855)
INSERT INTO Adres (SicilNo, IlceID) VALUES (410514,856)
INSERT INTO Adres (SicilNo, IlceID) VALUES (508823,857)
INSERT INTO Adres (SicilNo, IlceID) VALUES (488742,858)
INSERT INTO Adres (SicilNo, IlceID) VALUES (209421,859)
INSERT INTO Adres (SicilNo, IlceID) VALUES (643423,860)
INSERT INTO Adres (SicilNo, IlceID) VALUES (339701,861)
INSERT INTO Adres (SicilNo, IlceID) VALUES (561038,862)
INSERT INTO Adres (SicilNo, IlceID) VALUES (559697,863)
INSERT INTO Adres (SicilNo, IlceID) VALUES (592450,864)
INSERT INTO Adres (SicilNo, IlceID) VALUES (104092,865)
INSERT INTO Adres (SicilNo, IlceID) VALUES (798708,866)
INSERT INTO Adres (SicilNo, IlceID) VALUES (832357,867)
INSERT INTO Adres (SicilNo, IlceID) VALUES (214684,868)
INSERT INTO Adres (SicilNo, IlceID) VALUES (860889,869)
INSERT INTO Adres (SicilNo, IlceID) VALUES (213064,870)
INSERT INTO Adres (SicilNo, IlceID) VALUES (377331,871)
INSERT INTO Adres (SicilNo, IlceID) VALUES (248963,872)
INSERT INTO Adres (SicilNo, IlceID) VALUES (646225,873)
INSERT INTO Adres (SicilNo, IlceID) VALUES (428129,874)
INSERT INTO Adres (SicilNo, IlceID) VALUES (587421,875)
INSERT INTO Adres (SicilNo, IlceID) VALUES (398327,876)
INSERT INTO Adres (SicilNo, IlceID) VALUES (639804,877)
INSERT INTO Adres (SicilNo, IlceID) VALUES (530677,878)
INSERT INTO Adres (SicilNo, IlceID) VALUES (583733,879)
INSERT INTO Adres (SicilNo, IlceID) VALUES (450139,880)
INSERT INTO Adres (SicilNo, IlceID) VALUES (840674,881)
INSERT INTO Adres (SicilNo, IlceID) VALUES (718212,882)
INSERT INTO Adres (SicilNo, IlceID) VALUES (153455,883)
INSERT INTO Adres (SicilNo, IlceID) VALUES (221613,884)
INSERT INTO Adres (SicilNo, IlceID) VALUES (855079,885)
INSERT INTO Adres (SicilNo, IlceID) VALUES (197741,886)
INSERT INTO Adres (SicilNo, IlceID) VALUES (187687,887)
INSERT INTO Adres (SicilNo, IlceID) VALUES (503163,888)
INSERT INTO Adres (SicilNo, IlceID) VALUES (594864,889)
INSERT INTO Adres (SicilNo, IlceID) VALUES (398844,890)
INSERT INTO Adres (SicilNo, IlceID) VALUES (392717,891)
INSERT INTO Adres (SicilNo, IlceID) VALUES (620854,892)
INSERT INTO Adres (SicilNo, IlceID) VALUES (455623,893)
INSERT INTO Adres (SicilNo, IlceID) VALUES (582924,894)
INSERT INTO Adres (SicilNo, IlceID) VALUES (646250,895)
INSERT INTO Adres (SicilNo, IlceID) VALUES (471663,896)
INSERT INTO Adres (SicilNo, IlceID) VALUES (662599,897)
INSERT INTO Adres (SicilNo, IlceID) VALUES (333877,898)
INSERT INTO Adres (SicilNo, IlceID) VALUES (529692,899)
INSERT INTO Adres (SicilNo, IlceID) VALUES (161320,900)
INSERT INTO Adres (SicilNo, IlceID) VALUES (150076,901)
INSERT INTO Adres (SicilNo, IlceID) VALUES (353444,902)
INSERT INTO Adres (SicilNo, IlceID) VALUES (714538,903)
INSERT INTO Adres (SicilNo, IlceID) VALUES (560731,904)
INSERT INTO Adres (SicilNo, IlceID) VALUES (573662,905)
INSERT INTO Adres (SicilNo, IlceID) VALUES (154195,906)
INSERT INTO Adres (SicilNo, IlceID) VALUES (870855,907)
INSERT INTO Adres (SicilNo, IlceID) VALUES (186402,908)
INSERT INTO Adres (SicilNo, IlceID) VALUES (576302,909)
INSERT INTO Adres (SicilNo, IlceID) VALUES (873915,910)
INSERT INTO Adres (SicilNo, IlceID) VALUES (943861,911)
INSERT INTO Adres (SicilNo, IlceID) VALUES (809800,912)
INSERT INTO Adres (SicilNo, IlceID) VALUES (599170,913)
INSERT INTO Adres (SicilNo, IlceID) VALUES (612670,914)
INSERT INTO Adres (SicilNo, IlceID) VALUES (502895,915)
INSERT INTO Adres (SicilNo, IlceID) VALUES (618215,916)
INSERT INTO Adres (SicilNo, IlceID) VALUES (605271,917)
INSERT INTO Adres (SicilNo, IlceID) VALUES (834016,918)
INSERT INTO Adres (SicilNo, IlceID) VALUES (762429,919)
INSERT INTO Adres (SicilNo, IlceID) VALUES (991739,920)
INSERT INTO Adres (SicilNo, IlceID) VALUES (888133,921)
INSERT INTO Adres (SicilNo, IlceID) VALUES (818670,922)
INSERT INTO Adres (SicilNo, IlceID) VALUES (221582,923)
INSERT INTO Adres (SicilNo, IlceID) VALUES (217920,924)
INSERT INTO Adres (SicilNo, IlceID) VALUES (698922,925)
INSERT INTO Adres (SicilNo, IlceID) VALUES (418439,926)
INSERT INTO Adres (SicilNo, IlceID) VALUES (841657,927)
INSERT INTO Adres (SicilNo, IlceID) VALUES (801031,928)
INSERT INTO Adres (SicilNo, IlceID) VALUES (545016,929)
INSERT INTO Adres (SicilNo, IlceID) VALUES (129029,930)
INSERT INTO Adres (SicilNo, IlceID) VALUES (724264,931)
INSERT INTO Adres (SicilNo, IlceID) VALUES (851317,932)
INSERT INTO Adres (SicilNo, IlceID) VALUES (214408,933)
INSERT INTO Adres (SicilNo, IlceID) VALUES (487544,934)
INSERT INTO Adres (SicilNo, IlceID) VALUES (489410,935)
INSERT INTO Adres (SicilNo, IlceID) VALUES (363850,936)
INSERT INTO Adres (SicilNo, IlceID) VALUES (590931,937)
INSERT INTO Adres (SicilNo, IlceID) VALUES (459442,938)
INSERT INTO Adres (SicilNo, IlceID) VALUES (688708,939)
INSERT INTO Adres (SicilNo, IlceID) VALUES (928575,940)
INSERT INTO Adres (SicilNo, IlceID) VALUES (602235,941)
INSERT INTO Adres (SicilNo, IlceID) VALUES (263036,942)
INSERT INTO Adres (SicilNo, IlceID) VALUES (804328,943)
INSERT INTO Adres (SicilNo, IlceID) VALUES (706413,944)
INSERT INTO Adres (SicilNo, IlceID) VALUES (341122,945)
INSERT INTO Adres (SicilNo, IlceID) VALUES (618057,946)
INSERT INTO Adres (SicilNo, IlceID) VALUES (910117,947)
INSERT INTO Adres (SicilNo, IlceID) VALUES (807509,948)
INSERT INTO Adres (SicilNo, IlceID) VALUES (719179,949)
INSERT INTO Adres (SicilNo, IlceID) VALUES (206455,950)
INSERT INTO Adres (SicilNo, IlceID) VALUES (607766,951)
INSERT INTO Adres (SicilNo, IlceID) VALUES (159224,952)
INSERT INTO Adres (SicilNo, IlceID) VALUES (694505,953)
INSERT INTO Adres (SicilNo, IlceID) VALUES (954287,954)
INSERT INTO Adres (SicilNo, IlceID) VALUES (593116,955)
INSERT INTO Adres (SicilNo, IlceID) VALUES (870871,956)
INSERT INTO Adres (SicilNo, IlceID) VALUES (611321,957)
INSERT INTO Adres (SicilNo, IlceID) VALUES (863474,958)
INSERT INTO Adres (SicilNo, IlceID) VALUES (205913,959)
INSERT INTO Adres (SicilNo, IlceID) VALUES (353328,960)
INSERT INTO Adres (SicilNo, IlceID) VALUES (664750,961)
INSERT INTO Adres (SicilNo, IlceID) VALUES (921661,962)
INSERT INTO Adres (SicilNo, IlceID) VALUES (276422,963)
INSERT INTO Adres (SicilNo, IlceID) VALUES (276505,964)
INSERT INTO Adres (SicilNo, IlceID) VALUES (270850,965)
INSERT INTO Adres (SicilNo, IlceID) VALUES (268191,966)
INSERT INTO Adres (SicilNo, IlceID) VALUES (336357,967)
INSERT INTO Adres (SicilNo, IlceID) VALUES (756226,968)
INSERT INTO Adres (SicilNo, IlceID) VALUES (557615,969)
INSERT INTO Adres (SicilNo, IlceID) VALUES (898830,970)
INSERT INTO Adres (SicilNo, IlceID) VALUES (184948,971)
INSERT INTO Adres (SicilNo, IlceID) VALUES (910708,972)
INSERT INTO Adres (SicilNo, IlceID) VALUES (184579,973)
INSERT INTO Adres (SicilNo, IlceID) VALUES (552902,954)
INSERT INTO Adres (SicilNo, IlceID) VALUES (317608,955)
INSERT INTO Adres (SicilNo, IlceID) VALUES (579043,956)
INSERT INTO Adres (SicilNo, IlceID) VALUES (389488,957)
INSERT INTO Adres (SicilNo, IlceID) VALUES (360433,958)
INSERT INTO Adres (SicilNo, IlceID) VALUES (231571,959)
INSERT INTO Adres (SicilNo, IlceID) VALUES (814558,960)
INSERT INTO Adres (SicilNo, IlceID) VALUES (367990,961)
INSERT INTO Adres (SicilNo, IlceID) VALUES (194284,962)
INSERT INTO Adres (SicilNo, IlceID) VALUES (470828,963)
INSERT INTO Adres (SicilNo, IlceID) VALUES (116836,964)
INSERT INTO Adres (SicilNo, IlceID) VALUES (269303,965)
INSERT INTO Adres (SicilNo, IlceID) VALUES (542907,966)
INSERT INTO Adres (SicilNo, IlceID) VALUES (294078,967)
INSERT INTO Adres (SicilNo, IlceID) VALUES (793131,968)
INSERT INTO Adres (SicilNo, IlceID) VALUES (116581,969)
INSERT INTO Adres (SicilNo, IlceID) VALUES (136783,970)
INSERT INTO Adres (SicilNo, IlceID) VALUES (586338,971)
INSERT INTO Adres (SicilNo, IlceID) VALUES (984276,972)
INSERT INTO Adres (SicilNo, IlceID) VALUES (782934,973)
INSERT INTO Adres (SicilNo, IlceID) VALUES (465204,967)
INSERT INTO Adres (SicilNo, IlceID) VALUES (679125,968)
INSERT INTO Adres (SicilNo, IlceID) VALUES (169852,969)
INSERT INTO Adres (SicilNo, IlceID) VALUES (506541,970)
INSERT INTO Adres (SicilNo, IlceID) VALUES (180398,971)
INSERT INTO Adres (SicilNo, IlceID) VALUES (174337,972)
INSERT INTO Adres (SicilNo, IlceID) VALUES (764315,973)
