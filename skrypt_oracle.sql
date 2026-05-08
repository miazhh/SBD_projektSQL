-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-05-29 19:30:18.471

-- tables
-- Table: Klient
CREATE TABLE Klient (
    ID_klienta integer  NOT NULL,
    ID_osoby integer  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (ID_klienta)
) ;

-- Table: Material
CREATE TABLE Material (
    ID_materialu integer  NOT NULL,
    nazwa varchar2(30)  NOT NULL,
    typ varchar2(30)  NOT NULL,
    producent varchar2(30)  NOT NULL,
    cena_jednostkowa number(10,2)  NOT NULL,
    CONSTRAINT Material_pk PRIMARY KEY (ID_materialu)
) ;

-- Table: Ocena_klienta
CREATE TABLE Ocena_klienta (
    ID_oceny integer  NOT NULL,
    ID_zlecenia integer  NOT NULL,
    ocena number(1,0)  NOT NULL,
    komentarz varchar2(100)  NOT NULL,
    data_oceny date  NOT NULL,
    CONSTRAINT Ocena_klienta_pk PRIMARY KEY (ID_oceny)
) ;

-- Table: Osoba
CREATE TABLE Osoba (
    ID_osoby integer  NOT NULL,
    imie varchar2(20)  NOT NULL,
    nazwisko varchar2(20)  NOT NULL,
    email varchar2(30)  NOT NULL,
    telefon varchar2(20)  NOT NULL,
    CONSTRAINT Osoba_pk PRIMARY KEY (ID_osoby)
) ;

-- Table: Pojazd
CREATE TABLE Pojazd (
    ID_pojazdu integer  NOT NULL,
    marka varchar2(20)  NOT NULL,
    model varchar2(20)  NOT NULL,
    rok_produkcji number(4,0)  NOT NULL,
    nr_rejestracyjny varchar2(15)  NOT NULL,
    ID_wlasciciela integer  NOT NULL,
    CONSTRAINT nr_rejestracyjny UNIQUE (nr_rejestracyjny),
    CONSTRAINT Pojazd_pk PRIMARY KEY (ID_pojazdu)
) ;

-- Table: Pracownik
CREATE TABLE Pracownik (
    ID_pracownika integer  NOT NULL,
    ID_osoby integer  NOT NULL,
    stanowisko varchar2(20)  NOT NULL,
    pensja number(10,2)  NOT NULL,
    ID_przelozonego integer  NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (ID_pracownika)
) ;

-- Table: Usluga
CREATE TABLE Usluga (
    ID_uslugi integer  NOT NULL,
    nazwa varchar2(40)  NOT NULL,
    opis varchar2(100)  NOT NULL,
    szacowany_czas_trwania number(4,0)  NOT NULL,
    cena_bazowa number(10,2)  NOT NULL,
    CONSTRAINT Usluga_pk PRIMARY KEY (ID_uslugi)
) ;

-- Table: Zespol_Uslugi
CREATE TABLE Zespol_Uslugi (
    ID_zlecenia integer  NOT NULL,
    ID_uslugi integer  NOT NULL,
    ID_pracownika integer  NOT NULL,
    CONSTRAINT Zespol_Uslugi_pk PRIMARY KEY (ID_zlecenia,ID_uslugi,ID_pracownika)
) ;

-- Table: Zlecenie
CREATE TABLE Zlecenie (
    ID_zlecenia integer  NOT NULL,
    data_zlecenia date  NOT NULL,
    data_realizacji date  NULL,
    status varchar2(20)  NOT NULL,
    uwagi varchar2(100)  NULL,
    ID_pojazdu integer  NOT NULL,
    CONSTRAINT Zlecenie_pk PRIMARY KEY (ID_zlecenia)
) ;

-- Table: Zlecenie_Material
CREATE TABLE Zlecenie_Material (
    ID_materialu integer  NOT NULL,
    ID_zlecenia integer  NOT NULL,
    ilosc_uzyta number(10,2)  NOT NULL,
    CONSTRAINT Zlecenie_Material_pk PRIMARY KEY (ID_materialu,ID_zlecenia)
) ;

-- Table: Zlecenie_Usluga
CREATE TABLE Zlecenie_Usluga (
    ID_zlecenia integer  NOT NULL,
    ID_uslugi integer  NOT NULL,
    cena_koncowa number(10,2)  NOT NULL,
    czas_rzeczywisty number(4,0)  NOT NULL,
    CONSTRAINT Zlecenie_Usluga_pk PRIMARY KEY (ID_zlecenia,ID_uslugi)
) ;

