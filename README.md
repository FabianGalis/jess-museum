# JessMuseum
O aplicație pentru gestionarea unui muzeu de istorie, scris în Jess rule engine.

## Template-uri / Fapte
Template-urile din această aplicație sunt concepute în așa fel încât fiecare slot să fie utilizat într-un fel sau altul.
Bineînțeles că se pot adăuga ulterior slot-uri suplimentare cu scop pur informativ, fără a "strica" programul.


### pagina
Este un fapt ajutător care face posibilă navigarea în aplicație, mai exact selectarea facilităților acesteia de către utilizator.
Când este cazul, poate să conțină și un "argument". (când e nevoie de transmiterea de date suplimentare pentru o anumită funcționalitate)

### angajat
Reprezintă un angajat al muzeului și conține numele, specializarea (job-ul), anul angajării și un număr de telefon.

### exponat
Descrie un obiect cu un număr de inventar unic, expus într-o anumită locație.
Conține și un multislot pentru descrierea exponatului.

### sala
Muzeul este împărțit în săli, fiecare sală făcând parte dintr-o secție, iar numărul sălii corespunde cu locația unui exponat.
Fiecare sală are câte un angajat responsabil, deci conține și câmpul cu numele persoanei responsabile.

### tur
Fiecare sală poate fi vizitată în contextul unui tur și fiecare tur are un nume, un ghid, o capacitate și ziua și ora la care are loc.

### tur->sala
Face legătura între săli și tururi, arătând ce sală este vizitată în intermediul cărui tur.

## Reguli
Fiecare regulă corespunde unei funcționalități, selectate din regula inițială "meniu".


### meniu
De aici, utilizatorul poate să introducă un număr corespunzător opțiunii alese, și, ulterior, un argument specific dacă e cazul.

### lista_angajati
Pentru a vizualiza toți angajații muzeului se utilizează regula aceasta.
În plus față de faptele care descriu lista angajaților, există și o funcție care calculează anii de experiență. Conceptul acesta va fi relevant pentru următoarea regulă.

### experimentati
Dacă apare o provocare adevărată pentru muzeu, se pot găsi angajați experimentați prin a impune o limită de ani de experiență.
Se va afișa o listă a angajaților alături de calificarea lor pentru această provocare.

### lista_exponate_depozit
Sala numărul 0 este marcată prin convenție ca depozit, iar prin această regulă se poate verifica ce obiecte nu sunt încă expuse.

### responsabili
Este o regulă care afișează o listă completă a exponatelor, alături de numele persoanelor responsabile pentru fiecare în parte.
(responsabilii pe săli sunt responsabilii tuturor obiectelor expuse în acele săli)

### tel_pt_exponat
În cazul în care un exponat specific are o problemă sau trebuie inspectat, se poate folosi această regulă care indică direct numărul de telefon al persoanei responsabile.

### exponat_per_tur
Afișează ce exponate sunt vizitate în intermediul cărui tur.

### sali_goale
Tot în scop organizatoric, se pot afișa toate sălile care nu sunt folosite încă.
