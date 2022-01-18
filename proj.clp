(defglobal ?*pagina_curenta* = 0)
(defglobal ?*listanume* = 0)

/*PENTRU NAVIGARE*/
(deftemplate pagina (slot nr) (slot argument))
(deffacts initializare (pagina(nr nil)(argument nil)))

/*ELEMENTE MUZEU*/
(deftemplate angajat
    (slot nume(type STRING))
    (slot job(type STRING))/*specializarea*/
    (slot an(type INTEGER))/*anul angajarii*/
    (slot tel(type INTEGER))/*nr de telefon*/
)

(deftemplate exponat
    (slot nrinventar(type INTEGER))/*numarul de inventar*/
    (slot locatie(type INTEGER))/*sala in care e expus*/
    (multislot descriere(type STRING))/*descriere*/
)

(deftemplate sala
    (slot nrsala(type INTEGER))/*numarul salii*/
    (slot responsabil(type STRING))/*numele angajatului responsabil*/
    (multislot sectie(type STRING))/*numele sectiei*/
)

(deftemplate tur
    (slot nume(type STRING))/*numarul salii*/
    (slot capacitate(type NUMBER))/*cate persoane incap*/
    (slot ziua(type STRING))/*ziua inceperii*/
    (slot ora(type NUMBER))/*ora inceperii*/
    (slot ghid(type STRING))/*numele ghidului*/
)

(deftemplate tur->sala
    /*arata ce sali sunt vizitate in ce tur*/
    (slot numetur(type STRING))
    (slot nrsala(type INTEGER))
)

/*DATE MUZEU*/
(deffacts angajati "Lista angajatilor" 
    (angajat (nume Ignat)(job arheologie)(an 1986)(tel 0724355577))
    (angajat (nume Petronela)(job arhivistica)(an 2010)(tel 0722321012))
    (angajat (nume Barbu)(job restaurare)(an 1991)(tel 0724911286))
    (angajat (nume Costin)(job conservare)(an 2011)(tel 0731033910))
    (angajat (nume Valeriu)(job cercetare)(an 2018)(tel 0734295112))
    (angajat (nume Constantin)(job arhivistica)(an 1999)(tel 0734233814))
    (angajat (nume Maria)(job cercetare)(an 2013)(tel 0733967142))
    (angajat (nume Ivan)(job director)(an 2000)(tel 0722001040))
    (angajat (nume Marcel)(job securitate)(an 2003)(tel 0734388191))
)

(deffacts exponate "Lista exponatelor" 
    (exponat (nrinventar 1)(locatie 1)(descriere Moneda de argint, BELA al IV-lea))
    (exponat (nrinventar 23)(locatie 61)(descriere Opait cu ulei))
    (exponat (nrinventar 25)(locatie 0)(descriere Chimir otoman, sec. XVI))
    (exponat (nrinventar 21)(locatie 1)(descriere Moneda de argint, BELA al IV-lea))
    (exponat (nrinventar 2)(locatie 1)(descriere Moneda de argint, JOSEPH I))
    (exponat (nrinventar 61)(locatie 21)(descriere Maner de spada, sec. XIV))
    (exponat (nrinventar 84)(locatie 61)(descriere Pipa ornamentata))
    (exponat (nrinventar 22)(locatie 2)(descriere Coif de infanterie, sec. XV))
    (exponat (nrinventar 62)(locatie 21)(descriere Spada de tinuta, sec. XVIII))
    (exponat (nrinventar 24)(locatie 61)(descriere Pipa ornamentata))
    (exponat (nrinventar 30)(locatie 0)(descriere Suport de lumanare ornamentat))
    (exponat (nrinventar 26)(locatie 45)(descriere Cupa de argint, sec. XIV))
    (exponat (nrinventar 32)(locatie 0)(descriere Pistol de buzunar, sec. XIX))
    (exponat (nrinventar 40)(locatie 62)(descriere Baioneta germana))
    (exponat (nrinventar 41)(locatie 63)(descriere Pistol model C96))
)

(deffacts sali "Lista salilor"
    (sala (nrsala 0)(responsabil Marcel)(sectie DEPOZIT))
    (sala (nrsala 1)(responsabil Constantin)(sectie Timisoara medievala))
    (sala (nrsala 2)(responsabil Constantin)(sectie Timisoara medievala))
    (sala (nrsala 21)(responsabil Maria)(sectie Timisoara medievala))
    (sala (nrsala 61)(responsabil Maria)(sectie Perioada otomana))
    (sala (nrsala 62)(responsabil Marcel)(sectie Primul razboi mondial))
    (sala (nrsala 63)(responsabil Marcel)(sectie Primul razboi mondial))
    (sala (nrsala 45)(responsabil Ignat)(sectie Timisoara medievala))
    (sala (nrsala 25)(responsabil Valeriu)(sectie Imperiul Habsburgic))
    (sala (nrsala 24)(responsabil Barbu)(sectie Imperiul Habsburgic))
    (sala (nrsala 46)(responsabil Maria)(sectie Imperiul Habsburgic))
    (sala (nrsala 22)(responsabil Costin)(sectie Perioada otomana))
    (sala (nrsala 23)(responsabil Valeriu)(sectie Perioada otomana))
)

