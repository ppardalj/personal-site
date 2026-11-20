---
title: 'Ya no reviso el código'
description: 'Revisamos evidencias, no código. Por qué la code review manual ya no escala con agentes y qué evidencias pueden sustituirla.'
author: pedropardal
date: 2026-11-18T00:00:00.000Z
layout: post
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 23
---

Siempre he tenido una relación de amor-odio con las pull requests.

Cuando curraba en Tuenti (2012-2015, hace ya 14 años), teníamos un workflow bastante particular a la hora de revisar código.

Cuando querías integrar una rama, no abrías directamente una Pull request. El primer paso, en cambio, era pasar una Code Review en [Crucible](https://www.atlassian.com/software/crucible), la herramienta de Atlassian. Pero no era el único.

Aparte de eso, la rama tenía que pasar otros checks antes de plantearte ni siquiera integrar. Tenía que pasar una regresión y una exploratoria por parte del equipo de QA. Si el diff tenía cambios a base de datos (columnas, indices, tablas nuevas…), tenías que obtener aprobación del DBA. Evidentemente, la rama tenía que pasar al menos una versión “lite” de la CI (que de lite nada, ~45 minutacos).

Y solo cuando estabas listo para integrar, abrías un ticket de Integración en Jira, y a partir de ahí encomendabas tu rama al equipo de DevOps, que se encargaba de la integración como tal. Las ramas tenían que pasar la CI completa (más de 3 horas, con una batería gordísima de tests de Selenium) y algunos checks adicionales, y solo entonces se integraban… pero no en main, sino en la rama de la siguiente release, donde se mezclaba con el resto de ramas de otros ingenieros. Llegados un punto, se congelaba la release, se desplegaba a alpha, QA probaba lo que iba a pasar a prod, y finalmente, se desplegaba (con rollout progresivo, por cierto, pero eso es otro tema).

En su momento nunca tuve del todo claro por qué lo hacíamos así. Hoy, a toro pasao (disclaimer: sin contrastar esto con los DevOps de la época), entiendo que los motivos vendrían por aquí:

- **Economía computacional**: una release igual tenía fácil 10 o 15 ramas. Probar la full CI en cada cambio igual no salía rentable.
- **Concurrencia entre desarrolladores**: en su momento llegamos a ser más de 200 ingenieros subiendo ramas a prod cada día. Que dos cambios A y B pasen de forma aislada no quiere decir que A + B también vaya a pasar. En el caso de Tuenti, lo que se promocionaba en cada caso era exactamente lo que se había probado, y el resto tenía que reintegrarse.
- **Separación de responsabilidades**: en linea con lo anterior, eramos un montón de gente con diferentes roles: developers (en el rol de implementador o revisor), QA, devops, DBA, sistemas… el flujo anterior permitía tener responsabilidad colectiva sin que el proceso fuera un caos.
- **Jira como control plane**: esta está muy guapa, todo el flujo de integración se gestionaba mediante una máquina de estados de JIRA. En cada transición, un bot realizaba acciones y checkeos pertinentes, y las decisiones manuales se modelaban como transiciones desde el propio ticket de Jira.
- **El software es más que código**: que el código esté bien no significa que el cambio sea correcto: ¿y los cambios de config? ¿cambios de data o migraciones? ¿las pruebas manuales? ¿los feature flags? ¿coordinación con otros devs / equipos?

## La hostia de realidad

Tras esta primera experiencia como ingeniero profesional, después de casi 3 años trabajando así día a día, cuando cambié de curro y comencé a trabajar con un flujo más habitual de Pull requests, más cercano a lo que estamos acostumbrados todos, en el que lo más que se probaba en eran los tests unitarios en una CI en Jenkins (sino recuerdo mal, ni siquiera existía por aquel entonces el concepto de check requerido en Github)… os podéis imaginar que la hostia en la cara fue dura.

No entendía nada.

Pensaba que el estándar de ingeniería, como todo el mundo integraba software, era como se integraba software en Tuenti.

- No entendía por qué la code review y la PR eran la misma cosa. ¿Y el resto de checks? ¿y QA? ¿y las migraciones? ¿y si no quiero integrar aún? ¿y si hay cambios que no quiero integrar ya, pero quiero que mis compañeros ya vayan viéndolo y recibir feedback?
- No entendía cuando Jenkins daba bola roja en master. ¿¿¿Cómo va a ser, si todas las ramas han dado verde cada una??? De verdad que no me cabía en la cabeza.
- No entendía cómo cada equipo hacía la guerra por su cuenta y el proceso de integración y despliegue dependía de tu equipo, del tech lead y de conocimiento en la cabeza de las personas (ah sí, se podía desplegar a mano, que eso no lo he dicho jajaj omg)

Y otras muchas cosas que en su momento no entendía pero que, con el tiempo… pasaron a ser “lo normal”, y ya ni me acuerdo. Pero el sentimiento si lo recuerdo muy bien.

No es que el workflow de Tuenti fuera la hostia, evidentemente tenía sus problemas. Pero el punto es que quiero hacer es que, en el fondo, había aprendido que integrar software era la consecuencia de haber demostrado una serie de propiedades sobre un cambio. En otras empresas, integrar de software podía ser simplemente la consecuencia de que alguien hubiese pulsado un botón de “Approve”.

Y de ahí mi disonancia con las pull requests.

## Llega la IA

Hasta ahora.

La verdad es que la irrupción de los agentes me ha venido súper bien en este sentido, porque ha vuelto a sacar a debate todo lo que la industria consideraba buenas prácticas a la hora de revisar cambios. Por un motivo diferente, pero esos procesos ya no valen: los agentes son capaces de producir código a mayor velocidad de la que los humanos somos capaces de revisarlo. Revisarlo a mano se ha convertido en un cuello de botella.

Para resolver este problema, no podemos ser tan *naive* como algunos pretenden, y simplemente dejar de revisar código. Eso es peor todavía. De hecho, hacer *sólo* eso sería irresponsable. Pero sí que tenemos que cuestionar y revisar prácticas asentadas durante años, valorar qué funciona y qué no.

No debemos olvidar que, por mucho que los agentes sigan escribiendo el código, nosotros (y nuestro equipo) seguimos siendo responsables de las consecuencias derivadas de integrar ese código. Si introduce bugs, somos responsables. Si la feature sale mal, somos responsables. Si la arquitectura se degrada y perdemos [opciones de futuros](https://www.youtube.com/watch?v=K7Z8Wa83Wgo), somos responsables. Si sacar ese código tiene cualquier tipo de impacto negativo en nuestros negocios o nuestros usuarios / clientes, somos responsables. La pull request, desde este punto de vista, nuestra firma en un pull request es un aval de que tenemos razones suficientemente fundamentadas para creer en que el cambio va a cumplir esos requisitos. Es como cuando un arquitecto firma un proyecto de obra, o como cuando un notario firma una escritura. En ese caso, incluso asume responsabilidades legales y penales. Salvando las distancias, aprobar un PR viene a ser algo similar.

Esto es cierto, escriba el código yo mismo, un compañero, o un agente.

Si lo formularamos el *jobs to be done* del revisor como una [job story](https://www.mountaingoatsoftware.com/agile/job-stories-offer-a-viable-alternative-to-user-stories), sería algo así:

> *Cuando* se propone un cambio en el software del que soy responsable,
>
> *quiero* comprender su propósito, evaluar sus implicaciones y obtener evidencias suficientes de su calidad y correctitud,
>
> *para* poder avalar su integración y asumir, de manera informada, la responsabilidad sobre sus consecuencias.

¿Cómo conseguimos esto históricamente? Pues sólo tenéis que pensar por un momento… ¿qué miráis vosotros cuando revisáis un PR?

- **Funcionalidad**: ¿hace lo que tiene que hacer?
- **Corrección**: ¿mete bugs?
- **Diseño y arquitectura**: ¿es mantenible el código, i.e. mantiene abierta opciones de evolución a futuro, o me compra deuda técnica?
- **Legibilidad**: ¿cumple el estándar? ¿seré capaz de leerlo y mantenerlo cómodamente en el futuro?
- **Regresión**: ¿hay pruebas reproducibles de que lo que se ha implementado funciona?
- **Seguridad**: ¿el diff abre algun problema de seguridad?
- **Rendimiento**: ¿va a performear bien cuando pase a producción?
- **Documentación**: ¿el conocimiento que no se ve en el código, queda registrado?
- … y muchas más cosas.

Todos estos puntos son **propiedades** que buscamos evaluar de alguna manera, y buscamos **evidencias** que nos hagan ganar **confianza** de su presencia. Históricamente, esas evidencias las hemos recolectado manualmente, mirando el código. Sin embargo, a medida que los agentes nos han superado en productividad, y nos hemos convertido en el cuello de botella de nuestro propio proceso, revisar el código deja de ser una forma eficiente de obtener esas evidencias.

## La nueva (vieja) tésis

Pero la tésis se mantiene:

*Revisamos evidencias, no código. El código es una evidencia más*.

LA Pregunta, con mayúsculas, entonces es: ¿qué formas alternativas tenemos de obtener esas evidencias, que no supongan un cuello de botella? Sería deseable que esas evidencias se generarsen automáticamente, porque sino no podríamos mantener el ritmo de la generación de implementaciones. Y, por supuesto, tienen que ser generadas por un proceso en el que confiemos, que sea auditable y reproducible, y idealmente determinista.

Por suerte, históricamente también existen muchos de estos mecanismos, y muchos equipos los tienen implementados en su CI desde mucho tiempo antes de la era agéntica. Siempre han sido buenas prácticas. Me refiero a cosas como:

- Funcionalidad y corrección: tests de aceptación automatizados que verifican acceptance criteria documentados. Mutation testing, Property based testing…
- Diseño y arquitectura: architecture guardails / lints (ArchUnit, deptrac…), detectores de code smells, análisis estático… etc.
- Legibilidad: linters, coding standards, análisis estático.
- Seguridad: escaneo de dependencias, pruebas de autorización, property based testing…
- Rendimiento: profiling, performance tests…
- Compatibilidad: contract testing
- Operabilidad: análisis de logs, métricas, trazas, pruebas de migración…

Es cierto que, históricamente, el coste de aplicar muchas de estas técnicas han sido prohibitivo para muchos equipos, con recursos limitados, presión de negocio, etc. Pero hoy en día, tenemos un aliado fantástico. Los agentes nos pueden ayudar a implementar todos estos mecanismos para obtener evidencias de forma muchísimo más eficiente que antes, a una fracción del coste.

De hecho, hoy en día son posibles mecanismos que antes ni siquiera habíamos imaginado. Imaginate un agente que lea los criterios de aceptación de tu ticket, se abra un navegador con Playwright, use el producto como lo haría un usuario, y te saque pantallazos del estado final como evidencia visual del cambio que has hecho, y te lo aporte como un check adicional en el Pull request. Bueno, pues esto hoy en día es bastante más común de lo que parece.

Evidentemente, no todas las evidencias tienen el mismo valor. Si el mismo agente que ha implementado un cambio es el que decide cómo verificarlo, corremos el riesgo de que ambos procesos compartan los mismos errores. Parte de nuestro trabajo como ingenieros consiste precisamente en diseñar mecanismos de verificación independientes de la implementación, en los que podamos depositar nuestra confianza.

## Un cambio de paradigma

Llevo varios meses trabajando a full con agentes y, personalmente, el bloqueo más difícil de superar ha sido mental, no técnico. Estamos acostumbrados a que somos los que escribimos el código y lo revisamos. Pero en la era de los agentes, ni escribimos el código, ni parece que revisarlo nosotros sea una estrategia viable. Entonces, ¿dónde queda nuestro trabajo? ¿cuál es el rol del ingeniero?

Para mi, todo ha cambiado en el momento en el que he adoptado esta filosofía: **los ingenieros ya no construimos el producto, sino que construimos y engrasamos la máquina que construye el producto**. Pero quedarnos aquí suena a frase vacía de gurú, lo importante es qué cosas concretas, a nivel de comportamiento, cambian al adoptar esta filosofía. Esto es lo que a mi me ha funcionado, y es el experimento que os invitaría a probar:

1. **Dejad de escribir código**. Al menos, para implementar tareas de producción. En lugar de eso, pedidle todo a vuestros agentes, pero con un matiz: cuando el agente no sea capaz de generar el código correcto, identificad primero qué ha pasado: ¿Se ha dejado algún test? ¿Hay algún criterio de aceptación que no ha tenido en cuenta? ¿Ha metido algún bug sin darse cuenta? ¿Ha escrito código de baja calidad? ¿No ha respetado la arquitectura?. Luego preguntaos por qué: ¿faltaba algo en la especificación? ¿faltaba documentación? ¿quizá existía pero no la ha encontrado? y en base a eso, modificad el harness, y volved a pedirselo
2. Pero OJO: **seguid escribiendo código**, pero no para implementar nuevas features, sino para seguir desarrollando vuestra comprensión del código y vuestra capacidad de entenderlo. Pet projects, retos, katas de programación.
3. Cada vez que **reviséis código, preguntaos**: ¿qué evidencia estoy buscando revisando el código? ¿existe alguna forma alternativa de conseguir esta evidencia y “quedarme tranquilo”, que no sea revisando el código? O, dicho de otra manera, ¿qué pruebas tendrian que darme para confiar en que puedo asumir la responsabilidad de este código, sin mirarlo?
4. Pero no os quedéis en el ejercicio mental: **implementadlo**, con los agentes es barato. Probadlo un tiempo, en varias pull requests, y observad vuestro comportamiento y cómo os sentís al respecto. ¿Realmente ganáis más seguridad? ¿Seguís sintiendo la necesidad de mirar el código de forma tan exhaustiva? Medid también cuánto tiempo invertís en revisar cambios, y cuántos bugs se os escapan a producción (las [métricas DORA](https://dora.dev/guides/dora-metrics/) pueden ayudar, y medirlas con agentes es facilísimo).
5. Mientras estáis haciendo esto, **ponedle un WIP limit a los agentes**. Si los agentes siguen produciendo código a mayor velocidad de la que sois capaces de revisar, os va a poder la presión. Y si os puede la presión, vais a dejar de revisar cosas, pero por la razón equivocada, y eso sí es irresponsable. En lugar de eso, dejad espacio abierto para poder hacer las reflexiones y movimientos anteriores.

## Nuestro superpoder

Como humanos, tenemos una característica súper potente, y a menudo infrautilizada: la intuición. La intuición, mediante las emociones, nos dan pistas sobre el camino. ¿cómo te sientes ante la perspectiva de no mirar el código de los agentes? ¿qué emoción aparece? ¿sientes culpa? ¿o quizá es miedo? ¿incluso vergüenza? Cada una te dice cosas distintas. En mi caso, al principio sentía culpa por estar haciendo algo irresponsable, incluso vergüenza, por ir en contra del estándar de toda la industria. ¿Qué van a decir mis compañeros cuando les diga que no reviso el código? ¿Qué dirán mis lectores cuando se lo proponga?

Y está bien, las emociones nos dan información. Pero tenemos que indagarlas y cuestionarlas: ¿por qué siento culpa? ¿de verdad estoy haciendo algo irresponsable? Ahí entra la razón, el diálogo socrático, y las evidencias. Sentirme inseguro no significa que mi software sea inseguro. Sentirme seguro tampoco significa que mi software sea seguro. Necesito complementar mis sensaciones con datos.

Si dejo de mirar el código sin tener ninguna otra evidencia, y pulso approve, efectivamente estoy haciendo algo irresponsable. Pero ahora, imaginate que abres un pull request de un agente, y te encuentras con:

- ✅una descripción pulida del cambio y sus consecuencias
- ✅7865 unit tests verdes
- ✅1246 integration tests verdes
- ✅326 acceptance tests verdes
- ✅Quality ratchet: ninguna métrica de calidad medida empeora
- ✅Architecture check: el código no viola nuestra reglas arquitectónicas
- ✅verificación manual de cada acceptance criteria en un entorno efimero prod-like: trazas ok, métricas ok
- ✅GIF/Video de la UI del antes y el después
- ✅API y DB sin breaking changes. Contract testing pasa.
- ✅performance test: no empeora respecto a la baseline
- ✅Mutation testing: sin nuevos mutantes supervivientes
- ✅Security check: sin nuevas vulnerabilidades detectadas
- ✅Valoración de riesgo: two way - one way / plan de rollback

Con todas estas evidencias encima de la mesa, ¿Hasta qué punto estarías cometiendo una irresponsabilidad si no abres el diff y pulsas approve?

¿Estás abriendo el diff porque estás buscando responder una pregunta concreta que el resto de evidencias no pueden responder por sí solas? ¿o es un automatismo motivado por una creencia desarrollada a lo largo de toda una carrera?

La respuesta no te la va a dar ningún gurú, la tienes que buscar tú.
