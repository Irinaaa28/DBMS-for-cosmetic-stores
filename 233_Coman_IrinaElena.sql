--Proiect SGBD
--Coman Irina, 233

--ex 4

CREATE SEQUENCE ORAS_SECV START WITH 1;
CREATE SEQUENCE MAGAZIN_SECV START WITH 1;
CREATE SEQUENCE ANGAJAT_SECV START WITH 101;
CREATE SEQUENCE MANAGER_SECV START WITH 1001;
CREATE SEQUENCE FURNIZOR_SECV START WITH 1;
CREATE SEQUENCE PRODUS_SECV START WITH 1;
CREATE SEQUENCE CLIENT_SECV START WITH 1;
CREATE SEQUENCE COMANDA_SECV START WITH 1;
CREATE SEQUENCE VANZARE_SECV START WITH 1;
CREATE SEQUENCE RECEPTIONEAZA_SECV START WITH 1; 
CREATE SEQUENCE LUCREAZA_SECV START WITH 1;      
CREATE SEQUENCE VINDE_SECV START WITH 1;         
CREATE SEQUENCE TRANSPORTATOR_SECV START WITH 1;
CREATE SEQUENCE CATEGORIE_SECV START WITH 1;
CREATE SEQUENCE REVIEW_SECV START WITH 1;

--tabel 1: ORAS
CREATE TABLE ORAS(
    ID_Oras NUMBER(5) CONSTRAINT PK_ORAS PRIMARY KEY,
    Nume_Oras VARCHAR2(100) CONSTRAINT NN_Nume_Oras NOT NULL,
    Regiune VARCHAR2(100),
    Cod_Postal VARCHAR2(10)
);

--tabel 2: MAGAZIN
CREATE TABLE MAGAZIN(
    ID_Magazin NUMBER(5) CONSTRAINT PK_MAGAZIN PRIMARY KEY,
    Nume_Magazin VARCHAR2(100) CONSTRAINT NN_Nume_Magazin NOT NULL,
    Adresa_Magazin VARCHAR2(100),
    ID_Oras NUMBER(5) CONSTRAINT FK_MAGAZIN_ORAS REFERENCES ORAS(ID_Oras)
);

ALTER TABLE MAGAZIN
ADD CONSTRAINT UK_Nume_Magazin UNIQUE (Nume_Magazin);

ALTER TABLE MAGAZIN 
DROP CONSTRAINT FK_MAGAZIN_ORAS;

ALTER TABLE MAGAZIN
ADD CONSTRAINT FK_MAGAZIN_ORAS
FOREIGN KEY (ID_Oras)
REFERENCES ORAS(ID_Oras)
ON DELETE SET NULL;


--tabel 3: MANAGER
CREATE TABLE MANAGER(
    ID_Manager NUMBER(5) CONSTRAINT PK_MANAGER PRIMARY KEY,
    Nume_Manager VARCHAR2(100) CONSTRAINT NN_Nume_Manager NOT NULL,
    Prenume_Manager VARCHAR2(100) CONSTRAINT NN_Prenume_Manager NOT NULL,
    Email_Manager VARCHAR2(100) CONSTRAINT NN_Email_Manager NOT NULL,
    Data_Angajare DATE CONSTRAINT NN_Data_Angajare NOT NULL,
    ID_Magazin NUMBER(5) CONSTRAINT FK_MANAGER_MAGAZIN REFERENCES MAGAZIN(ID_Magazin)
);

ALTER TABLE MANAGER
DROP CONSTRAINT FK_MANAGER_MAGAZIN;

ALTER TABLE MANAGER
ADD CONSTRAINT FK_MANAGER_MAGAZIN
FOREIGN KEY (ID_Magazin)
REFERENCES MAGAZIN(ID_Magazin)
ON DELETE SET NULL;

--tabel 4: ANGAJAT
CREATE TABLE ANGAJAT(
    ID_Angajat NUMBER(5) CONSTRAINT PK_ANGAJAT PRIMARY KEY,
    Nume_Angajat VARCHAR2(100) CONSTRAINT NN_Nume_Angajat NOT NULL,
    Prenume_Angajat VARCHAR2(100) CONSTRAINT NN_Prenume_Angajat NOT NULL,
    Email_Angajat VARCHAR2(100) CONSTRAINT NN_Email_Angajat NOT NULL,
    Data_Angajare_A DATE CONSTRAINT NN_Data_Angajare_A NOT NULL,
    ID_Manager NUMBER(5) CONSTRAINT FK_ANGAJAT_MANAGER REFERENCES MANAGER(ID_Manager)
);

ALTER TABLE ANGAJAT DROP CONSTRAINT FK_ANGAJAT_MANAGER;

ALTER TABLE ANGAJAT
ADD CONSTRAINT FK_ANGAJAT_MANAGER FOREIGN KEY (ID_Manager)
REFERENCES MANAGER(ID_Manager) ON DELETE SET NULL;

--tabel 5:CATEGORIE
CREATE TABLE CATEGORIE(
    ID_Categorie NUMBER(10) CONSTRAINT PK_CATEGORIE PRIMARY KEY,
    Nume_Categorie VARCHAR2(100) CONSTRAINT NN_Nume_Categorie NOT NULL
);

--tabel 6: REVIEW
CREATE TABLE REVIEW(
    ID_Review NUMBER(10) CONSTRAINT PK_REVIEW PRIMARY KEY,
    Tip_Review VARCHAR2(100) CONSTRAINT NN_Tip_Review NOT NULL,
    Nr_Stele NUMBER(10) CONSTRAINT NN_Nr_Stele NOT NULL
);

--tabel 7: PRODUS
CREATE TABLE PRODUS(
    ID_Produs NUMBER(5) CONSTRAINT PK_PRODUS PRIMARY KEY,
    Nume_Produs VARCHAR2(100) CONSTRAINT NN_Nume_Produs NOT NULL,
    Brand VARCHAR2(100),
    Pret NUMBER(10, 2) CONSTRAINT NN_Pret NOT NULL,
    Stoc NUMBER(5) CONSTRAINT NN_Stoc NOT NULL,
    ID_Review NUMBER(10) CONSTRAINT FK_PRODUS_REVIEW REFERENCES REVIEW(ID_Review),
    ID_Categorie NUMBER(10) CONSTRAINT FK_PRODUS_CATEGORIE REFERENCES CATEGORIE(ID_Categorie)
);

ALTER TABLE PRODUS DROP CONSTRAINT FK_PRODUS_CATEGORIE;

ALTER TABLE PRODUS
ADD CONSTRAINT FK_PRODUS_CATEGORIE FOREIGN KEY (ID_Categorie)
REFERENCES CATEGORIE(ID_Categorie) ON DELETE SET NULL;

ALTER TABLE PRODUS DROP CONSTRAINT FK_PRODUS_REVIEW;

ALTER TABLE PRODUS
ADD CONSTRAINT FK_PRODUS_REVIEW FOREIGN KEY (ID_Review)
REFERENCES REVIEW(ID_Review) ON DELETE SET NULL;

--tabel 8: CLIENT
CREATE TABLE CLIENT(
    ID_Client NUMBER(5) CONSTRAINT PK_CLIENT PRIMARY KEY,
    Nume_Client VARCHAR2(100) CONSTRAINT NN_Nume_Client NOT NULL,
    Prenume_Client VARCHAR2(100) CONSTRAINT NN_Prenume_Client NOT NULL
);

--tabel 9: VANZARE
CREATE TABLE VANZARE(
    ID_Vanzare NUMBER(10) CONSTRAINT PK_VANZARE PRIMARY KEY,
    Data_Vanzare DATE CONSTRAINT NN_Data_Vanzare NOT NULL,
    Suma_Totala NUMBER(10, 2) CONSTRAINT NN_Suma_Totala NOT NULL,
    ID_Produs NUMBER(5) CONSTRAINT FK_VANZARE_PRODUS REFERENCES PRODUS(ID_Produs)
);

