---
title: 'Cómo diseñar una estrategia de testing efectiva'
description: 'Una buena estrategia de testing marca la diferencia entre un equipo que es capaz de entregar valor a sus clientes de forma sostenida, y uno que no.'
date: 2025-02-06T00:00:00.000Z
layout: newsletterpost
author: pedropardal
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 5
---

Hoy te voy a explicar cómo diseñar una estrategia de testing automatizado efectiva para tu proyecto.

La inmensa mayoría de los proyectos en los que he trabajado caían en una de estas dos categorías:

- No se preocupaban en añadir tests hasta que el coste de desarrollar nuevas features crecía exponencialmente, y ya demasiado tarde.
- Comenzaban con una estrategia sobredimensionada, cubriendo hasta el más mínimo detalle con todos los tipos de tests posible. El coste para lanzar incluso una primera versión es elevadísimo.

Ambos extremos son antipatrones. Aunque el primero pueda parecer más evidente, el segundo también nos resta agilidad y competitividad.

La clave de una buena estrategia de automatización de tests es que sea adaptativa: que evolucione en complejidad a medida que lo va haciendo el proyecto.

Vamos a ver cómo lograrlo.

## Utiliza test-driven development

TDD es la base de cualquier estrategia de testing seria, y es prerrequisito para todo lo demás.

Utilizar TDD no sólo nos garantiza una cobertura elevada desde el principio, sino que nos lleva a desarrollar una solución que tiene la complejidad justa: ni más ni menos.

Esto es importante porque algo que pasa siempre en proyectos nuevos, es que no está claro qué es lo que hay que implementar. Es muy típico desarrollar una funcionalidad y que, a la hora de la entrega, el cliente nos diga que no era lo que quería.

Usar TDD nos obliga a tener esto claro; podemos usarlo a nuestro favor para evitar retrabajo y llegar antes a lanzar las primeras versiones del producto.

## Describe los criterios de aceptación

Una muy buena forma de aclarar los requisitos funcionales es describir los criterios de aceptación utilizando el lenguaje Gherkin. O, dicho de otra forma, formularlos según la plantilla:

- *Dado `<un contexto>`*
- *Cuando `<el usuario realiza una acción>`*
- *Entonces `<ocurre un resultado observable>`*

Por ejemplo:

- *Dado que el usuario no está logado*
- *Cuando intenta acceder a su perfil*
- *Entonces se le muestra un error de autenticación y se le redirige a la pantalla de login*

Esta plantilla ayuda a producto a definir una solución que resuelve el problema del usuario, a desarrollo a implementarla y a QA a verificarla.

## Empieza por los tests end-to-end

Al principio del proyecto, la incertidumbre es máxima.

No sólo estamos descubriendo los requisitos, sino también el diseño de la solución.

¿Qué capas tendrá nuestra aplicación? ¿Usaremos arquitectura hexagonal, DDD, onion?

Muchos equipos cometen el error de definir la arquitectura demasiado pronto, resultando en una falta de arquitectura o un exceso de complejidad.

Cambiar la arquitectura cuesta más una vez que probamos cada pieza por separado con tests unitarios. Si nos equivocamos de arquitectura, no tardaremos en tener que pagar el precio.

Este es uno de los motivos por los que es buena idea empezar por los tests end-to-end.

Por ejemplo, imagina que estamos probando un nuevo endpoint en una API web. Si conseguimos escribir un test que:

- invoque el sistema haciendo una llamada HTTP, y
- compruebe el outcome del test verificando la respuesta HTTP o el estado resultante de la base de datos,

tendremos un test que va a salir verde si y solo si el endpoint hace lo que debe, independientemente de cual sea la arquitectura subyacente.

Esto nos da libertad para cambiar la arquitectura y experimentar con diferentes enfoques, hasta que encontremos el que sea más adecuado.

Esta estrategia también se conoce como “***outside-in development***”, término acuñado por Steve Freeman y Nat Pryce en el libro “Growing Object Oriented Software Guided By Tests” (2009):

> *Start with the outside event that triggers the behavior we want to implement […] until we reach a visible effect (such as a sent message or log entry) indicating that we’ve achieved our goal. The end-to-end test shows us the end points of that process, so we can explore our way through the space in the middle.*

Además, si empezamos por los tests end-to-end, tendremos desde el primer momento un test que verifica que la aplicación se levanta y funciona, evitando la situación de “100% de cobertura de tests, pero la app no funciona” que se puede (y se suele) dar al escribir únicamente tests unitarios.

Si hemos descrito los criterios de aceptación utilizando la fórmula Dado/Cuando/Entonces o Given/When/Then desde el punto de vista del usuario, pasar de ahí a los tests end-to-end será muchísimo más sencillo.

## Sustituye los tests end-to-end por tests de contrato + colaboración

Depender únicamente de tests end-to-end a la larga puede traer problemas.

Los tests end-to-end son muy costosos:

- Son **complejos** de escribir: el setup de un test tiene que levantar y limpiar la infraestructura subyacente: provisionar bases de datos, levantar colas, lanzar background jobs...
- Tienden a ser más **lentos**: al haber llamadas asíncronas a sistemas externos, como HTTP, bases de datos, colas, etc., los tiempos de ejecución aumentan. Si tenemos muchos tests de este tipo, nuestra suite de test se volverá muy lenta, y dejaremos de ejecutarla tan a menudo, perdiendo efectividad.
- Pueden ser **frágiles**: al tener más partes móviles y involucrar a sistemas externos, la probabilidad de que alguna de estas partes falle aumenta. De la misma forma, si no nos podemos fiar de que si el test falla es porque hay algo roto y no porque la BBDD se ha resfriado, dejaremos de confiar en ellos.

