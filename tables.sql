-- Autor: Igor Włodarczyk
-- Baza danych: PostgreSQL

CREATE TABLE filie (
    id SERIAL PRIMARY KEY,
    lokalizacja VARCHAR(50)
);

CREATE TABLE wydzialy (
    id VARCHAR(10) DEFAULT ('W' || NEXTVAL('wydzial_id')) PRIMARY KEY,
    nazwa VARCHAR(50)
);

CREATE TABLE prowadzacy (
    id SERIAL PRIMARY KEY,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    data_urodzenia DATE,
    wydzial_id VARCHAR(10) REFERENCES wydzialy(id)
);

CREATE TABLE kierunki (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(50),
    wydzial_id VARCHAR(10) REFERENCES wydzialy(id)
);

CREATE TABLE studenci (
    indeks INT DEFAULT NEXTVAL('indeks') PRIMARY KEY,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    data_urodzenia DATE,
    semestr INT,
    plec VARCHAR(1) CHECK (plec IN ('M', 'K')),
    kierunek_id INT REFERENCES kierunki(id)
);

CREATE TABLE kursy (
    id SERIAL PRIMARY KEY,
    nazwa  VARCHAR(50),
    kierunek_id INT REFERENCES kierunki(id),
    filia_id INT REFERENCES filie(id)
);

CREATE TABLE zapisy (
    id SERIAL PRIMARY KEY,
    kurs_id INT REFERENCES kursy(id),
    student_id INT REFERENCES studenci(indeks)
);

CREATE TABLE oceny (
    id SERIAL PRIMARY KEY,
    ocena FLOAT,
    data_wystawienia DATE,
    zapis_id INT REFERENCES zapisy(id)
);






