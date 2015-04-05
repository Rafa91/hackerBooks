#Hacker Books

**¿Qué otros métodos similares hay? ¿En qué se distingue isMemberOfClass:?**

También se puede realizar una función similar con isMemberOfClass o simplemente
con la comparación [obj1 class]==[obj2 class]. En particular, isMemberOfClass 
nos da información exacta sobre que tipo de clase es, ya que isKindOfClass también
devuelve YES si se compara una clase padre con su hija.


**¿Donde guardarías estos datos?**

También los guardaría en la carpeta Documents ya que ésta permite almacenar bastantes
datos y no se ve modificada por el sistema operativo en el tiempo. La URL no la
he modificado, porque si intentamos realizar un acceso a una URL que apunta a 
nuestros documentos, pero el documento en cuestión no existe, sólo devuelve nil.
De esta forma, si por algún motivo no encuentra el archivo, siempre tendremos
una segunda vía para acceder a esa información.


**¿Cómo harías eso? ¿Se te ocurre más de una forma de hacerlo? 
Explica la decisión de diseño que hayas tomado.**

Me he decantado por la opción de guardar solamente los títulos de los libros, ya
que son únicos y me aseguro de no repetir níngun libro. Otras opciones, que he
descartado, son guardar los libros completos tanto en formato BSIBook como en
formato JSON porque el volumen a guardar es demasiado grande e incluso la opción
por la que he optado deberá guardarse en la carpeta Documents, o alguna similar,
en un futuro si aumentan los libros de la biblioteca.
Por otro lado, todo este trabajo se resuelve con Core Data. Si no recuerdo mal,
sólo tenía que guardar referencias y se hace todo mucho mas liviano.

**¿Cómo lo harías? Es decir, ¿cómo enviarías información de un AGTBook
a un AGTLibraryTableViewController? ¿Se te ocurre más de una forma de hacerlo? ¿Cual te
parece mejor? Explica tu elección.**

He optado por el sistema de notificaciones internas porque la opción de delegado
sólo es válida si tenemos que comunicarnos con uno y la comunicación no es muy 
"compleja". Esta opción tiene el inconveniente de que a la larga será más dificil
entender el código pero más sencillo que algún controlador más tenga en cuenta
cambios realizados en el modelo.

**¿Es esto una aberración desde el punto de rendimiento (volver a cargar datos
que en su mayoría ya estaban correctos)? Explica por qué no es así. ¿Hay una
forma alternativa? ¿Cuando crees que vale la pena usarlo?**

Realmente el sistema operativo no desecha las vistas de las celdas sino que las
reutiliza si son necesarias identificandolas con una misma etiqueta. Existen métodos
para recargar solo celdas, tramos de celdas o secciones, pero la mejora es bastante
escasa.

**Cuando el usuario cambia en la tabla el libro seleccionado, el 
AGTSimplePDFViewController debe de actualizarse. ¿Cómo lo harías?**

Lo he implementado mediante notificaciones ya que es la forma más eficiente.


P.D. Enseñadnos autolayout porque me he vuelto loco con la interfaz y al final la
he tenido que dejar mal. La única que medio se ve bien es la interfaz del iphone.
