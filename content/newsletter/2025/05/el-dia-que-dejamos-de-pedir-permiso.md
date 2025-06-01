---
title: 'El día que dejamos de pedir permiso'
description: 'Cuando lideraba el equipo de Visual Content en Trivago, me cansé de tener que pedir permiso para mejorar nuestro sistema.'
date: 2025-05-21T00:00:00.000Z
layout: newsletterpost
author: pedropardal
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 7
---
Cuando lideraba el equipo de contenido visual en Trivago, me cansé de tener que pedir permiso para mejorar nuestro sistema.

Por si no lo conoces, Trivago es uno de los mayores portales web de comparación de precios de hoteles.

Estábamos desarrollando funcionalidades críticas para el contenido visual de los hoteles. El tipo de contenido que, **si no funciona, afecta directamente al revenue de la empresa**.

Pero cada mejora era una odisea.

Nuestro codebase estaba en librerías que las aplicaciones que consumían las imágenes importaban como dependencias.

Por tanto, dependíamos del ciclo de releases de hotel search, del equipo del backoffice de hoteles, de procesos compartidos y código que no controlábamos.

Podíamos desarrollar una mejora… pero teníamos que esperar dos semanas para que viera la luz.

Si algo se rompía, tocaba debuggear en un entorno que no era nuestro.

Y si algo se rompía en otro equipo, nuestro despliegue se caía igualmente.

Cada cambio era un riesgo.

Cada release, un infierno.

## **Me sentía atrapado en un sistema que no podíamos evolucionar.**

Y todo era por la arquitectura.

Por las dependencias.

No importaba cuán bien escribiésemos el código si todo estaba acoplado a otras apps.

Durante meses, la mayor parte de nuestro tiempo no se iba en aportar valor, sino en lidiar con operativa, coordinación, y arreglar cosas que ni habíamos roto.

80% de nuestro tiempo, literalmente.

Y lo peor: ya lo veíamos como normal.

Hasta que lo cuestionamos.

---

## **¿Qué hicimos exactamente?**

Creamos una solución de tres piezas, que llamamos **Project Casanova**:

**Image API**: Un backend propio con contratos bien definidos, ownership dentro del equipo y despliegue independiente.

  - Empezamos con un documento blueprint, desacoplamos por completo de hotel search y expusimos una capa REST estable.
  - Creamos un cliente reusable que los demás equipos podían integrar sin depender de nuestro ciclo.

**Nuevo flujo de datos**:

  - Separación total del esquema de base de datos legado de hotel search, rediseñando el modelo de datos y añadiendo la metadata necesaria para implementar nuevas funcionalidades.
  - Esto nos permitió migrar a un modelo *push* liderado por el equipo de contenido (en vez de depender de triggers externos).

**Image Admin Area**:

  - Herramientas internas para dar autonomía al equipo de contenido.
  - Mejor gestión de inventario, estado de procesamiento y control de calidad visual.

Pasamos de una arquitectura centrada en librerías compartidas y sincronización forzada…

a una arquitectura orientada a APIs, con límites claros y decisiones reversibles.

Pero sobre todo…

## **Pasamos de esperar dos semanas… a desplegar varias veces al día.**

Esa decisión nos cambió la vida:

- Redujimos el tiempo dedicado a operativa del 80% al 40% en solo tres meses.
- Aceleramos el desarrollo del Admin Area para Content.
- Mejoramos la ingestión de imágenes HQ desde nuestros content partners.
- Facilitamos la integración con otros equipos con APIs limpias.
- Y lo principal: mejoramos la calidad visual en las fichas de hotel. Más contexto para el usuario → más clickouts → más revenue.

Todo eso gracias a una sola decisión de arquitectura, bien pensada.

Una que devolvió al equipo la autonomía que nunca debimos perder.

## **La autonomía técnica empieza con un diseño que te deja respirar.**

Quizá tú también estás en un sistema que ya te parece “normal”, pero que en realidad te está atando las manos.

Quizá estás apagando fuegos sin saber que la fuente del incendio es arquitectónica.

Y quizá necesitas un espacio donde puedas pensar estas decisiones con perspectiva, con herramientas, con criterio.

Este jueves 22 a las 19:00, hago una sesión AMA (*ask me anything*) en directo.

Responderé dudas sobre arquitectura, diseño evolutivo, modularidad, y cómo tomar decisiones que de verdad cambian cómo trabaja un equipo.

Al final, compartiré también cómo puedes seguir profundizando con la formación avanzada Master Arquitecto.

Para venir, sólo tienes que apuntarte aquí:

[[Apuntarme al AMA]](https://us06web.zoom.us/meeting/register/dcWo7VadSXmLbQ_T-aEU8w)

Nos vemos el Jueves a las 19:00

Un abrazo,

Pedro