-- foreign keys
-- Reference: Klient_Osoba (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Osoba
    FOREIGN KEY (ID_osoby)
    REFERENCES Osoba (ID_osoby);

-- Reference: Ocena_klienta_Zlecenie (table: Ocena_klienta)
ALTER TABLE Ocena_klienta ADD CONSTRAINT Ocena_klienta_Zlecenie
    FOREIGN KEY (ID_zlecenia)
    REFERENCES Zlecenie (ID_zlecenia);

-- Reference: Pojazd_Klient (table: Pojazd)
ALTER TABLE Pojazd ADD CONSTRAINT Pojazd_Klient
    FOREIGN KEY (ID_wlasciciela)
    REFERENCES Klient (ID_klienta);

-- Reference: Pracownik_Osoba (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Osoba
    FOREIGN KEY (ID_osoby)
    REFERENCES Osoba (ID_osoby);

-- Reference: Pracownik_Pracownik (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Pracownik
    FOREIGN KEY (ID_przelozonego)
    REFERENCES Pracownik (ID_pracownika);

-- Reference: Zespol_Uslugi_Pracownik (table: Zespol_Uslugi)
ALTER TABLE Zespol_Uslugi ADD CONSTRAINT Zespol_Uslugi_Pracownik
    FOREIGN KEY (ID_pracownika)
    REFERENCES Pracownik (ID_pracownika);

-- Reference: Zespol_Uslugi_Zlecenie_Usluga (table: Zespol_Uslugi)
ALTER TABLE Zespol_Uslugi ADD CONSTRAINT Zespol_Uslugi_Zlecenie_Usluga
    FOREIGN KEY (ID_zlecenia,ID_uslugi)
    REFERENCES Zlecenie_Usluga (ID_zlecenia,ID_uslugi);

-- Reference: Zlecenie_Material_Material (table: Zlecenie_Material)
ALTER TABLE Zlecenie_Material ADD CONSTRAINT Zlecenie_Material_Material
    FOREIGN KEY (ID_materialu)
    REFERENCES Material (ID_materialu);

-- Reference: Zlecenie_Material_Zlecenie (table: Zlecenie_Material)
ALTER TABLE Zlecenie_Material ADD CONSTRAINT Zlecenie_Material_Zlecenie
    FOREIGN KEY (ID_zlecenia)
    REFERENCES Zlecenie (ID_zlecenia);

-- Reference: Zlecenie_Pojazd (table: Zlecenie)
ALTER TABLE Zlecenie ADD CONSTRAINT Zlecenie_Pojazd
    FOREIGN KEY (ID_pojazdu)
    REFERENCES Pojazd (ID_pojazdu);

-- Reference: Zlecenie_Usluga_Usluga (table: Zlecenie_Usluga)
ALTER TABLE Zlecenie_Usluga ADD CONSTRAINT Zlecenie_Usluga_Usluga
    FOREIGN KEY (ID_uslugi)
    REFERENCES Usluga (ID_uslugi);

-- Reference: Zlecenie_Usluga_Zlecenie (table: Zlecenie_Usluga)
ALTER TABLE Zlecenie_Usluga ADD CONSTRAINT Zlecenie_Usluga_Zlecenie
    FOREIGN KEY (ID_zlecenia)
    REFERENCES Zlecenie (ID_zlecenia);




INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (1, 'Jan', 'Kowalski', 'jan.kowalski@gmail.com', '987456123');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (2, 'Anna', 'Nowak', 'anna.nowak@wp.pl', '097253678');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (3, 'Piotr', 'Wiśniewski', 'piotr.wisniewski@onet.pl', '125345987');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (4, 'Maria', 'Zielińska', 'maria.zielinska@gmail.com', '567987125');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (5, 'Tomasz', 'Wójcik', 'tomasz.wojcik@o2.pl', '653897823');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (6, 'Katarzyna', 'Krawczyk', 'katarzyna.krawczyk@gmail.com', '512345678');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (7, 'Michał', 'Dąbrowski', 'michal.dabrowski@interia.pl', '600700800');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (8, 'Barbara', 'Lewandowska', 'barbara.lewandowska@wp.pl', '701801901');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (9, 'Adam', 'Zając', 'adam.zajac@o2.pl', '789123456');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (10, 'Ewa', 'Szymańska', 'ewa.szymanska@wp.pl', '321654987');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (11, 'Krzysztof', 'Król', 'krzysztof.krol@outlook.com', '654789321');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (12, 'Agnieszka', 'Wieczorek', 'agnieszka.wieczorek@interia.pl', '888999000');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (13, 'Paweł', 'Jankowski', 'pawel.jankowski@gmail.com', '997665443');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (14, 'Magdalena', 'Mazur', 'magdalena.mazur@onet.pl', '908070605');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (15, 'Robert', 'Kubiak', 'robert.kubiak@o2.pl', '776655443');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (16, 'Aleksandra', 'Pawlak', 'aleksandra.pawlak@wp.pl', '612345987');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (17, 'Mateusz', 'Ziółkowski', 'mateusz.ziolkowski@gmail.com', '741852963');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (18, 'Natalia', 'Górska', 'natalia.gorska@interia.pl', '852963741');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (19, 'Jakub', 'Sikora', 'jakub.sikora@outlook.com', '963852741');
INSERT INTO OSOBA (ID_osoby, imie, nazwisko, email, telefon) VALUES (20, 'Dorota', 'Witkowska', 'dorota.witkowska@o2.pl', '700600500');


INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (1, 3, 'Mechanik', 4500.00, NULL);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (2, 4, 'Elektryk', 4700.00, 1);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (3, 5, 'Diagnosta', 4800.00, 1);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (4, 11, 'Recepcjonista', 3900.00, 1);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (5, 12, 'Kierownik', 6000.00, NULL);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (6, 13, 'Asystent', 3500.00, 5);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (7, 14, 'Magazynier', 4000.00, 5);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (8, 15, 'Informatyk', 5500.00, 5);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (9, 16, 'Księgowy', 5000.00, 5);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (10, 17, 'HR', 4300.00, 5);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (11, 18, 'Sprzątacz', 3200.00, 5);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (12, 19, 'Logistyk', 4600.00, 5);
INSERT INTO Pracownik (ID_pracownika, ID_osoby, stanowisko, pensja, ID_przelozonego) VALUES (13, 20, 'Specjalista BHP', 5100.00, 5);


INSERT INTO Klient (ID_klienta, ID_osoby) VALUES (1, 1);
INSERT INTO Klient (ID_klienta, ID_osoby) VALUES (2, 2);
INSERT INTO Klient (ID_klienta, ID_osoby) VALUES (3, 3);
INSERT INTO Klient (ID_klienta, ID_osoby) VALUES (4, 4);
INSERT INTO Klient (ID_klienta, ID_osoby) VALUES (5, 5);
INSERT INTO Klient (ID_klienta, ID_osoby) VALUES (6, 6);
INSERT INTO Klient (ID_klienta, ID_osoby) VALUES (7, 7);
INSERT INTO Klient (ID_klienta, ID_osoby) VALUES (8, 8);
INSERT INTO Klient (ID_klienta, ID_osoby) VALUES (9, 9);
INSERT INTO Klient (ID_klienta, ID_osoby) VALUES (10, 10);


INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (1, 'Toyota', 'Corolla', 2015, 'WX12345', 5);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (2, 'Ford', 'Focus', 2016, 'GA45678', 1);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (3, 'Mazda', '3', 2017, 'KR78901', 9);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (4, 'Skoda', 'Octavia', 2020, 'LU23456', 3);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (5, 'Volkswagen', 'Golf', 2018, 'PO67890', 5);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (6, 'Hyundai', 'i30', 2014, 'EL34567', 2);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (7, 'Kia', 'Ceed', 2021, 'KT90123', 10);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (8, 'Opel', 'Astra', 2019, 'BI56789', 1);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (9, 'Renault', 'Clio', 2013, 'DL43210', 4);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (10, 'Seat', 'Leon', 2016, 'ZS10987', 5);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (11, 'Fiat', 'Tipo', 2020, 'WX99999', 6);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (12, 'Citroen', 'C4', 2019, 'GA11111', 8);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (13, 'Peugeot', '208', 2015, 'KR22222', 9);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (14, 'Nissan', 'Qashqai', 2022, 'LU33333', 7);
INSERT INTO Pojazd (ID_pojazdu, marka, model, rok_produkcji, nr_rejestracyjny, ID_wlasciciela) VALUES (15, 'Dacia', 'Duster', 2018, 'PO44444', 10);


INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa) VALUES (1, 'Oklejanie samochodu', 'Folia ochronna PPF lub zmiana koloru', 480, 3500.00);
INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa) VALUES (2, 'Detailing zewnętrzny', 'Czyszczenie karoserii, felg i powłoka ceramiczna', 240, 1200.00);
INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa) VALUES (3, 'Detailing wewnętrzny', 'Dokładne czyszczenie wnętrza i impregnacja', 180, 800.00);
INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa) VALUES (4, 'Detailing combo', 'Pakiet zewnętrzny i wewnętrzny', 360, 1800.00);
INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa) VALUES (5, 'Renowacja lakieru', 'Polerowanie lakieru i usuwanie rys', 300, 1400.00);
INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa) VALUES (6, 'Pranie tapicerki', 'Pranie materiałowej lub skórzanej tapicerki', 150, 600.00);
INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa) VALUES (7, 'Dezynfekcja wnętrza', 'Ozonowanie i usuwanie zapachów', 90, 300.00);
INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa) VALUES (8, 'Czyszczenie silnika', 'Mycie komory silnika bezpiecznymi środkami', 60, 250.00);
INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa) VALUES (9, 'Woskowanie', 'Ręczne lub maszynowe woskowanie karoserii', 120, 400.00);
INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa) VALUES (10, 'Aplikacja powłoki ceramicznej', 'Trwała ochrona lakieru', 300, 2000.00);


INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (1, 'Folia PPF', 'Folia ochronna', '3M', 120.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (2, 'Folia winylowa', 'Folia kolorowa', 'Avery Dennison', 90.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (3, 'Pasta polerska', 'Polerowanie', 'Menzerna', 65.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (4, 'Gąbka polerska', 'Akcesoria', 'Flexipads', 30.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (5, 'Powłoka ceramiczna', 'Ochrona lakieru', 'Gtechniq', 250.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (6, 'Płyn do felg', 'Czyszczenie', 'Koch Chemie', 40.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (7, 'APC', 'Uniwersalny środek', 'Shiny Garage', 35.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (8, 'Cleaner', 'Przygotowanie lakieru', 'Soft99', 55.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (9, 'Mikrofibra', 'Akcesoria', 'Work Stuff', 15.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (10, 'Wosk syntetyczny', 'Ochrona lakieru', 'Collinite', 80.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (11, 'Wosk naturalny', 'Ochrona lakieru', 'Swissvax', 150.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (12, 'Środek do tapicerki', 'Czyszczenie wnętrza', 'Tenzi', 25.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (13, 'Impregnat do skóry', 'Pielęgnacja skóry', 'Poorboy’s', 60.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (14, 'Płyn do szyb', 'Czyszczenie', 'Meguiar’s', 20.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (15, 'Płyn do plastiku', 'Czyszczenie wnętrza', 'Detailink', 22.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (16, 'Płyn do silnika', 'Mycie silnika', 'Astonish', 28.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (17, 'Ozonator wkład', 'Ozonowanie', 'O3Tech', 75.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (18, 'Środek antybakteryjny', 'Dezynfekcja', 'Karcher', 33.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (19, 'Detailer spray', 'Wykończenie', 'Auto Finesse', 45.00);
INSERT INTO Material (ID_materialu, nazwa, typ, producent, cena_jednostkowa) VALUES (20, 'Iron remover', 'Dekontaminacja', 'Bilt Hamber', 55.00);


INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (1, TO_DATE('2024-01-10', 'YYYY-MM-DD'), TO_DATE('2024-01-11', 'YYYY-MM-DD'), 'Zrealizowane', NULL, 1);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (2, TO_DATE('2024-02-15', 'YYYY-MM-DD'), TO_DATE('2024-02-17', 'YYYY-MM-DD'), 'Zrealizowane', 'Powłoka ceramiczna', 2);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (3, TO_DATE('2024-03-20', 'YYYY-MM-DD'), NULL, 'W toku', 'Pranie wnętrza', 3);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (4, TO_DATE('2024-03-22', 'YYYY-MM-DD'), NULL, 'Oczekujące', NULL, 3);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (5, TO_DATE('2024-04-05', 'YYYY-MM-DD'), TO_DATE('2024-04-06', 'YYYY-MM-DD'), 'Zrealizowane', NULL, 4);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (6, TO_DATE('2024-04-10', 'YYYY-MM-DD'), NULL, 'Oczekujące', NULL, 5);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (7, TO_DATE('2024-04-15', 'YYYY-MM-DD'), NULL, 'Oczekujące', NULL, 6);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (8, TO_DATE('2024-04-20', 'YYYY-MM-DD'), TO_DATE('2024-04-21', 'YYYY-MM-DD'), 'Zrealizowane', 'Silnik czyszczony', 7);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (9, TO_DATE('2024-04-23', 'YYYY-MM-DD'), TO_DATE('2024-04-24', 'YYYY-MM-DD'), 'Zrealizowane', NULL, 8);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (10, TO_DATE('2024-05-01', 'YYYY-MM-DD'), NULL, 'W toku', NULL, 9);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (11, TO_DATE('2024-05-05', 'YYYY-MM-DD'), NULL, 'Oczekujące', 'Klient prosił o telefon', 9);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (12, TO_DATE('2024-05-10', 'YYYY-MM-DD'), NULL, 'Oczekujące', NULL, 10);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (13, TO_DATE('2024-05-12', 'YYYY-MM-DD'), NULL, 'W toku', NULL, 11);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (14, TO_DATE('2024-05-14', 'YYYY-MM-DD'), NULL, 'Oczekujące', NULL, 12);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (15, TO_DATE('2024-05-15', 'YYYY-MM-DD'), NULL, 'W toku', 'Zlecenie ekspresowe', 13);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (16, TO_DATE('2024-05-18', 'YYYY-MM-DD'), NULL, 'Oczekujące', NULL, 14);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (17, TO_DATE('2024-05-20', 'YYYY-MM-DD'), NULL, 'Oczekujące', NULL, 15);
INSERT INTO Zlecenie (ID_zlecenia, data_zlecenia, data_realizacji, status, uwagi, ID_pojazdu) VALUES (18, TO_DATE('2024-05-21', 'YYYY-MM-DD'), NULL, 'Oczekujące', 'Nowy klient', 1);


INSERT INTO Zlecenie_Usluga VALUES (1, 1, 3600.00, 490);
INSERT INTO Zlecenie_Usluga VALUES (2, 10, 2100.00, 310);
INSERT INTO Zlecenie_Usluga VALUES (3, 3, 850.00, 190);
INSERT INTO Zlecenie_Usluga VALUES (4, 6, 620.00, 160);
INSERT INTO Zlecenie_Usluga VALUES (4, 7, 310.00, 95);
INSERT INTO Zlecenie_Usluga VALUES (5, 2, 1250.00, 250);
INSERT INTO Zlecenie_Usluga VALUES (6, 8, 260.00, 65);
INSERT INTO Zlecenie_Usluga VALUES (7, 4, 1850.00, 370);
INSERT INTO Zlecenie_Usluga VALUES (8, 5, 1500.00, 310);
INSERT INTO Zlecenie_Usluga VALUES (9, 2, 1200.00, 240);
INSERT INTO Zlecenie_Usluga VALUES (9, 10, 2200.00, 320);
INSERT INTO Zlecenie_Usluga VALUES (10, 9, 430.00, 125);
INSERT INTO Zlecenie_Usluga VALUES (11, 3, 790.00, 170);
INSERT INTO Zlecenie_Usluga VALUES (12, 6, 590.00, 140);
INSERT INTO Zlecenie_Usluga VALUES (13, 7, 300.00, 90);
INSERT INTO Zlecenie_Usluga VALUES (14, 4, 1800.00, 360);
INSERT INTO Zlecenie_Usluga VALUES (15, 2, 1150.00, 230);
INSERT INTO Zlecenie_Usluga VALUES (16, 3, 800.00, 180);
INSERT INTO Zlecenie_Usluga VALUES (17, 1, 3400.00, 470);
INSERT INTO Zlecenie_Usluga VALUES (18, 8, 255.00, 60);
INSERT INTO Zlecenie_Usluga VALUES (18, 9, 420.00, 130);


INSERT INTO Zespol_Uslugi VALUES (1, 1, 1);
INSERT INTO Zespol_Uslugi VALUES (1, 1, 2);
INSERT INTO Zespol_Uslugi VALUES (1, 1, 3);
INSERT INTO Zespol_Uslugi VALUES (1, 1, 4);
INSERT INTO Zespol_Uslugi VALUES (2, 10, 5);
INSERT INTO Zespol_Uslugi VALUES (3, 3, 6);
INSERT INTO Zespol_Uslugi VALUES (3, 3, 7);
INSERT INTO Zespol_Uslugi VALUES (4, 6, 8);
INSERT INTO Zespol_Uslugi VALUES (4, 7, 9);
INSERT INTO Zespol_Uslugi VALUES (5, 2, 10);
INSERT INTO Zespol_Uslugi VALUES (5, 2, 11);
INSERT INTO Zespol_Uslugi VALUES (6, 8, 12);
INSERT INTO Zespol_Uslugi VALUES (7, 4, 13);
INSERT INTO Zespol_Uslugi VALUES (7, 4, 1);
INSERT INTO Zespol_Uslugi VALUES (7, 4, 2);
INSERT INTO Zespol_Uslugi VALUES (8, 5, 3);
INSERT INTO Zespol_Uslugi VALUES (9, 2, 4);
INSERT INTO Zespol_Uslugi VALUES (9, 2, 5);
INSERT INTO Zespol_Uslugi VALUES (9, 10, 6);
INSERT INTO Zespol_Uslugi VALUES (10, 9, 7);
INSERT INTO Zespol_Uslugi VALUES (11, 3, 8);
INSERT INTO Zespol_Uslugi VALUES (11, 3, 9);
INSERT INTO Zespol_Uslugi VALUES (12, 6, 10);
INSERT INTO Zespol_Uslugi VALUES (13, 7, 11);
INSERT INTO Zespol_Uslugi VALUES (14, 4, 12);
INSERT INTO Zespol_Uslugi VALUES (14, 4, 13);
INSERT INTO Zespol_Uslugi VALUES (15, 2, 1);
INSERT INTO Zespol_Uslugi VALUES (15, 2, 2);
INSERT INTO Zespol_Uslugi VALUES (16, 3, 3);
INSERT INTO Zespol_Uslugi VALUES (16, 3, 4);
INSERT INTO Zespol_Uslugi VALUES (16, 3, 5);
INSERT INTO Zespol_Uslugi VALUES (17, 1, 6);
INSERT INTO Zespol_Uslugi VALUES (17, 1, 7);
INSERT INTO Zespol_Uslugi VALUES (17, 1, 8);
INSERT INTO Zespol_Uslugi VALUES (17, 1, 9);
INSERT INTO Zespol_Uslugi VALUES (18, 8, 10);
INSERT INTO Zespol_Uslugi VALUES (18, 9, 11);


INSERT INTO Zlecenie_Material VALUES (1, 1, 5.00);
INSERT INTO Zlecenie_Material VALUES (2, 1, 3.00);
INSERT INTO Zlecenie_Material VALUES (9, 1, 2.00);
INSERT INTO Zlecenie_Material VALUES (5, 2, 1.00);
INSERT INTO Zlecenie_Material VALUES (8, 2, 0.50);
INSERT INTO Zlecenie_Material VALUES (9, 2, 1.00);
INSERT INTO Zlecenie_Material VALUES (7, 3, 1.50);
INSERT INTO Zlecenie_Material VALUES (12, 3, 2.00);
INSERT INTO Zlecenie_Material VALUES (9, 3, 1.00);
INSERT INTO Zlecenie_Material VALUES (12, 4, 2.50);
INSERT INTO Zlecenie_Material VALUES (17, 4, 1.00);
INSERT INTO Zlecenie_Material VALUES (18, 4, 0.50);
INSERT INTO Zlecenie_Material VALUES (3, 5, 2.00);
INSERT INTO Zlecenie_Material VALUES (4, 5, 2.00);
INSERT INTO Zlecenie_Material VALUES (9, 5, 1.00);
INSERT INTO Zlecenie_Material VALUES (16, 6, 1.20);
INSERT INTO Zlecenie_Material VALUES (9, 6, 0.80);
INSERT INTO Zlecenie_Material VALUES (3, 7, 2.00);
INSERT INTO Zlecenie_Material VALUES (4, 7, 2.00);
INSERT INTO Zlecenie_Material VALUES (7, 7, 1.50);
INSERT INTO Zlecenie_Material VALUES (12, 7, 2.00);
INSERT INTO Zlecenie_Material VALUES (9, 7, 2.00);
INSERT INTO Zlecenie_Material VALUES (3, 8, 3.00);
INSERT INTO Zlecenie_Material VALUES (4, 8, 2.50);
INSERT INTO Zlecenie_Material VALUES (8, 8, 1.00);
INSERT INTO Zlecenie_Material VALUES (9, 8, 1.50);
INSERT INTO Zlecenie_Material VALUES (3, 9, 2.00);
INSERT INTO Zlecenie_Material VALUES (4, 9, 1.50);
INSERT INTO Zlecenie_Material VALUES (5, 9, 1.00);
INSERT INTO Zlecenie_Material VALUES (8, 9, 0.80);
INSERT INTO Zlecenie_Material VALUES (9, 9, 2.00);
INSERT INTO Zlecenie_Material VALUES (10, 10, 1.00);
INSERT INTO Zlecenie_Material VALUES (9, 10, 0.50);
INSERT INTO Zlecenie_Material VALUES (7, 11, 1.00);
INSERT INTO Zlecenie_Material VALUES (12, 11, 1.50);
INSERT INTO Zlecenie_Material VALUES (9, 11, 0.80);
INSERT INTO Zlecenie_Material VALUES (12, 12, 1.80);
INSERT INTO Zlecenie_Material VALUES (9, 12, 1.00);
INSERT INTO Zlecenie_Material VALUES (17, 13, 1.00);
INSERT INTO Zlecenie_Material VALUES (18, 13, 0.50);
INSERT INTO Zlecenie_Material VALUES (3, 14, 2.00);
INSERT INTO Zlecenie_Material VALUES (4, 14, 1.50);
INSERT INTO Zlecenie_Material VALUES (7, 14, 1.20);
INSERT INTO Zlecenie_Material VALUES (12, 14, 1.80);
INSERT INTO Zlecenie_Material VALUES (9, 14, 2.00);
INSERT INTO Zlecenie_Material VALUES (3, 15, 2.00);
INSERT INTO Zlecenie_Material VALUES (4, 15, 1.50);
INSERT INTO Zlecenie_Material VALUES (9, 15, 1.00);
INSERT INTO Zlecenie_Material VALUES (7, 16, 1.00);
INSERT INTO Zlecenie_Material VALUES (12, 16, 1.50);
INSERT INTO Zlecenie_Material VALUES (9, 16, 1.00);
INSERT INTO Zlecenie_Material VALUES (1, 17, 4.00);
INSERT INTO Zlecenie_Material VALUES (2, 17, 3.00);
INSERT INTO Zlecenie_Material VALUES (9, 17, 2.00);
INSERT INTO Zlecenie_Material VALUES (16, 18, 1.00);
INSERT INTO Zlecenie_Material VALUES (10, 18, 1.00);
INSERT INTO Zlecenie_Material VALUES (9, 18, 1.50);


INSERT INTO Ocena_klienta VALUES (1, 1, 5, 'Rewelacyjna jakość oklejania! Polecam każdemu.', TO_DATE('2024-01-13', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (2, 2, 5, 'Lakier błyszczy jak nowy, obsługa wzorowa.', TO_DATE('2024-02-18', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (3, 3, 5, 'Wnętrze wyczyszczone perfekcyjnie, zero zastrzeżeń.', TO_DATE('2024-03-25', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (4, 4, 5, 'Pełna dezynfekcja i tapicerka jak nowa. Super.', TO_DATE('2024-03-28', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (5, 5, 5, 'Szybko, dokładnie i zgodnie z oczekiwaniami.', TO_DATE('2024-04-07', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (6, 6, 5, 'Silnik czysty jak z fabryki. Efekt wow!', TO_DATE('2024-04-12', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (7, 7, 5, 'Zestaw usług detailingowych wykonany wzorowo.', TO_DATE('2024-04-16', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (8, 8, 5, 'Lakier odnowiony perfekcyjnie. Widać doświadczenie.', TO_DATE('2024-04-22', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (9, 9, 5, 'Usługa powłoki ceramicznej spełniła oczekiwania.', TO_DATE('2024-04-26', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (10, 10, 5, 'Auto jak z salonu – bardzo polecam!', TO_DATE('2024-05-02', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (11, 11, 3, 'Detaling wewnętrzny ok, ale mogło być dokładniej.', TO_DATE('2024-05-08', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (12, 12, 3, 'Usługa zgodna z opisem, ale bez efektu wow.', TO_DATE('2024-05-13', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (13, 13, 3, 'Wnętrze czyste, choć zapach pozostał nieprzyjemny.', TO_DATE('2024-05-15', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (14, 14, 3, 'OK, ale za długo trwało i brak kontaktu.', TO_DATE('2024-05-16', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (15, 15, 1, 'Lakier niedokładnie wypolerowany, dużo hologramów.', TO_DATE('2024-05-17', 'YYYY-MM-DD'));
INSERT INTO Ocena_klienta VALUES (16, 16, 1, 'Auto odebrane brudne. Nie polecam.', TO_DATE('2024-05-18', 'YYYY-MM-DD'));

COMMIT;

---------------------


--1). Policz i wypisz, ilu jest pracowników na podanym stanowisku

CREATE OR REPLACE PROCEDURE z1(nazwa_stanowiska VARCHAR)
AS
    ile INT;
BEGIN
    SELECT COUNT(*) INTO ile
    FROM Pracownik
    WHERE stanowisko = nazwa_stanowiska;

    dbms_output.put_line('Liczba pracownikow na stanowisku ' || nazwa_stanowiska || ': ' || ile);
END;

--test
BEGIN
z1('Mechanik');
END;
----------------------

--2). Zablokuj możliwość dodawania nowych ocen

CREATE OR REPLACE TRIGGER z2
BEFORE INSERT
ON Ocena_klienta
BEGIN
    raise_application_error(-20500, 'Dodawanie ocen nie jest możliwe');
END;

--test
INSERT INTO Ocena_klienta (ID_oceny, ID_zlecenia, ocena, komentarz, data_oceny) VALUES (999, 1, 5, 'Test blokady', SYSDATE);
-------------------

--3). Stwórz procedurę, która przyjmie numer zlecenia (ID). Jeśli zlecenie nie istnieje, wypisz komunikat. W przeciwnym razie zaktualizuj to zlecenie: ustaw status na 'Zrealizowane', a datę realizacji na bieżącą datę

CREATE OR REPLACE PROCEDURE z3(nr_zlecenia INT)
AS
    ile INT;
BEGIN
    SELECT COUNT(*) INTO ile
    FROM Zlecenie
    WHERE ID_zlecenia = nr_zlecenia;

    IF ile = 0 THEN
        dbms_output.put_line('Zlecenie o podanym numerze nie istnieje');
    ELSE
        UPDATE Zlecenie
        SET status = 'Zrealizowane',
            data_realizacji = SYSDATE
        WHERE ID_zlecenia = nr_zlecenia;

        dbms_output.put_line('Zlecenie nr ' || nr_zlecenia || ' zostalo zakończone.');
    END IF;
END;

--test
UPDATE Zlecenie
SET status = 'W toku', data_realizacji = NULL
WHERE ID_zlecenia = 4;

SELECT ID_zlecenia, status, data_realizacji FROM Zlecenie WHERE ID_zlecenia = 4;

BEGIN
    z3(4);
END;

SELECT ID_zlecenia, status, data_realizacji FROM Zlecenie WHERE ID_zlecenia = 4;
------------------

--4). Stwórz wyzwalacz, który nie pozwoli usunąć usługi, nie pozwoli dodać usługi z ceną 0 lub niższą oraz nie pozwoli na modyfikację nazwy usług.

CREATE OR REPLACE TRIGGER z4
BEFORE INSERT OR UPDATE OR DELETE
ON Usluga
FOR EACH ROW
BEGIN
    IF DELETING THEN
        raise_application_error(-20500, 'Nie mozna usuwac uslug');
    ELSIF INSERTING THEN
        IF :NEW.cena_bazowa <= 0 THEN
            raise_application_error(-20500, 'Cena uslugi musi byc wieksza od 0');
        END IF;
    ELSE
        IF :OLD.nazwa != :NEW.nazwa THEN
            raise_application_error(-20500, 'Nie mozna zmieniac nazwy uslugi');
        END IF;
    END IF;
END;

--test
DELETE FROM Usluga WHERE ID_uslugi = 1;

INSERT INTO Usluga (ID_uslugi, nazwa, opis, szacowany_czas_trwania, cena_bazowa)
VALUES (999, 'Darmowa myjnia', 'Test', 10, 0);

UPDATE Usluga SET nazwa = 'Nowa nazwa' WHERE ID_uslugi = 1;

--5). Stwórz procedurę do przyznawania podwyżki, która przyjmie ID pracownika i kwotę. Jeśli pracownik nie istnieje wypisz komunikat.

CREATE OR REPLACE PROCEDURE z5(id_prac INT, kwota INT)
AS
    ile INT;
BEGIN
    SELECT COUNT(*) INTO ile
    FROM Pracownik
    WHERE ID_pracownika = id_prac;

    IF ile = 0 THEN
        dbms_output.put_line('Nie ma pracownika o podanym ID');
    ELSE
        UPDATE Pracownik
        SET pensja = pensja + kwota
        WHERE ID_pracownika = id_prac;

        dbms_output.put_line('Przyznano podwyzke w wysokosci: ' || kwota);
    END IF;
END;

--test

BEGIN
    z5(111, 500);
END;

--6). Stwórz wyzwalacz, który przy modyfikacji danych pracownika zadba, aby nowa pensja nie była mniejsza od starej. Jeśli ktoś spróbuje obniżyć pensję, zostanie zachowana stara wartość.

CREATE OR REPLACE TRIGGER z6
BEFORE UPDATE
ON Pracownik
FOR EACH ROW
BEGIN
    IF :NEW.pensja < :OLD.pensja THEN
        :NEW.pensja := :OLD.pensja;
    END IF;
END;

--test
SELECT pensja FROM Pracownik WHERE ID_pracownika = 2;

UPDATE Pracownik SET pensja = 100 WHERE ID_pracownika = 2;

SELECT pensja FROM Pracownik WHERE ID_pracownika = 2;