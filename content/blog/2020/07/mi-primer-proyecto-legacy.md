---
date: 2020-07-27T00:00:00+01:00
title: Mi primer proyecto legacy
featured_image: '/images/nesa-by-makers-kwzWjTnDPLk-unsplash.jpg'
card_image: '/images/nesa-by-makers-kwzWjTnDPLk-unsplash.jpg'
images: ['/images/nesa-by-makers-kwzWjTnDPLk-unsplash.jpg']
tags: ["legacy-code", "batallitas"]
author: pedropardal
layout: post
aliases:
- "/post/mi-primer-proyecto-legacy/"
---

Mi primer contacto con código legacy fue hace ya más de 15 años, y ni siquiera sabía lo que era código legacy. En aquella época, jugaba a un juego online que se llama [Ultima Online](https://uo.com/) (si por casualidad has llegado a jugar, dame like, suscribete y activa la campanita). Básicamente es un RPG de mundo abierto donde puedes interactuar con los personajes de otra gente, ir a matar bichicos, pegarte de hostias con los demás… algo parecido al WoW, pero más viejuno todavía, con gráficos en 2D isométricos cutres.

![](/images/blog/ultima-online.jpg)

Como en aquella época no tenía pasta para pagarme los 20 eurazos al mes que costaba la suscripción al servidor oficial, pues jugaba en los servers piratas que había. Estos servers piratas, que estaban mantenidos y gestionados por gente de la calle que nada tenía que ver con la empresa que llevaba el juego, pues os podéis imaginar, los dueños hacían lo que les daba la gana: ponerle oro a sus colegas, banear a la gente que le caía mal sin motivos, no eran capaces de arreglar bugs que la gente usaba en su beneficio… total, que la experiencia era nefasta.

Esto me llevó a mi y a un amigo a darle forma a la idea de montarnos nuestro propio server: *"¡en nuestro server el staff no será corrupto porque nosotros no nos corromperemos!"*, *"¡trataremos a todo el mundo por igual!"*, *"¡arreglaremos todos los bugs para que la experiencia sea la mejor!"* (Spoiler alert: no dimos ni una). Así que nos pusimos a investigar cómo montar nuestro propio server.

![](/images/blog/bender-server.jpg)

Lo interesante de esto, y por lo que lo cuento, es porque para montar un server, existía (y existe) un proyecto open source llamado [RunUO](https://github.com/runuo/runuo), que te permitía montar un server con código C# sobre la plataforma .NET. Era una aplicación de consola, que se comunicaba con un protocolo custom a nivel de byte con los clientes (ni APIs ni HTTP ni nada), y que en vez de base de datos tenía todos los datos del mundo en memoria, incluso los de jugadores que no entraban al server hacía años, esos también.

Y así fue como tuve mi primera experiencia con un proyecto grande (~500k líneas de código), que no tenía ni un sólo test, y que estaba escrito en su mayor parte por gente que tenía poca idea de ingeniería del software y buenas prácticas… pero que oye, de alguna forma… funcionaba. Mi primer proyecto era código legacy, y yo ni lo sabía.

## UO Legends

Durante los siguientes 10 años que duró UO Legends, el server que montamos, se convirtió en el servidor no oficial más grande de España, monté un equipo de 10 personas de los cuales hasta unos 5 hacíamos contribuciones regulares de código, y mi equipo y yo [desarrollamos 2 expansiones completas del juego](https://www.youtube.com/watch?v=2QlM9xTkyww), un montón de funcionalidad, corregimos infinidad de fallos, metimos otra infinidad porque claro, el código no tenía tests :P así que tocabas una cosa y se rompían tres :D.

![](/images/blog/uolegends.jpg)

Desarrollar y probar cosas sobre este proyecto tampoco era tarea fácil. Para que os hagáis una idea, cada vez que querías probar un pequeño cambio, tenías que parar el server, desconectar los clientes, re-compilar toda la base de código (que tardaba ~2 minutos), volver a cargar toda la “base de datos” en memoria (que para el server de producción, si lo traías a local tardaba alrededor de 10 minutos), conectar los clientes, y probar a mano lo que quisieras. Y si te dejabas algún detallito pues… vuelta a empezar.

Seguro que os habéis tenido experiencias similares en vuestros proyectos. Yo os cuento éste porque es el que puedo contar y el que más me marcó pero… os hacéis una idea.

Este proyecto lo empecé en… 2005. Para 2007 empecé la carrera, acabé las asignaturas en 2012 y ese mismo año empecé a trabajar. Y claro, en el mundo real, pues también te encuentras legacy, está por todas partes. Y a mí siempre ha sido un tema que me ha llamado mucho la atención, siempre he tenido una vena perfeccionista que me ha llevado a “querer arreglar las cosas que no están rotas”. Y entre una cosa y otra, me decidí a hacer mi proyecto de fin de carrera, precisamente sobre legacy code, y precisamente usando este proyecto del Ultima Online como excusa.

## Mi proyecto de fin de carrera

*“Estudio y refactorización del código del servidor de un juego multijugador online masivo”*, que bueno, por el nombre pues es bastante descriptivo, te puedes imaginar.

¿Cuánto tiempo crees que me llevó hacer el proyecto? ¡3 años! O sea, hasta finales de 2015 no defendí el proyecto de fin de carrera. Y básicamente, el motivo por el que tardé tantísimo tiempo en hacer el proyecto (aparte de porque ya estaba trabajando, y ves que el dinero entra en la cuenta, y pues dices ¿pa qué carajo voy a acabar la carrera?)... no, en serio, el motivo principal fue, que abordé el legacy completamente MAL.

Intenté documentar una aplicación de 500k líneas de código, sin priorizar nada, sin un objetivo, más allá del “mejorar por mejorar”, de la utopía de “voy a cambiarlo todo para dejarlo perfecto”, y planteé varias líneas de trabajo, algunas de las cuales eran muy interesantes a nivel académico, y con las cuales aprendí un montón, pero que, en la práctica… la mayoría no valían para nada. Me comí infinidad de horas de frustración peleándome con ese código, pero lo bueno después de todo, es que saqué muchas lecciones.

## Lecciones aprendidas

Os quiero contar las tres lecciones que a mi parecer fueron más importantes.

1. La primera, es que **siempre habrá legacy**. No importa cuánto mejores el código, esa arquitectura perfecta, ese código perfecto… no existe. Y si existe, ni siquiera merece la pena alcanzarlo, pues el coste de llegar allí es prohibitivo. Es, asintótico, en el mismo sentido que en física, [nunca se puede llegar a alcanzar la velocidad de la luz](https://www.youtube.com/watch?v=biaVwtKOlWI), porque el coste de energía sería cada vez mayor y mayor. Por tanto, no se puede. Si pintásemos la curva de mejora de legacy code en función del esfuerzo invertido, hay un punto de rendimiento decreciente a partir del cual perdemos ROI, y deja de tener sentido invertir.

2. La segunda lección, es que hay que **localizar la mejora del código alrededor de un objetivo**. Mejorar por mejorar puede estar muy bien con fines académicos o didácticos, pero cuando te enfrentas a un proyecto en el mundo real, si no tienes un problema que resolver que motive invertir esfuerzo… todo el esfuerzo habrá sido en vano.

3. Y por último, la tercera lección, es que para vencer con éxito al monstruo del legacy code, hay que **contar con las habilidades, herramientas y técnicas adecuadas**. Hay que saber de orientación a objetos, pero también hay que controlar de testing. Hay que abordar el problema desde un punto de vista pragmático, y tener el mindset adecuado para que “no se te vaya la pinza”.

Todo esto yo no lo tenía en su momento y lo he ido desarrollando con el tiempo a base de palos como esta historia que os he contado. Reciéntemente me decidí a poner en valor éstas y otras experiencias, y montar un [curso de legacy code](https://www.exeal.com/legacy) para que tú no tengas que aprender a base de palos. Si trabajas cada día con un proyecto así y *no te gusta, te da sustito y te asusta*, yo que tú no me lo pensaba.

---

PD. Si te interesa te puedes bajar la memoria de mi proyecto de fin de carrera [aquí](https://drive.google.com/file/d/11p9r3qFSUmITv0TzbuccXu2WZf5dZB_-/view?usp=sharing) (Disclaimer: es un tostón de más de 200 páginas). 
