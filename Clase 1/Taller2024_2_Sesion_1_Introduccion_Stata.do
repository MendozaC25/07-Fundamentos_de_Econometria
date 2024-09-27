/*---------------------------
----QLAB - PUCP -------------
-- Taller de reforzamiento y-
-- nivelación de Econometría-
-- y aplicaciones con Stata--
-----------------------------
---- Sesión 1 ---------------
-- Introducción a Stata -----
-----------------------------
-- César Mora - 2024 --------
-----------------------------*/


* Cargamos la base de datos de ejemplo en la web llamada "auto" que incluye información sobre autos usados
webuse auto, clear

* Revisar las diversas ventanas de Stata con la base de datos cargada

** Ver el actual directorio de trabajo:
cd

* Cambiar de directorio por la carpeta en la que se encuentran las bases de datos:
cd "...."


/* Comentarios como este pueden ser escritos 
   en varias líneas
   sin necesidad de colocar asteriscos en cada línea */
  
/*---------------------------------
-- Importación de bases de datos --
---------------------------------*/

* Cargando base en formato Stata desde el disco duro:
use "hsfemale", clear

* Limpiando la memoria del programa (cuando ya se tiene cargada una base de datos)
clear

* Cargando base en formato Stata desde la web:
use https://stats.idre.ucla.edu/stat/data/hs0,clear

* Guardamos la base datos en nuestro disco duro
save "nueva_base"

* Si queremos reemplazarla (sobreescribirla), simplemente usamos la opción "replace"
save "mi_primera_base",replace


* Cargando un excel:
import excel using "hs0_excel.xlsx",sheet("Hoja1") firstrow  clear

* Cargando un csv:
import delimited using "hs0.csv", clear

** Guardandolo como base de Stata:
save "hs0_stata"


/*---------------------------------
-- Help files----------------------
---------------------------------*/

* Revisar el help para el comando "summarize"
help summarize

* Volviendo al ejemplo de la base de estudiantes:
use https://stats.idre.ucla.edu/stat/data/hs0,clear 

* Summarize para todas las variables
summarize

* Summarize para variables elegidas (usando la abreviatura "summ")
summ read write

* Summarize con detalles adicionales:
summ read write, detail

/*---------------------------------
-- Visualizando la información-----
---------------------------------*/

* browse de la base cargada
browse

* Lista de todas las variables y observaciones
list

* Lista de read y write para las primeras cinco observaciones:
li read write in 1/5

* Lista de science para las últimas 3 observaciones:
li science in -5/L

** Opción if:

* Lista de read y write para los casos en elos que write sea mayor a 65
list read write if write>65

* Browse de variables gender, ses y read para mujeres (gender=2) con un puntaje de read mayor a 70
browse gender ses read if gender == 2 & read > 70 

* Browse de variables gender, ses y read para hombres (gender=1) con un puntaje de read mayor a 70 y de math mayor a 50 en simultáneo:
browse gender ses read math if gender == 1 & read > 70 & math>50	

* Summarize y el uso de if para diferenciar la media de "math" entre hombres y mujeres
summ write math
summ write math if gender==1
summ write math if gender==2

summ read if race==4
summ read if race==3

/* EJERCICIO:

Use la base de datos de ejemplo con información socioeconómica de estudiantes y su rendimiento académico llamada hs0, la cual puede abrir con el siguiente comando: use https://stats.idre.ucla.edu/stat/data/hs0 

	*Explore la base de datos y determina cuántas observaciones tiene y cuántas variables
	browse
	
	*¿Cuántas variables son etiquetadas, y cuántas son de tipo string (texto)
	browse
	* 2 etiquetadas, y 1 string
	
	*Haz un browse de la información de estudiantes con puntajes de “read” y “math” mayores a 65 por separado y en simultáneo.
	
	browse read math if read>65
	browse read math if math>65
	browse read math if read>65 & math>65
	
	*Muestra en la pantalla principal de Stata a las observaciones entre las filas 20 y 35 para las variables “read” y “math”
	
	list read math in 20/35
	
	
*/

/*---------------------------------
-- Explorando mis datos -----------
---------------------------------*/

* Abrimos la base nuevamente:
use https://stats.idre.ucla.edu/stat/data/hs0, clear

* Inspección con codebook (general, y de variables seleccionadas)
codebook
codebook read gender prgtype

* Resumen estadístico con summarize (general y para dos variables elegidas):
summarize
summ read math

* Resumen detallado de read para mujeres (gender=2):
summarize read if gender == 2, detail

*Tabulación de las frecuencias de estatus socioeconómico (ses):
tabulate ses

* Tabulación sin etiquetas:
tab ses, nolabel

* Tabulación cruzada entre race y ses (observar frecuencias):
tab race ses 

* con porcentajes por fila (row)
tab race ses, row
* con porcentajes por columna (col)
tab race ses, col
* con porcentajes por fila y columna 
tab race ses, row col

/* EJERCICIO:
Usando la base de datos del ejercicio anterior (hs0) explore:

	* ¿Cuántas persona de raza (race) white hay en la base de datos?
	* ¿Cuál es la etiqueta para el sector socioeconómico (ses) high?
	* ¿Cuántos estudiantes de raza blanca llevan el programa (prgtype) general?
	* Encuentre el promedio de notas de “math” para los estudiantes de raza (race) blanca (white) y de estado socioeconómico (ses) alto (high)
	* Encuentre el promedio de notas de “read” para los estudiantes que llevan el programa (prgtype) académico (academic)
*/

