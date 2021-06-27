-- Inicjalizacja bazy danych
DROP DATABASE IF EXISTS dziennik2;
CREATE DATABASE dziennik2;
-- przejscie do nowo utworzonej bazy
USE dziennik2;
-- Utworzenie tabeli Uczen
CREATE TABLE Uczen (
	nrLegitymacji varchar(10) NOT NULL,
	Imie varchar(40) NOT NULL,
	Nazwisko varchar(40) NOT NULL,
	ID_Adresu int unsigned NOT NULL,
	ID_Klasy int unsigned NOT NULL,
	PESEL varchar(11) NOT NULL,
	nrTelefonu varchar(9),
	Email varchar(40) NOT NULL,
	Login varchar(40) NOT NULL,
	Haslo varchar(50) NOT NULL,
	PRIMARY KEY(nrLegitymacji),
	UNIQUE(nrLegitymacji) ,
	UNIQUE(PESEL)
);
-- Utworzenie tabeli Nauczyciel
CREATE TABLE Nauczyciel(
	ID_Nauczyciela int unsigned NOT NULL AUTO_INCREMENT,
	ID_Adresu int unsigned NOT NULL,
	nrGabinetu int unsigned,
	Imie varchar(40) NOT NULL,
	Nazwisko varchar(40) NOT NULL,
	PESEL varchar(11) NOT NULL,
	nrTelefonu varchar(9) NOT NULL,
	Email varchar(40) NOT NULL,
	Login varchar(40) NOT NULL,
	Haslo varchar(50) NOT NULL,
	PRIMARY KEY(ID_Nauczyciela)
);
-- Utworzenie tabeli Administrator
CREATE TABLE Administrator(
	ID_Administratora int unsigned NOT NULL AUTO_INCREMENT,
	Imie varchar(40) NOT NULL,
	Nazwisko varchar(40) NOT NULL,
	PESEL varchar(11) NOT NULL,
	ID_Adresu int unsigned NOT NULL,
	nrTelefonu varchar(9) NOT NULL,
	Email varchar(40) NOT NULL,
	Login varchar(40) NOT NULL,
	Haslo varchar(50) NOT NULL,
	PRIMARY KEY(ID_Administratora)
);
-- Utworzenie tabeli Opiekun
CREATE TABLE Opiekun(
	ID_Opiekuna int unsigned NOT NULL AUTO_INCREMENT,
	Imie varchar(40) NOT NULL,
	Nazwisko varchar(40) NOT NULL,
	ID_Adresu int unsigned NOT NULL,
	PESEL varchar(11) NOT NULL,
	nrTelefonu varchar(9) NOT NULL,
	Email varchar(40) NOT NULL,
	Login varchar(40) NOT NULL,
	Haslo varchar(50) NOT NULL,
	PRIMARY KEY(ID_Opiekuna)
);
-- Utworzenie tabeli Ocena
CREATE TABLE Ocena(
	ID_Oceny int unsigned NOT NULL AUTO_INCREMENT,
	nrLegitymacjiUcznia VARCHAR(11) NOT NULL,
	ID_Nauczyciela int unsigned NOT NULL,
	ID_Przedmiotu int unsigned NOT NULL,
	Data DATE NOT NULL,
	Ocena DECIMAL(3,2) NOT NULL,
	Komentarz varchar(500),
	PRIMARY KEY(ID_Oceny)
);
-- Utworzenie tabeli Klasa
CREATE TABLE Klasa(
	ID_Klasy int unsigned NOT NULL AUTO_INCREMENT,
	Wychowawca int unsigned NOT NULL,
	Rocznik int unsigned NOT NULL,
	Oddzial varchar(3) NOT NULL,
	profil varchar(40),
	liczebnosc int unsigned NOT NULL,
	PRIMARY KEY(ID_Klasy)
);
-- Utworzenie tabeli Przedmiot
CREATE TABLE Przedmiot(
	ID_Przedmiotu int unsigned NOT NULL AUTO_INCREMENT,
	Nazwa varchar(40) NOT NULL,
	PRIMARY KEY(ID_Przedmiotu)
);
-- Utworzenie tabeli Adres
CREATE TABLE Adres(
	ID_Adresu int unsigned NOT NULL AUTO_INCREMENT,
	Miejscowosc VARCHAR(40) NOT NULL,
	KodPocztowy VARCHAR(6) NOT NULL,
	Ulica VARCHAR(40),
	nrDomu int unsigned NOT NULL,
	nrMieszkania int unsigned,
	PRIMARY KEY(ID_Adresu)
);
-- Utworzenie tabeli Zachowanie
CREATE TABLE Zachowanie(
	nrLegitymacjiUcznia VARCHAR(11) NOT NULL,
	PunktyZachowania int,
	UNIQUE(nrLegitymacjiUcznia)
);
-- Utworzenie tabeli Uwaga
CREATE TABLE Uwaga(
	ID_Uwagi int unsigned NOT NULL AUTO_INCREMENT,
	nrLegitymacjiUcznia varchar(11) NOT NULL,
	ID_Nauczyciela int unsigned NOT NULL,
	OdjetePunkty int NOT NULL,
	Komentarz varchar(500),
	PRIMARY KEY(ID_Uwagi)
);
-- Utworzenie tabeli JednostkaLekcyjna
-- Dodano juz wszystkie tabele, ktore nie sa pomostowe, wiec
-- od razu w definicji tabeli umieszczamy relacje
CREATE TABLE JednostkaLekcyjna(
	ID_Nauczyciela int unsigned NOT NULL,
	ID_Klasy int unsigned NOT NULL,
	ID_Przedmiotu int unsigned NOT NULL,
	FOREIGN KEY (ID_Nauczyciela) REFERENCES Nauczyciel(ID_Nauczyciela) ON DELETE CASCADE,
	FOREIGN KEY (ID_Klasy) REFERENCES Klasa(ID_Klasy) ON DELETE CASCADE,
	FOREIGN KEY (ID_Przedmiotu) REFERENCES Przedmiot(ID_Przedmiotu) ON DELETE CASCADE
);
-- Utworzenie OpiekunUcznia
CREATE TABLE OpiekunUcznia(
	nrLegitymacjiUcznia varchar(11) NOT NULL,
	ID_Opiekuna int unsigned NOT NULL,
	FOREIGN KEY(nrLegitymacjiUcznia) REFERENCES Uczen(NrLegitymacji) ON DELETE CASCADE,
	FOREIGN KEY(ID_Opiekuna) REFERENCES Opiekun(ID_Opiekuna) ON DELETE CASCADE
);
-- dodawanie relacji dla tabeli Uczen
ALTER TABLE Uczen
ADD FOREIGN KEY (ID_Klasy) REFERENCES Klasa(ID_Klasy) ON DELETE CASCADE;
ALTER TABLE Uczen
ADD FOREIGN KEY (ID_Adresu) REFERENCES Adres(ID_Adresu) ON DELETE CASCADE;
-- dodawanie relacji dla tabeli Nauczyciel
ALTER TABLE Nauczyciel
ADD FOREIGN KEY(ID_Adresu) REFERENCES Adres(ID_Adresu) ON DELETE CASCADE;
-- dodawanie relacji dla tabeli Administrator
ALTER TABLE Administrator
ADD FOREIGN KEY(ID_Adresu) REFERENCES Adres(ID_Adresu) ON DELETE CASCADE;
-- dodawanie relacji dla Opiekuna
ALTER TABLE Opiekun
ADD FOREIGN KEY(ID_ADresu) REFERENCES Adres(ID_Adresu) ON DELETE CASCADE;
-- dodawanie relacji dla Ocena
ALTER TABLE Ocena
ADD FOREIGN KEY(nrLegitymacjiUcznia) REFERENCES Uczen(nrLegitymacji) ON DELETE CASCADE;
ALTER TABLE Ocena
ADD FOREIGN KEY(ID_Nauczyciela) REFERENCES Nauczyciel(ID_Nauczyciela) ON DELETE CASCADE;
ALTER TABLE Ocena
ADD FOREIGN KEY(ID_Przedmiotu) REFERENCES Przedmiot(ID_Przedmiotu) ON DELETE CASCADE;
-- dodawanie relacji dla Klasa
ALTER TABLE Klasa
ADD FOREIGN KEY(Wychowawca) REFERENCES Nauczyciel(ID_Nauczyciela) ON DELETE CASCADE;
-- dodawanie relacji dla Zachowania
ALTER TABLE Zachowanie
ADD FOREIGN KEY(nrLegitymacjiUcznia) REFERENCES Uczen(nrLegitymacji) ON DELETE CASCADE;
-- dodawanie relacji dla Uwaga
ALTER TABLE Uwaga
ADD FOREIGN KEY(nrLegitymacjiUcznia) REFERENCES Uczen(nrLegitymacji) ON DELETE CASCADE;
ALTER TABLE Uwaga
ADD FOREIGN KEY(ID_Nauczyciela) REFERENCES Nauczyciel(ID_Nauczyciela) ON DELETE CASCADE;

