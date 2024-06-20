/* Dohvati sve (zapise i polja) podatke iz tablice filmovi */
SELECT * from filmovi;
/* Dohvati sve (zapise i polja) podatke iz tablice clanovi */
SELECT * from clanovi;


-- dohvati polja naslov, godina iz tablice filmov
SELECT naslov AS Naslov, godina AS "Godina izavanja" from filmovi;

-- dohvati samo prvi zapis iz tablice filmovi
SELECT * from filmovi WHERE id=1;

-- dohvati zapis iz tablice filmovi gdje je naslov Inception
SELECT * from filmovi WHERE naslov='Inception';

-- dohvati zapise iz tablice filmovi gdje je ID 2 ili 3
SELECT * from filmovi WHERE id=2 OR id=3;
SELECT * from filmovi WHERE id IN (2,3);

-- dohvati zapise iz tablice clanovi gdje je ime Ivan i telefon je 0912345678
SELECT * from clanovi WHERE ime="Ivan Horvat" AND telefon='0912345678';

SELECT * from filmovi WHERE (id=1 OR id=2) AND naslov='Kum';

-- dohvati zapise iz tablice filmovi gdje je film noviji od godine 1990
SELECT * from filmovi WHERE godina >= 1990;

-- dohvati zapise iz tablice filmovi gdje je film id razlicit od 2
SELECT * from filmovi WHERE id != 2;

-- poredaj filmove po godinama uzlazno
SELECT * from filmovi ORDER BY godina ASC;

-- poredaj filmove po godinama silazno
SELECT * from filmovi ORDER BY godina DESC;

-- pretrazi tablicu filmovi po naslovu filma
SELECT * from filmovi WHERE naslov LIKE "%nceptio%";

-- count, avg, sum
SELECT count(id) AS "Broj filmova u bazi" from filmovi;
SELECT count(id) AS "Broj filmova u bazi mladjih od 24 godine" from filmovi WHERE godina > 1990;

SELECT avg(cijena) AS 'Prosjek cijene' from cjenik;
SELECT format(avg(cijena), 2) AS 'Prosjek cijene formatiran' from cjenik;

SELECT sum(cijena) AS 'Ukupna cijena' from cjenik;

-- spoji tablice filmovi i zanrovi kako bi u rezultatu dobio skupljene podatke iz obje tablice
SELECT f.naslov, f.godina, z.ime AS 'Zanr'
    from filmovi f
    JOIN zanrovi z ON f.zanr_id = z.id;

-- spoji tablice filmovi, zanrovi i cjenik kako bi u rezultatu dobio skupljene podatke iz sve tri tablice
SELECT f.naslov, f.godina, z.ime AS 'Zanr', c.tip_filma AS 'Tip', c.cijena, c.zakasnina_po_danu AS 'Zakasnina'
    from filmovi f
    JOIN zanrovi z ON f.zanr_id = z.id
    JOIN cjenik c ON f.cjenik_id = c.id;


-- ispisi clanove koji su posudili vise od jednog filma

SELECT c.ime
    FROM clanovi c
    JOIN posudba p ON p.clan_id = c.id
    GROUP BY c.ime
    HAVING COUNT(c.id) > 1;


SELECT c.*, p.*
    FROM clanovi c
    JOIN posudba p ON p.clan_id = c.id;

    
SELECT c.*, COUNT(c.id) AS "Broj Posudbi"
    FROM clanovi c
    JOIN posudba p ON p.clan_id = c.id
    GROUP BY c.id;

SELECT c.*, COUNT(c.id) AS "Broj Posudbi"
    FROM clanovi c
JOIN posudba p ON p.clan_id = c.id
JOIN zaliha z ON z.film_id = p.clan_id
    GROUP BY c.id
HAVING COUNT(c.id) > 1;


SELECT f.*, SUM(z.kolicina) AS "Ukupna kolicina"
    FROM filmovi f
JOIN zaliha z ON z.film_id = f.id
GROUP BY f.id;


SELECT c.ime, f.naslov
    FROM clanovi c
    JOIN posudba p ON p.clan_id = c.id
    JOIN filmovi f ON f.naslov = p.zaliha_id;


SELECT  
    c.id "ID", 
    c.ime "CLAN", 
    c.email "EMAIL", 
    f.naslov "NASLOV", 
    m.tip "MEDIJ", 
    p.datum_posudbe "DATUM POSUDBE", 
    p.datum_povrata "DATUM POVRATA"
FROM clanovi c
    JOIN posudba p ON p.clan_id = c.id
    JOIN zaliha z ON p.zaliha_id = z.id
    JOIN filmovi f ON f.id = z.film_id
    JOIN mediji m ON m.id = z.id;

SELECT c.ime, COUNT(p.id) "Posudba"
    FROM clanovi c
    JOIN posudba p ON p.clan_id = c.id
    GROUP BY c.ime
    HAVING COUNT(p.id) > 1;