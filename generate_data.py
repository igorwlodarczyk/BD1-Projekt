import random
from const import (
    imiona_meskie,
    imiona_zenskie,
    nazwiska_zenskie,
    nazwiska_meskie,
    kursy,
)

sql_file = open("load_data.sql", "w")

liczba_wydzialow = 11
lista_wydzialow = [f"W{i}" for i in range(1, liczba_wydzialow + 1)]

plcie = ["M", "K"]


def generowanie_daty(zakres_lat: tuple) -> str:
    rok = random.randint(zakres_lat[0], zakres_lat[1])
    miesiac = random.randint(1, 12)
    if miesiac < 10:
        miesiac = "0" + str(miesiac)
    dzien = random.randint(1, 27)
    if dzien < 10:
        dzien = "0" + str(dzien)
    return f"{rok}-{miesiac}-{dzien}"


# generowanie prowadzacych
liczba_prowadzacych = 113
zakres_lat_prowadzacych = (1961, 1990)
for _ in range(liczba_prowadzacych):
    plec = random.choice(plcie)
    data_urodzenia = generowanie_daty(zakres_lat_prowadzacych)
    wydzial = random.choice(lista_wydzialow)
    if plec == "M":
        imie = random.choice(imiona_meskie)
        nazwisko = random.choice(nazwiska_meskie)
    else:
        imie = random.choice(imiona_zenskie)
        nazwisko = random.choice(nazwiska_zenskie)

    polecenie = "INSERT INTO prowadzacy (imie, nazwisko, data_urodzenia, wydzial_id)\n"
    polecenie += f"VALUES ('{imie}', '{nazwisko}', '{data_urodzenia}', '{wydzial}');\n"
    sql_file.write(polecenie)

# generowanie studentow
liczba_studentow = 8251
liczba_kierunkow = 31
zakres_lat_studentow = (1995, 2004)
for _ in range(liczba_studentow):
    plec = random.choice(plcie)
    data_urodzenia = generowanie_daty(zakres_lat_studentow)
    kierunek = random.randint(1, liczba_kierunkow)
    if plec == "M":
        imie = random.choice(imiona_meskie)
        nazwisko = random.choice(nazwiska_meskie)
    else:
        imie = random.choice(imiona_zenskie)
        nazwisko = random.choice(nazwiska_zenskie)
    semestr = random.randint(1, 7)
    polecenie = "INSERT INTO studenci (imie, nazwisko, data_urodzenia, semestr, plec, kierunek_id)\n"
    polecenie += f"VALUES ('{imie}', '{nazwisko}', '{data_urodzenia}', {semestr}, '{plec}', {kierunek});\n"
    sql_file.write(polecenie)

# generowanie kursow
liczba_kursow = 6500
for _ in range(liczba_kursow):
    if random.random() < 0.8:
        filia = 1
    else:
        filia = random.randint(2, 3)
    nazwa_kursu = random.choice(kursy) + " " + str(random.randint(1, 2))
    kierunek = random.randint(1, liczba_kierunkow)
    polecenie = "INSERT INTO kursy (nazwa, kierunek_id, filia_id)\n"
    polecenie += f"VALUES ('{nazwa_kursu}', {kierunek}, {filia});\n"
    sql_file.write(polecenie)


# generowanie zapisow
liczba_zapisow = 13 * liczba_studentow
for _ in range(liczba_zapisow):
    kurs_id = random.randint(1, liczba_kursow)
    student_id = random.randint(269999 - liczba_studentow + 1, 269999)
    polecenie = "INSERT INTO zapisy (kurs_id, student_id)\n"
    polecenie += f"VALUES ({kurs_id}, {student_id});\n"
    sql_file.write(polecenie)

# generowanie ocen
oceny = (2, 3, 3.5, 4, 4.5, 5, 5.5)
for zapis in range(1, liczba_zapisow + 1):
    ocena = random.choice(oceny)
    rok = "2023"
    dzien = random.randint(10, 23)
    miesiac = "06"
    data = f"{rok}-{miesiac}-{dzien}"
    polecenie = "INSERT INTO oceny (ocena, data_wystawienia, zapis_id)\n"
    polecenie += f"VALUES ({ocena}, '{data}', {zapis});\n"
    sql_file.write(polecenie)

sql_file.close()