-- trigger dla wstawiania danych do tabel
-- Uczen,Nauczyciel,Administrator,Opiekun


-- 1trigger dla kontroli liczebnosci klasy
-- dla insert
DELIMITER $$
CREATE TRIGGER ile_osob_w_klasie_INSERT BEFORE INSERT ON Uczen
FOR EACH ROW
BEGIN
DECLARE n INT DEFAULT 0;
SET n=NEW.ID_Klasy;
UPDATE Klasa SET Liczebnosc=(SELECT Liczebnosc+1 FROM Klasa WHERE ID_Klasy=n) WHERE ID_Klasy=n;
END $$
DELIMITER ;
-- dla update
DELIMITER $$
CREATE TRIGGER ile_osob_w_klasie_UPDATE BEFORE UPDATE ON Uczen
FOR EACH ROW
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE o INT DEFAULT 0;
SET n=NEW.ID_Klasy;
SET o=OLD.ID_Klasy;
UPDATE Klasa SET Liczebnosc=(SELECT Liczebnosc+1 FROM Klasa WHERE ID_Klasy=n) WHERE ID_Klasy=n;
UPDATE Klasa SET Liczebnosc=(SELECT Liczebnosc-1 FROM Klasa WHERE ID_Klasy=o) WHERE ID_Klasy=o;
END $$
DELIMITER ;
-- dla delete
DELIMITER $$
CREATE TRIGGER ile_osob_w_klasie_DELETE BEFORE DELETE ON Uczen
FOR EACH ROW
BEGIN
DECLARE n INT DEFAULT 0;
SET n=OLD.ID_Klasy;
UPDATE Klasa SET Liczebnosc=(SELECT Liczebnosc-1 FROM Klasa WHERE ID_Klasy=n) WHERE ID_Klasy=n;
END $$
DELIMITER ;

-- podobny lista triggerow dla zachowania
-- dla insert
DELIMITER $$
CREATE TRIGGER zachowanie_INSERT BEFORE INSERT ON Uwaga
FOR EACH ROW
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE uczen VARCHAR(11);
SET n=NEW.OdjetePunkty;
SET uczen=NEW.nrLegitymacjiUcznia;
UPDATE Zachowanie SET PunktyZachowania=(SELECT PunktyZachowania+n FROM Zachowanie WHERE nrLegitymacjiUcznia=uczen) WHERE nrLegitymacjiUcznia=uczen;
END $$
DELIMITER ;

-- dla delete
DELIMITER $$
CREATE TRIGGER zachowanie_DELETE BEFORE DELETE ON Uwaga
FOR EACH ROW
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE uczen VARCHAR(11);
SET n=OLD.OdjetePunkty;
SET uczen=OLD.nrLegitymacjiUcznia;
UPDATE Zachowanie SET PunktyZachowania=(SELECT PunktyZachowania-n FROM Zachowanie WHERE nrLegitymacjiUcznia=uczen) WHERE nrLegitymacjiUcznia=uczen;
END $$
DELIMITER ;


-- 2procedura dodajaca ocene do tabeli Oceny
DROP PROCEDURE IF EXISTS dodaj_ocene;
DELIMITER $$
CREATE PROCEDURE dodaj_ocene(IN nrLegitymacjiUcznia VARCHAR(11),IN ID_Nauczyciela INT unsigned,IN ID_Przedmiotu INT unsigned,IN Data DATE, IN Ocena DECIMAL(3,2),IN Komentarz VARCHAR(500))
BEGIN
	DECLARE q VARCHAR(300);
	SET q='INSERT INTO Ocena(nrLegitymacjiUcznia,ID_Nauczyciela,ID_Przedmiotu,Data,Ocena,Komentarz) VALUES(?,?,?,?,?,?);';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING nrLegitymacjiUcznia,ID_Nauczyciela,ID_Przedmiotu,Data,Ocena,Komentarz;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;


-- 3procedura dodajaca uwage do tabeli Uwaga
DROP PROCEDURE IF EXISTS dodaj_uwage;
DELIMITER $$
CREATE PROCEDURE dodaj_uwage(IN nrLegitymacjiUcznia VARCHAR(11),IN ID_Nauczyciela INT,IN OdjetePunkty INT,IN Komentarz VARCHAR(500))
BEGIN
	DECLARE q VARCHAR(300);
	SET q='INSERT INTO Uwaga(nrLegitymacjiUcznia,ID_Nauczyciela,OdjetePunkty,Komentarz) VALUES(? , ? , ? , ? );';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING nrLegitymacjiUcznia, ID_Nauczyciela,OdjetePunkty, Komentarz;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 4procedura, ktora dodaje ucznia do tabeli Uczen
DROP PROCEDURE IF EXISTS dodaj_ucznia;
DELIMITER $$
CREATE PROCEDURE dodaj_ucznia(IN nrLegitymacji VARCHAR(11), IN Imie VARCHAR(40), IN Nazwisko VARCHAR(40), IN ID_Adresu INT unsigned, IN ID_Klasy INT unsigned, IN PESEL VARCHAR(11), IN nrTelefonu VARCHAR(9), IN Email VARCHAR(40),IN Login VARCHAR(40), IN Haslo VARCHAR(50))
BEGIN
	DECLARE q VARCHAR(300);
	DECLARE Hash VARCHAR(160);
	SET Hash=SHA1(Haslo);
    SET q='INSERT INTO Uczen(nrLegitymacji,Imie,Nazwisko,ID_Adresu,ID_Klasy,PESEL,nrTelefonu,Email,Login,Haslo) VALUES (?,?,?,?,?,?,?,?,?,?);';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING nrLegitymacji,Imie,Nazwisko,ID_Adresu,ID_Klasy,PESEL,nrTelefonu,Email,Login,Hash;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 5procedura dodajaca nauczyciela do tabeli Nauczyciel
