---
title: 'Este concepto me hizo entender la programación a otro nivel'
description: 'Object Calisthenics son 10 reglas a seguir a la hora de escribir código que al aplicarlas pueden darle un salto de calidad a tu código.'
date: 2024-07-30T00:00:00.000Z
layout: newsletterpost
author: pedropardal
tags: [newsletter]
images: [/images/blog/posts/dojo.jpg]
featured_image: /images/blog/posts/dojo.jpg
card_image: /images/blog/posts/dojo.jpg
type: newsletter
issue_number: 1
aliases:
  - "/newsletter/este-concepto-me-hizo-entender-la-programacion-a-otro-nivel/"
---

Hace ya varios años, me encontré con el concepto de Object Calisthenics.

Por si no lo conocías, se trata de [10 reglas a seguir a la hora de escribir código](https://www.cs.helsinki.fi/u/luontola/tdd-2009/ext/ObjectCalisthenics.pdf), que son fáciles de aplicar (si no quieres, no hay que pensar mucho), y que al aplicarlas pueden darle un salto de calidad a tu código bastante tocho.

Desde que lo conocí me parece un concepto brillante.

Su brillantez viene porque sirve a cualquier programador, independientemente de su nivel.

Me explico.

Para los más juniors, el simple hecho de seguir las reglas al pie de la letra, aún sin pensar mucho, les ayuda a dar un salto de calidad.

Pero sobre todo, ayuda a forjar buenos hábitos.

De hecho, se llaman Object Calisthenics porque, igual que los ejercicios de calistenia, lo importante es la forma y la repetición.

Es decir, lo haces siempre “así” y poco a poco te vas acostumbrando a programar de esa manera.

Pero es que para los developers más avanzados, también es incluso más útil.

Cada una de las reglas viene de un concepto más abstracto, pero es una versión ultra aterrizada y práctica del mismo, para usar en el día a día.

P.ej, la regla del “no más de un punto por linea”.

Esta regla nos dice que no hagamos cadenas de mensajes.

El típico `this.objeto.metodo().otroMetodo().otroMetodoMás().yVengaOtroMasPorQueNo();`

Esta regla viene del concepto de acoplamiento, que es el grado, o la fuerza con la que una clase o método depende de otro.

Si dependemos fuertemente de clases que “nos quedan lejos”, estamos dificultando la mantenibilidad del código, incrementando el riesgo de que ocurra ese fenómeno de “he tocado aquí y se han roto 3 cosas en otro sitio” (*seguro que nunca te ha pasado, verdad?*).

Es decir, el grado de acoplamiento debe ser proporcional a la localidad (a más “lejos” nos quede otra clase, menos acoplamiento queremos con ella).

Volviendo a la regla de calisthenics: cada llamada adicional en una cadena de mensajes, incrementa el acoplamiento de nuestro código con objetos que están “más allá” de nuestro ámbito.

Lo bonito de esta regla, es que a un junior no hace falta explicarle el concepto de acoplamiento. Simplemente sigue la regla (de momento).

Pero con un senior, podemos llegar mucho más lejos, y tener conversaciones mucho más profundas.

En mi curso gratuito de object calisthenics, intento darle este enfoque (por cierto, te lo dejo por [aquí](https://academia.exeal.com/courses/object-calisthenics))

Por cada una de las reglas, te digo qué pinta tiene aplicarla en código.

Pero luego, te explico cuál es el concepto que hay detrás, para que puedas “tirar del hilo” y seguir aprendiendo.

Porque claro, las reglas no son infalibles.

Quizá te pueden ayudar en un 80% de los casos.

Pero en el otro 20% (mira! otra vez la [regla de Pareto](https://es.wikipedia.org/wiki/Principio_de_Pareto)!) necesitas entender los conceptos que hay detrás para tomar buenas decisiones de diseño.

Al final son estas cosillas las que (al menos en el plano técnico) ayudan a marcar la diferencia como developer y líder técnico.
 
- [Aprende Object Calisthenics](https://academia.exeal.com/courses/object-calisthenics?utm_source=newsletter&utm_medium=email)

Un abrazo,
Pedro
