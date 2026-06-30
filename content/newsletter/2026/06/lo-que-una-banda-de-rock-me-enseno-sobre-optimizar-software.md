---
title: 'Lo que una banda de rock me enseñó sobre optimizar software.'
description: 'Cómo un problema de rendimiento, UX e ingeniería acabó reduciendo un 45% el coste de conseguir nuevos oyentes.'
author: pedropardal
date: 2026-06-26T00:00:00.000Z
layout: post
tags: [newsletter]
images: [/images/blog/posts/pedro-guitar.jpg]
featured_image: /images/blog/posts/pedro-guitar.jpg
type: newsletter
issue_number: 19
---

Aparte de dedicarme al desarrollo de software, tengo otra ocupación que no muchos conoceréis: por las noches soy estrella del rock 🤘 🎸

![YEAHHHH](/images/blog/posts/pedro-guitar.jpg)

Bueno, igual me he venido un poco arriba. La cosa es que toco la guitarra en una banda de rock alternativo, [Sibelclan](https://open.spotify.com/intl-es/artist/4sZueNxPiahAGVrLqOzBPF). Hacemos temas propios del estilo de bandas como Muse, Royal Blood, System of a Down o Queens of the Stone Age, y tenemos ya un par de discos publicados.

Aparte de eso, como soy un hombre renacentista que sabe mucho de tó y poco de ná, y me gusta meterme en mil fregaos, dentro de la banda también me dedico a la gestión, la promoción de conciertos, creación de contenido y marketing digital.

Una de las cosas de las que me encargo es de crear y gestionar campañas de *ads* (anuncios) en Meta, para dar a conocer a la banda, y conseguir nuevos oyentes.

En la historia de hoy, os quiero contar **cómo la parte técnica de una campaña de marketing mal montada nos estaba haciendo perder pasta**, cómo usé mi conocimiento técnico para darme cuenta y arreglarlo, y cómo así he acabado ahorrándole a la banda unos cientos de euros en publi cada mes.

## El lado tech de las campañas de anuncios en Meta

Las campañas de Meta son algo súper habitual en el marketing de software, como productos SaaS, servicios de agencia, consultoría o formaciones. Si has trabajado en algún SaaS, es muy probable que tu empresa haga campañas de este estilo como estrategia de crecimiento.

En la industria musical también cumplen un rol crítico: son la gasolina con la que una banda consigue clientes para su producto: la música, los shows en directo y la venta de discos y merchan.

## Cómo funciona un embudo de ventas musical

*(si ya sabes algo de marketing digital, siéntete libre de saltarte esta parte)*

Por poneros en situación, una campaña de marketing musical es un “embudo de ventas”, es decir, un journey de varias fases en las que el potencial cliente (o lead) va avanzando progresivamente. En este caso, funciona más o menos así:

1. El usuario ve un anuncio en Instagram (típicamente un fragmento de un videoclip de una canción concreta). El CTA (*call-to-action*, o llamada a la acción) del anuncio es “Escuchar la canción”. En un producto SaaS podría ser probar la aplicación, registrarse, descargar un white paper…
2. Cuando el usuario clicka en “Escuchar”, se le redirige a una landing page, donde puede seleccionar en qué plataforma musical escuchar la canción (Spotify, Apple Music, Tidal, YouTube…).
3. El usuario escucha el tema en su plataforma favorita, y ya ahí decide si guardar la canción para escucharla luego (save), seguir a la banda (follow) u olvidarse de nosotros para siempre (caerse del embudo).

!image.png

El éxito de una campaña de este tipo se mide con KPIs como estos:

- ***CTR (Click-through rate): e***s el ratio de personas que pinchan en el anuncio sobre el total de veces que se muestra (alcance).
- ***% Click / LPV***: es el ratio de personas que ven la landing sobre el total de clicks en el anuncio. Y alguien podría pensar que deberían ser iguales, ¿verdad? Pos no :D pueden pasar mil cosas entre medias: que la página tarde en cargar (!!), que el usuario se harte y cierre, clicks accidentales, bots…
- ***CPR (”SpotifyClicks”)***: Nº de personas a las que le carga la landing, y que seleccionan una plataforma para ir a escuchar la canción.
- ***Nº de listeners y saves*** en Spotify.

De todas estas métricas, hay una dos en concreto que dependen enormemente de que la parte técnica de la landing page esté montada y funcione impecable: el %clicks/LPV y el CPR o ratio de conversión de la landing.

Y en la primera campaña que lanzamos, tras varios días de dejarlas correr, justo **estas métricas son las que peor iban**.

## La landing page

Existen un montón de servicios para crear landings de marketing musical: LinkFire, FeatureFM, Toneden... Pero todos, o casi todos, cuestan una buena pasta cada mes. Y la banda aún no tiene recursos para permitirse un gasto fijo así.

Así que, como soy ingeniero pensé: para una triste landing page, la puedo montar yo mismo, muy difícil no tiene que ser… ¿qué puede salir mal? 😅

La primera aproximación fue justo eso: montar un sitio estático con Hugo, la herramienta que uso para montar todas las webs estáticas de mis proyectos, con un HTML basicote y el link a Spotify.

Tras 3-4 días en prod, esto es lo que pasó:

- La gente clickaba en el anuncio
- Pero Spotify no registraba ni un solo oyente.

Tras investigar, entendí lo que estaba ocurriendo: la landing page se estaba abriendo en el navegador embebido de la app de Instagram. Cuando clickas en un enlace de Spotify, en el 99.99% de las veces te redirige a la web de Spotify DENTRO del navegador de instagram. En este contexto, no estás logado, y por tanto **Spotify no te cuenta como oyente**.

Es decir, estábamos mandando oyentes potenciales a… la nada.

Peloteando un poco con Claude, me dio un Javascript guarruno que detectaba si estabas dentro de la app de Instagram, y redirigía al usuario a la app nativa. Lo probé y a mi me funcionó, pero tras pushearlo a prod y dejar correr otros 2-3 días, seguíamos con 0 oyentes.

Frustrado por la situación, me di por vencido y opté por cambiar la landing page casera por una de las pocas soluciones que encontré gratuita, pero probada: **SubmitHub links**. No es la mejor, pero lo cierto es que muchas bandas la usan, y no les va del todo mal.

Mejor tener un embudo funcional, aunque no optimizado, que un embudo completamente roto. Ya habrá tiempo de optimizar.

Tras migrar la landing a SubmitHub empezamos a ver los primeros oyentes llegar a Spotify. El embudo estaba funcionando 🥳

## La tasa de conversión

Sin embargo, tras varios días más corriendo, me di cuenta de que el CPR (el coste por resultado, o coste por click en la landing page) se había disparado. La conversión de la landing page había caido apenas a un 23%; es decir, que de 100 personas que llegaban a la landing, solo 23 clickaban en el botón para ir a Spotify. Los otros 77 los perdíamos antes siquiera de poder llevarlos a Spotify. A modo de referencia, un valor sano para este parámetro sería entre un 35-45%.

Hay dos factores principales que influyen en la tasa de conversión de una landing, y tienen que ver con: la velocidad de carga de la página (puramente técnico), y la UX/UI (que la página se entienda, el botón sea visible, el CTA evidente, etc.).

Lo primero que hice fue hacer una prueba de performance con Google PageSpeed Insights. La prueba reveló lo siguiente:

- El arte de la carátula del single era un PNG de 500KB que SubmitHub no había comprimido: lo estaba sirviendo tal cual, a resolución HD, para luego mostrarlo en una caja de 300x300 px.
- La landing se estaba sirviendo directamente desde los servidores de SubmitHub en US, sin CDN. Por tanto el tráfico de España tenía una latencia muy elevada.
- La landing estaba llena de Javascripts de tracking: el pixel de Facebook, Google analytics, Google tag manager, el propio tracking de SubmitHub… que ralentizaban su carga.

La putada es que, cuando usas un servicio de terceros como SubmitHub, saber todo lo que hay mal da igual porque no tienes capacidad de control para cambiar la landing.

Así que se me ocurrió hacer…

## Ingeniería inversa y mejora continua

Mi hipótesis fue: ¿y si cojo la landing de SubmitHub, que sé que funciona (aunque regulera), y plancho el código en una landing propia, desplegada y controlada por mi, que pueda modificar, iterar, mejorar y adaptar a mi gusto?

Y eso hice 😆

- Rescaté la landing de Hugo, pero esta vez usando como base el código de SubmitHub.
- Redije al máximo el tamaño de los assets, comprimiendo la imagen de la carátula del single usando webp, con compresión y tamaño mínimos, hasta tener un fichero de apenas 40KB.
- Optimicé el peso de la página minificando el HTML, inlineando todo el CSS y javascript necesario.
- Eliminé todo el javascript de tracking innecesario y lo sustituí por llamadas al tracking pixel de Meta, que es muchísimo más rápido. Sólo con el Pixel de Meta ya tengo el nivel de trackeo necesario para medir y optimizar campañas, no necesito más Analytics.
- Me ahorré una request inú til al /favicon.ico, añadiendo un favicon vectorial inline.
- Optimicé el delivery worldwide y cacheé todas las peticiones, metiendo la CDN de Cloudflare delante.

El resultado: una web que carga únicamente con 3 peticiones, y que según PageInsights pasó de tardar 4.2 segundos en cargar en conexión 4G a **solamente 1.5s, y 0s de bloqueo**.

Nada mal.

Además, aproveché para hacer 2 pequeñas mejoras de UI/UX:

- Poner un overlay de play sobre la imagen de la carátula del single, para aumentar la superficie de click y dejar un hint visual evidente.
- Aumentar el tamaño de la carátula, siempre teniendo cuidado que el botón de “Escuchar en Spotify” siguiera visible (*”above the fold”*).

## *Show me the numbers*

Gracias a todo esto, conseguí aumentar la conversión de la landing page **de un 23% a un 42%**. Eso, traducido a impacto económico en los costes de campaña, significa que, si antes un click a Spotify nos costaba 1.38€, ahora ha pasado a costarnos 0.76€, **un 45% menos**.

Es decir, que si quisieramos conseguir 100 oyentes al mes, antes nos costaría 138€ de inversión, y ahora podemos conseguirlos sólo con 76€. O visto de otra manera, que si tuvieramos 200€ para invertir (nuestro presu actual para ads), esa cantidad antes nos traerían 145 oyentes; ahora, nos rentaría mucho más, trayéndonos **263 oyentes**. Esto, literalmente, puede marcar la diferencia entre que Spotify empiece a recomendar nuestra música a nuevos oyentes y consigamos crecer de forma orgánica, o la banda se quede estancada.

Y todo esto, sólo optimizando la landing page, con **mejoras puntuales técnicas y de UI/UX**.

## Reflexiones y aprendizajes

1. El primero y más obvio: cuando juegas a escala, pequeñas mejoras y optimizaciones, ya sean técnicas / de rendimiento, o de producto / diseño / UI / UX, tienen un impacto enorme, porque multiplican por números muy grandes (hablamos de que el alcance de las campañas es del orden de miles o decenas de miles de personas).

A la hora de promocionar un SaaS o cualquier otro negocio digital, lo mismo aplica exactamente. Mucha gente puede pensar que este tipo de aprendizajes es algo que solo aplica para optimizar SaaS con miles de usuarios mensuales… pero ya veis que la situación es mucho más de andar por casa de lo que parece.
2. Otro aprendizaje es que, lo que me hizo cuenta de que algo iba mal, y saber dónde mirar, fue el tener conocimiento y ownership end to end de todo el proceso: saber de marketing y montar la campaña, pero además montar la landing, desplegarla, operarla y optimizarla.
3. Otra lección muy valiosa: no te las des de listo y montes algo desde cero: empieza con una solución que funcione (aunque no sea óptima, como SubmitHub en mi caso), demuestra que funciona y, a partir de ahí, optimiza poco a poco.

Durante años hemos pensado que marketing e ingeniería son disciplinas distintas. Pero yo cada vez creo menos en esta separación: **cuando entiendes el sistema completo, eres capaz de ver mejoras que nadie más ve**.

Estas lecciones han salido de un “pet project” como mi banda, pero aplican igual a proyectos más serios. Nunca sabes de dónde vas a sacar nuevos aprendizajes, así que mi filosofía y lo que aconsejaría a cualquiera es mantener siempre la curiosidad y las ganas de aprender.

Y si puede ser con una buena banda sonora de rock alternativo como [Sibelclan](https://open.spotify.com/intl-es/artist/4sZueNxPiahAGVrLqOzBPF), mejor 🤘 🎸