ALTER TABLE VANZARE
DROP CONSTRAINT FK_VANZARE_PRODUS;

ALTER TABLE VANZARE
ADD CONSTRAINT FK_VANZARE_PRODUS FOREIGN KEY (ID_Produs) 
REFERENCES PRODUS(ID_Produs)ON DELETE SET NULL;

--tabel 10: TRANSPORTATOR
CREATE TABLE TRANSPORTATOR(
    ID_Transportator NUMBER(10) CONSTRAINT PK_TRANSPORTATOR PRIMARY KEY,
    Nume_Transportator VARCHAR2(100) CONSTRAINT NN_Nume_Transportator NOT NULL,
    Email_Transportator VARCHAR2(100),
    Telefon_Transportator VARCHAR2(15)
);

--tabel 11: FURNIZOR
CREATE TABLE FURNIZOR(
    ID_Furnizor NUMBER(10) CONSTRAINT PK_FURNIZOR PRIMARY KEY,
    Nume_Furnizor VARCHAR2(100) CONSTRAINT NN_Nume_Furnizor NOT NULL,
    Adresa_Furnizor VARCHAR2(200),
    Email_Furnizor VARCHAR2(100),
    Telefon VARCHAR2(15)
);

--tabel 12: COMANDA
CREATE TABLE COMANDA(
    ID_Comanda NUMBER(10) CONSTRAINT PK_COMANDA PRIMARY KEY,
    Data_Comanda DATE CONSTRAINT NN_Data_Comanda NOT NULL,
    Data_Livrare DATE,
    Valoare_Totala NUMBER(10, 2),
    ID_Magazin NUMBER(5) CONSTRAINT FK_COMANDA_MAGAZIN REFERENCES MAGAZIN(ID_Magazin),
    ID_Produs NUMBER(5) CONSTRAINT FK_COMANDA_PRODUS REFERENCES PRODUS(ID_Produs),
    ID_Transportator NUMBER(10) CONSTRAINT FK_COMANDA_TRANSPORTATOR REFERENCES TRANSPORTATOR(ID_Transportator)
);

ALTER TABLE COMANDA
DROP CONSTRAINT FK_COMANDA_MAGAZIN;

ALTER TABLE COMANDA
ADD CONSTRAINT FK_COMANDA_MAGAZIN FOREIGN KEY (ID_Magazin) 
REFERENCES MAGAZIN(ID_Magazin)ON DELETE SET NULL;

ALTER TABLE COMANDA
DROP CONSTRAINT FK_COMANDA_PRODUS;

ALTER TABLE COMANDA
ADD CONSTRAINT FK_COMANDA_PRODUS FOREIGN KEY (ID_Produs) 
REFERENCES PRODUS(ID_Produs)ON DELETE SET NULL;

ALTER TABLE COMANDA
DROP CONSTRAINT FK_COMANDA_TRANSPORTATOR;

ALTER TABLE COMANDA
ADD CONSTRAINT FK_COMANDA_TRANSPORTATOR FOREIGN KEY (ID_Transportator) 
REFERENCES TRANSPORTATOR(ID_Transportator)ON DELETE SET NULL;

--tabel 13: LUCREAZA
CREATE TABLE LUCREAZA(
    ID_Angajat NUMBER(5),
    ID_Magazin NUMBER(5),
    Pozitie VARCHAR2(100),
    CONSTRAINT PK_LUCREAZA PRIMARY KEY (ID_Angajat, ID_Magazin),
    CONSTRAINT FK_LUCREAZA_ANGAJAT FOREIGN KEY (ID_Angajat) REFERENCES ANGAJAT(ID_Angajat),
    CONSTRAINT FK_LUCREAZA_MAGAZIN FOREIGN KEY (ID_Magazin) REFERENCES MAGAZIN(ID_Magazin)
);

ALTER TABLE LUCREAZA DROP CONSTRAINT FK_LUCREAZA_ANGAJAT;

ALTER TABLE LUCREAZA
ADD CONSTRAINT FK_LUCREAZA_ANGAJAT FOREIGN KEY (ID_Angajat)
REFERENCES ANGAJAT(ID_Angajat) ON DELETE SET NULL;

ALTER TABLE LUCREAZA DROP CONSTRAINT FK_LUCREAZA_MAGAZIN;

ALTER TABLE LUCREAZA
ADD CONSTRAINT FK_LUCREAZA_MAGAZIN FOREIGN KEY (ID_Magazin)
REFERENCES MAGAZIN(ID_Magazin) ON DELETE SET NULL;

--tabel 14: RECEPTIONEAZA
CREATE TABLE RECEPTIONEAZA(
    ID_Furnizor NUMBER(10),
    ID_Comanda NUMBER(10),
    Data_Primire DATE CONSTRAINT NN_Data_Primire NOT NULL,
    Stare_Comanda VARCHAR2(50),
    Cantitate NUMBER(5),
    CONSTRAINT PK_RECEPTIONEAZA PRIMARY KEY (ID_Furnizor, ID_Comanda),
    CONSTRAINT FK_RECEPTIONEAZA_FURNIZOR FOREIGN KEY (ID_Furnizor) REFERENCES FURNIZOR(ID_Furnizor),
    CONSTRAINT FK_RECEPTIONEAZA_COMANDA FOREIGN KEY (ID_Comanda) REFERENCES COMANDA(ID_Comanda)
);

ALTER TABLE RECEPTIONEAZA DROP CONSTRAINT FK_RECEPTIONEAZA_FURNIZOR;

ALTER TABLE RECEPTIONEAZA
ADD CONSTRAINT FK_RECEPTIONEAZA_FURNIZOR FOREIGN KEY (ID_Furnizor)
REFERENCES FURNIZOR(ID_Furnizor) ON DELETE SET NULL;

ALTER TABLE RECEPTIONEAZA DROP CONSTRAINT FK_RECEPTIONEAZA_COMANDA;

ALTER TABLE RECEPTIONEAZA
ADD CONSTRAINT FK_RECEPTIONEAZA_COMANDA FOREIGN KEY (ID_Comanda)
REFERENCES COMANDA(ID_Comanda) ON DELETE SET NULL;

--tabel 15: VINDE
CREATE TABLE VINDE(
    ID_Angajat NUMBER(5),
    ID_Vanzare NUMBER(10),
    ID_Client NUMBER(5),
    CONSTRAINT PK_VINDE PRIMARY KEY (ID_Angajat, ID_Vanzare, ID_Client),
    CONSTRAINT FK_VINDE_ANGAJAT FOREIGN KEY (ID_Angajat) REFERENCES ANGAJAT(ID_Angajat),
    CONSTRAINT FK_VINDE_VANZARE FOREIGN KEY (ID_Vanzare) REFERENCES VANZARE(ID_Vanzare),
    CONSTRAINT FK_VINDE_CLIENT FOREIGN KEY (ID_Client) REFERENCES CLIENT(ID_Client)
);

ALTER TABLE VINDE DROP CONSTRAINT FK_VINDE_ANGAJAT;

ALTER TABLE VINDE
ADD CONSTRAINT FK_VINDE_ANGAJAT FOREIGN KEY (ID_Angajat)
REFERENCES ANGAJAT(ID_Angajat) ON DELETE SET NULL;

ALTER TABLE VINDE DROP CONSTRAINT FK_VINDE_VANZARE;

ALTER TABLE VINDE
ADD CONSTRAINT FK_VINDE_VANZARE FOREIGN KEY (ID_Vanzare)
REFERENCES VANZARE(ID_Vanzare) ON DELETE SET NULL;

ALTER TABLE VINDE DROP CONSTRAINT FK_VINDE_CLIENT;

ALTER TABLE VINDE
ADD CONSTRAINT FK_VINDE_CLIENT FOREIGN KEY (ID_Client)
REFERENCES CLIENT(ID_Client) ON DELETE SET NULL;


