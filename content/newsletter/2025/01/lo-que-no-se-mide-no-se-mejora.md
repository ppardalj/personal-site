---
title: 'Lo que no se mide, no se mejora'
description: 'Para plantear una estrategia de mejora de un equipo, lo primero que hay que hacer es obtener una foto fiable de dónde están actualmente.'
date: 2025-01-24T00:00:00.000Z
layout: newsletterpost
author: pedropardal
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 4
---

Recientemente he comenzado a liderar una iniciativa de transformación y mejora del proceso de delivery de un equipo de desarrollo de un cliente.

Para plantear una estrategia de mejora de un equipo, lo primero que hay que hacer es obtener una foto fiable de dónde están actualmente.

Fiable significa que sea información objetiva, que no esté condicionada por el punto de vista personal de los miembros del equipo

Si, como líder, únicamente te vas a preguntarle a cada uno de los miembros del equipo cómo ven la situación y te fías ciegamente de su criterio, probablemente estés trabajando sobre supuestos falsos.

## La realidad no existe

La percepción de la realidad de cada miembro del equipo está condicionada por sus experiencias pasadas, su seniority, incluso sus relaciones personales con los demás miembros del equipo. P.ej., una persona que esté quemada te dará una versión más catastrofista de la realidad de lo que realmente es.

No me malinterpretéis, obtener esta información de los miembros del equipo es crucial y necesario.

Pero hay que tener en cuenta que es información sesgada y pasada por un filtro.

No puede ser la información que utilicemos como base para evaluar la situación del equipo y tomar decisiones. Tiene que ser información complementaria, utilizada para interpretar y añadir matices de dimensiones adicionales.

En su lugar, hay una cosa que nos da una foto mucho más cercana a la realidad.

Se trata de las métricas.

## Los números no mienten

El equipo puede tener la sensación de que su proceso de despliegue a producción no es lo suficientemente estable y sentirse inseguros.

Pero, ¿cuán inseguros?

La métrica te lo dice.

Lo cuantifica.

Por ejemplo:

***“Un 17% de las tareas que se entregan en producción necesitan retrabajo.”***

Pero, ¿por qué es importante poder cuantificarlo?

Con este número podemos hacer muchas cosas.

Por ejemplo, podemos comprar con valores de referencia para ver si estamos moviéndonos en rangos aceptables.

