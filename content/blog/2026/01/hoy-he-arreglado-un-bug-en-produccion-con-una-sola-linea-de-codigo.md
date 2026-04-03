---
date: 2026-01-30T00:00:00+01:00
title: Hoy he arreglado un bug en producción con una sola línea de código
featured_image: '/images/blog/1713271807954.jpg'
card_image: '/images/blog/1713271807954.jpg'
images: ['/images/blog/1713271807954.jpg']
author: pedropardal
layout: post
tags: ["opinion"]
---

Hoy he arreglado un bug en producción con una sola línea de código.
Tiempo total: 2 horas y 45 minutos. ¿Mucho o poco?

Me he tirado ese tiempo debugando, escribiendo un test que reprodujera el bug (verlo en rojo), aplicando el fix mínimo y viendo cómo el test pasaba a verde.

El cambio real fue una línea.

¿La diferencia? -> Ahora tengo un 100 % de confianza en que el bug está arreglado.

Antes de esto, el propio CEO me contaba que durante mucho tiempo, el discurso era “sí, sí, ya está arreglado”…

Pero no era verdad.
Los bugs volvían a aparecer.

No porque hubiera mala intención, sino porque no se testeaba y no había ninguna garantía real.

Esta vez sí la hay.

He aplicado TDD. Y ahora puedo decir, sin matices, que el fix funciona.
Eso genera algo clave: CONFIANZA.

- Confianza para que negocio pueda planificar y saber qué puede esperar del sistema.
- Confianza en mi trabajo, porque si digo que algo está arreglado, lo está.
- Y confianza futura, cuando tenga que proponer cambios más grandes y sepa que mi criterio técnico es fiable.

¿Parece mucho tiempo para arreglar un bug de una línea?
Yo creo que no.

Piensa en las horas que se gastan de otra forma:

- retrabajo
- Customer Support atendiendo el mismo problema
- el equipo dev volviendo a debugar porque el “fix” no funcionó.
- el CEO entrando en modo pánico

Estas 2:45h son una inversión que se hace una vez y se acabó.

Coste fijo.
Resultado predecible.
Usuarios felices.
Negocio contento.

No he tardado 2 horas y 45 minutos en escribir una línea.
He tardado 2 horas y 45 minutos en cerrar el bug para siempre.
