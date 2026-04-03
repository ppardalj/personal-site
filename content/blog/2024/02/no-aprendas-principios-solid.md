---
title: 'No aprendas principios SOLID'
description: 'Los principios SOLID esconden la trampa de caer en el dogma de seguirlos ciegamente. Para evitarla, pensemos en términos de trade-offs y propiedades.'
author: pedropardal
date: 2024-02-11T00:00:00.000Z
layout: post
tags: ["oo-design"]
images: [/images/blog/posts/coder.jpg]
featured_image: /images/blog/posts/coder.jpg
card_image: /images/blog/posts/coder.jpg
---

Los principios SOLID son considerados por mucha gente la quintaesencia del *buen diseño de software*. Llega un momento en la carrera de todo desarrollador que, harto de [sufrir por tener que mantener código espaguetti cada día](https://www.exeal.com/cursos/rescata-tu-proyecto/), descubre SOLID y, cegado por el despecho y la ira hacia el código legacy, intenta aplicar SOLID a rajatabla.

Sin embargo, **los principios SOLID esconden una trampa muy peligrosa**: una en la que no caemos hasta que hemos aplicado SOLID lo suficiente como para darnos cuenta de que, en el mejor de los casos, nos hace perder el tiempo con discusiones infructíferas y, en el peor, puede convertir una base de código en un lugar más infernal aún en el que trabajar.

## El dogma

Volviendo al tema del despecho, cuando eres junior y te encuentras con esta situación, empiezas a informarte y buscar soluciones. Vas a charlas, lees posts, empiezas a seguir a los gurús. Cosas que están muy bien, ojo, todo lo que sea informarse y aprender nos ayuda a crecer como profesionales. Sin embargo, hay tres sesgos cognitivos a tener en cuenta, con los que tener mucho cuidado:

- El primero es el **sesgo de confirmación**. Cualquier información que recibimos que valide nuestra experiencia, la asumimos como cierta. Si nos viene alguien y nos dice que la solución al dolor de trabajar en una base de código legacy son los principios SOLID, le compraremos el argumento porque sufrimos ese dolor y queremos huir de él.

- El segundo, es el **sesgo de autoridad**. Tendemos a darle más peso a la opinión de algunas personas por el mero hecho de ser quienes son. En otras palabras: "si lo dice [Uncle Bob](https://es.wikipedia.org/wiki/Robert_C._Martin), que es un best-seller y alguien a quien todo el mundo considera un gurú, pues será verdad".

- El tercero, es el **sesgo muestral**. Por ejemplo, por cómo está construido internet y cómo funcionan los motores de búsqueda y el SEO, se tiende a dar visibilidad al contenido que valida la linea *mainstream* de pensamiento, y dejar fuera otras opiniones.

Porque, en definitiva, muchos acrónimos que, como SOLID, **se venden como principios, relamente no lo son**, sino que son más bien heurísticas que aplicaban en el contexto del autor, pero ese contexto no tiene por qué ser el nuestro.

## El pensamiento crítico

El mundo ha cambiado mucho desde que se formularon estos "principios". Los lenguajes de programación han evolucionado, hay cientos de frameworks nuevos, la experiencia de los años genera nuevo conocimiento. El contexto no es el mismo, y debemos ponernos al día.

El problema en concreto con los principios SOLID, aparte del hecho de que muchos de ellos son ambiguos por definición, como el Single Responsibility Principle, es justamente que están formulados como principios absolutos. Como un ideal alcanzable. Y esto es un error de base.

Asumir que se puede ser 100% compliant con SOLID, sería tanto como creer que existe el código perfecto. Por suerte, esto no es así. Y menos mal, porque sino las IAs ya nos habrían sustituido. El *mejor* código (sea lo que sea que signifique "mejor") para resolver cada problema, depende del problema en cuestión. Ahí es donde entra en juego el pensamiento crítico y la parte difícil del trabajo del ingeniero de software.

## Todo es un trade-off

Pero, ¿qué herramientas tenemos para tomar estas decisiones, o trade-offs, de manera informada? En su artículo [CUPID: for joyful coding](https://dannorth.net/cupid-for-joyful-coding/), Dan North nos sugiere hablar en términos de **propiedades en lugar de principios**:

> *Principles are like rules: you are **either compliant or you are not**. This gives rise to “bounded sets” of rule-followers and rule-enforcers rather than “centred sets” of people with shared values.*
> *Instead, I started thinking about **properties: qualities or characteristics of code rather than rules to follow**.*

Las propiedades definen un continuo, y cada punto de ese continuo nos proporciona diferentes cualidades al código. Tomemos como ejemplo el ratio de tamaño de código por fichero. Un ratio alto significa que el código está concentrado en pocos ficheros más largos. Un ratio bajo significa que tenemos muchos ficheros, muy pequeñitos.

**Ninguno de los dos extremos es bueno o malo**, de por sí. Tener pocos ficheros grandes puede hacer que cada uno de ellos sea complicado de leer, pero al tener menos partes móviles, el sistema en sí puede ser más simple y sencillo de trabajar. En el otro extremo, tener muchos ficheros pequeños puede ayudar a la legibilidad de cada uno, pero sacrificamos la capacidad de entender el sistema como un todo, o ponemos en peligro la facilidad de seguir el flujo de ejecución. ¿Quién no se ha visto con 20 ficheros abiertos a la vez, saltando de uno a otro, intentando entender qué hace el código?

## SOLID en términos de propiedades

En [mis formaciones](https://academia.exeal.com/), intento fomentar que la gente **aprenda a pensar**. Que no se queden en el dogma del libro. Les animo a que hagan sus propias interpretaciones del mismo y, por supuesto, que las contrasten en la práctica.

Es cierto que los principios SOLID tienen un trasfondo positivo: la intención detrás es buena. Pero con SOLID me pasaba que **no había lugar a este tipo de discusión y aprendizaje**. Así que desde hace no mucho, intento explicar SOLID desde un nuevo ángulo: en términos de otras propiedades del código.

En el resto del artículo me gustaría explicar el problema con cada principio, y qué propiedades uso en su lugar.

### Principio de responsabilidad única (Single responsibility principle, SRP)

La formulación más típica de este principio es:

> *"Una clase debe tener solo una única responsabilidad."*

El problema de este principio es que es ambiguo por definición: **depende de cuál sea la definición de responsabilidad**. Las definiciones más típicas, como "una razón para cambiar", también son ambiguas. Al final, en el mejor de los casos, gastamos infinidad de tiempo qué significa "responsabilidad" y, en el peor, escribiendo cientos de mini-clases que cada una hacen una única cosa. Que en algunos contextos puede ser lo adecuado, pero en otros muchos probablemente no.

En su lugar, encuentro más útil hablar de *encapsulación* y *cohesión*:
- **Encapsulación**: Es una medida de cómo de expuestos están los invariantes del dominio, es decir, aquellas reglas que no se deberían violar o estados que no se deberían dar.
- **Cohesión**: Es una medida de cómo de fuerte es la relación entre los métodos y los datos de una clase y el concepto o propósito que sirve la clase.

### Principio abierto-cerrado (Open-closed principle, OCP)

Este principio dice que:

> *"El código debe estar abierto para extenderlo, pero cerrado para modificarlo"*

En la práctica, este principio, junto con el de inversión de dependencias, llevan a escribir código "por si acaso", a la optimización prematura. Esto lleva a código complejo, con abstracciones innecesarias, a confusión sobre si realmente esas abstracciones son necesarias o no y, en última instancia, a complejidad accidental.

Por otra parte, tenemos el otro extremo, que es el "principio" YAGNI. Haz solo el código que sea necesario, y no más. **¿Veis la paradoja?**. Seguir YAGNI a rajatabla también puede traer problemas de mantenibilidad.

Además, éste principio, por cómo está descrito, favorece la herencia como mecanismo de reusabilidad de código. Hoy en día sabemos, por la experiencia de los años, que la composición suele ser un mejor mecanismo de delegación, ya que reduce el acoplamiento (¡anda! otra propiedad :D).

Hay que tener en cuenta que el OCP fue acuñado en otros tiempos. Épocas y situaciones en las que reescribir código era más caro. Tiempos de compilación elevados, dependencias con otros equipos en proyectos de consultoría, herramientas de refactoring menos potentes, cosas así.

Hoy en día muchos de esos factores no aplican, la dicotomía entre abierto y cerrado no existe. Por ello, mi selección de propiedades relevantes sobre las que hablar en lugar del Open-closed principle son:

- **Componibilidad**: la capacidad de un componente para componerse con otro.
- **Acoplamiento**: el grado de interdependencia real con otros componentes.
- **Legibilidad**: la capacidad para entender un código rápidamente en caso de necesitar cambiarlo.

En realidad, son indicadores de otras propiedades más abstractas, como la simplicidad o la mantenibilidad.

### Principio de sustitución de Liskov (Liskov substitution principle, LSP)

Este principio dice algo tal que así:

> *"Cada tipo que hereda de otro puede usarse como su padre sin necesidad de conocer las diferencias entre ellos"*

En realidad este principio es totalmente válido, pero a la hora de la verdad casi nadie lo entiende. En la práctica, lo que realmente viene a decir es:

> *"No tomes decisiones en tu código en base al subtipo de un objeto"*

O lo que es lo mismo, no uses el operador `instanceof`. O lo que es lo mismo, usar correctamente el mecanismo de polimorfismo de los lenguajes orientados a objetos. Es decir, no acoplarse con los subtipos. Acoplarse. Acoplamiento, otra propiedad, ¡que además ya hemos visto!

### Principio de segregación de interfaces (Interface segregation principle, ISP)

Sigamos.

> *"Los clientes de un programa dado sólo deberían conocer de éste aquellos métodos que realmente usan, y no aquellos que no necesitan usar."*

Más allá del hecho de ser un concepto muy centrado en lenguajes de tipado estático, en general es un buen consejo, pero al igual que el Single Responsibility Principle, llevado al extremo degenera en una explosión de interfaces de un solo método.

En lugar de eso, creo que tiene más sentido hablar simplemente en términos de acoplamiento y cohesión:
- **Acoplamiento**: ¿cuál es el grado de dependencia con código que no uso?
- **Cohesión**: ¿cuál es el grado de relación de los miembros de la interfaz entre sí?

La clave aquí es que no puedes optimizar las dos a la vez, por lo que te ves obligado a pensar dónde está el *sweet spot* en tu caso particular.

### Principio de inversión de dependencias (Dependency inversion principle, DIP)

Simplificado, este principio viene a decir lo siguiente:

> *"Depende de las abstracciones, no de las implementaciones concretas."*

De nuevo, aplicando ciegamente este principio y llevándolo al extremo, llegamos a un diseño que tiene interfaces para todo. Un diseño con más elementos de los necesarios y, lo peor, complicado de razonar y de navegar. Cada vez que te encuentras con una interfaz (que es en cada llamada) tienes que ponerte a buscar cuál es la clase que la implementa.

En la práctica, hay un problema aún peor. Las interfaces propician un estilo de testing conocido como **testear interacción** o colaboración. En la práctica, este tipo de tests acaban siendo reimplementaciones del código de producción, que no aportan seguridad a la hora de refactorizar, sino todo lo contrario, dificultan esta tarea.

Pensemos por un momento la motivación principal de usar interfaces. Además de la herencia, las interfaces son el mecanismo principal para implementar polimorfismo. ¿Cuándo queremos usar polimorfismo? Cuando tenemos diferentes opciones. Dicho de otra forma, cuando vamos a tener varias implementaciones de una interfaz. Si sólo va a haber una implementación, ¿para qué queremos una interfaz?

Es cierto que hay algunos escenarios en los que una interfaz con una única implementación pueden se deseables, por ejemplo, cuando estamos traspasando la barrera de un componente, y/o queremos testear la interacción con éste. En este caso, usaremos un doble de test, que no deja de ser otra implementación diferente de la dependencia, volviendo al caso anterior. De hecho, es en lo que se basa la arquitectura hexagonal.

En cualquier caso, todas estas son muchas menos situaciones que "hacerlo siempre sin pensar".

Dicho esto, se me vienen a la cabeza las siguientes propiedades hacia las que pivotar el discurso:

- **Flexibilidad**: ¿qué capacidad tenemos de combinar los componentes de diferentes maneras para lograr comportamientos diferentes?
- **Tamaño/Complejidad**: ¿de cuántas partes móviles se compone nuestro código? (mientras menos, mejor)
- **Testeabilidad**: ¿cómo de posible y fácil es escribir tests efectivos, especialmente para el código que se comunica con otros componentes?
- **Pureza** (en el sentido "funcional" de la palabra): ¿cómo de aislados están los efectos laterales?

## Ya no enseño SOLID

Por todo esto que has leído, desde hace un tiempo no enseño SOLID en [mis formaciones](https://academia.exeal.com/).

Es decir, sí, vale, sigue en el temario (casi que por una cuestión de SEO y, por qué no decirlo, clickbait), y sigo mencionando y explicando los principios, porque tarde o temprano aparecen en las conversaciones. Pero ahora siempre intento abordarlos desde la perspectiva de las propiedades que hay detrás, para fomentar el pensamiento crítico y evitar que mis alumnos caigan en el dogma.

Si alguna vez te encontraste divagando con tu equipo sobre qué significa una responsabilidad, o sobre si esos tests unitarios que parece que replican el código de producción aportan algo de valor, te animo a revisitar esas decisiones bajo este prisma alternativo.

Y, por supuesto, que luego nos compartas qué aprendisteis.

## Recursos para seguir aprendiendo

- [SOLID is not solid (David Bryant Copeland)](https://solid-is-not-solid.com/)
- [CUPID: For joyful coding (Dan North)](https://dannorth.net/cupid-for-joyful-coding/)
- [Why every single element of SOLID is wrong (Dan North)](https://dannorth.net/cupid-the-back-story/)
- [https://www.entropywins.wtf/blog/2017/02/17/why-every-single-argument-of-dan-north-is-wrong/ (Jeroen De Dauw)](https://www.entropywins.wtf/blog/2017/02/17/why-every-single-argument-of-dan-north-is-wrong/)