Según el estudio de [Accelerate](https://www.amazon.es/Accelerate-Software-Performing-Technology-Organizations/dp/1942788339) sobre más de 23.000 profesionales de IT, en empresas de diferentes sectores, tecnologias y tamaños, la media de tasa de errores de un equipo “average” está en un 15%, mientras que los “high performers” están por debajo del 10% y los “elite performers” por debajo del 5%. Sabiendo en qué tipología se encuentra nuestro equipo, sabremos también qué retos nos podemos encontrar dentro de esta tipología de equipos y qué margen de mejora tenemos.

Otro uso de las métricas es valorar el impacto de iniciativas de mejora.

Por ejemplo, ¿qué pasaría si, para reducir el % de retrabajo en este equipo, incrementaramos la cobertura de tests automatizados un 10%, bajo el supuesto de que una suite de test automatizados más extensiva ayudará a cazar más bugs antes en el proceso de entrega?

Sólo podremos saberlo si medimos la métrica objetivo a lo largo del tiempo y analizamos su evolución.

Si después de varias semanas el % de retrabajo baja al 14%, podríamos asumir que la iniciativa de incrementar la cobertura ha tenido efecto.

## Pero, ¿ha tenido el efecto que deseabamos?

Para ello, antes de implementar la iniciativa, hay que formular una hipótesis y definir un objetivo para la métrica. P.ej.:

*“Suponemos que incrementar la cobertura de tests en un 10% provocará una disminución de la tasa de retrabajo en un 5% (del 17% al 12%).”*

Si, finalmente, baja sólo un 3%, podemos decir que ha tenido ligeramente menos efecto del que esperábamos.

Esta es información que podemos tener en cuenta para futuras decisiones.

Cada vez vamos menos a ciegas.

## Pero, ¿qué mido?

Me alegra que me lo preguntes, porque no es ninguna tontería.

Mucha gente que empieza a medir, empieza por lo obvio: ¿qué me dan las herramientas que usamos?

Y comienzan a medir story points, velocidad, el burndown chart y si eso la cobertura de código.

Estas no son unas buenas métricas, o al menos no son buenas si sólo vas a medir eso, primero porque son completamente subjetivas y volátiles (que alguien me diga qué significa un story point), y segundo porque te cuentan sólo la mitad de la pelicula.

En lugar de eso, comienza por medir las 4 key metrics que propone Accelerate o un derivado de las mismas que puedas medir fácilmente:

- Deployment frequency (apunta siempre que se haga una entrega, y sacas la frecuencia por intervalo de tiempo)
- Lead time for changes (para cada cambio, apunta fecha en la que el equipo comenzó a trabajar en el cambio, y fecha en la que se entregó, haces la resta y sacas la media)
- Change failure rate (para cada entrega, apunta si hubo que hacer rollback o un retrabajo considerable)
- Mean time to recover (para cada vez que hubo alguna incidencia con un deploy, apunta cuánto tiempo se tardó en volver a la normalidad, y saca la media).

Hay muchísimas formas de tomar estas métricas: por procesos, con herramientas, etc. Pero lo más importante, es utilizar una forma en la que siempre se tomen, y que siempre se tomen de la misma manera.

Lo que nos interesa, más que valores absolutos, es ver la evolución de la métrica en el tiempo respecto a un objetivo, para saber si estamos mejorando o no y a qué ritmo, y eso si medimos cada vez de forma diferente no podremos hacerlo.

## Pero, ¿qué objetivo ponemos inicialmente?

Muchas veces al principio, te lo tienes que inventar.

Para las 4 key metrics te puedes inspirar en los valores de referencia del estudio de Accelerate.

Pero lo importante, realmente, es poner un objetivo y hacer la medición.

Mientras más mediciones vayamos haciendo, más aprenderemos a establecer valores objetivo y a entender cómo impactan las iniciativas en los números, y unas métricas en otras, en nuestro caso particular.

## Pero ¿cómo empezar a medir?

A los técnicos que nos ha tocado desempeñar roles de gestión, nos puede más la parte de técnico que la de gestor.

Y eso es un arma de doble filo.

Como técnicos, no nos va a temblar el pulso en automatizar la toma de métricas y montar unos dashboards de kpis de la hostia.

Pero, también como técnicos, corremos varios riesgos que ponen en peligro la toma de métricas.

Los dos más peligrosos, son:

1. Se nos va la pinza y acabamos montando una automatización para tomar las métricas en la que invertimos más tiempo que en tomarlas manualmente.
2. No nos gusta hacer cosas manualmente, así que si no hay una automatización o una herramienta que nos de las métricas, no las tomamos.

Personalmente creo que el problema más peligroso es el 2º.

Nos limitamos a las métricas que nos dan herramientas como Jira, Azure Devops, Gitlab o Sonarqube.

Y aunque algunas de las métricas que nos dan pueden ser útiles, en mi experiencia casi nunca son las que buscamos.

Pero acabamos siendo esclavos de las herramientas.

Cuando debería ser al revés: deberíamos usar herramientas que estén a nuestro servicio, que nos den los números que necesitamos, presentados como mejor nos sea útil.

## Pero, ¿qué herramientas?

Pues yo por ejemplo soy muy fan del Excel.

Por ejemplo, se pueden medir las 4 key metrics de accelerate con un Excel y un mínimo de proceso, y os aseguro que es más útil para hacerle una radiografía a un equipo que todos los dashboards y widgets y reports que las herramientas corporate nos pueden dar.

Y lo mejor, es que en Excel puedes hacer lo que te de la gana: fórmulas, visualizaciones, agregaciones, filtrados…

Y encima es gratis.

Todo esto es la base de la gestión cuantitativa

Es decir, una gestión basada en datos, en lugar de en opiniones subjetivas.

Es un tipo de gestión que es ampliamente utilizada en empresas y en producto, pero que, por algún motivo, no está tan extendido en la gestión de equipos de desarrollo de software.

Incluso cuando…

## La gestión cuantitativa es condición necesaria para la mejora continua

Porque, recordemos: lo que no se mide, no se mejora.

Porque si no tenemos herramientas que nos permitan valorar objetivamente si nuestras iniciativas de mejora están teniendo efecto o no, vamos completamente a ciegas.

Lo que no sé, es por qué este tipo de gestión no está más extendida: muy pocos de los equipos con los que he trabajado optimizan su operativa tomando decisiones basadas en datos.

Quizá es porque, como industria, aún no entendemos del todo bien qué métricas están relacionadas con la eficiencia operativa de un equipo.

Quizá es porque, como líderes, creemos que no podemos obtener estas métricas porque nuestras herramientas no nos las dan, o porque nuestros compañeros de equipo no son lo suficientemente disciplinados para reportarlas sistemáticamente.

O quizá es porque los líderes de equipo, que vienen de un background puramente técnico, no tienen conocimientos en este tipo de gestión. 

Quiero creer que es esta última, o al menos es lo que me pasaba a mi.

Pero, en los últimos años que vengo teniendo la empresa, he estudiado bastante sobre gestión cuantitativa (a nivel de empresa) y he aplicado esos conocimientos en la gestión de equipos de desarrollo, con muy buenos resultados.

Porque las bases son las mismas.

Si te interesa el tema, déjame un mensaje para que lo sepa y así hablar más sobre el tema.

Nos vemos en la próxima newsletter!

Un abrazo,
Pedro
