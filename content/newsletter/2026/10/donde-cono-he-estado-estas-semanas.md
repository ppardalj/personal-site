---
title: '¿Dónde coño he estado estas semanas?'
description: 'Tres meses construyendo side projects con agentes, cerrando redes para cortar el ruido, y un catálogo de patrones nacido de repetir las mismas soluciones.'
author: pedropardal
date: 2026-10-04T00:00:00.000Z
layout: post
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 21
---

Hace unas semanas (desde verano) que no publico nada en la newsletter. Aproveché que terminé un proyecto en cliente y se me quedaron bastantes horas libres para, obviamente descansar, pero también empezar varios side projects. He aprovechado para dar vida a algunas ideas que tenía por ahí aparcadas a nivel personal, y de paso ponerme las pilas con el desarrollo agéntico, ya que sentía que estaba bastante desactualizado.

Algunas cosas que he construido estas últimas semanas:

- [https://github.com/Ne2-Studio/el-baul](https://github.com/Ne2-Studio/el-baul) : una app para familias, para compartir fotografías y recuerdos familiares.
- [https://github.com/ne2-studio/cashclarity](https://github.com/ne2-studio/cashclarity) : una app de gestión de saldos, para llevar mayor control de las finanzas personales y profesionales.
- [https://github.com/ne2-studio/leadhub](https://github.com/ne2-studio/leadhub) : un pequeño gestor de respuestas de formularios de contacto para mis webs.
- [https://github.com/ne2-studio/reforge](https://github.com/ne2-studio/reforge) : una app para llevar trackeo de las comidas y ejercicios
- [https://github.com/ne2-studio/fanflow](https://github.com/ne2-studio/fanflow) : una plataforma para crear smart links y landings de marketing musical (para mi banda Sibelclan).

Aparte de esto, el cliente con el que acabé (un e-commerce) me volvió a llamar, y he empezado un proyecto súper chulo: una plataforma BNPL (*buy now, pay later*), integrada con Shopify, para que los clientes del e-commerce puedan comprar a crédito y pagar más adelante.

Todos estos proyectos los estoy desarrollando intensivamente con agentes. Y en cuestión de apenas 3 meses ha cambiado radicalmente la forma en la que desarrollo software. La verdad es que echo la vista atrás, y han sido unas semanas TAN intensas y con TANTOS cambios que no sabría por dónde empezar. Precisamente es uno de los motivos por los que me apetece contarlo: ponerme en orden las ideas, y compartirlo con vosotros.

Supongo que todo comenzó en algún momento del principio del verano. Como ya os conté en su momento, estaba bastante saturado del mundo influencer, de que si no tenías 10 agentes corriendo en paralelo eras un mindundi, de que el apocalipsis de los developers estaba a la vuelta de la esquina, blablabla.

Así que tomé una decisión: **Cerrar las redes**.

**Cortar el ruido de raíz.**

Hice el siguiente trato conmigo mismo: durante unas semanitas, en vez de dejarme llevar por el FOMO y el síndrome del impostor, iba a centrarme en descubrir por mí mismo qué ha cambiado y qué no, pero construyendo cosas de verdad. Sentía que tenía que ir acompañado de hacer el ejercicio de dejar ir todas las buenas prácticas y fundamentos que creía inamovibles, y subir el potenciómetro del escepticismo al máximo. ¿TDD? quizá ya no aplica. ¿clean code? supongamos que es verdad que a los agentes les da igual. ¿arquitectura hexagonal? no por defecto.

Ha sido un ejercicio bastante duro, cualquiera que os diga que poner en duda tus convicciones de una carrera entera es fácil no tiene ni idea, se te tambalea todo. Pero decidí confiar en que tengo criterio, buen juicio y experiencia suficiente como para encontrar la verdad de todo esto por mí mismo.

Y buah, *what a ride*.

Siento que he aprendido más en 2 meses que en los últimos 4 años, a todos los niveles: arquitectura de software, tecnología, obviamente agentes/IA, discovery de producto, incluso a mí mismo. Y finalmente, hace relativamente poco, he vuelto a encender las redes en modo oyente, y no deja de ser gratificante ver como muchas de las conclusiones a las que estoy llegando van en la misma línea de hacia dónde están yendo gente a la que sigo y admiro. Nunca viene mal un poquito de validación, jejej.

Contaros en un único post todo lo que he ido aprendiendo estos meses sería imposible, así que lo iré dosificando en varios posts que iré escribiendo poco a poco a medida que vaya teniendo tiempo. Igual me tomo la licencia de apoyarme un poquito en la IA en alguno de ellos, pero es que sino siento que no los voy a sacar nunca, y **mejor hecho que perfecto**.

En cualquier caso, os dejo con algunos de los temas sobre los que me apetece escribir las próximas semanas:

- Las skills que no pueden faltar en ningún proyecto: *run* y *verify*.
- Estrategia de testing para codebases agénticas: *component acceptance testing*.
- Arquitectura de *deep modules* para optimizar la carga cognitiva de los agentes (y personas) y reducir el blast radius de los cambios.
- Los dos modos de trabajo con agentes: *modo interactivo y modo desatendido*.
- Cómo lanzar código a producción *sin leerlo*, sin cometer irresponsabilidades y sin sentir culpa.
- Codebases que se curan a sí mismas: modelo de atributos de calidad y la skill *find-architecture-gaps*.
- Patrones de desarrollo agéntico: software factory lights out vs tripulación de agentes: ¿qué trend ganará?
- Construyendo mi propia software factory 😈

Pero tampoco quiero terminar este post con una lista de cosas chulas y dejaros con la miel en los labios. Así que os quiero compartir algo.

## Donde hay patrón no manda agente

Esta semana pasada estuve compilando una lista de problemas/soluciones que me he encontrado durante estas semanas en todos los proyectos en los que he trabajado. Todas tienen en común que han sido situaciones en las que:

1. Me he encontrado en más de un proyecto el mismo problema, y he aplicado una solución similar.
2. El agente no ha dado con la solución él solo, y yo he tenido que diseñarla a nivel arquitectónico y hacerle steering en esa dirección concreta.

Después de copiar las mismas soluciones una y otra vez en diferentes codebases y ver como se me quedaban desactualizadas, decidí hacer un catálogo de patrones como referencia para que el agente pudiera leerlo y, tomando eso y otro proyecto como implementación de referencia, pudiera replicar la misma solución en múltiples proyectos.

Y bueno, realmente los patrones no tienen absolutamente nada que ver con agentes: la mayoría son aplicaciones de conceptos, fundamentos o arquitecturas a tecnologías / frameworks concretos. Por ejemplo:

- Host fino y deep modules en C#
- One build, many deploys en SPAs frontend.
- Tests de aceptación sobre imagenes docker ya construidas.
- Arquitectura hexagonal en C#.
- Arquitectura en capas para frontend React.
- … y muchas más.

En total, son 17 artículos de momento, todos con la misma forma: Problema, Solución, Implementación, variantes y ejemplos / referencias reales. Están escritos con la ayuda de Claude, con una fase previa humana de input, otra posterior de edición, y usando como referencia todas las codebases donde se aplicó el patrón.

Cada patrón tiene un nivel de madurez inspirado en el Tech Radar de Thoughtworks, en función de lo maduro que considere el patrón y el número de proyectos donde ya está aplicado con éxito: Experimentando, En pruebas y Adoptado.

La idea es ir ampliando el catálogo con todos los patrones que me vaya encontrando en el futuro, basado en el trabajo real de proyectos reales, y con referencias open source siempre que sea posible.

Aquí os lo dejo:

[http://patterns.exeal.com/](http://patterns.exeal.com/)

Espero que os sea útil, y me encantaría oír vuestro feedback, como siempre, para saber si este contenido es útil o no. Por mi parte, seguiré trabajando y escribiendo para ir compartiendo los temas en los que he ido trabajando estas semanas.

Hasta entonces, nos vemos en la próxima versión =)

Un abrazo,
