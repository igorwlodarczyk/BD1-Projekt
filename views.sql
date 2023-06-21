CREATE VIEW najlepsi_studenci_w4 AS
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

CREATE VIEW kierunki_w4 AS
SELECT nazwa
FROM kierunki
WHERE wydzial_id = 'W4';

CREATE VIEW prowadzacy_wiek AS
SELECT imie, nazwisko, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_urodzenia) AS wiek
FROM prowadzacy
ORDER BY wiek DESC;

