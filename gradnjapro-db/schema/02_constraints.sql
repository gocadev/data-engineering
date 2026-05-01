-- constraints documents
-- ============================
-- DOCUMENTS DOMAIN CONSTRAINTS
-- ============================

-- Dokument PK
ALTER TABLE [dbo].[Dokument]
ADD CONSTRAINT [PK_Dokument] PRIMARY KEY ([Id]);

-- Dokument → VrstaDokumenta
ALTER TABLE [dbo].[Dokument]
ADD CONSTRAINT [FK_Dokument_VrstaDokumenta_VrstaDokumentaId]
FOREIGN KEY ([VrstaDokumentaId]) REFERENCES [dbo].[VrstaDokumenta]([Id]);

-- Dokument → VrstaDokumenta (vezni dokument)
ALTER TABLE [dbo].[Dokument]
ADD CONSTRAINT [FK_Dokument_VrstaDokumenta_VrstaVezniDokumentId]
FOREIGN KEY ([VrstaVezniDokumentId]) REFERENCES [dbo].[VrstaDokumenta]([Id]);

-- Dokument → Objekat
ALTER TABLE [dbo].[Dokument]
ADD CONSTRAINT [FK_Dokument_Objekat_ObjekatId]
FOREIGN KEY ([ObjekatId]) REFERENCES [dbo].[Objekat]([Id]);

-- Dokument → Partner (dobavljač)
ALTER TABLE [dbo].[Dokument]
ADD CONSTRAINT [FK_Dokument_Partner_PartnerId]
FOREIGN KEY ([PartnerId]) REFERENCES [dbo].[Partner]([Id]);

-- Dokument → Partner (prevoznik)
ALTER TABLE [dbo].[Dokument]
ADD CONSTRAINT [FK_Dokument_Partner_PrevoznikId]
FOREIGN KEY ([PrevoznikId]) REFERENCES [dbo].[Partner]([Id]);

-- Dokument → Vozilo
ALTER TABLE [dbo].[Dokument]
ADD CONSTRAINT [FK_Dokument_Vozila_VoziloId]
FOREIGN KEY ([VoziloId]) REFERENCES [dbo].[Vozila]([Id]);

-- Dokument → Vozac
ALTER TABLE [dbo].[Dokument]
ADD CONSTRAINT [FK_Dokument_Vozac_VozacId]
FOREIGN KEY ([VozacId]) REFERENCES [dbo].[Vozac]([Id]);

-- DokumentStavka PK
ALTER TABLE [dbo].[DokumentStavka]
ADD CONSTRAINT [PK_DokumentStavka] PRIMARY KEY ([Id]);

-- DokumentStavka → Dokument
ALTER TABLE [dbo].[DokumentStavka]
ADD CONSTRAINT [FK_DokumentStavka_Dokument_DokumentId]
FOREIGN KEY ([DokumentId]) REFERENCES [dbo].[Dokument]([Id]) ON DELETE CASCADE;

-- DokumentStavka → Zalihe
ALTER TABLE [dbo].[DokumentStavka]
ADD CONSTRAINT [FK_DokumentStavka_Zalihe_ZaliheId]
FOREIGN KEY ([ZaliheId]) REFERENCES [dbo].[Zalihe]([Id]);

-- constraints_inventory
-- ============================
-- INVENTORY DOMAIN CONSTRAINTS
-- ============================

-- Zalihe PK
ALTER TABLE [dbo].[Zalihe]
ADD CONSTRAINT [PK_Zalihe] PRIMARY KEY ([Id]);

-- Zalihe → VrstaZaliha
ALTER TABLE [dbo].[Zalihe]
ADD CONSTRAINT [FK_Zalihe_VrstaZaliha_VrstaZalihaId]
FOREIGN KEY ([VrstaZalihaId]) REFERENCES [dbo].[VrstaZaliha]([Id]);

-- ObjekatZalihe PK
ALTER TABLE [dbo].[ObjekatZalihe]
ADD CONSTRAINT [PK_ObjekatZalihe] PRIMARY KEY ([Id]);

-- ObjekatZalihe → Objekat
ALTER TABLE [dbo].[ObjekatZalihe]
ADD CONSTRAINT [FK_ObjekatZalihe_Objekat_ObjekatId]
FOREIGN KEY ([ObjekatId]) REFERENCES [dbo].[Objekat]([Id]) ON DELETE CASCADE;

-- ObjekatZalihe → Zalihe
ALTER TABLE [dbo].[ObjekatZalihe]
ADD CONSTRAINT [FK_ObjekatZalihe_Zalihe_ZaliheId]
FOREIGN KEY ([ZaliheId]) REFERENCES [dbo].[Zalihe]([Id]) ON DELETE CASCADE;

--constraints_partners_logistics
-- ====================================
-- PARTNERS & LOGISTICS DOMAIN
-- ====================================

-- Partner PK
ALTER TABLE [dbo].[Partner]
ADD CONSTRAINT [PK_Partner] PRIMARY KEY ([Id]);

-- Vozila PK
ALTER TABLE [dbo].[Vozila]
ADD CONSTRAINT [PK_Vozila] PRIMARY KEY ([Id]);

-- Vozac PK
ALTER TABLE [dbo].[Vozac]
ADD CONSTRAINT [PK_Vozac] PRIMARY KEY ([Id]);


-- constraints_stockcount
-- ============================
-- STOCK COUNT DOMAIN
-- ============================

-- Popis PK
ALTER TABLE [dbo].[Popis]
ADD CONSTRAINT [PK_Popis] PRIMARY KEY ([Id]);

