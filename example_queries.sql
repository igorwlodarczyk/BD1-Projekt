-- Autor: Igor Włodarczyk
-- Baza danych: PostgreSQL

-- Zapytanie wylicza średnią ocen poszczególnego studenta
SELECT s.indeks, s.imie, s.nazwisko, ROUND(AVG(o.ocena)::numeric, 2) AS srednia_ocen
FROM studenci s
JOIN zapisy z ON s.indeks = z.student_id
JOIN oceny o ON z.id = o.zapis_id
GROUP BY s.indeks, s.imie, s.nazwisko
ORDER BY srednia_ocen DESC;

-- Zapytanie wylicza liczbę studentek na każdym wydziale
SELECT COUNT(*) AS liczba_studentek, w.id AS wydzial
FROM studenci s
JOIN kierunki k ON s.kierunek_id = k.id
JOIN wydzialy w ON k.wydzial_id = w.id
WHERE s.plec = 'K'
GROUP BY w.id
ORDER BY liczba_studentek DESC;

-- Zapytanie wylicza % kobiet na uczelni
SELECT ROUND((COUNT(*) FILTER (WHERE plec = 'K') * 100.0) / COUNT(*), 2) AS procent_kobiet
FROM studenci;

-- Zapytanie wylicza % studentek na każdym wydziale
SELECT (COUNT(*) FILTER (WHERE plec = 'K') * 100 / COUNT(*)) AS procent_studentek, w.id AS wydzial
FROM studenci s
JOIN kierunki k ON s.kierunek_id = k.id
JOIN wydzialy w ON k.wydzial_id = w.id
GROUP BY w.id
ORDER BY procent_studentek DESC;

-- Zapytanie pokazuje 10 studentów z najlepszą średnią z wydziału W4
SELECT s.indeks, s.imie, s.nazwisko, ROUND(AVG(o.ocena)::numeric, 2) AS srednia_ocen
FROM studenci s
JOIN zapisy z ON s.indeks = z.student_id
JOIN oceny o ON z.id = o.zapis_id
JOIN kierunki k ON s.kierunek_id = k.id
JOIN wydzialy w ON k.wydzial_id = w.id
WHERE w.id = 'W4'
GROUP BY s.indeks, s.imie, s.nazwisko
ORDER BY srednia_ocen DESC
LIMIT 10;

-- Zapytanie pokazuje wszystkie kierunki na wydziale W4
SELECT nazwa
FROM kierunki
WHERE wydzial_id = 'W4';

-- Zapytanie pokazuje wszystkich prowadzących wraz z ich wiekiem
SELECT imie, nazwisko, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_urodzenia) AS wiek
FROM prowadzacy
ORDER BY wiek DESC;

-- Zapytanie oblicza liczbę osób zapisanych na kurs
SELECT COUNT(*) AS liczba_osob, k.nazwa AS nazwa_kursu, kierunki.nazwa AS kierunek
FROM zapisy z 
JOIN kursy k ON z.kurs_id = k.id
JOIN kierunki ON k.kierunek_id = kierunki.id
GROUP BY k.id, kierunki.nazwa;

-- Zapytanie oblicza liczbę kursów dostępnych w poszczególnych filiach
SELECT COUNT(*) AS liczba_kursow, f.lokalizacja
FROM kursy k
JOIN filie f ON f.id = k.filia_id
GROUP BY f.lokalizacja
ORDER BY liczba_kursow DESC; 

-- Zapytanie oblicza liczbę ocen 2.0 u każdego studenta
SELECT s.indeks, s.imie, s.nazwisko, COUNT(*) AS liczba_niezaliczonych_kursow
FROM oceny o
JOIN zapisy z ON o.zapis_id = z.id
JOIN studenci s ON z.student_id = s.indeks
WHERE o.ocena = 2
GROUP BY s.indeks, s.imie, s.nazwisko
ORDER BY liczba_niezaliczonych_kursow DESC;

-- Zapytanie pokazuje kierunki, które mają ponad 500 zapisanych studentów
SELECT k.nazwa, COUNT(*) AS liczba_studentow
FROM studenci s
JOIN kierunki k ON s.kierunek_id = k.id
GROUP BY k.nazwa
HAVING COUNT(*) > 500
ORDER BY liczba_studentow DESC;

-- Zapytanie pokazuje, liczbę studentów na poszczególnych semestrach
SELECT semestr, COUNT(*) AS liczba_studentow
FROM studenci
GROUP BY semestr
ORDER BY semestr ASC;