(deffacts tururi_si_sali "fact-uri ajutatoare"
    (tur->sala (numetur Asediul_de_la_1716)(nrsala 23))
    (tur->sala (numetur Asediul_de_la_1716)(nrsala 24))
    (tur->sala (numetur Personalitati_timisorene)(nrsala 2))
    (tur->sala (numetur Personalitati_timisorene)(nrsala 25))
    (tur->sala (numetur Personalitati_timisorene)(nrsala 61))
    (tur->sala (numetur Personalitati_timisorene)(nrsala 62))
    (tur->sala (numetur Viata_in_timisoara_otomana)(nrsala 21))
    (tur->sala (numetur Viata_in_timisoara_otomana)(nrsala 22))
    (tur->sala (numetur Viata_in_timisoara_otomana)(nrsala 25))
)

(deffacts tururi "Lista tururilor"
    (tur (nume Personalitati_timisorene)(capacitate 20)(ziua Miercuri)(ora 12)(ghid Constantin))
    (tur (nume Asediul_de_la_1716)(capacitate 50)(ziua Joi)(ora 13)(ghid Valeriu))
    (tur (nume Viata_in_timisoara_otomana)(capacitate 30)(ziua Sambata)(ora 16)(ghid Costin))
    (tur (nume Revolutia_industriala)(capacitate 30)(ziua Marti)(ora 9)(ghid Valeriu))
)

/*argument: INTEGER*/
/*returneaza diferenta dintre anul curent si anul angajarii*/
(deffunction ani_experienta (?an)
    (return (- (+ 1970 (/ (time) 31556926 )) ?an ))
)

/*regula initiala*/
(defrule meniu
    (pagina (nr nil))
    =>
    (printout t "Selectati optiunea dorita:" crlf
        "0. Iesire" crlf
        "1. Lista angajatilor si experienta lor" crlf
        "2. Angajati experimentati (introd. anii necesari)" crlf
        "3. Lista exponate din depozit" crlf
        "4. Responsabili exponate" crlf
        "5. Nr. de telefon al responsabilului pt. un exponat (introd. nr. de inventar)" crlf
        "6. Exponate vizitate intr-un tur (introd. numele turului)" crlf
        "7. Sali goale" crlf)
    (bind ?r (read))
    (if (or (eq ?r 2) (eq ?r 5))
    	then
        	(assert (pagina (nr ?r)(argument (read))))
        else
        	(assert (pagina (nr ?r)))
     )
)

(defrule lista_angajati
    (pagina (nr 1))
    (angajat (nume ?x)(an ?y)(job ?z))
    =>
    (printout t ?x " (" ?z "), experienta " (integer (ani_experienta ?y)) " ani" crlf)
)

(defrule experimentati
    (pagina (nr 2)(argument ?a))
    (angajat (nume $?x)(an ?y))
    =>
    (if (< ?a (ani_experienta ?y))
    	then
        	(printout t "  CALIFICAT: " ?x ", experienta " (integer (ani_experienta ?y)) " ani" crlf)
        else
        	(printout t "NECALIFICAT: " ?x ", experienta " (integer (ani_experienta ?y)) " ani" crlf)
     )
)

(defrule lista_exponate_depozit
    (pagina (nr 3))
    ?exp<-(exponat {locatie == 0} )
    =>
    (printout t "nr. " ?exp.nrinventar " " ?exp.descriere crlf)
    )

(defrule responsabili
    (pagina (nr 4))
    (angajat (nume ?x))
    (sala (responsabil ?x)(nrsala ?y))
    (exponat (locatie ?y)(descriere $?d))
    =>
    (printout t $?d " -> " ?x crlf)
)

(defrule tel_pt_exponat
    (pagina (nr 5)(argument ?a))
    (angajat (nume ?x)(tel ?y))
    (sala (responsabil ?x)(nrsala ?z))
    (exponat (locatie ?z)(nrinventar ?a)(descriere $?d))
    =>
    (printout t $?d " -> " ?y crlf)
)

(defrule exponat_per_tur
    (pagina (nr 6))
    (tur (nume ?t))
    (tur->sala (numetur ?t)(nrsala ?s))
    (exponat (locatie ?s)(nrinventar ?x)(descriere $?d))
    =>
    (printout t ?t ": nr. " ?x " " $?d crlf)
)

(defrule sali_goale
    (pagina (nr 7))
    ?s<-(sala (nrsala ?n))
    (not(exponat (locatie ?n)))
    =>
    (printout t "nr. " ?s.nrsala " " $?s.sectie crlf)
)

/*(watch facts)*/
/*(watch all)*/
(reset)
/*(facts)*/
(run)