DROP PROCEDURE IF EXISTS dodaj_nauczyciela;
DELIMITER $$
CREATE PROCEDURE dodaj_nauczyciela(IN ID_Adresu INT unsigned,IN nrGabinetu INT unsigned,IN Imie VARCHAR(40),IN Nazwisko VARCHAR(40), IN PESEL VARCHAR(11),IN nrTelefonu VARCHAR(9),IN Email VARCHAR(40),IN Login VARCHAR(40),IN Haslo VARCHAR(40))
BEGIN
	DECLARE q VARCHAR(300);
	DECLARE Hash VARCHAR(160);
	SET Hash=SHA(Haslo);
    	SET q='INSERT INTO Nauczyciel(ID_Adresu,nrGabinetu,Imie,Nazwisko,PESEL,nrTelefonu,Email,Login,Haslo) VALUES (?,?,?,?,?,?,?,?,?);';
    	PREPARE stmnt FROM q;
    	EXECUTE stmnt USING ID_Adresu,nrGabinetu,Imie,Nazwisko,PESEL,nrTelefonu,Email,Login,Hash;
    	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 6procedura dodajaca opiekuna do tabeli Opiekunowie
DROP PROCEDURE IF EXISTS dodaj_opiekuna;
DELIMITER $$
CREATE PROCEDURE dodaj_opiekuna(IN Imie VARCHAR(40),IN Nazwisko VARCHAR(40),IN ID_Adresu INT unsigned, IN PESEL VARCHAR(11),IN nrTelefonu VARCHAR(9),IN Email VARCHAR(40),IN Login VARCHAR(40),IN Haslo VARCHAR(40))
BEGIN
	DECLARE q VARCHAR(300);
	DECLARE Hash VARCHAR(160);
	SET Hash=SHA(Haslo);
     SET q='INSERT INTO Opiekun(Imie,Nazwisko,ID_Adresu,PESEL,nrTelefonu,Email,Login,Haslo) VALUES (?,?,?,?,?,?,?,?);';
     PREPARE stmnt FROM q;
     EXECUTE stmnt USING Imie,Nazwisko,ID_Adresu,PESEL,nrTelefonu,Email,Login,Hash;
     DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 7procedura, która dla zadanego ucznia zwraca jego średnią z podanego przedmiotu
DROP PROCEDURE IF EXISTS oblicz_srednia;
DELIMITER $$
CREATE PROCEDURE oblicz_srednia(IN nrLegitymacji VARCHAR(10), IN Przedmiot VARCHAR(40))
BEGIN
   DECLARE q VARCHAR(300);
   SET q = 'SELECT AVG(O.Ocena) AS srednia FROM (Ocena O JOIN Uczen U ON O.nrLegitymacjiUcznia = U.nrLegitymacji)
            JOIN Przedmiot P ON O.ID_Przedmiotu = P.ID_Przedmiotu
            WHERE U.nrLegitymacji = ? AND P.Nazwa = ?';
   PREPARE stmnt FROM q;
   EXECUTE stmnt USING nrLegitymacji, Przedmiot;
   DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- TODO 4 userów(nauczyciel,administrator,opiekun,uczeń) OGÓLNYCH i ustawienie uprawnień
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'admin';
CREATE USER IF NOT EXISTS 'nauczyciel'@'localhost' IDENTIFIED BY 'nauczyciel';
CREATE USER IF NOT EXISTS 'opiekun'@'localhost' IDENTIFIED BY 'opiekun';
CREATE USER IF NOT EXISTS 'uczen'@'localhost' IDENTIFIED BY 'uczen';

GRANT ALL PRIVILEGES ON dziennik2. * TO 'admin'@'localhost';
GRANT SUPER ON *.* TO 'admin'@'localhost';

GRANT SELECT ON dziennik2.Uczen TO 'uczen'@'localhost';
GRANT SELECT ON dziennik2.Nauczyciel TO 'uczen'@'localhost';
GRANT SELECT ON dziennik2.Opiekun TO 'uczen'@'localhost';
GRANT SELECT ON dziennik2.Ocena TO 'uczen'@'localhost';
GRANT SELECT ON dziennik2.Klasa TO 'uczen'@'localhost';
GRANT SELECT ON dziennik2.Przedmiot TO 'uczen'@'localhost';
GRANT SELECT ON dziennik2.Adres TO 'uczen'@'localhost';
GRANT SELECT ON dziennik2.Zachowanie TO 'uczen'@'localhost';
GRANT SELECT ON dziennik2.Uwaga TO 'uczen'@'localhost';
GRANT SELECT ON dziennik2.JednostkaLekcyjna TO 'uczen'@'localhost';
GRANT SELECT ON dziennik2.OpiekunUcznia TO 'uczen'@'localhost';

GRANT SELECT ON dziennik2.Uczen TO 'opiekun'@'localhost';
GRANT SELECT ON dziennik2.Nauczyciel TO 'opiekun'@'localhost';
GRANT SELECT ON dziennik2.Opiekun TO 'opiekun'@'localhost';
GRANT SELECT ON dziennik2.Ocena TO 'opiekun'@'localhost';
GRANT SELECT ON dziennik2.Klasa TO 'opiekun'@'localhost';
GRANT SELECT ON dziennik2.Przedmiot TO 'opiekun'@'localhost';
GRANT SELECT ON dziennik2.Adres TO 'opiekun'@'localhost';
GRANT SELECT ON dziennik2.Zachowanie TO 'opiekun'@'localhost';
GRANT SELECT ON dziennik2.Uwaga TO 'opiekun'@'localhost';
GRANT SELECT ON dziennik2.JednostkaLekcyjna TO 'opiekun'@'localhost';
GRANT SELECT ON dziennik2.OpiekunUcznia TO 'opiekun'@'localhost';

GRANT SELECT ON dziennik2.Uczen TO 'nauczyciel'@'localhost';
GRANT SELECT ON dziennik2.Nauczyciel TO 'nauczyciel'@'localhost';
GRANT SELECT ON dziennik2.Opiekun TO 'nauczyciel'@'localhost';
GRANT SELECT ON dziennik2.Ocena TO 'nauczyciel'@'localhost';
GRANT INSERT ON dziennik2.Ocena TO 'nauczyciel'@'localhost';
GRANT UPDATE ON dziennik2.Ocena TO 'nauczyciel'@'localhost';
GRANT DELETE ON dziennik2.Ocena TO 'nauczyciel'@'localhost';
GRANT SELECT ON dziennik2.Klasa TO 'nauczyciel'@'localhost';
GRANT SELECT ON dziennik2.Przedmiot TO 'nauczyciel'@'localhost';
GRANT SELECT ON dziennik2.Adres TO 'nauczyciel'@'localhost';
GRANT SELECT ON dziennik2.Zachowanie TO 'nauczyciel'@'localhost';
GRANT INSERT ON dziennik2.Zachowanie TO 'nauczyciel'@'localhost';
GRANT UPDATE ON dziennik2.Zachowanie TO 'nauczyciel'@'localhost';
GRANT DELETE ON dziennik2.Zachowanie TO 'nauczyciel'@'localhost';
GRANT SELECT ON dziennik2.Uwaga TO 'nauczyciel'@'localhost';
GRANT INSERT ON dziennik2.Uwaga TO 'nauczyciel'@'localhost';
GRANT UPDATE ON dziennik2.Uwaga TO 'nauczyciel'@'localhost';
GRANT DELETE ON dziennik2.Uwaga TO 'nauczyciel'@'localhost';
GRANT SELECT ON dziennik2.JednostkaLekcyjna TO 'nauczyciel'@'localhost';
GRANT SELECT ON dziennik2.OpiekunUcznia TO 'nauczyciel'@'localhost';