-- Popis → Objekat
ALTER TABLE [dbo].[Popis]
ADD CONSTRAINT [FK_Popis_Objekat_ObjekatId]
FOREIGN KEY ([ObjekatId]) REFERENCES [dbo].[Objekat]([Id]) ON DELETE CASCADE;

-- PopisStavke PK
ALTER TABLE [dbo].[PopisStavke]
ADD CONSTRAINT [PK_PopisStavke] PRIMARY KEY ([Id]);

-- PopisStavke → Popis
ALTER TABLE [dbo].[PopisStavke]
ADD CONSTRAINT [FK_PopisStavke_Popis_PopisId]
FOREIGN KEY ([PopisId]) REFERENCES [dbo].[Popis]([Id]);

-- PopisStavke → Zalihe
ALTER TABLE [dbo].[PopisStavke]
ADD CONSTRAINT [FK_PopisStavke_Zalihe_ZaliheId]
FOREIGN KEY ([ZaliheId]) REFERENCES [dbo].[Zalihe]([Id]) ON DELETE CASCADE;


--constraints_production
-- ============================
-- PRODUCTION DOMAIN
-- ============================

-- ProizvodniNalog PK
ALTER TABLE [dbo].[ProizvodniNalog]
ADD CONSTRAINT [PK_ProizvodniNalog] PRIMARY KEY ([Id]);

-- ProizvodniNalog → VrstaDokumenta
ALTER TABLE [dbo].[ProizvodniNalog]
ADD CONSTRAINT [FK_ProizvodniNalog_VrstaDokumenta_VrstaDokumentaId]
FOREIGN KEY ([VrstaDokumentaId]) REFERENCES [dbo].[VrstaDokumenta]([Id]);

-- ProizvodniNalog → Objekat (materijal)
ALTER TABLE [dbo].[ProizvodniNalog]
ADD CONSTRAINT [FK_ProizvodniNalog_Objekat_ObjekatMaterijalId]
FOREIGN KEY ([ObjekatMaterijalId]) REFERENCES [dbo].[Objekat]([Id]);

-- ProizvodniNalog → Objekat (proizvod)
ALTER TABLE [dbo].[ProizvodniNalog]
ADD CONSTRAINT [FK_ProizvodniNalog_Objekat_ObjekatProizvodId]
FOREIGN KEY ([ObjekatProizvodId]) REFERENCES [dbo].[Objekat]([Id]);

-- ProizvodniNalog → Partner
ALTER TABLE [dbo].[ProizvodniNalog]
ADD CONSTRAINT [FK_ProizvodniNalog_Partner_PartnerId]
FOREIGN KEY ([PartnerId]) REFERENCES [dbo].[Partner]([Id]);

-- ProizvodniNalog → Zalihe (proizvod)
ALTER TABLE [dbo].[ProizvodniNalog]
ADD CONSTRAINT [FK_ProizvodniNalog_Zalihe_ProizvodId]
FOREIGN KEY ([ProizvodId]) REFERENCES [dbo].[Zalihe]([Id]);

-- ProizvodniNalog → Receptura
ALTER TABLE [dbo].[ProizvodniNalog]
ADD CONSTRAINT [FK_ProizvodniNalog_Receptura_RecepturaId]
FOREIGN KEY ([RecepturaId]) REFERENCES [dbo].[Receptura]([Id]);

-- ProizvodniNalogStavka PK
ALTER TABLE [dbo].[ProizvodniNalogStavka]
ADD CONSTRAINT [PK_ProizvodniNalogStavka] PRIMARY KEY ([Id]);

-- ProizvodniNalogStavka → ProizvodniNalog
ALTER TABLE [dbo].[ProizvodniNalogStavka]
ADD CONSTRAINT [FK_ProizvodniNalogStavka_ProizvodniNalog_ProizvodniNalogId]
FOREIGN KEY ([ProizvodniNalogId]) REFERENCES [dbo].[ProizvodniNalog]([Id]);

-- ProizvodniNalogStavka → Zalihe (materijal)
ALTER TABLE [dbo].[ProizvodniNalogStavka]
ADD CONSTRAINT [FK_ProizvodniNalogStavka_Zalihe_MaterijalId]
FOREIGN KEY ([MaterijalId]) REFERENCES [dbo].[Zalihe]([Id]);

-- Receptura PK
ALTER TABLE [dbo].[Receptura]
ADD CONSTRAINT [PK_Sastavnica] PRIMARY KEY ([Id]);

-- Receptura → Zalihe (proizvod)
ALTER TABLE [dbo].[Receptura]
ADD CONSTRAINT [FK_Sastavnica_Zalihe_ProizvodId]
FOREIGN KEY ([ProizvodId]) REFERENCES [dbo].[Zalihe]([Id]);

-- RecepturaStavka PK
ALTER TABLE [dbo].[RecepturaStavka]
ADD CONSTRAINT [PK_RecepturaStavka] PRIMARY KEY ([Id]);

-- RecepturaStavka → Receptura
ALTER TABLE [dbo].[RecepturaStavka]
ADD CONSTRAINT [FK_RecepturaStavka_Receptura_RecepturaId]
FOREIGN KEY ([RecepturaId]) REFERENCES [dbo].[Receptura]([Id]);

-- RecepturaStavka → Zalihe (materijal)
ALTER TABLE [dbo].[RecepturaStavka]
ADD CONSTRAINT [FK_RecepturaStavka_Zalihe_MaterijalId]
FOREIGN KEY ([MaterijalId]) REFERENCES [dbo].[Zalihe]([Id]);

