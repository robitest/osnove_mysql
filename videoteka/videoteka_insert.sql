INSERT INTO zanrovi (ime)
VALUES
('Action'),
('Comedy'),
('Drama');

INSERT INTO filmovi (naslov, godina, zanr_id)
VALUES
('Inception', 1, 1),
('The Hangover', 2, 2),
('The Godfather', 3, 1); 

INSERT INTO cjenik (tip_filma, cijena, zakasnina_po_danu)
VALUES
('Jit', 3.50, 1.50),
('Regular', 2.00, 1.00),
('Old', 1.00, 0.50); 

INSERT INTO mediji (tip, koeficijent)
VALUES
('Kazeta', 1),
('DVDr', 1.2),
('BlueRay', 1.50); 

INSERT INTO clanovi (ime, adresa, telefon, email, clanski_broj)
VALUES
('Jhon Doe', '123 Eln Street', '555-1234', 'a@b.com', 'V001'),
('Jane Smith', '456 Oak Avenue', '555-5678', 'a@b2.com', 'V002'),
('Alice Johnson', '789 Pine Road', '555-9012', 'a@b3.com', 'V003'),

INSERT INTO posudba (datum_posudbe, datum_povrata, film_id, clan_id, cjenik_id, medij_id)
VALUES
('2024-09-06', DATE_SUB(NOW(), INTERVAL 2 DAY), 1, 2, 1, 1),
(DATE_SUB(NOW()), DATE_SUB(NOW(), INTERVAL 2 DAY), 1, 2, 1, 1),
('2024-09-06', DATE_SUB(NOW(), INTERVAL 2 DAY), 1, 2, 1, 1),