GRANT EXECUTE ON dziennik2.* TO 'nauczyciel'@'localhost';
GRANT EXECUTE ON dziennik2.* TO 'opiekun'@'localhost';
GRANT EXECUTE ON dziennik2.* TO 'uczen'@'localhost';
FLUSH PRIVILEGES;


-- 8 oblicz_średnia_ogólna- funkcja, która dla zadanego ucznia zwraca jego średnią ze wszystkich przedmiotów
DROP PROCEDURE IF EXISTS oblicz_srednia_ogolna;
DELIMITER $$
CREATE PROCEDURE oblicz_srednia_ogolna(IN nrLegitymacji VARCHAR(10))
BEGIN
   DECLARE q VARCHAR(300);
   SET q = 'SELECT AVG(srednia) AS sredniaOgolna FROM
    (SELECT AVG(O.Ocena) AS srednia FROM Ocena O JOIN Uczen U
    ON O.nrLegitymacjiUcznia = U.nrLegitymacji
    WHERE U.nrLegitymacji = ?
    GROUP BY O.ID_Przedmiotu) tab1';
   PREPARE stmnt FROM q;
   EXECUTE stmnt USING nrLegitymacji;
   DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 10procedura dodajaca adres do tabeli Adres
DROP PROCEDURE IF EXISTS dodaj_adres;
DELIMITER $$
CREATE PROCEDURE dodaj_adres(IN Miejscowosc VARCHAR(40), IN KodPocztowy VARCHAR(6), IN Ulica VARCHAR(40), IN nrDomu INT UNSIGNED, IN nrMieszkania INT UNSIGNED)
BEGIN
    DECLARE q VARCHAR(200);
    SET q = 'INSERT INTO Adres(miejscowosc, kodpocztowy, ulica, nrdomu, nrmieszkania) VALUES( ?, ?, ?, ?, ?);';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING Miejscowosc, KodPocztowy, Ulica, nrDomu, nrMieszkania;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 11procedura dodajaca klase do tabeli Klasa
DROP PROCEDURE IF EXISTS dodaj_klase;
DELIMITER $$
CREATE PROCEDURE dodaj_klase(IN Wychowawca INT, IN Rocznik INT, IN Oddzial VARCHAR(3), IN profil VARCHAR(40), IN liczebnosc INT)
BEGIN
    DECLARE q VARCHAR(200);
    SET q = 'INSERT INTO Klasa( wychowawca, rocznik, oddzial, profil, liczebnosc) VALUES( ?, ?, ?, ?, ?);';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING Wychowawca, Rocznik, Oddzial, profil, liczebnosc;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 12procedura wyświetlająca adres dla podanego użytkownika
DROP PROCEDURE IF EXISTS wyswietl_adres;
DELIMITER $$
CREATE PROCEDURE wyswietl_adres(IN imie VARCHAR(40), IN nazwisko VARCHAR(40))
BEGIN
    DECLARE q VARCHAR(200);
    SET q = 'SELECT A.Miejscowosc, A.KodPocztowy, A.ULica, A.nrDomu, A.nrMieszkania FROM Adres A JOIN Uczen U
            ON A.ID_Adresu = U.ID_Adresu WHERE U.Imie = ? AND U.Nazwisko = ?;';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING imie, nazwisko;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;
-- 13procedura dodająca przedmiot do tabeli Przedmioty
DROP PROCEDURE IF EXISTS dodaj_przedmiot;
DELIMITER $$
CREATE PROCEDURE dodaj_przedmiot(IN nazwa VARCHAR(40))
BEGIN
	DECLARE q VARCHAR(200);
	SET q='INSERT INTO Przedmiot(Nazwa) VALUES (?);';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING Nazwa;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 14procedura, ktora dodaje administratora do tabeli Administrator, pomocne w skrypcie generującym dane

DROP PROCEDURE IF EXISTS dodaj_administratora;
DELIMITER $$
CREATE PROCEDURE dodaj_administratora(IN Imie VARCHAR(40), IN Nazwisko VARCHAR(40), IN PESEL VARCHAR(11), IN ID_Adresu INT unsigned, IN nrTelefonu VARCHAR(9), IN Email VARCHAR(40),IN Login VARCHAR(40), IN Haslo VARCHAR(50))
BEGIN
	DECLARE q VARCHAR(300);
	DECLARE Hash VARCHAR(160);
	SET Hash=SHA1(Haslo);
    	SET q='INSERT INTO Administrator(Imie,Nazwisko,PESEL,ID_Adresu,nrTelefonu,Email,Login,Haslo) VALUES(?,?,?,?,?,?,?,?);';
    	PREPARE stmnt FROM q;
    	EXECUTE stmnt USING Imie,Nazwisko,PESEL,ID_Adresu,nrTelefonu,Email,Login,Hash;
    	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 15procedura, ktora dodaje zachowanie, pomocne w skrypcie

DROP PROCEDURE IF EXISTS dodaj_zachowanie;
DELIMITER $$
CREATE PROCEDURE dodaj_zachowanie(IN nrLegitymacjiUcznia VARCHAR(11),IN Punkty INT)
BEGIN
	DECLARE q VARCHAR(200);
	SET q='INSERT INTO Zachowanie(nrLegitymacjiUcznia,PunktyZachowania ) VALUES(?,?);';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING nrLegitymacjiUcznia,Punkty;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;


-- 16procedura,	ktora dodaje jednostke do JednostkiLekcyjnej

DROP PROCEDURE IF EXISTS dodaj_lekcje;
DELIMITER $$
CREATE PROCEDURE dodaj_lekcje(IN ID_Nauczyciela INT unsigned, IN ID_Klasy INT unsigned, IN ID_Przedmiotu INT unsigned)
BEGIN
	DECLARE q VARCHAR(200);
	SET q='INSERT INTO JednostkaLekcyjna(ID_Nauczyciela,ID_Klasy,ID_Przedmiotu) VALUES (?,?,?);';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING ID_Nauczyciela, ID_Klasy, ID_Przedmiotu;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 17procedura, ktora dodaje relacje opiekun-uczen

DROP PROCEDURE IF EXISTS dodaj_relacje;
DELIMITER $$
CREATE PROCEDURE dodaj_relacje(IN nrLegitymacjiUcznia VARCHAR(11),IN ID_Opiekuna INT unsigned)
BEGIN
	DECLARE q VARCHAR(200);
	SET q='INSERT INTO OpiekunUcznia(nrLegitymacjiUcznia,ID_Opiekuna) VALUES(?,?);';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING nrLegitymacjiUcznia,ID_Opiekuna;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 18 procedura znajdująca uzytkownika, ktory zalogowal sie do bazy
