-- Baza podataka jednostavne knjiznice
    -- Knjižnica svojim članovima izdaje članske iskaznice.
    -- Knjige su kategorizirane po žanrovima.
    -- Svaka knjiga ima jedinstveni ISBN, ali može postojati više kopija iste knjige.
    -- Knjižnica treba pratiti svaku fizičku kopiju knjige i stanje dostupnosti iste.
    -- Članovi mogu posuđivati ​​knjige na određeno vrijeme, a zakašnjeli povrati povlače novčanu kaznu.

-- ER Diagram
    -- Entiteti:
        -- Član
        -- Knjiga
        -- Kategorija (Žanr)
        -- Kopija
        -- Posudba

-- Relacije
    -- Članovi mogu posuditi više knjiga.
    -- Svaka knjiga pripada jednom žanru.
    -- Svaka knjiga može imati više primjeraka.
    -- Svaki zapis o posudbi povezan je s jednim članom i jednim primjerkom knjige.

-- SQL naredbe za kreiranje baze
    -- kreirajte bazu i popunite tablice sa proizvoljnim podacima


DROP DATABASE IF EXISTS knjiznica;
CREATE DATABASE IF NOT EXISTS knjiznica DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE knjiznica;

-- Tablica za članove knjižnice
CREATE TABLE IF NOT EXISTS clanovi (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ime VARCHAR(100) NOT NULL,
    prezime VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    datum_rodjenja DATE,
    datum_clanstva DATE NOT NULL DEFAULT (CURDATE())
);-- ako ne navedemo ENGINE=InnoDB MySQL ce po zadanim postavkama sam postaviti InnoDB

-- Tablica za žanrove knjiga
CREATE TABLE IF NOT EXISTS zanrovi (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    naziv VARCHAR(100) UNIQUE NOT NULL
);

-- Tablica za knjige
CREATE TABLE IF NOT EXISTS knjige (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    naslov VARCHAR(200) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    zanr_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (zanr_id) REFERENCES zanrovi(id)
);

-- Tablica za fizičke kopije knjiga
CREATE TABLE IF NOT EXISTS kopija (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    knjiga_id INT UNSIGNED NOT NULL,
    barkod VARCHAR(50) NOT NULL,
    dostupna BOOLEAN DEFAULT TRUE,
    UNIQUE (knjiga_id, barkod),
    FOREIGN KEY (knjiga_id) REFERENCES knjige(id)
);

-- Tablica za posudbe
CREATE TABLE IF NOT EXISTS posudbe (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    clan_id INT UNSIGNED NOT NULL,
    kopija_id INT UNSIGNED NOT NULL,
    datum_posudbe DATE NOT NULL DEFAULT (CURDATE()),
    datum_povrata DATE,
    zakasnina DECIMAL(5, 2),
    FOREIGN KEY (clan_id) REFERENCES clanovi(id),
    FOREIGN KEY (kopija_id) REFERENCES kopija(id)
);

-- Popunjavanje tablica

INSERT INTO clanovi (ime, prezime, email, datum_rodjenja)
VALUES
('Ana', 'Horvat', 'ana.horvat@example.com', '1985-02-15'),
('Ivan', 'Kovačić', 'ivan.kovacic@example.com', '1990-07-23'),
('Marija', 'Petrović', 'marija.petrovic@example.com', '1978-11-05'),
('Luka', 'Novak', 'luka.novak@example.com', '1983-09-30'),
('Petra', 'Jurić', 'petra.juric@example.com', '1992-06-12');

INSERT INTO zanrovi (naziv)
VALUES
('Fikcija'), 
('Znanstvena fantastika'), 
('Detektivski'), 
('Povijesni'), 
('Ljubavni'); 

INSERT INTO knjige (naslov, autor, isbn, zanr_id)
VALUES
('Gospodar prstenova', 'J.R.R. Tolkien', '9780261102385', 1),
('Dina', 'Frank Herbert', '9780441013593', 2),
('Sherlock Holmes', 'Arthur Conan Doyle', '9780451524935', 3),
('Rat i mir', 'Lav Tolstoj', '9780140447934', 4),
('Ponos i predrasude', 'Jane Austen', '9780141439518', 5);

INSERT INTO kopija (knjiga_id, barkod, dostupna)
VALUES
(1, 'BAR1234567890', TRUE),
(1, 'BAR1234567891', TRUE),
(2, 'BAR2234567890', FALSE),
(3, 'BAR3234567890', TRUE),
(4, 'BAR4234567890', TRUE),
(5, 'BAR5234567890', FALSE),
(5, 'BAR5234567891', TRUE);

INSERT INTO posudbe (clan_id, kopija_id, datum_posudbe, datum_povrata, zakasnina)
VALUES
(1, 1, '2024-06-01', '2024-06-15', 0.00),
(2, 3, '2024-05-20', '2024-06-10', 5.00),
(3, 5, '2024-06-10', NULL, 0.00),
(4, 2, '2024-06-05', '2024-06-12', 0.00),
(5, 6, '2024-05-15', '2024-06-01', 2.50);
