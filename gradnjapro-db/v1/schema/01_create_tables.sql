CREATE TABLE [dbo].[Dokument](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [VrstaDokumentaId] INT NOT NULL,
    [DateDoc] datetime2(7) NOT NULL,
    [DateCreated] datetime2(7) NOT NULL,
    [DateUpdated] datetime2(7) NOT NULL,
    [Opis] nvarchar(100) NULL,
    [UserId] nvarchar(128) NULL,
    [Status] INT NOT NULL,
    [ObjekatId] INT NULL,
    [PartnerId] INT NULL,
    [PrevoznikId] INT NULL,
    [VezniDokumentId] INT NULL,
    [VrstaVezniDokumentId] INT NULL,
    [KorisnikId] nvarchar(128) NULL,
    [Napomena] nvarchar(128) NULL,
    [DateValidated] datetime2(7) NULL,
    [Validacija] INT NULL,
    [Broj] nvarchar(30) NOT NULL,
    [BrojVeznogDokumenta] nvarchar(30) NULL,
    [VoziloId] INT NULL,
    [VozacId] INT NULL,
    [GenDoc] bit NOT NULL
);

CREATE TABLE [dbo].[DokumentStavka](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [DokumentId] INT NULL,
    [Stavka] INT NULL,
    [ZaliheId] INT NOT NULL,
    [Kolicina] FLOAT NOT NULL,
    [JedMere] nvarchar(20) NULL,
    [Cena] FLOAT NOT NULL
);

CREATE TABLE [dbo].[Help](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Naslov] nvarchar(30) NULL,
    [Opis] nvarchar(max) NOT NULL
);

CREATE TABLE [dbo].[Objekat](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Naziv] nvarchar(50) NOT NULL,
    [Tip] INT NOT NULL,
    [Opis] nvarchar(100) NULL,
    [Adresa] nvarchar(100) NULL,
    [VrstaCene] INT NOT NULL
);

CREATE TABLE [dbo].[ObjekatZalihe](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [ObjekatId] INT NOT NULL,
    [ZaliheId] INT NOT NULL,
    [Kolicina] FLOAT NOT NULL,
    [Cena] FLOAT NOT NULL
);

CREATE TABLE [dbo].[Partner](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Naziv] nvarchar(50) NOT NULL,
    [Tip] INT NOT NULL,
    [Adresa] nvarchar(100) NULL,
    [PIB] nvarchar(20) NULL,
    [TekuciRacun] nvarchar(30) NULL,
    [MB] nvarchar(30) NULL,
    [Napomena] nvarchar(100) NULL
);

CREATE TABLE [dbo].[Popis](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [DateDoc] datetime2(7) NOT NULL,
    [DateCreated] datetime2(7) NOT NULL,
    [DateUpdated] datetime2(7) NOT NULL,
    [Opis] nvarchar(100) NULL,
    [UserId] nvarchar(128) NULL,
    [Status] INT NOT NULL,
    [ObjekatId] INT NOT NULL
);

CREATE TABLE [dbo].[PopisStavke](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [PopisId] INT NULL,
    [Stavka] INT NULL,
    [ZaliheId] INT NOT NULL,
    [Kolicina] FLOAT NOT NULL,
    [JedMere] nvarchar(20) NULL,
    [KolicinaP] FLOAT NOT NULL
);

CREATE TABLE [dbo].[ProizvodniNalog](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [VrstaDokumentaId] INT NOT NULL,
    [DateDoc] datetime2(7) NOT NULL,
    [DateCreated] datetime2(7) NOT NULL,
    [DateUpdated] datetime2(7) NOT NULL,
    [Opis] nvarchar(100) NULL,
    [UserId] nvarchar(128) NULL,
    [Status] INT NOT NULL,
    [ObjekatMaterijalId] INT NOT NULL,
    [ObjekatProizvodId] INT NOT NULL,
    [PartnerId] INT NULL,
    [ProizvodId] INT NOT NULL,
    [Kolicina] FLOAT NOT NULL,
    [Cena] FLOAT NOT NULL,
    [RecepturaId] INT NULL,
    [CreateDoc] bit NOT NULL,
    [JedMere] nvarchar(10) NULL,
    [VrstaVezniDokumentId] INT NULL,
    [VezniDokumentId] INT NULL,
    [BrojVeznogDokumenta] nvarchar(50) NULL
);

CREATE TABLE [dbo].[ProizvodniNalogStavka](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [ProizvodniNalogId] INT NULL,
    [Stavka] INT NULL,
    [MaterijalId] INT NOT NULL,
    [Kolicina] FLOAT NOT NULL,
    [Cena] FLOAT NOT NULL,
    [Skart] FLOAT NOT NULL,
    [JedMere] nvarchar(10) NULL
);

CREATE TABLE [dbo].[Receptura](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [ProizvodId] INT NOT NULL,
    [Opis] nvarchar(100) NULL,
    [DateDoc] datetime2(7) NOT NULL,
    [Status] INT NOT NULL,
    [UserId] nvarchar(128) NOT NULL
);

CREATE TABLE [dbo].[RecepturaStavka](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Stavka] INT NOT NULL,
    [RecepturaId] INT NULL,
    [MaterijalId] INT NOT NULL,
    [Kolicina] FLOAT NOT NULL,
    [Skart] FLOAT NOT NULL,
    [JedMere] nvarchar(20) NULL
);

CREATE TABLE [dbo].[Tarife](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Naziv] nvarchar(50) NOT NULL,
    [Tip] INT NOT NULL,
    [Stopa] FLOAT NOT NULL,
    [DateCreated] datetime2(7) NOT NULL
);

CREATE TABLE [dbo].[UsersLogins](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [UserName] nvarchar(30) NOT NULL,
    [Status] INT NOT NULL,
    [DateLogin] datetime2(7) NOT NULL,
    [Session] nvarchar(30) NULL
);

CREATE TABLE [dbo].[Vozac](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Ime] nvarchar(30) NOT NULL,
    [Prezime] nvarchar(30) NOT NULL
);

CREATE TABLE [dbo].[Vozila](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Naziv] nvarchar(50) NOT NULL,
    [Opis] nvarchar(100) NULL,
    [RegBroj] nvarchar(15) NOT NULL
);

CREATE TABLE [dbo].[VrstaDokumenta](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Naziv] nvarchar(50) NOT NULL,
    [Skracenica] nvarchar(10) NOT NULL,
    [Stanje] INT NOT NULL,
    [Cena] INT NOT NULL
);

CREATE TABLE [dbo].[VrstaZaliha](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Naziv] nvarchar(50) NOT NULL,
    [Opis] nvarchar(100) NULL
);

CREATE TABLE [dbo].[Zalihe](
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Naziv] nvarchar(50) NOT NULL,
    [Opis] nvarchar(100) NULL,
    [JedMere] nvarchar(10) NOT NULL,
    [Cena] FLOAT NULL,
    [VrstaZalihaId] INT NULL,
    [Marka] nvarchar(20) NULL
);