SET @Type='';
DROP PROCEDURE IF EXISTS user_detail;
DELIMITER $$
CREATE PROCEDURE user_detail(IN userLogin VARCHAR(40),IN userHaslo VARCHAR(40),OUT Type VARCHAR(14))
BEGIN
	DECLARE q VARCHAR(1500);
	DECLARE userHash VARCHAR(160);
	SET userHash=SHA1(userHaslo);
	SET q='IF ((SELECT COUNT(NrLegitymacji) FROM Uczen WHERE nrLegitymacji=(SELECT nrLegitymacji FROM Uczen WHERE Uczen.Login=? AND Uczen.Haslo=?))>0) THEN SELECT "Uczen" INTO @Type;
	ELSEIF ((SELECT COUNT(ID_Nauczyciela) FROM Nauczyciel WHERE ID_Nauczyciela=(SELECT ID_Nauczyciela FROM Nauczyciel WHERE Nauczyciel.Login=? AND Nauczyciel.Haslo=?))>0) THEN SELECT "Nauczyciel" INTO @Type;
	ELSEIF ((SELECT COUNT(ID_Opiekuna) FROM Opiekun WHERE ID_Opiekuna=(SELECT ID_Opiekuna FROM Opiekun WHERE Opiekun.Login=? AND Opiekun.Haslo=?))>0) THEN SELECT "Opiekun" INTO @Type;
	ELSEIF ((SELECT COUNT(ID_Administratora) FROM Administrator WHERE ID_Administratora=(SELECT ID_Administratora FROM Administrator WHERE Administrator.Login=? AND Administrator.Haslo=?))>0) THEN SELECT "Administrator" INTO @Type;
	END IF;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING userLogin,userHash,userLogin,userHash,userLogin,userHash,userLogin,userHash;
	DEALLOCATE PREPARE stmnt;
	SET Type=@Type;
END $$
DELIMITER ;

-- 19procedura zwracająca nrLegitymacji ucznia po loginie i haśle
SET @StudentID='';

DROP PROCEDURE IF EXISTS student_id;
DELIMITER $$
CREATE PROCEDURE student_id(IN userLogin VARCHAR(40),IN userHaslo VARCHAR(40),OUT StudentID VARCHAR(11))
BEGIN
	DECLARE q VARCHAR(200);
	DECLARE hash VARCHAR(160);
	SET hash=SHA1(userHaslo);
	SET q='SELECT A.nrLegitymacji INTO @StudentID FROM(SELECT nrLegitymacji FROM Uczen WHERE Uczen.Login=? AND Uczen.Haslo=?)A;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING userLogin,hash;
	DEALLOCATE PREPARE stmnt;
	SET StudentID=@StudentID;
END $$
DELIMITER ;

-- 20procedura zwracająca ID_Nauczyciela dla nauczyciela po loginie i haśle
SET @TeacherID=0;

DROP PROCEDURE IF EXISTS teacher_id;
DELIMITER $$
CREATE PROCEDURE teacher_id(IN userLogin VARCHAR(40),IN userHaslo VARCHAR(40),OUT TeacherID INT unsigned)
BEGIN
	DECLARE q VARCHAR(200);
	DECLARE hash VARCHAR(160);
	SET hash=SHA1(userHaslo);
	SET q='SELECT A.ID INTO @TeacherID FROM(SELECT ID_Nauczyciela AS ID FROM Nauczyciel WHERE Nauczyciel.Login=? AND Nauczyciel.Haslo=?)A;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING userLogin,hash;
	DEALLOCATE PREPARE stmnt;
	SET TeacherID=@TeacherID;
END $$
DELIMITER ;
-- 21procedura zwracająca ID_Opiekuna dla opiekuna po loginie i haśle
SET @ParentID=0;
DROP PROCEDURE IF EXISTS parent_id;
DELIMITER $$
CREATE PROCEDURE parent_id(IN userLogin VARCHAR(40),IN userHaslo VARCHAR(40),OUT ParentID INT unsigned)
BEGIN
	DECLARE q VARCHAR(200);
	DECLARE hash VARCHAR(160);
	SET hash=SHA1(userHaslo);
	SET q='SELECT A.ID INTO @ParentID FROM(SELECT ID_Opiekuna AS ID FROM Opiekun WHERE Opiekun.Login=? AND Opiekun.Haslo=?)A;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING userLogin,hash;
	DEALLOCATE PREPARE stmnt;
	SET ParentID=@ParentID;
END $$
DELIMITER ;

-- 22procedura zwracająca ID_Administratora dla administratora po loginie i haśle
SET @AdminID=0;
DROP PROCEDURE IF EXISTS admin_id;
DELIMITER $$
CREATE PROCEDURE admin_id(IN userLogin VARCHAR(40),IN userHaslo VARCHAR(40),OUT AdminID INT unsigned)
BEGIN
	DECLARE q VARCHAR(200);
	DECLARE hash VARCHAR(160);
	SET hash=SHA1(userHaslo);
	SET q='SELECT A.ID INTO @AdminID FROM(SELECT ID_Administratora AS ID FROM Administrator WHERE Administrator.Login=? AND Administrator.Haslo=?)A;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING userLogin,hash;
	DEALLOCATE PREPARE stmnt;
	SET AdminID=@AdminID;
END $$
DELIMITER ;

-- 23procedura wyświetlająca wszystkie oceny danego ucznia

DROP PROCEDURE IF EXISTS show_marks;
DELIMITER $$
CREATE PROCEDURE show_marks(IN StudentID VARCHAR(11),IN Nazwa VARCHAR(40))
BEGIN
	DECLARE q VARCHAR(400);
	SET q='SELECT Ocena.ID_Oceny, Ocena.Ocena,Nauczyciel.Imie,Nauczyciel.Nazwisko,Przedmiot.Nazwa,Ocena.Data,Ocena.Komentarz FROM Ocena JOIN Nauczyciel ON Ocena.ID_Nauczyciela=Nauczyciel.ID_Nauczyciela JOIN Przedmiot ON Ocena.ID_Przedmiotu=Przedmiot.ID_Przedmiotu WHERE Ocena.nrLegitymacjiUcznia=? AND Przedmiot.Nazwa LIKE ?;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING StudentID,Nazwa;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 24procedura wyświetlająca wszystkie uwagi danego ucznia
DROP PROCEDURE IF EXISTS show_notes;
DELIMITER $$
CREATE PROCEDURE show_notes(IN StudentID VARCHAR(11))
BEGIN
	DECLARE q VARCHAR(200);
	SET q='SELECT Uwaga.OdjetePunkty, Nauczyciel.Imie, Nauczyciel.Nazwisko, Uwaga.Komentarz FROM Uwaga JOIN Nauczyciel ON Nauczyciel.ID_Nauczyciela=Uwaga.ID_Nauczyciela WHERE nrLegitymacjiUcznia=?;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING StudentId;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 25procedura wyświetlająca zachowanie danego ucznia

DROP PROCEDURE IF EXISTS show_points;
DELIMITER $$
CREATE PROCEDURE show_points(IN StudentID VARCHAR(11))
BEGIN
	DECLARE q VARCHAR(200);
	SET q='SELECT PunktyZachowania FROM Zachowanie WHERE nrLegitymacjiUcznia=?';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING StudentId;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 26 procedura pokazujaca wybranych (domyślnie wszystkich) uczniow w widoku administratora
DROP PROCEDURE IF EXISTS show_students;
DELIMITER $$
CREATE PROCEDURE show_students(IN firstname VARCHAR(40), IN lastname VARCHAR(40))
BEGIN
    DECLARE q VARCHAR(400);
    SET q = 'SELECT nrLegitymacji, Imie, Nazwisko, CONCAT(Adres.Miejscowosc," ",Adres.Ulica, " ",Adres.nrDomu,"/",Adres.nrMieszkania), Klasa.ID_Klasy, PESEL, nrTelefonu, Email, Login
           FROM Uczen JOIN Adres ON Adres.ID_Adresu=Uczen.ID_Adresu JOIN Klasa ON Uczen.ID_Klasy=Klasa.ID_Klasy
           WHERE Imie LIKE ? AND Nazwisko LIKE ?;';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING firstname, lastname;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 27 procedura pokazujaca wybranych (domyślnie wszystkich) nauczycieli w widoku administratora