Por todo esto, **no debemos abusar de los tests end-to-end** y depender únicamente de ellos.

La solución es adoptar progresivamente el archiconocido modelo de la **pirámide de tests**.

Este modelo nos recomienda tener unos pocos tests end-to-end, lentos pero amplios, y una base de tests unitarios de los componentes, de menor scope, pero más rápidos.

![](/images/blog/posts/test-pyramid.jpg)

Pero, ¿cómo pasamos de tener sólamente tests end-to-end (o un modelo de pirámide invertida) a un modelo en pirámide?

La respuesta es mediante el **refactoring continuo de los tests** junto con el código de producción.

Hay dos situaciones en especial en las que prestar atención:

- En reglas de negocio con una combinatoria muy amplia o compleja. Imagina, por ejemplo, las reglas para calcular impuestos de una factura. En lugar de testear toda la combinatoria con 4735 tests end-to-end, podemos extraer un componente pequeño que implemente esas reglas (y sólo esas reglas), y testear la lógica con tests unitarios, ahorrando end-to-ends.
- Cuando la interfaz de estos componentes se ha vuelto lo suficientemente estable y reutilizable, podemos sustituir algunos tests end-to-end por tests de contrato + tests de colaboración. Comenzamos a tratar el componente reutilizable o subsistema complejo como “código de librería”, y escribimos:
    - Un test de contrato, que verifica que la pieza se comporta correctamente.
    - Un test de colaboración, que verifica que nuestro sistema usa la pieza como debe a través de su interfaz pública, sustituyéndola por un mock / doble de test.

La combinación de test de contrato + colaboración nos da casi los mismos beneficios que un end-to-end, pero sin muchos de sus drawbacks.

Aplicando sistemáticamente estas dos técnicas, poco a poco iremos “esculpiendo” nuestra pirámide de tests.

## El modelo del queso suizo

No hace falta probar todos los detalles con todos los diferentes tipos de tests de nuestra estrategia.

P.ej., si ya estamos probando la combinatoria de las reglas de negocio con tests unitarios, no hace falta probar esa misma combinatoria con tests end-to-end. Quizá es suficiente con tener sólo un end-to-end que pruebe el happy path.

Esto es lo que se conoce como el **modelo del queso suizo**: si imaginamos que cada tipo de test en nuestra estrategia (unitarios, end-to-end, integración…) es una loncha de queso suizo, y los agujeros del queso son casos sin cubrir, lo importante no es que todas las lonchas no tengan agujeros, sino que **la superposición de todas las lonchas no deje ningún agujero al descubierto**.

La idea es utilizar en cada caso el tipo de test más adecuado para lo que queramos probar. Por ejemplo:

- Si vamos a probar si una query compleja con un dialecto de SQL específico se comporta adecuadamente, no usaremos tests unitarios, sino tests de integración contra una instancia de una base de datos real (idealmente con la misma versión específica que usamos en producción).
- Si vamos a probar las diferentes posibilidades de los descuentos que se pueden aplicar a un pedido en función de las campañas de marketing configuradas, no lo probaremos con tests end-to-end pesados, sino con tests unitarios rápidos y específicos.

## Complementa con una buena estrategia de testing manual

La automatización no es el santo grial del testing y la calidad del software: hay cosas que, sencillamente, renta más probar manualmente que pagar el precio de automatizarlas.

Por tanto, tenemos que estar constantemente evaluando dónde conviene y dónde no aplicar automatización.

Esto no quiere decir que descuidemos las partes que no se automaticen.

De la misma forma que los tests automatizados se ejecutan en cada build y en cada despliegue, las regresiones manuales también deberían ejecutarse con la mayor frecuencia posible.

Pero, al contrario que las máquinas, que ejecutan religiosamente los tests siempre igual y sin cansarse, las personas que ejecutamos los tests manuales podemos tener fallos: no ejecutarlos siempre igual, saltarnos pruebas, tener descuidos…

Por ello, es importante que lo que no se automatice, aún así **se procedimente en forma de un plan de pruebas**.

Es responsabilidad de todo el equipo (no sólo de QA) conocer, mantener, **ejecutar (sí, los devs también)** y mejorar este plan de pruebas a lo largo del tiempo.

## La estrategia de test es la clave de la entrega continua

Por desgracia hay muchos equipos que, cuando piensan en entrega continua, tienen la cabeza puesta únicamente en la automatización de la build, las pipelines de CI/CD, etc.

Y es verdad que son cosas importantes, pero una pipeline de CI/CD a la que le metes basura por un lado, sólo puede sacar una cosa por el otro: basura procesada. “***Garbage in, garbage out***”.

![](/images/blog/posts/garbage-in-garbage-out.jpg)

Una buena estrategia de testing marca la diferencia entre un equipo que es capaz de entregar valor a sus clientes de forma sostenida, y uno que no.

¿Y tu equipo, es capaz de entregar valor a tiempo y de forma predecible?

Respóndeme a este email y cuéntame! Estaré encantado de leerte!

Nos vemos en la próxima newsletter.

Un abrazo,
Pedro