--ex5

--tabel 1: ORAS
INSERT INTO ORAS (ID_Oras, Nume_Oras, Regiune, Cod_Postal) VALUES (2793, 'Bucuresti', 'Muntenia', '302813');
INSERT INTO ORAS (ID_Oras, Nume_Oras, Regiune, Cod_Postal) VALUES (3292, 'Cluj-Napoca', 'Transilvania', '481462');
INSERT INTO ORAS (ID_Oras, Nume_Oras, Regiune, Cod_Postal) VALUES (1761, 'Timisoara', 'Banat', '379430');
INSERT INTO ORAS (ID_Oras, Nume_Oras, Regiune, Cod_Postal) VALUES (3829, 'Iasi', 'Moldova', '705227');
INSERT INTO ORAS (ID_Oras, Nume_Oras, Regiune, Cod_Postal) VALUES (5386, 'Constanta', 'Dobrogea', '947832');

select * from ORAS;

--tabel 2: MAGAZIN
INSERT INTO MAGAZIN (ID_Magazin, Nume_Magazin, Adresa_Magazin, ID_Oras) VALUES (17634, 'Sevora Central', 'Str. Libertatii nr. 12', 2793);
INSERT INTO MAGAZIN (ID_Magazin, Nume_Magazin, Adresa_Magazin, ID_Oras) VALUES (28637, 'Sevora Nord', 'Str. Garii nr. 5', 3292);
INSERT INTO MAGAZIN (ID_Magazin, Nume_Magazin, Adresa_Magazin, ID_Oras) VALUES (34902, 'Sevora Sud', 'Str. Florilor nr. 8', 2793);
INSERT INTO MAGAZIN (ID_Magazin, Nume_Magazin, Adresa_Magazin, ID_Oras) VALUES (47644, 'Sevora Est', 'Str. Mihai Viteazu nr. 20', 5386);
INSERT INTO MAGAZIN (ID_Magazin, Nume_Magazin, Adresa_Magazin, ID_Oras) VALUES (52831, 'Sevora Vest', 'Str. Victoriei nr. 15', 2793);

select * from MAGAZIN;

--tabel 3: MANAGER
INSERT INTO MANAGER (ID_Manager, Nume_Manager, Prenume_Manager, Email_Manager, Data_Angajare, ID_Magazin) 
VALUES (100, 'Popescu', 'Ion', 'ion.popescu@magazin.ro', DATE '2020-01-01', 47644);
INSERT INTO MANAGER (ID_Manager, Nume_Manager, Prenume_Manager, Email_Manager, Data_Angajare, ID_Magazin) 
VALUES (200, 'Ionescu', 'Maria', 'maria.ionescu@magazin.ro', DATE '2020-02-01', 28637);
INSERT INTO MANAGER (ID_Manager, Nume_Manager, Prenume_Manager, Email_Manager, Data_Angajare, ID_Magazin) 
VALUES (300, 'Georgescu', 'Andrei', 'andrei.georgescu@magazin.ro', DATE '2020-03-01', 52831);
INSERT INTO MANAGER (ID_Manager, Nume_Manager, Prenume_Manager, Email_Manager, Data_Angajare, ID_Magazin) 
VALUES (400, 'Vasilescu', 'Elena', 'elena.vasilescu@magazin.ro', DATE '2020-04-01', 17634);
INSERT INTO MANAGER (ID_Manager, Nume_Manager, Prenume_Manager, Email_Manager, Data_Angajare, ID_Magazin) 
VALUES (500, 'Dumitrescu', 'Cristina', 'cristina.dumitrescu@magazin.ro', DATE '2020-05-01', 34902);

select * from MANAGER;

--tabel 4: ANGAJAT
INSERT INTO ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager) VALUES
(101, 'Mihai', 'Alexandru', 'alexandru.mihai@magazin.ro', DATE '2021-01-14', 100);
INSERT INTO ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager) VALUES
(102, 'Popa', 'Roxana', 'roxana.popa@magazin.ro', DATE '2021-02-07', 200);
INSERT INTO ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager) VALUES
(103, 'Stan', 'Daniel', 'daniel.stan@magazin.ro', DATE '2021-03-21', 300);
INSERT INTO ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager) VALUES
(104, 'Iliescu', 'Ioana', 'ioana.iliescu@magazin.ro', DATE '2021-04-20', 400);
INSERT INTO ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager) VALUES
(105, 'Radu', 'Marius', 'marius.radu@magazin.ro', DATE '2021-05-10', 500);
INSERT INTO ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager) VALUES
(106, 'Neagu', 'Adriana', 'adriana.neagu@magazin.ro', DATE '2021-06-24', 300);
INSERT INTO ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager) VALUES
(107, 'Lazar', 'Cosmin', 'cosmin.lazar@magazin.ro', DATE '2021-07-19', 400);
INSERT INTO ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager) VALUES
(108, 'Voicu', 'Gabriel', 'gabriel.voicu@magazin.ro', DATE '2021-08-12', 400);
INSERT INTO ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager) VALUES
(109, 'Marin', 'Ana', 'ana.marin@magazin.ro', DATE '2021-09-21', 200);
INSERT INTO ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager) VALUES
(110, 'Constantin', 'Lucian', 'lucian.constantin@magazin.ro', DATE '2021-10-25', 500);

select * from ANGAJAT;

--tabel 5: CATEGORIE
INSERT INTO CATEGORIE (ID_Categorie, Nume_Categorie) VALUES (11, 'Makeup');
INSERT INTO CATEGORIE (ID_Categorie, Nume_Categorie) VALUES (12, 'Creme fata');
INSERT INTO CATEGORIE (ID_Categorie, Nume_Categorie) VALUES (13, 'Creme corp');
INSERT INTO CATEGORIE (ID_Categorie, Nume_Categorie) VALUES (14, 'Ingrijirea parului');
INSERT INTO CATEGORIE (ID_Categorie, Nume_Categorie) VALUES (15, 'Produse de styling');

select * from CATEGORIE;

--tabel 6: REVIEW
INSERT INTO REVIEW (ID_Review, Tip_Review, Nr_Stele) VALUES (100, 'Foarte rau', 1); 
INSERT INTO REVIEW (ID_Review, Tip_Review, Nr_Stele) VALUES (200, 'Rau', 2); 
INSERT INTO REVIEW (ID_Review, Tip_Review, Nr_Stele) VALUES (300, 'OK', 3); 
INSERT INTO REVIEW (ID_Review, Tip_Review, Nr_Stele) VALUES (400, 'Bun', 4); 
INSERT INTO REVIEW (ID_Review, Tip_Review, Nr_Stele) VALUES (500, 'Foarte bun', 5); 

select * from REVIEW;