DROP PROCEDURE IF EXISTS show_teachers;
DELIMITER $$
CREATE PROCEDURE show_teachers(IN firstname VARCHAR(40), IN lastname VARCHAR(40))
BEGIN
    DECLARE q VARCHAR(400);
    SET q = 'SELECT ID_Nauczyciela, Imie, Nazwisko, CONCAT(Adres.Miejscowosc," ",Adres.Ulica, " ",Adres.nrDomu,"/",Adres.nrMieszkania), nrGabinetu, PESEL, nrTelefonu, Email, Login
           FROM Nauczyciel JOIN Adres ON Nauczyciel.ID_Adresu=Adres.ID_Adresu
           WHERE Imie LIKE ? AND Nazwisko LIKE ?;';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING firstname, lastname;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 28 procedura pokazujaca wybranych (domyślnie wszystkich) opiekunów w widoku administratora

DROP PROCEDURE IF EXISTS show_parents;
DELIMITER $$
CREATE PROCEDURE show_parents(IN firstname VARCHAR(40), IN lastname VARCHAR(40))
BEGIN
    DECLARE q VARCHAR(400);
    SET q = 'SELECT ID_Opiekuna, Imie, Nazwisko, CONCAT(Adres.Miejscowosc," ",Adres.Ulica, " ",Adres.nrDomu,"/",Adres.nrMieszkania), 0, PESEL, nrTelefonu, Email, Login
           FROM Opiekun JOIN Adres ON Opiekun.ID_Adresu=Adres.ID_Adresu
           WHERE Imie LIKE ? AND Nazwisko LIKE ?;';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING firstname, lastname;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 29 procedura pokazujaca wybranych (domyślnie wszystkich) administratorów w widoku administratora

DROP PROCEDURE IF EXISTS show_admins;
DELIMITER $$
CREATE PROCEDURE show_admins(IN firstname VARCHAR(40), IN lastname VARCHAR(40))
BEGIN
    DECLARE q VARCHAR(400);
    SET q = 'SELECT ID_Administratora, Imie, Nazwisko, CONCAT(Adres.Miejscowosc," ",Adres.Ulica, " ",Adres.nrDomu,"/",Adres.nrMieszkania), 0, PESEL, nrTelefonu, Email, Login
           FROM Administrator JOIN Adres ON Administrator.ID_Adresu=Adres.ID_Adresu
           WHERE Imie LIKE ? AND Nazwisko LIKE ?;';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING firstname, lastname;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 30 procedura zwracająca wszystkie oceny wystawione przez danego nauczyciela CONCAT(Klasa.Rocznik,Klasa.Oddzial)
DROP PROCEDURE IF EXISTS marks_teacher_view;
DELIMITER $$
CREATE PROCEDURE marks_teacher_view(IN firstname VARCHAR(40),IN lastname VARCHAR(40),IN ID_Nauczyciela INT unsigned)
BEGIN
	DECLARE q VARCHAR(1000);
	SET q='SELECT Ocena.ID_Oceny, Ocena.Ocena, Uczen.nrLegitymacji, Uczen.Imie, Uczen.Nazwisko, CONCAT(Klasa.Rocznik,Klasa.Oddzial),Przedmiot.Nazwa,Ocena.Data,Ocena.Komentarz FROM Ocena JOIN Uczen ON Ocena.nrLegitymacjiUcznia=Uczen.nrLegitymacji JOIN Klasa ON Uczen.ID_Klasy=Klasa.ID_Klasy JOIN Przedmiot ON Ocena.ID_Przedmiotu=Przedmiot.ID_Przedmiotu  WHERE Uczen.Imie LIKE ? AND Uczen.Nazwisko LIKE ? AND Ocena.ID_Nauczyciela=?;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING firstname,lastname,ID_Nauczyciela;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 31 procedura zwracająca wszystkie uwagi wystawione przez danego nauczyciela
DROP PROCEDURE IF EXISTS notes_teacher_view;
DELIMITER $$
CREATE PROCEDURE notes_teacher_view(IN firstname VARCHAR(40), IN lastname VARCHAR(40), IN ID_Nauczyciela INT unsigned)
BEGIN
	DECLARE q VARCHAR(1000);
	SET q='SELECT Uwaga.ID_Uwagi, Uwaga.OdjetePunkty,Uczen.nrLegitymacji,Uczen.Imie,Uczen.Nazwisko,CONCAT(Klasa.Rocznik,Klasa.Oddzial),
Uwaga.Komentarz FROM Uwaga JOIN Uczen ON Uwaga.nrLegitymacjiUcznia=Uczen.nrLegitymacji JOIN Nauczyciel ON Uwaga.ID_Nauczyciela=Nauczyciel.ID_Nauczyciela JOIN Klasa ON Uczen.ID_Klasy=Klasa.ID_Klasy WHERE Uczen.Imie LIKE ? AND Uczen.Nazwisko LIKE ? AND Uwaga.ID_Nauczyciela=?;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING firstname,lastname,ID_Nauczyciela;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;
-- 32 procedura zwracająca wszystkich uczniów nauczanych przez nauczyciela
DROP PROCEDURE IF EXISTS students_teacher_view;
DELIMITER $$
CREATE PROCEDURE students_teacher_view(IN firstname VARCHAR(40),IN lastname VARCHAR(40), IN ID_Nauczyciela INT unsigned)
BEGIN
	DECLARE q VARCHAR(1000);
	SET q='SELECT Uczen.nrLegitymacji,Uczen.Imie,Uczen.Nazwisko,CONCAT(Klasa.Rocznik,Klasa.Oddzial) FROM JednostkaLekcyjna JOIN Klasa ON JednostkaLekcyjna.ID_Klasy=Klasa.ID_Klasy JOIN Nauczyciel ON JednostkaLekcyjna.ID_Nauczyciela=Nauczyciel.ID_Nauczyciela JOIN Uczen ON Uczen.ID_Klasy=Klasa.ID_KLasy WHERE Uczen.Imie LIKE ? AND Uczen.Nazwisko LIKE ? AND JednostkaLekcyjna.ID_Nauczyciela=?;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING firstname,lastname,ID_Nauczyciela;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 33 procedura zwracajaca ID_przedmiotu po nazwie
DROP PROCEDURE IF EXISTS find_subjectID;
DELIMITER $$
CREATE PROCEDURE find_subjectID(IN name VARCHAR(40))
BEGIN
	DECLARE q VARCHAR(200);
	SET q='SELECT ID_Przedmiotu FROM Przedmiot WHERE Nazwa=?;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING name;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 34 procedura sprawdzajaca czy podana legitymacja znajduje sie w bazie
DROP PROCEDURE IF EXISTS legitymacja_check;
DELIMITER $$
CREATE PROCEDURE legitymacja_check(IN nrLegitymacji VARCHAR(11))
BEGIN
	DECLARE q VARCHAR(200);
	SET q='SELECT COUNT(*) FROM Uczen WHERE nrLegitymacji=?;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING nrLegitymacji;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 35 proceudra edytująca ucznia