/*---------------------------------
-- Visualización de datos ---------
---------------------------------*/

* Histograma de write
histogram write

* Histograma de write con densidad normal e intervalos de largo 7
hist write, normal width(7)

* Boxplot de algunas notas (analizar)
graph box read write math science
** version horizontal:
graph box read write math science socst, horizontal

* Scatter plot de math y science
scatter math science

* Gráfico de barras de frecuencia según tipo de programa (prgtype):
graph bar (count), over(prgtype)

* Gráfico de barras de frecuencia según género (gender):
graph bar (count), over(gender) 

* Gráfico superpuesto de scatter plot y curva suavizada:
scatter write read
lowess write read
twoway (scatter write read) (lowess write read)

/* EJERCICIO:
Usando la base de datos del ejercicio anterior (hs0):

	* Realice un gráfico de scatter y determine la relación entre dos notas de su elección (read, write, math, etc.)
	* Para el gráfico anterior, cambie los marcadores de scatter por triángulos en vez de círculos (usar help para saber cómo hacerlo)
	* Realice un gráfico de scatter entre math y science diferenciando por las tres categorías de “ses”, usando el comando twoway.
*/

/*---------------------------------
-- Gestión de datos ---------------
---------------------------------*/

* Creación de variables (generate):

* Suma de tres variables
generate total = math + science + socst
** inspección de la nueva variable "total"
summarize total math science socst

* Revisar los casos en los que "science" es missing:
li math science socst if science == .
browse math science socst if science == .

* Lo mismo que lo anterior pero usando la función missing():
li math science socst total if missing(science)

* Reemplanzando valores:
** Reemplazar con 80 para los casos en los que total es igual a .
replace total = 80 if science == .
sum total

* Creación de variables con funciones extendidas (comando "egen"):

** la función "rowmean" crea el promedio de la fila de variables especificadas
egen meantest = rowmean(read math science socst)
summarize meantest read math science socst


* Renombrar variables (rename)
rename gender sexo
rename sexo female

* Recodificando variables (recode)
tab female
recode female (1=0)(2=1)
tab female

* Etiquetado de variables:
label variable math "Nota en Matemática"
codebook math
histogram math

* Etiquetado de valores (creación de etiqueta y aplicación)
label define tipo_escuela 1 "Pública" 2 "Privada"
label values schtyp tipo_escuela
tab schtyp
tab schtyp,nolabel

* Codificar variables string a numéricas:
encode prgtype, gen(prog)
browse prog prgtype

** Revisar el etiquetado de la nueva variable "prog":
tab prog
tab prog, nolabel


/* EJERCICIO:
Usando la base de datos del ejercicio anterior (hs0):

	* Usando los comandos generate  y replace cree la variable “math_high”, la cual es una dummy que toma el valor 1 si “math” está por encima de 60 y el valor 0 en otro caso.

	* Etiquete esta nueva variable creando una etiqueta llamada “etiqueta_math” que coloque la leyenda “Alto” al valor 1, y la leyenda “bajo” al valor 0.

	* Aplique la “etiqueta_math” a la variable “math_high” y explore esta última variable usando browse  y tabulate.
*/

/*---------------------------------
-- Operaciones con bases de datos -
---------------------------------*/

* Abrimos la base nuevamente:
use https://stats.idre.ucla.edu/stat/data/hs0, clear

* Comando "keep":

** conservando solo algunas variables:
keep id read math

** conservando observaciones según condiciones:
keep if read>50 & math>50


* Debido a que hemos perdido información, abrimos la base nuevamente:
use https://stats.idre.ucla.edu/stat/data/hs0, clear

* Comando "drop":

** eliminando algunas variables:
drop schtyp prgtype socst

** eliminando algunas observaciones según condiciones:
drop if math <10 | science==.


* Debido a que hemos perdido información, abrimos la base nuevamente:
use https://stats.idre.ucla.edu/stat/data/hs0, clear


* Ordenando información con sort y gsort:

** revisando datos no ordenados
li id read math in 1/5

* ordenando de menor a mayor con sort, y revisando los datos ordenados:
sort math
li id read math in 1/5


* ordenando de mayor a menor con gsort(-), y revisando los datos ordenados:
gsort -id -read -math 
li id read math in 1/5
browse id read math 

/* EJERCICIO:
Usando la base de datos del ejercicio anterior (hs0):

	* Vuelva a cargar la base de datos desde la web
	* Obtenga una submuestra de la base de datos que considere solo aquellos estudiantes que tengan un puntaje de “write” mayor o igual a 60. Puede usar los comandos keep o drop
	* Conserve solamente las variables “id” y “write”, y guarde esta nueva base de datos con el nombre “write_alto”.
	* Revise cuántas observaciones tiene esta base

	* Vuelva a cargar la base de datos desde la web, pero en esta ocasión solo conserve las observaciones en las que el puntaje de “write”sea menor a 60. 
	* Conserve solo las variables “id” y “write” y guarde esta base con el nombre “write_bajo”
	* Revise cuántas observaciones tiene esta base

	* Vuelva a cargar la base de datos desde la web, y elimine la variable “write”
	* Guarde esta nueva base de datos con el nombre “sin_write”.
*/


/*-----------------------------
-- Combinando bases de datos -
-------------------------------*/

cd "..."

** Append (apilar):
use "write_alto",clear
append using "write_bajo"
summ write 

** Merge (emparejar):
merge 1:1 id using "sin_write"
tab _merge