--tabel 7: PRODUS
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (15327, 'Fond de ten', 'Estee Lauder', 190.50, 100, 500, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (78432, 'Ruj Color Sensational', 'Maybelline', 40.00, 200, 400, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (31475, 'Mascara Lash Paradise', 'LOreal', 45.75, 150, 500, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (42435, 'Pudra Translucenta', 'Clinique', 130.00, 300, 400, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (53113, 'Paleta de Farduri', 'Urban Decay', 275.00, 250, 400, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (63782, 'Sampon Elseve', 'LOreal', 22.00, 120, 200, 14);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (78245, 'Balsam de Par Hydra Source', 'Biolage', 62.50, 180, 300, 14);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (89213, 'Spray Fixativ Elnett', 'LOreal', 18.00, 140, 500, 15);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (93456, 'Fond de ten Double Wear', 'Estee Lauder', 195.00, 130, 400, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (10234, 'Creion de Ochi Super Liner', 'LOreal', 17.00, 160, 300, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (11324, 'Ruj Matte Ink', 'Maybelline', 35.00, 170, 300, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (12456, 'Paleta de Contur', 'Anastasia Beverly Hills', 245.00, 90, 400, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (13579, 'Ser pentru Par Frizz Ease', 'John Frieda', 125.50, 110, 300, 14);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (14789, 'Mascara Better Than Sex', 'Too Faced', 159.00, 100, 300, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (15987, 'Creion de Sprancene Brow Wiz', 'Anastasia Beverly Hills', 83.00, 130, 100, 11);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (16387, 'Crema de hidratare SPF 50', 'CeraVe', 79.00, 180, 400, 12);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (17443, 'Liftactiv Collagen Specialist', 'Vichy', 130.00, 50, 300, 12);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (18622, 'Revitalift Laser X3', 'LOreal', 90.00, 110, 500, 12);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (19718, 'Dream Coat', 'ColorWow', 160.00, 100, 500, 15);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (20921, 'Spray de par', 'Moroccanoil', 135.00, 60, 200, 15);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (21574, 'Brazilian Bum Bum Cream', 'Sol de Janeiro', 104.00, 140, 300, 13);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (22374, 'Moisturizers', 'CeraVe', 40.00, 100, 400, 13);
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) 
VALUES (23900, 'Lipikar Baume AP+M', 'La Roche-Posay', 130.00, 120, 500, 13);

select * from PRODUS;

--tabel 8: CLIENT
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (1965, 'Moldovan', 'Cristian');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (2439, 'Popescu', 'Alina');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (3576, 'Stan', 'Vasile');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (4920, 'Ionescu', 'Mihaela');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (5864, 'Dumitru', 'Andrei');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (6326, 'Georgescu', 'Elena');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (7983, 'Radu', 'Mihai');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (8028, 'Marin', 'Ana');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (9254, 'Pavel', 'Ioan');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (1029, 'Barbu', 'Laura');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (1123, 'Popa', 'Mirela');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (1239, 'Stefan', 'Daniel');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (1395, 'Andrei', 'Mariana');
INSERT INTO CLIENT (ID_Client, Nume_Client, Prenume_Client) VALUES (1476, 'Pavel', 'Georgiana');

select * from CLIENT;

--tabel 9: VANZARE
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (17854032, DATE '2024-02-01', 62.50, 78245);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (25684596, DATE '2024-02-05', 18.00, 89213);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (32153543, DATE '2024-02-10', 45.75, 31475);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (48046263, DATE '2024-02-15', 125.50, 13579);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (55315628, DATE '2024-02-20', 40.00, 78432);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (63415764, DATE '2024-02-25', 35.00, 11324);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (74523695, DATE '2024-03-01', 245.00, 12456);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (85780893, DATE '2024-03-05', 22.00, 63782);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (94696243, DATE '2024-03-10', 195.00, 93456);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (10826538, DATE '2024-03-15', 190.50, 15327);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (11738684, DATE '2024-12-07', 190.50, 15327);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (12892486, DATE '2025-01-03', 90.0, 18622);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (13674794, DATE '2025-01-05', 40.00, 22374);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (14673574, DATE '2024-11-28', 45.75, 31475);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (15729319, DATE '2024-07-09', 130.00, 17443);
INSERT INTO VANZARE (ID_Vanzare, Data_Vanzare, Suma_Totala, ID_Produs) VALUES (16284030, DATE '2024-08-15', 104.00, 21574);

select * from VANZARE;

--tabel 10: TRANSPORTATOR
INSERT INTO TRANSPORTATOR (ID_Transportator, Nume_Transportator, Email_Transportator, Telefon_Transportator) 
VALUES (143, 'Fan Courier', 'fancourier@gmail.com', '0743956778');
INSERT INTO TRANSPORTATOR (ID_Transportator, Nume_Transportator, Email_Transportator, Telefon_Transportator) 
VALUES (279, 'Sameday', 'sameday@yahoo.com', '0739275438');
INSERT INTO TRANSPORTATOR (ID_Transportator, Nume_Transportator, Email_Transportator, Telefon_Transportator) 
VALUES (339, 'Cargus', 'cargus@gmail.com', '0764975080');
INSERT INTO TRANSPORTATOR (ID_Transportator, Nume_Transportator, Email_Transportator, Telefon_Transportator) 
VALUES (494, 'DPD', 'dpd@gmail.com', '0747356944');
INSERT INTO TRANSPORTATOR (ID_Transportator, Nume_Transportator, Email_Transportator, Telefon_Transportator) 
VALUES (583, 'GLS', 'gls@yahoo.com', '0729385694');

select * from TRANSPORTATOR;

--tabel 11: FURNIZOR
INSERT INTO FURNIZOR (ID_Furnizor, Nume_Furnizor, Adresa_Furnizor, Email_Furnizor, Telefon) VALUES 
(378261, 'Furnizor Makeup', 'Str. Progresului nr. 134', 'contact@furnizormakeup.ro', '0721378261');
INSERT INTO FURNIZOR (ID_Furnizor, Nume_Furnizor, Adresa_Furnizor, Email_Furnizor, Telefon) VALUES 
(402864, 'Furnizor Creme Fata', 'Str. Tudor Vladimirescu nr. 29', 'contact@furnizorcremefata.ro', '0721402864');
INSERT INTO FURNIZOR (ID_Furnizor, Nume_Furnizor, Adresa_Furnizor, Email_Furnizor, Telefon) VALUES 
(729462, 'Furnizor Creme Corp', 'Str. Capitan Aviator Alexandru Serbanescu nr. 50', 'contact@furnizorcremecorp.ro', '0721729462');
INSERT INTO FURNIZOR (ID_Furnizor, Nume_Furnizor, Adresa_Furnizor, Email_Furnizor, Telefon) VALUES 
(382394, 'Furnizor Produse Par', 'Str. Nicolae Caramfil nr. 25', 'contact@furnizorprodusepar.ro', '0721382394');
INSERT INTO FURNIZOR (ID_Furnizor, Nume_Furnizor, Adresa_Furnizor, Email_Furnizor, Telefon) VALUES 
(738621, 'Furnizor Produse Styling', 'Str. Academiei nr. 28', 'contact@furnizorprodusestyling.ro', '0721738621');

select * from FURNIZOR;

--tabel 12: COMANDA
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator)
VALUES (6731983147, DATE '2022-01-15', DATE '2022-01-20', 1050.00, 28637, 78245, 143);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (4729864671, DATE '2022-01-18', DATE '2022-01-23', 4000.00, 34902, 53113, 339);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (3287346409, DATE '2023-01-21', DATE '2023-01-26', 2362.50, 52831, 89213, 494);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (4682289382, DATE '2023-01-25', DATE '2023-01-30', 9000.00, 52831, 42435, 279);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (5643764201, DATE '2023-01-28', DATE '2023-02-02', 6250.00, 47644, 13579, 143);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (6721983197, DATE '2023-02-01', DATE '2023-02-06', 3200.00, 17634, 10234, 583);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (5732964683, DATE '2023-02-03', DATE '2023-02-08', 2750.00, 34902, 31475, 279);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (4987346490, DATE '2023-02-05', DATE '2023-02-10', 3400.00, 17634, 78432, 494);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (4182289352, DATE '2023-02-08', DATE '2023-02-13', 2850.00, 34902, 93456, 143);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (5343764210, DATE '2023-02-10', DATE '2023-02-15', 1500.00, 28637, 11324, 339);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (6021983147, DATE '2024-02-12', DATE '2024-02-17', 4700.00, 47644, 12456, 583);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (5729864672, DATE '2024-02-14', DATE '2024-02-19', 5900.00, 28637, 15327, 143);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (5287346410, DATE '2024-02-16', DATE '2024-02-21', 4100.00, 52831, 63782, 279);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (4782289383, DATE '2024-02-18', DATE '2024-02-23', 3500.00, 17634, 14789, 143);
INSERT INTO COMANDA (ID_Comanda, Data_Comanda, Data_Livrare, Valoare_Totala, ID_Magazin, ID_Produs, ID_Transportator) 
VALUES (5643764211, DATE '2024-02-20', DATE '2024-02-25', 4500.00, 17634, 15987, 339);

select * from COMANDA;

--tabel 13: LUCREAZA
INSERT INTO LUCREAZA (ID_Angajat, ID_Magazin, Pozitie) VALUES (101, 47644, 'Vanzator');
INSERT INTO LUCREAZA (ID_Angajat, ID_Magazin, Pozitie) VALUES (102, 28637, 'Casier');
INSERT INTO LUCREAZA (ID_Angajat, ID_Magazin, Pozitie) VALUES (103, 52831, 'Vanzator');
INSERT INTO LUCREAZA (ID_Angajat, ID_Magazin, Pozitie) VALUES (104, 17634, 'Casier');
INSERT INTO LUCREAZA (ID_Angajat, ID_Magazin, Pozitie) VALUES (105, 34902, 'Vanzator');
INSERT INTO LUCREAZA (ID_Angajat, ID_Magazin, Pozitie) VALUES (106, 52831, 'Casier');
INSERT INTO LUCREAZA (ID_Angajat, ID_Magazin, Pozitie) VALUES (107, 17634, 'Vanzator');
INSERT INTO LUCREAZA (ID_Angajat, ID_Magazin, Pozitie) VALUES (108, 17634, 'Casier');
INSERT INTO LUCREAZA (ID_Angajat, ID_Magazin, Pozitie) VALUES (109, 28637, 'Vanzator');
INSERT INTO LUCREAZA (ID_Angajat, ID_Magazin, Pozitie) VALUES (110, 34902, 'Casier');

select * from LUCREAZA;

--tabel 14: RECEPTIONEAZA
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (729462, 6731983147, DATE '2022-01-15', 'Livrata', 100);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (378261, 4729864671, DATE '2022-01-18', 'Livrata', 200);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (382394, 3287346409, DATE '2023-01-21', 'Livrata', 150);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (402864, 4682289382, DATE '2023-01-25', 'Anulata', 300);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (738621, 5643764201, DATE '2023-01-28', 'Livrata', 250);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (378261, 6721983197, DATE '2023-02-01', 'Livrata', 100);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (729462, 5732964683, DATE '2023-02-03', 'Livrata', 200);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (382394, 4987346490, DATE '2023-02-05', 'Livrata', 150);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (402864, 4182289352, DATE '2023-02-08', 'Anulata', 300);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (738621, 5343764210, DATE '2023-02-10', 'Livrata', 250);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (378261, 6021983147, DATE '2024-02-12', 'Livrata', 100);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (729462, 5729864672, DATE '2024-02-14', 'Anulata', 200);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (402864, 5287346410, DATE '2024-02-16', 'Livrata', 150);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (382394, 4782289383, DATE '2024-02-18', 'Livrata', 250);
INSERT INTO RECEPTIONEAZA (ID_Furnizor, ID_Comanda, Data_Primire, Stare_Comanda, Cantitate) VALUES (738621, 5643764211, DATE '2024-02-20', 'Anulata', 150);

select * from RECEPTIONEAZA;

--tabel 15: VINDE
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (101, 94696243, 3576);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (101, 55315628, 6326);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (102, 32153543, 7983);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (101, 74523695, 1965);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (103, 10826538, 5864);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (109, 48046263, 1029);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (109, 85780893, 8028);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (104, 17854032, 4920);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (104, 25684596, 2439);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (105, 63415764, 9254);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (102, 11738684, 1123);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (107, 12892486, 9254);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (105, 13674794, 1239);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (101, 14673574, 1123);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (104, 15729319, 1395);
INSERT INTO VINDE (ID_Angajat, ID_Vanzare, ID_Client) VALUES (103, 16284030, 1476);

select * from VINDE;

--ex 6
--Sa se creeze o procedura stocata independenta prin care sa se afiseze primele 3 branduri de produse dupa media review-urilor, indiferent de categorie. 
--Daca 2 branduri au aceeasi medie, atunci se vor afisa in ordine descrescatoare dupa numarul de produse vandute ale acestui brand.

set serveroutput on
create or replace procedure branduri3 is

    type t_medie_review is table of number index by varchar2(100);
    medie_review t_medie_review;
    type t_nr_vanzari is table of number index by varchar2(100);
    nr_vanzari t_nr_vanzari;
    type t_branduri is table of varchar2(100);
    branduri t_branduri;
    type t_top3 is varray(5) of varchar2(100);
    top3 t_top3;
    
    cursor c1 is
        select p.Brand brand, avg(r.Nr_Stele) medie
        from PRODUS p join REVIEW r on p.ID_Review = r.ID_Review
        group by p.Brand
        order by medie desc;
    cursor c2 is
        select p.Brand brand, count(v.ID_Vanzare) nrvanzari
        from PRODUS p join VANZARE v on p.ID_Produs = v.ID_Produs(+)
        group by p.Brand;
        
    indexx pls_integer :=1;
    v_brand varchar2(100);
    v_medie number;
    v_nrvanzari number;
    
    type t_combined is record (brand varchar2(100), medie number, nrvanzari number);
    type t_combined_indexed is table of t_combined index by pls_integer;
    combined t_combined_indexed;
    
begin 
    branduri := t_branduri();
    top3 := t_top3();
    combined := t_combined_indexed();
    for i in c1 loop
        branduri.extend;
        branduri(indexx) := i.brand;
        medie_review(i.brand) := i.medie;
        indexx := indexx + 1;
    end loop;
    
    for j in c2 loop
        nr_vanzari(j.brand) := j.nrvanzari;
    end loop;
    
    indexx := 1;
    for i in 1..branduri.count loop
        combined(indexx).brand := branduri(i);
        combined(indexx).medie := medie_review(branduri(i));
        combined(indexx).nrvanzari := nr_vanzari(branduri(i));
        indexx := indexx + 1;
    end loop;
    
    for i in 1..combined.count-1 loop
        for j in i+1..combined.count loop
            if (combined(i).medie < combined(j).medie) or 
            (combined(i).medie = combined(j).medie and combined(i).nrvanzari < combined(j).nrvanzari) then
                declare
                    temp_brand varchar2(100);
                    temp_medie number;
                    temp_nrvanzari number;
                begin
                    temp_brand := combined(i).brand;
                    temp_medie := combined(i).medie;
                    temp_nrvanzari := combined(i).nrvanzari;
                    
                    combined(i).brand := combined(j).brand;
                    combined(i).medie := combined(j).medie;
                    combined(i).nrvanzari := combined(j).nrvanzari;
                    
                    combined(j).brand := temp_brand;
                    combined(j).medie := temp_medie;
                    combined(j).nrvanzari := temp_nrvanzari;
                end;
            end if;
        end loop;
    end loop;
    
    top3 := t_top3(combined(1).brand, combined(2).brand, combined(3).brand);
    dbms_output.put_line('Top 3 branduri:');
    for i in 1..top3.count loop
        dbms_output.put_line('Brand:' || top3(i));
    end loop;
end branduri3;
/

begin
    branduri3;
end;
/
        
--ex 7              
--Sa se creeze o procedura care primeste ca parametru o valoare de tip intreg si care afiseaza mai multe detalii despre angajatul care a 
--avut cele mai multe vanzari, in functie de valoare. Daca valoarea introdusa ca parametru a procedurii este 1, atunci se afiseaza numele 
--clientilor carora acest angajat le-a facut vanzari. Daca valoarea este 2, atunci se afiseaza suma totala a vanzarilor facute de acest 
--angajat. Altfel, se afiseaza toate detaliile despre managerul acestuia.

set serveroutput on
create or replace procedure info_top_ang(indice in number) is

    cursor c_top_ang is
        select a.ID_Angajat, Nume_Angajat, Prenume_Angajat, count(v.ID_Vanzare)
        from ANGAJAT a join VINDE v on a.ID_Angajat = v.ID_Angajat
        group by a.ID_Angajat, Nume_Angajat, Prenume_Angajat
        having count(*) = (select max(count(*))
                            from VINDE
                            group by ID_Angajat);
                            
    cursor c_clienti_vanzari(id_ang in number) is
        select Nume_Client, Prenume_Client, Suma_Totala
        from CLIENT c join VINDE vi on c.ID_Client = vi.ID_Client
                      join ANGAJAT a on a.ID_Angajat = vi.ID_Angajat
                      join VANZARE v on vi.ID_Vanzare = v.ID_Vanzare
        where a.ID_Angajat = id_ang;
        
    cursor c_manager(id_ang in number) is
        select m.ID_Manager, Nume_manager, Prenume_Manager, Email_Manager, Data_Angajare, ID_Magazin
        from MANAGER m join ANGAJAT a on a.ID_Manager = m.ID_Manager
        where a.ID_Angajat = id_ang;
        
    v_id_ang number;
    v_nume_ang varchar2(100);
    v_prenume_ang varchar2(100);
    v_nrvanzari number;
    suma_totala number := 0;
    type rec_info_manager is record(
        id_man MANAGER.ID_Manager%type,
        nume_man MANAGER.Nume_Manager%type,
        prenume_man MANAGER.Prenume_Manager%type,
        email_man MANAGER.Email_Manager%type,
        dataang_man MANAGER.Data_Angajare%type,
        id_mag MANAGER.ID_Magazin%type);
    info_manager rec_info_manager;
    
begin
    open c_top_ang;
    fetch c_top_ang into v_id_ang, v_nume_ang, v_prenume_ang, v_nrvanzari;
    close c_top_ang;
    dbms_output.put_line('Angajatul ' || v_nume_ang || ' ' || v_prenume_ang || ', cu ID-ul ' || v_id_ang || ' a efectuat ' || v_nrvanzari || ' vanzari.');
    if indice = 1 then
        dbms_output.put_line('Clientii angajatului ' || v_nume_ang || ' ' || v_prenume_ang || ':');
        for client in c_clienti_vanzari(v_id_ang) loop
            dbms_output.put_line(client.Nume_Client || ' ' || client.Prenume_Client);
        end loop;
    elsif indice = 2 then
        dbms_output.put_line('Suma totala incasata de ' ||  v_nume_ang || ' ' || v_prenume_ang || ':');
        for v in c_clienti_vanzari(v_id_ang) loop
            suma_totala := suma_totala + v.Suma_Totala;
        end loop;
        dbms_output.put_line(suma_totala);
    else
        open c_manager(v_id_ang);
        fetch c_manager into info_manager.id_man, info_manager.nume_man, info_manager.prenume_man,
        info_manager.email_man, info_manager.dataang_man, info_manager.id_mag;
        close c_manager;
        dbms_output.put_line(info_manager.id_man || ' ' || info_manager.nume_man || ' ' || info_manager.prenume_man || ' ' || 
        info_manager.email_man || ' ' || info_manager.dataang_man || ' ' || info_manager.id_mag);
    end if;
end info_top_ang;
/

begin
    info_top_ang(1);
end;
/
        
begin
    info_top_ang(2);
end;
/       

begin
    info_top_ang(3);
end;
/
        
--ex 8
--Sa se creeze o functie care sa returneze un sir de caractere, ce contine informatii despre managerul care lucreaza într-un magazin 
--situat în orasul cu ID-ul citit de la tastatura, dat ca parametru al functiei. Informatiile ce trebuie sa includa sirul de returnat 
--sunt: ID-ul, numele si prenumele managerului si numele si regiunea orasului în care lucreaza. Sirul de caractere ce va fi returnat 
--de functie va fi de forma 'Managerul cu ID-ul (v_ID_Manager) si numele (v_Nume_Manager,  v_Prenume_Manager) lucreaza in orasul 
--(v_Nume_Oras) din regiunea ( v_Regiune)’.
--Daca în orasul dat nu exista niciun manager, va aparea exceptia NO_DATA_FOUND, iar daca sunt cel putin 2 manageri ce lucreaza în 
--acest oras, va aparea exceptia TOO_MANY_ROWS. De asemenea, se va trata si cazul în care se introduce la tastatura un oras inexistent.

create or replace function info_manager_oras (id_orass in number) 
return varchar2
deterministic
is
    v_ID_Manager MANAGER.ID_Manager%type;
    v_Nume_Manager MANAGER.Nume_Manager%type;
    v_Prenume_Manager MANAGER.Prenume_Manager%type;
    v_Nume_Oras ORAS.Nume_Oras%type;
    v_Regiune ORAS.Regiune%type;
    v_exista_oras number;
    rezultat varchar2(500);
    
begin
    select count(*) 
    into v_exista_oras
    from ORAS
    where ID_Oras = id_orass;

    if v_exista_oras = 0 then
        raise_application_error(-20003, 'Orasul nu exista');
    end if;
    
    select m.ID_Manager, m.Nume_Manager, m.Prenume_Manager, o.Nume_Oras, o.Regiune
    into v_ID_Manager, v_Nume_Manager, v_Prenume_Manager, v_Nume_Oras, v_Regiune
    from MANAGER m join MAGAZIN ma on m.ID_Magazin = ma.ID_Magazin
                    join ORAS o on o.ID_Oras = ma.ID_Oras
    where o.ID_Oras = id_orass;
    
    rezultat := 'Managerul cu ID-ul ' || v_ID_Manager || ' si numele ' || v_Nume_Manager || ' ' || v_Prenume_Manager ||
        ' lucreaza in orasul ' || v_Nume_Oras || ' din regiunea ' || v_Regiune;
    return rezultat;
exception
    when no_data_found then 
        raise_application_error(-20000, 'Nu exista manageri in orasul dat');
    when too_many_rows then 
        raise_application_error(-20001, 'Exista mai multi manageri in orasul dat');
end info_manager_oras;
/

set serveroutput on
declare 
    id_oras ORAS.ID_Oras%type;
begin
    id_oras := &p_id_oras;
    dbms_output.put_line(info_manager_oras(id_oras));
end;
/

    
--ex 9
--Sa se creeze o procedura stocata independenta care, pe baza ID-ului unui produs si a unui numar minim de stele, date ca 
--parametri, sa afiseze numele produsului, brandul produsului, ID-ul comenzii si numele furnizorului în care este implicat 
--produsul respectiv. Aceste informatii se vor afisa doar daca produsul are numarul de stele mai mare sau egal decât cel dat 
--ca parametru în procedura si daca starea comenzii în care este implicat produsul este "Livrata".

create or replace procedure info_prod_com_furn(id_prod number, nrminstele number) is
    v_Nume_produs PRODUS.Nume_Produs%type;
    v_Brand PRODUS.Brand%type;
    v_Nr_Stele REVIEW.Nr_Stele%type;
    v_ID_Comanda COMANDA.ID_Comanda%type;
    v_Nume_Furnizor FURNIZOR.Nume_Furnizor%type;
    v_Stare_Comanda RECEPTIONEAZA.Stare_Comanda%type;
    exista_prod number := 0;
    
    exception_no_product exception;
    exception_lower_than_nrminstele exception;
    exception_no_delivered_order exception;
    exception_lower_than_nrminstele_and_no_delivered_order exception;
    
begin
    select count(*)
    into exista_prod
    from PRODUS
    where ID_Produs = id_prod;
    
    if exista_prod = 0 then
        raise exception_no_product;
    end if;
    
    select p.Nume_Produs, p.Brand, r.Nr_Stele, c.ID_Comanda, rec.Stare_Comanda, f.Nume_Furnizor
    into v_Nume_Produs, v_Brand, v_Nr_Stele, v_ID_Comanda, v_Stare_Comanda, v_Nume_Furnizor
    from COMANDA c right outer join PRODUS p on c.ID_Produs = p.ID_Produs
               join REVIEW r on p.ID_Review = r.ID_Review
               join RECEPTIONEAZA rec on c.ID_Comanda = rec.ID_Comanda
               join FURNIZOR f on rec.ID_Furnizor = f.ID_Furnizor
    where p.ID_Produs = id_prod;
    
    if v_Nr_Stele < nrminstele and v_Stare_Comanda = 'Anulata' then
        raise exception_lower_than_nrminstele_and_no_delivered_order;
    end if;
    
    if v_Nr_Stele < nrminstele then
        raise exception_lower_than_nrminstele;
    end if;
    
    if v_Stare_Comanda = 'Anulata' then
        raise exception_no_delivered_order;
    end if;
    
    dbms_output.put_line('Produsul ' || v_Nume_Produs || ' de la brandul ' || v_Brand || ' se regaseste in comanda cu ID-ul ' || v_ID_Comanda || ' furnizata de ' || v_Nume_Furnizor);
exception
    when exception_no_product then
        raise_application_error(-20000, 'Produsul dat nu exista');
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'Produsul nu este implicat in nicio comanda');
    when exception_lower_than_nrminstele_and_no_delivered_order then
        raise_application_error(-20005, 'Produsul are un numar de stele mai mic decat numarul dat si nu este implicat intr-o comanda livrata');
    when exception_lower_than_nrminstele then
        raise_application_error(-20002, 'Produsul are un numar de stele mai mic decat numarul dat');
    when exception_no_delivered_order then
        raise_application_error(-20003, 'Produsul nu este implicat intr-o comanda livrata');
    when others then
        raise_application_error(-20004, 'Alta eroare');
end info_prod_com_furn;
/

set serveroutput on
begin
    info_prod_com_furn(1, 1);
end;
/

set serveroutput on
begin
    info_prod_com_furn(16387, 1);
end;
/

set serveroutput on
begin
    info_prod_com_furn(10234, 5);
end;
/

set serveroutput on
begin
    info_prod_com_furn(42435, 1);
end;
/

set serveroutput on
begin
    info_prod_com_furn(42435, 5);
end;
/

    
set serveroutput on
begin
    info_prod_com_furn(53113, 3);
end;
/
    
--ex 10 
--Sa se creeze un declansator la nivel de comanda care dupa orice comanda LMD (INSERT, UPDATE sau DELETE) sa afiseze un mesaj
--de tipul „<<Operatia LMD>> a fost realizata cu succes!”.
create or replace trigger afisare_mesaj
    after insert or update or delete on PRODUS
begin
    if inserting then
        dbms_output.put_line('Inserarea a fost realizata cu succes!');
    elsif deleting then
        dbms_output.put_line('Stergerea a fost realizata cu succes!');
    else
        dbms_output.put_line('Actualizarea a fost realizata cu succes!');
    end if;
end afisare_mesaj;
/

set serveroutput on
INSERT INTO PRODUS (ID_Produs, Nume_Produs, Brand, Pret, Stoc, ID_Review, ID_Categorie) VALUES (1, 'Sampon uscat', 'Batiste', 30, 50, 200, 15);

update PRODUS
set Stoc = stoc + 100
where ID_Produs = 1;

delete from PRODUS where ID_Produs = 1;

alter trigger afisare_mesaj disable;

--ex 11
--Sa se defineasca un declansator la nivel de linie care sa nu permita cresterea preturilor produselor care au stocul mai mic sau egal decat 100.
create or replace trigger crestere_pret_interzisa
    before update of Pret on PRODUS
    for each row
    when (NEW.Pret > OLD.Pret)
begin
    if :OLD.Stoc <= 100 then
        raise_application_error(-20010, 'Cresterea pretului unui produs avand stocul cel mult 100 este interzisa');
    end if;
end crestere_pret_interzisa;
/

--Din cele 3 produse, doar produsul cu ID-ul 78432 are stocul > 100.
update PRODUS
set Pret = Pret + 1
where ID_Produs in (15327, 78432, 12456);

update PRODUS
set Pret = Pret + 1
where Stoc > 100;
rollback;

update PRODUS
set Pret = Pret + 1
where Stoc <= 100;

alter trigger crestere_pret_interzisa disable;

--ex 12
--Sa se defineasca un declansator care, in urma unei operatiuni CREATE sau DROP asupra obiectelor din schema, sa afiseze pe ecran
--un mesaj de tipul 'Utilizatorul ... a creat un obiect de tip ... cu numele ...'.

set serveroutput on
create or replace trigger info_create_drop
    after create or drop on schema
declare
    v_event varchar2(50);
    v_object varchar2(50);
    v_obj_type varchar2(50);
    v_user varchar2(50);
begin
    v_event := sys.sysevent;
    v_object := sys.dictionary_obj_name;
    v_obj_type := sys.dictionary_obj_type;
    v_user := sys.login_user;
    
    if v_event = 'CREATE' then
        dbms_output.put_line('Utilizatorul ' || v_user || ' a creat un obiect de tip ' || v_obj_type || ' cu numele ' || v_object);
    elsif v_event = 'DROP' then
        dbms_output.put_line('Utilizatorul ' || v_user || ' a sters un obiect de tip ' || v_obj_type || ' cu numele ' || v_object);
    end if;
end;
/

create table PATRON(
    ID_Patron NUMBER(5),
    Nume_Patron VARCHAR2(100),
    Prenume_Patron VARCHAR2(100)
);

drop table PATRON;

alter trigger info_create_drop disable;

--ex 13
--Sa se defineasca un pachet care sa permita gestiunea angajatilor si a vanzarilor din magazine. Pachetul va contine:
--a. o procedura care determina adaugarea unui angajat, dandu-se informatii complete despre acesta:
--- codul angajatului va fi generat automat utilizându-se o secventa; 
--- informatiile personale vor fi date ca parametri (nume, prenume,  email); 
--- data angajarii va fi data curenta;
--- codul managerului se va obtine cu ajutorul unei functii stocate în pachet care va avea ca parametri numele si prenumele managerului;
--b. o functie ce va returna angajatul cu cea mai mare suma incasata din vanzari; daca exista mai multi angajati cu aceeasi suma, se va alege primul in ordinea alfabetica;
--c. o procedura pentru schimbarea pozitiei angajatului cu cea mai mare suma incasata din vanzari in 'Angajatul lunii';
--d. o functie ce va returna cea mai recenta vanzare facuta de un angajat cu ID-ul dat;
--e. o procedura care determina stergerea unui angajat, dupa un ID dat.
--Pentru fiecare functie si procedura se vor trata toate exceptiile corespunzatoare.


create or replace package gestionare_angajati_vanzari as
    type angajat_vanzari is table of number(5) index by pls_integer;
    type angajat_sters is record (
        id_ang ANGAJAT.ID_Angajat%type,
        nume_ang ANGAJAT.Nume_Angajat%type,
        prenume_ang ANGAJAT.Prenume_Angajat%type,
        email_ang ANGAJAT.Email_Angajat%type
    );
    procedure adauga_angajat (
        nume_ang in ANGAJAT.Nume_Angajat%type, 
        prenume_ang in ANGAJAT.Prenume_Angajat%type, 
        email_ang in ANGAJAT.Email_Angajat%type,
        nume_man in MANAGER.Nume_Manager%type, 
        prenume_man in MANAGER.Prenume_manager%type
    );
    function top_angajat return ANGAJAT.ID_Angajat%type;
    procedure angajatul_lunii (id_ang in ANGAJAT.ID_Angajat%type);
    function cea_mai_recenta_vanzare (id_ang in ANGAJAT.ID_Angajat%type) return VANZARE.ID_Vanzare%type;
    procedure sterge_angajat (id_angg in ANGAJAT.ID_Angajat%type);
end gestionare_angajati_vanzari;
/

create or replace package body gestionare_angajati_vanzari is
    procedure adauga_angajat (
        nume_ang in ANGAJAT.Nume_Angajat%type, 
        prenume_ang in ANGAJAT.Prenume_Angajat%type, 
        email_ang in ANGAJAT.Email_Angajat%type,
        nume_man in MANAGER.Nume_Manager%type, 
        prenume_man in MANAGER.Prenume_manager%type)
    is
        id_angajat ANGAJAT.ID_Angajat%type;
        id_manager ANGAJAT.ID_Manager%type;
    begin
        id_angajat := ANGAJAT_SECV.nextval;
        dbms_output.put_line('ID-ul angajatului generat: ' || id_angajat);
        select ID_Manager into id_manager
        from MANAGER
        where Nume_Manager = nume_man
        and Prenume_Manager = prenume_man;
        dbms_output.put_line('ID-ul managerului obtinut: ' || id_manager);
        insert into ANGAJAT (ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat, Data_Angajare_A, ID_Manager)
        values (id_angajat, nume_ang, prenume_ang, email_ang, sysdate, id_manager);
        dbms_output.put_line('Angajatul a fost adaugat cu succes!');
    exception
        when no_data_found then
            raise_application_error(-20001, 'Managerul nu exista');
        when others then
            raise_application_error(-20002, 'Eroare in adaugarea angajatului');
    end adauga_angajat;
    
    function top_angajat return ANGAJAT.ID_Angajat%type  
    is 
        ang_sum_v angajat_vanzari;
        max_vanzari number := 0;
        top_angajat_id ANGAJAT.ID_Angajat%type;
    begin
        for ang in (
        select a.ID_Angajat, sum(v.Suma_Totala) as Total_Vanzari
        from ANGAJAT a 
        join VINDE vi on a.ID_Angajat = vi.ID_Angajat
        join VANZARE v on vi.ID_Vanzare = v.ID_Vanzare
        group by a.ID_Angajat) loop
            ang_sum_v(ang.ID_Angajat) := ang.Total_Vanzari;
            if ang.Total_Vanzari > max_vanzari then
                max_vanzari := ang.Total_Vanzari;
                top_angajat_id := ang.ID_Angajat;
            end if;
        end loop;
        return top_angajat_id;
    exception
        when no_data_found then
            raise_application_error(-20003, 'Niciun angajat nu a facut o vanzare');
        when others then
            raise_application_error(-20004, 'Alta eroare in gasirea angajatului cu cea mai mare suma incasata in vanzari');
    end top_angajat;
    
    procedure angajatul_lunii (id_ang in ANGAJAT.ID_Angajat%type) is
    begin
        update LUCREAZA
        set Pozitie = 'Angajatul lunii'
        where ID_Angajat = id_ang;
        
        dbms_output.put_line('Angajatul lunii a fost actualizat cu succes');
    exception
        when others then
            raise_application_error(-20005, 'Eroare la actualizarea angajatului lunii');
    end angajatul_lunii;
    
    function cea_mai_recenta_vanzare (id_ang in ANGAJAT.ID_Angajat%type) 
        return VANZARE.ID_Vanzare%type
    is
        id_vanzare_recenta VANZARE.ID_Vanzare%type;
        exceptie_angajatul_nu_exista exception;
        --exceptie_angajatul_nu_a_vandut_nimic exception;
        exista_ang number := 0;
    begin
        select count(*) into exista_ang
        from ANGAJAT 
        where ID_Angajat = id_ang;
        if exista_ang = 0 then
            raise exceptie_angajatul_nu_exista;
        end if;
        
        with vanz_ang as
        (select v.ID_Vanzare, a.ID_Angajat
        from VANZARE v join VINDE vi on v.ID_Vanzare = vi.ID_Vanzare
                       join ANGAJAT a on vi.ID_Angajat = a.ID_Angajat
         where a.ID_Angajat = id_ang
         order by Data_Vanzare desc)
        select va.ID_Vanzare into id_vanzare_recenta
        from vanz_ang va
        where rownum = 1;
        
        return id_vanzare_recenta;
    exception
        when exceptie_angajatul_nu_exista then
            raise_application_error(-20006, 'Angajatul nu exista');
        when no_data_found then
            raise_application_error(-20007, 'Angajatul nu a efectuat nicio vanzare');
        when others then
            raise_application_error(-20008, 'Alta eroare in gasirea celei mai recente vanzari');
    end cea_mai_recenta_vanzare;
    
    procedure sterge_angajat (id_angg in ANGAJAT.ID_Angajat%type) is
        angajat_sters1 angajat_sters;
        exista_ang number := 0;
        exceptie_angajatul_nu_exista exception;
    begin
        select count(*) into exista_ang
        from ANGAJAT 
        where ID_Angajat = id_angg;
        if exista_ang = 0 then
            raise exceptie_angajatul_nu_exista;
        end if;
        
        select ID_Angajat, Nume_Angajat, Prenume_Angajat, Email_Angajat
        into angajat_sters1.id_ang, angajat_sters1.nume_ang, angajat_sters1.prenume_ang, angajat_sters1.email_ang
        from ANGAJAT
        where ID_Angajat = id_angg;
        
        delete from ANGAJAT where ID_Angajat = id_angg;
        
        dbms_output.put_line('Angajatul ' || angajat_sters1.nume_ang || ' ' || angajat_sters1.prenume_ang || 
        ', cu ID-ul ' || angajat_sters1.id_ang || ' si email-ul ' || angajat_sters1.email_ang || ' a fost sters cu succes!');
    exception
        when exceptie_angajatul_nu_exista then
            raise_application_error(-20009, 'Angajatul nu exista');
        when others then
            raise_application_error(-20008, 'Alta eroare in stergerea angajatului');
    end sterge_angajat;
end gestionare_angajati_vanzari;
/

--Cu ajutorul pachetului definit, 
--a1.	sa se adauge angajatul Pop Ion, cu adresa de email popion@gmail.com, aflat sub conducerea managerului Ionescu Maria.
--a2    ce se intampla daca se incearca adaugarea unui angajat cu un manager inexistent?
--b.	Sa se afiseze, cu ajutorul functiei corespunzatoare din pachet, angajatul cu cea mai mare suma incasata din vanzari si sa se schimbe pozitia acestuia in ’Angajatul lunii’.
--c.	Care este cea mai recenta vanzare facuta de angajatul cu ID-ul 101? Dar 108?
--d.	Sa se stearga angajatul introdus in subpunctul a) si sa se afiseze mesajul corespunzator.

drop sequence ANGAJAT_SECV;
CREATE SEQUENCE ANGAJAT_SECV START WITH 200 INCREMENT BY 1;

set serveroutput on
--a1
begin
    gestionare_angajati_vanzari.adauga_angajat('Pop', 'Ion', 'popion@gmail.com', 'Ionescu', 'Maria');
end;
/

--a2
begin
    gestionare_angajati_vanzari.adauga_angajat('Pop', 'Ion', 'popion@gmail.com', 'Ionescuuu', 'Maria');
end;
/


--b
declare
    id_top_angajat ANGAJAT.ID_Angajat%type;
begin
    id_top_angajat := gestionare_angajati_vanzari.top_angajat;
    gestionare_angajati_vanzari.angajatul_lunii(id_top_angajat);
end;
/

select * from LUCREAZA;
--c
declare
    id_vanzare_101 VANZARE.ID_Vanzare%type;
    id_vanzare_108 VANZARE.ID_Vanzare%type;
begin
    id_vanzare_101 := gestionare_angajati_vanzari.cea_mai_recenta_vanzare(101);
    dbms_output.put_line('Cea mai recenta vanzarea a angajatului cu ID-ul 101: ' || id_vanzare_101);
    id_vanzare_108 := gestionare_angajati_vanzari.cea_mai_recenta_vanzare(108);
    dbms_output.put_line('Cea mai recenta vanzarea a angajatului cu ID-ul 108: ' || id_vanzare_108);
end;
/

--d
begin
    gestionare_angajati_vanzari.sterge_angajat(205);
end;
/


    