DROP PROCEDURE IF EXISTS edit_student;
DELIMITER $$
CREATE PROCEDURE edit_student(IN currentID VARCHAR(10), IN id VARCHAR(10), IN firstname VARCHAR(40), IN lastname VARCHAR(40),
                                IN address INT UNSIGNED, IN class INT UNSIGNED, IN pesel VARCHAR(11),
                                IN phone VARCHAR(9), IN mail VARCHAR(40))
BEGIN
   DECLARE q VARCHAR(500);
   SET q = 'UPDATE Uczen
            SET nrLegitymacji = ?, Imie = ?, Nazwisko = ?, ID_Adresu = ?, ID_Klasy = ?,
           PESEL = ?, nrTelefonu = ?, Email = ?
           WHERE nrLegitymacji = ?;';
   PREPARE stmnt FROM q;
   EXECUTE stmnt USING id, firstname, lastname, address, class, pesel, phone, mail, currentID;
   DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 36 procedura edytująca nauczyciela
DROP PROCEDURE IF EXISTS edit_teacher;
DELIMITER $$
CREATE PROCEDURE edit_teacher(IN currentID VARCHAR(10), IN id VARCHAR(10), IN firstname VARCHAR(40), IN lastname VARCHAR(40),
                              IN address INT UNSIGNED, IN class INT UNSIGNED, IN pesel VARCHAR(11),
                              IN phone VARCHAR(9), IN mail VARCHAR(40))
BEGIN
    DECLARE q VARCHAR(500);
    SET q = 'UPDATE Nauczyciel
            SET ID_Nauczyciela = ?, Imie = ?, Nazwisko = ?, ID_Adresu = ?, nrGabinetu = ?,
           PESEL = ?, nrTelefonu = ?, Email = ?
           WHERE ID_Nauczyciela = ?;';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING id, firstname, lastname, address, class, pesel, phone, mail, currentID;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 37 procedura edytująca opiekuna
DROP PROCEDURE IF EXISTS edit_parent;
DELIMITER $$
CREATE PROCEDURE edit_parent(IN currentID VARCHAR(10), IN id VARCHAR(10), IN firstname VARCHAR(40), IN lastname VARCHAR(40),
                              IN address INT UNSIGNED, IN pesel VARCHAR(11),
                              IN phone VARCHAR(9), IN mail VARCHAR(40))
BEGIN
    DECLARE q VARCHAR(500);
    SET q = 'UPDATE Opiekun
            SET ID_Opiekuna = ?, Imie = ?, Nazwisko = ?, ID_Adresu = ?,
           PESEL = ?, nrTelefonu = ?, Email = ?
           WHERE ID_Opiekuna = ?;';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING id, firstname, lastname, address, pesel, phone, mail, currentID;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 38 procedura edytująca administratora
DROP PROCEDURE IF EXISTS edit_admin;
DELIMITER $$
CREATE PROCEDURE edit_admin(IN currentID VARCHAR(10), IN id VARCHAR(10), IN firstname VARCHAR(40), IN lastname VARCHAR(40),
                             IN address INT UNSIGNED, IN pesel VARCHAR(11),
                             IN phone VARCHAR(9), IN mail VARCHAR(40))
BEGIN
    DECLARE q VARCHAR(500);
    SET q = 'UPDATE Administrator
            SET ID_Administratora = ?, Imie = ?, Nazwisko = ?, ID_Adresu = ?,
           PESEL = ?, nrTelefonu = ?, Email = ?
           WHERE ID_Administratora = ?;';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING id, firstname, lastname, address, pesel, phone, mail, currentID;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 39 procedura usuwająca ucznia z bazy
DROP PROCEDURE IF EXISTS remove_student;
DELIMITER $$
CREATE PROCEDURE remove_student(IN id VARCHAR(10))
BEGIN
   DECLARE q VARCHAR(100);
   SET q = 'DELETE FROM Uczen WHERE nrLegitymacji = ?';
   PREPARE stmnt FROM q;
   EXECUTE stmnt USING id;
   DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 40 procedura usuwająca nauczyciela z bazy
DROP PROCEDURE IF EXISTS remove_teacher;
DELIMITER $$
CREATE PROCEDURE remove_teacher(IN id VARCHAR(10))
BEGIN
    DECLARE q VARCHAR(100);
    SET q = 'DELETE FROM Nauczyciel WHERE ID_Nauczyciela = ?';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING id;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 41 procedura usuwająca opiekuna z bazy
DROP PROCEDURE IF EXISTS remove_parent;
DELIMITER $$
CREATE PROCEDURE remove_parent(IN id VARCHAR(10))
BEGIN
    DECLARE q VARCHAR(100);
    SET q = 'DELETE FROM Opiekun WHERE ID_Opiekuna = ?';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING id;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 42 procedura usuwająca administratora z bazy
DROP PROCEDURE IF EXISTS remove_admin;
DELIMITER $$
CREATE PROCEDURE remove_admin(IN id VARCHAR(10))
BEGIN
    DECLARE q VARCHAR(100);
    SET q = 'DELETE FROM Administrator WHERE ID_Administratora = ?';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING id;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 43temp
DROP PROCEDURE IF EXISTS create_student;
DELIMITER $$
CREATE PROCEDURE create_student(IN id VARCHAR(11), IN firstname VARCHAR(40), IN lastname VARCHAR(40), IN address INT unsigned,
                                IN class INT unsigned, IN pesel VARCHAR(11), IN phone VARCHAR(9), IN email VARCHAR(40),
                                IN login VARCHAR(40), IN password VARCHAR(50))
BEGIN
    DECLARE q VARCHAR(300);
    DECLARE Hash VARCHAR(160);
    SET Hash=SHA1(password);
    SET q='INSERT INTO Uczen VALUES (?,?,?,?,?,?,?,?,?,?);';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING id, firstname, lastname, address, class, pesel, phone, email, login, Hash;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 44temp2

DROP PROCEDURE IF EXISTS create_behaviour;
DELIMITER $$
CREATE PROCEDURE create_behaviour(IN id VARCHAR(11))
BEGIN
   DECLARE q VARCHAR(100);
   SET q = 'INSERT INTO Zachowanie VALUES (?, 100)';
   PREPARE stmnt FROM q;
   EXECUTE stmnt USING id;
   DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 45temp3
DROP PROCEDURE IF EXISTS create_admin;
DELIMITER $$
CREATE PROCEDURE create_admin(IN id VARCHAR(11), IN firstname VARCHAR(40), IN lastname VARCHAR(40), IN address INT unsigned,
                               IN pesel VARCHAR(11), IN phone VARCHAR(9), IN email VARCHAR(40),
                               IN login VARCHAR(40), IN password VARCHAR(50))
BEGIN
    DECLARE q VARCHAR(300);
    DECLARE Hash VARCHAR(160);
    SET Hash=SHA1(password);
    SET q='INSERT INTO Administrator VALUES (?,?,?,?,?,?,?,?,?);';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING id, firstname, lastname, address, pesel, phone, email, login, Hash;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 46 procedura zwracająca wszystkich uczniów danego opiekuna w szkole
DROP PROCEDURE IF EXISTS parent_students;
DELIMITER $$
CREATE PROCEDURE parent_students(IN ID_Opiekuna INT unsigned)
BEGIN
	DECLARE q VARCHAR(600);
	SET q='SELECT Uczen.nrLegitymacji,Uczen.Imie,Uczen.Nazwisko,CONCAT(Klasa.Rocznik,Klasa.Oddzial) FROM Uczen JOIN Klasa ON Uczen.ID_Klasy=Klasa.ID_Klasy JOIN OpiekunUcznia ON Uczen.nrLegitymacji=OpiekunUcznia.nrLegitymacjiUcznia WHERE OpiekunUcznia.ID_Opiekuna=?;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING ID_Opiekuna;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

