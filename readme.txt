Verna Dorian-Alexandru 334CC
Tema FLEX

Tema am rezolvat-o in doua etape astfel incat sa imi fie mai usor.

1) Prima oara am incercat rezolvarea temei fara cazul in care
exista obiecte compuse
2) Dupa ce am facut pasul 1, am incercat sa adaptez tema pentru
obiecte compuse

La sectiunea de declarari am pus mai multe declarari de variabile.
Am folosit variabile precum count_vertexes, count_textures,
count_faces si count_tabs pentru a numara vertecsii, coordonatele
pt textura, punctele pentru fete si tab-urile cu care indentez (in
cazul in care am obiecte compuse, atunci pe acestea le printez la
un anumit numar de tab-uri). Variabila is_texture o folosesc pentru
a sti daca la obiectul respectiv am descoperit keyword-ul img, caz
in care avem imagine de textura. In momentul cand voi printa
detaliile legate de imaginea de texturare, conditia de a printa
imaginea respectiva sau "fara imagine textura" este data de valoarea
pe care o are variabila data. Mai am si variabila inner_object_found
care indica faptul ca avem sau nu un obiect compus. Sirul image il
folosesc pentru a printa imaginea de textura.

Apoi scriu expresiile regulate pe care le folosesc. Voi scrie
pt ce folosesc fiecare dintre aceste ER in urmatoarele:
1) object_keyword -> pt identificarea sirului "Object"
2) object_name -> pt identificarea numelui obiectului
3) begin_paranthesis -> pt identificarea acoladei care marcheaza
inceputul descrierii unui obiect
4) end_paranthesis -> pt identificarea acoladei care marcheaza
sfarsitul descrierii unui obiect
5) vertexes_keyword -> pt identificarea sirului "vertexes", sa
stiu de unde incep sa numar vertecsii
6) texture_keyword -> pt identificarea sirului "texture", sa
stiu de unde incep sa numar coordonatele de textura
7) faces_keyword -> pt identificarea sirului "faces", sa
stiu de unde incep sa numar fetele
8) img_keyword -> pt identificarea sirului "img", sa
stiu de unde incep sa caut dupa numele imaginii de texturare
9) digit -> pt identificarea unei cifre
10) sign -> pt identificarea semnului + sau -
11) natural_number -> pt identificarea unui nr natural
12) float_number -> pt identificarea unui nr real
13) real_number_0_1 -> pt identificarea unui nr real intre 0 si 1
14) texture_number -> pt identificarea unui numar pt coordonatele
de texturare
15) vertex_cartesian -> pt identificarea coordonatelor carteziene
ale unui vertex
16) vertex_homogenous -> pt identificarea coordonatelor omogene
ale unui vertex
17) face_aux -> ER auxiliara pt face
18) face -> pt a identifica o fata
19) texture_image_name -> pentru a identifica numele unei imagini
de textura (nu contine spatiu sau \n).

Am folosit 7 stari (pe langa INITIAL)
0) INITIAL -> in initial sunt la inceput, trec in MAY_BE_OBJECT_FOUND
daca intalnesc keyword-ul "Object", initializez si variabila prin care
numar tab-urile
1) MAY_BE_OBJECT_FOUND -> daca sunt in aceasta stare si gasesc un nume
valid de obiect, atunci initializez toate celelalte variabile de count,
momentan nu am gasit nicio imagine de textura, deci is_texture = 0,
printez numarul necesar de tab-uri. Printez numele obiectului si apoi
trec in starea in care verific daca pot incepe printarea celorlalte
detalii ale obiectului (CHECK_PARANTHESIS)
2) CHECK_PARANTHESIS -> in aceasta stare verific daca am intalnit o1
acolada care marcheaza inceputul descrierii unui obiect, caz in care
avansez in printarea celorlalte detalii ale obiectului
3) GET_OBJECT_PROPERTIES -> in aceasta stare pot face match pe mai
multe ER. In functie de keyword-ul gasit putem trece in starile:
COUNT_VERTEXES, COUNT_TEXTURES, COUNT_FACES, GET_IMAGE_NAME,
MAY_BE_OBJECT_FOUND, GET_OBJECT_PROPERTIES, INITIAL
Daca inainte gasesc un obiect compus in interiorul acestuia prezent,
atunci printez imaginea de texturare (sau "fara
imagine textura dupa caz") si apoi trec la citirea
obiectului compus.
Daca nu am avut obiect compus si ajung la o acolada de inchidere,
atunci printez imaginea de textura pe care am gasit-o (sau "fara
imagine textura dupa caz")
4) COUNT_VERTEXES -> in starea aceasta numar vertecsii pana ajung la un \n
5) COUNT_TEXTURES -> in starea aceasta numar coordonatele de texturare
pana ajung la un \n
6) COUNT_FACES -> in starea aceasta numar fetele pana ajung la un \n
7) GET_IMAGE_NAME -> in aceasta gasesc imaginea de texturare

In partea de cod ma folosesc de elementele invatate la curs pentru
citirea din mai multe fisiere. Am scris si functia yywrap. M-am
folosit de scheletul dat la curs pentru aceasta citire.

Am luat in considerare observatia pusa pe forum conform careia
obiectele compuse apar la sfarsitul descrierii unui obiect.

Tema am facut-o sub Linux (Ubuntu).

Cel mai greu lucru a fost sa printez imaginea de texturare
atunci cand aveam obiecte compuse (motiv pentru care am folosit
inner_object_found).

Per total a fost o tema ok, consider ca am inteles mai bine elementele
invatate la aceasta materie lucrand la aceasta tema.

Verna Dorian-Alexandru 334CC
