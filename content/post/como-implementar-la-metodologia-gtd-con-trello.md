---
date: 2019-11-26T00:00:00+01:00
title: Cómo implementar la metodología GTD con Trello
featured_image: '/images/nesa-by-makers-kwzWjTnDPLk-unsplash.jpg'
omit_header_text: true
tags: ["productividad personal", "soft skills", "gtd", "trello"]
---

Una de las claves del éxito de cualquier trabajador del conocimiento, y en particular de los que nos dedicamos a la consultoría y el desarrollo de software, es **tener un buen sistema de organización personal**. Desde las clásicas, minimalistas pero efectivas, listas de tareas, hasta metodologías más elaboradas como *Autofocus* o *Getting Things Done*, es esencial disponer de algún sistema que te permita gestionar tu tiempo, tu atención o foco, tus compromisos y prioridades, con el fin de mantener nuestros niveles productivos y alcanzar nuestros objetivos, sin que necesariamente caigamos en preocupaciones y/o estrés.

Entre las claves de la productividad, además de ser capaces de vaciar nuestra mente en un sistema confiable fuera de nuestra cabeza, o poder poner foco en aquello que podemos hacer en cada momento, se encuentra un principio muy simple: haz lo que a ti te funcione. En este sentido, [Getting Things Done](https://gettingthingsdone.com/) (o GTD en adelante), la metodología que yo personalmente uso, no prescribe ninguna implementación concreta del método, sino que lo deja abierto para que tú lo adaptes a tus necesidades.

En mi caso, tras varios años de experimentar con diferentes implementaciones, tanto analógicas como digitales, llevo bastante tiempo usando [Trello](https://trello.com/), la popular aplicación de gestión de tarjetas. En este artículo pretendo explicar cómo he implementado GTD con Trello; no es para nada obligatorio implementar GTD de esta manera, **esto es lo que me funciona a mí**, pero si te estás planteando montar tu propio sistema de organización personal, seguro que encuentras algunas ideas en este artículo.

El resto del artículo asume que el lector está familiarizado con GTD. En caso de que no lo conozcas, te dejo [este artículo](https://www.plannercode.com/tecnicas-planificacion/introduccion-a-gtd/) a modo de introducción.

## GTD con Trello

En esencia, GTD se basa en elementos muy simples: listas, items y relaciones entre ellos. Esto lo hace particularmente apropiado para implementarlo con Trello, cuyos elementos básicos, columnas, tarjetas y etiquetas, se pueden mapear directamente con los de GTD. Cada lista de GTD es una columna (p.ej, Bandeja de Entrada, Acciones siguientes, Proyectos, etc.); cada item de una lista es una tarjeta en una columna. Las relaciones entre items de diferentes listas (por ejemplo, acciones de un proyecto, objetivos de un área de responsabilidad) se pueden implementar con etiquetas de una forma que describiré en breve. Pero antes, entremos en detalle de cómo se implementan las listas de control y los hábitos básicos de **capturar**, **aclarar** y **hacer**.

### Capturar: Bandeja de entrada

En la lista **Bandeja de Entrada** implemento el hábito de *capturar* de GTD; cualquier idea, nota, o input que quiera introducir al sistema es añadido a esta lista. La uso principalmente de tres formas:

- Añadiendo tarjetas desde la aplicación de escritorio, lo que me permite hacer rápidamente un [barrido mental](https://medium.com/better-humans/how-to-do-a-gtd-mind-sweep-b314223ba108).
- Añadiendo tarjetas desde el smartphone, lo que me permite apuntar ideas o notas esté donde esté, en cualquier momento.
- Usando la función **Compartir en Trello** del smartphone en cualquier contenido que sea compartible (videos, páginas web, blogposts...), puedo guardar contenido interesante para procesarlo después.

### Aclarar: El flujo de trabajo

Utilizo cuatro listas adicionales para "aclarar los cosas" de la bandeja de entrada, esto es, definir qué son y clasificarlas cada vez que pongo a punto mi sistema GTD (normalmente una vez al día):

- **Próximas acciones**: tareas que son físicamente accionables. Siempre son frases con verbos en infinitivo. P.ej.: *Realizar un brainstorming sobre canales de entrada de proyectos*.
- **Esperando**: cosas que he delegado, o que estoy esperando a que pasen. Uso la fórmula "Esperando a ...". P.ej.: *Esperando a que la casera me ingrese la fianza del alquiler*.
- **Proyectos**: resultados que requieren más de una acción física. Los formulo en tiempo pasado, lo cual me permite obtener énfasis en formularlos en forma de un resultado y no de acción (los proyectos "no se hacen"), y me permiten hacerme una idea de cómo sera mi realidad cuando los proyectos estén acabados, lo cual me da un extra de motivación. P.ej.: *Blogpost sobre mi workflow de GTD publicado*
- **Archivo de seguimiento**: inputs que se activarán en el futuro, p.ej. una cita un día concreto, o algo que sólo se puede accionar a partir de cierta fecha. Acompaño cada tarjeta de un deadline y un recordatorio que me notifique con antelación de que la fecha en cuestión está próxima. P.ej.: *Recoger el certificado de empadronamiento a partir de la primera semana de Diciembre*.

Adicionalmente, utilizo la descripción de las tarjetas para añadir material de consulta relacionado con el proyecto, p.ej. números de teléfono, notas, links a otros recursos como mapas mentales, diagramas, etc.

![](/images/gtd-trello/control.png)

### Hacer: Próximas acciones y contextos

Etiqueto todas las tarjetas de la lista de próximas acciones con etiquetas que representan mis [contextos](http://simplicitybliss.com/2011/06/a-fresh-take-on-contexts/). Uso etiquetas de tres tipos:

- **Situación** (color naranja): cosas que sólo puedo hacer en un lugar o con una herramienta determinada: *calls*, *errands*, *home*, *laptop*, *office*, *pen and paper*.
- **Tiempo y energía** (color rojo): dependen de mi tiempo disponible y estado anímico: *focus*, *willpower*.
- **Personas** (color morado): agrupo todos los asuntos que dependen de una persona en concreto para tratarlos todos de golpe si es posible.

Esta categorización me permite usar los filtros de Trello para decidir qué hacer en cada momento, por ejemplo: activar el filtro *office* cuando estoy en la oficina, activar el filtro *focus* cuando tengo mucha energía y tiempo por delante, activar el filtro de una persona concreta cuando tengo un 1:1 para ver todos los asuntos que tengo pendientes con ella.

![](/images/gtd-trello/contexts.png)

### Primer nivel de perspectiva: foco en proyectos

Para cada proyecto, creo una etiqueta de proyecto, que uso para etiquetar tanto la tarjeta del proyecto, como todas las acciones, tareas delegadas, a la espera o futuras. Esto me permite **poner foco** en un proyecto en concreto haciendo una búsqueda por la etiqueta del proyecto, lo cual me revela todas las tarjetas relacionadas con el proyecto. De un vistazo, puedo ver, por ejemplo, si es necesario definir acciones siguientes para un proyecto, qué proyectos están bloqueados por cosas a la espera, etc. Utilizo esta técnica en mi [revisión semanal](https://facilethings.com/blog/es/basics-weekly-review) para hacer un seguimiento de todos los proyectos activos y asegurarme de que todos están en marcha.

### Objetivos (OKR's)

Los objetivos son similares a los proyectos, pero a más largo plazo. Aunque GTD plantea un plazo bastante amplio para los objetivos (2-3 años), a mí me funciona mejor trabajar con un plazo menor (3 meses - 1 año).

Formulo mis objetivos en forma de [OKR's (Objectives and Key Results)](https://rework.withgoogle.com/guides/set-goals-with-okrs/steps/introduction/). Uso las checklists de Trello para definir los Key Results, lo cual me permite visualizar fácilmente el progreso hacia cada uno de mis objetivos. También les asigno un deadline.

![](/images/gtd-trello/okr.png)

De la misma forma que con los proyectos, cada objetivo tiene su propia etiqueta, que asigno tanto al objetivo como a los proyectos que giran en torno a ese objetivo. Con esto persigo lo siguiente:

- Poder hacer foco en un objetivo concreto: visualizar rápidamente todos los **proyectos que me harán avanzar** a un objetivo concreto, o identificar si el progreso hacia **algún objetivo está parado** por no haber ningún proyecto definido.
- Identificar proyectos que no están relacionados con ningún objetivo. En teoría, estos proyectos me están **quitando foco** y debería plantearme si realizarlos o no, o si quizá están relacionados con algún objetivo aún no formulado.

Mientras las relaciones entre objetivos y proyectos la mantengo en mi revisión semanal, la lista de proyectos la replanteo a más largo plazo, en las revisiones trimestrales y anuales.

![](/images/gtd-trello/goals-and-projects.png)

### Áreas de responsabilidad

Una lista similar a la de objetivos es la de **Áreas de responsabilidad**. Cada item aquí representa aquellos aspectos de la vida y el trabajo que no quiero descuidar, por ejemplo: *desarrollo personal*, *ocio*, *relaciones*, *desarrollo profesional*, etc. Mantengo una relación mediante etiquetas similar a la de proyectos-objetivos o proyectos-acciones, de tal forma que en mi revisión trimestral puedo comprobar de que ningún área de responsabilidad está descuidada, asegurandome de que hay al menos un objetivo definido por cada área de responsabilidad.

![](/images/gtd-trello/goals-and-areas.png)

### Listas de apoyo

Finalmente, mantengo dos listas de apoyo al resto del sistema:
**Algún día / Tal vez**: cosas que quiero hacer en algún momento, pero con las que no quiero comprometerme ahora mismo. La reviso cada semana, para comprobar si hay alguna idea incubando que es el momento de activar.
**Material de consulta**: información relevante que no necesariamente está relacionada con algún proyecto.

## Ventajas

El hecho de usar Trello aporta múltiples ventajas, entre las que se incluyen:

- La curva de aprendizaje de la herramienta es cero, si como yo ya la usas para otros fines.
- El sistema de filtros por etiquetas es excelente para poner foco en cualquiera de los niveles de perspectiva. Además, se puede encontrar utilidad a otras muchas funcionalidades de la herramienta, como las checklist, plazos de vencimiento, comentarios, archivos adjuntos, etc.
- Disponer de aplicación web y móvil para gestionar el GTD desde cualquier sitio.
- La herramienta es lo suficientemente flexible y potente como para dar soporte y experimentar con diferentes estructuras de listas, etiquetas, relaciones, etc. Si algo no te funciona, depende únicamente de ti cambiarlo.
- Es gratuito.

## Desventajas

- El esfuerzo de mantenimiento. Si bien es algo que disminuye significativamente con el tiempo a medida que nos habituamos al uso (yo ya no lo encuentro un gran problema), sobre todo al principio puede resultar tedioso acostumbrarse a crear todas las etiquetas necesarias y mantener las relaciones entre las tarjetas para poder poner el foco. También es cierto que no lo encuentro precisamente más engorroso que la clásica implementación analógica que propone David Allen con una libreta Moleskine.
- Al ser una aplicación de propósito general, se echan en falta funcionalidades que sí encontraríamos en software específico de gestión de productividad. Por ejemplo, las que yo más echo en falta son time tracking y estadísticas de uso. Quizá esto se pueda suplir con plugins, cosa que aún no he investigado.
- Necesitas disponer de conexión a Internet para acceder al sistema, por lo que no puedes hacer una revisión sin conexión, por ejemplo si viajas en avión.

## Conclusiones

Tras más de 5 años usando GTD y habiéndolo implementado de diversas formas, tanto analógicas como digitales, con y sin el soporte de herramientas de productividad, llevo ya más de dos años siguiendo este enfoque, y es el que mejor me ha funcionado hasta el momento. La posibilidad de usar las funcionalidades de Trello para cambiar la implementación y probar cosas nuevas es lo que más valoro, junto al hecho de que dispongo de mi sistema completo en cualquier sitio en el que tenga acceso al tablero de Trello, que a efectos prácticos es siempre que lleve el móvil encima. En un futuro próximo, me gustaría plantear un pet project para suplir las carencias de Trello e implementar funcionalidades nuevas, aprovechando el hecho de que Trello tiene [una API de desarrolladores abierta](https://developers.trello.com/reference#introduction), la posibilidad de [desarrollar power-ups](https://tech.trello.com/power-up-tutorial-part-one/), etc.

Para un profesional del conocimiento, en particular en la industria del desarrollo de software, la adopción de unos sólidos hábitos de organización personal es tanto o más importante que las propias competencias técnicas. Independientemente de tu rol, ya seas *engineering manager*, *C-level executive* o desarrollador, te puedes beneficiar de adoptar estos hábitos. Particularmente he encontrado que, en nuestra industria, el uso de herramientas como Trello ya está muy asentado para otros fines, como gestión de proyectos o de backlog de producto, por lo que adoptarlo para implementar tu propio sistema de organización personal es un paso muy natural. Si te animas a darlo, [házmelo saber](https://www.ppardalj.com/contacto/) si necesitas ayuda.