-- 47 procedura zwracająca oceny dla każdego ucznia danego opiekuna w szkole
DROP PROCEDURE IF EXISTS parent_grades;
DELIMITER $$
CREATE PROCEDURE parent_grades(IN firstName VARCHAR(40),IN lastName VARCHAR(40),IN ID_Opiekuna INT unsigned)
BEGIN
	DECLARE q VARCHAR(1000);
	SET q='SELECT Ocena.ID_Oceny, Uczen.Imie,Uczen.Nazwisko,Ocena.Ocena,Nauczyciel.Imie,Nauczyciel.Nazwisko,Przedmiot.Nazwa,Ocena.Data,Ocena.Komentarz FROM Ocena JOIN Nauczyciel ON Ocena.ID_Nauczyciela=Nauczyciel.ID_Nauczyciela JOIN Przedmiot ON Ocena.ID_Przedmiotu=Przedmiot.ID_Przedmiotu JOIN Uczen ON Ocena.nrLegitymacjiUcznia=Uczen.nrLegitymacji JOIN OpiekunUcznia ON Ocena.nrLegitymacjiUcznia=OpiekunUcznia.nrLegitymacjiUcznia WHERE Uczen.Imie LIKE ? AND Uczen.Nazwisko LIKE ? AND OpiekunUcznia.ID_Opiekuna=?;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING firstName, lastName, ID_Opiekuna;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;
-- 48 procedura zwracająca uwagi dla każdego ucznia danego opiekuna w szkole
DROP PROCEDURE IF EXISTS parent_notes;
DELIMITER $$
CREATE PROCEDURE parent_notes(IN firstName VARCHAR(40),IN lastName VARCHAR(40),IN ID_Opiekuna INT unsigned)
BEGIN
	DECLARE q VARCHAR(1000);
	SET q='SELECT Uczen.Imie, Uczen.Nazwisko,Uwaga.OdjetePunkty,Nauczyciel.Imie,Nauczyciel.Nazwisko,Uwaga.Komentarz FROM Uwaga JOIN Uczen ON Uwaga.nrLegitymacjiUcznia=Uczen.nrLegitymacji JOIN Nauczyciel ON Uwaga.ID_Nauczyciela=Nauczyciel.ID_Nauczyciela JOIN OpiekunUcznia ON Uwaga.nrLegitymacjiUcznia=OpiekunUcznia.nrLegitymacjiUcznia WHERE Uczen.Imie LIKE ? AND Uczen.Nazwisko LIKE ? AND OpiekunUcznia.ID_Opiekuna=?;';
PREPARE stmnt FROM q;
	EXECUTE stmnt USING firstName, lastName, ID_Opiekuna;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;
-- 49 procedura zwracająca zachowanie dla każdego ucznia danego opiekuna w szkole
DROP PROCEDURE IF EXISTS parent_behaviour;
DELIMITER $$
CREATE PROCEDURE parent_behaviour(IN ID_Opiekuna INT unsigned)
BEGIN
	DECLARE q VARCHAR(1000);
	SET q='SELECT Uczen.Imie,Uczen.Nazwisko,Zachowanie.PunktyZachowania FROM Uczen JOIN Zachowanie ON Uczen.nrLegitymacji=Zachowanie.nrLegitymacjiUcznia JOIN OpiekunUcznia ON Uczen.nrLegitymacji=OpiekunUcznia.nrLegitymacjiUcznia WHERE OpiekunUcznia.ID_Opiekuna=?;';
	PREPARE stmnt FROM q;
	EXECUTE stmnt USING ID_Opiekuna;
	DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS login_check;
DELIMITER $$
CREATE PROCEDURE login_check(IN login VARCHAR(11))
BEGIN
    DECLARE q VARCHAR(200);
    SET q='SELECT COUNT(*) FROM ((SELECT Login FROM Uczen) UNION (SELECT Login FROM Nauczyciel) UNION (SELECT Login FROM Opiekun)
          UNION (SELECT Login FROM Administrator)) A WHERE A.Login = ?;';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING login;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

SET @Points=0;
DROP PROCEDURE IF EXISTS edytuj_uwage;
DELIMITER $$
CREATE PROCEDURE edytuj_uwage(IN idUwagi INT, IN nrLegitymacjiUcznia VARCHAR(11),IN ID_Nauczyciela INT unsigned,IN OdjetePunkty INT,IN Komentarz VARCHAR(500))
BEGIN
    DECLARE q VARCHAR(300);
    DECLARE r VARCHAR(300);
    DECLARE s VARCHAR(300);
    DECLARE roznica INT DEFAULT 0;
    SET autocommit=0;
    START TRANSACTION;
    SET r='SELECT Uwaga.OdjetePunkty INTO @Points FROM Uwaga WHERE ID_Uwagi=?;';
    PREPARE stmnt FROM r;
    EXECUTE stmnt USING idUwagi;
    DEALLOCATE PREPARE stmnt;
    SET roznica=@Points-OdjetePunkty;
    SET s='UPDATE Uwaga SET nrLegitymacjiUcznia = ?, ID_Nauczyciela = ?, OdjetePunkty = ?, Komentarz = ? WHERE ID_Uwagi = ?;';
    PREPARE stmnt FROM s;
    EXECUTE stmnt USING nrLegitymacjiUcznia,ID_Nauczyciela,OdjetePunkty,Komentarz, idUwagi;
    DEALLOCATE PREPARE stmnt;
    SET q='UPDATE Zachowanie SET PunktyZachowania=PunktyZachowania - ? WHERE Zachowanie.nrLegitymacjiUcznia=?;';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING roznica,nrLegitymacjiUcznia;
    DEALLOCATE PREPARE stmnt;
    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS edytuj_ocene;
DELIMITER $$
CREATE PROCEDURE edytuj_ocene(IN idOceny INT, IN nrLegitymacjiUcznia VARCHAR(11),IN ID_Nauczyciela INT unsigned,IN ID_Przedmiotu INT unsigned,IN Data DATE, IN Ocena DECIMAL(3,2),IN Komentarz VARCHAR(500))
BEGIN
    DECLARE q VARCHAR(300);
    SET q = 'UPDATE Ocena SET nrLegitymacjiUcznia = ?, ID_Nauczyciela = ?, ID_Przedmiotu = ?, Data = ?, Ocena = ?, Komentarz = ? WHERE ID_Oceny = ?';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING nrLegitymacjiUcznia,ID_Nauczyciela,ID_Przedmiotu,Data,Ocena,Komentarz, idOceny;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS remove_mark;
DELIMITER $$
CREATE PROCEDURE remove_mark(IN id VARCHAR(10))
BEGIN
    DECLARE q VARCHAR(100);
    SET q = 'DELETE FROM Ocena WHERE ID_Oceny = ?';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING id;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS remove_note;
DELIMITER $$
CREATE PROCEDURE remove_note(IN id VARCHAR(10))
BEGIN
    DECLARE q VARCHAR(100);
    SET q = 'DELETE FROM Uwaga WHERE ID_Uwagi = ?';
    PREPARE stmnt FROM q;
    EXECUTE stmnt USING id;
    DEALLOCATE PREPARE stmnt;
END $$
DELIMITER ;
