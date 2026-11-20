---
title: 'Las dos skills que todo proyecto agéntico debería tener'
description: 'Cómo las skills run y verify le ahorran al agente redescubrir en cada tarea cómo levantar tu aplicación y cómo verificar sus cambios.'
author: pedropardal
date: 2026-10-13T00:00:00.000Z
layout: post
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 22
---

Cuando me metí de lleno en el mundo del desarrollo con agentes, no paraba de escuchar supuestas maravillas sobre la capacidad de los modelos. Que en cuestión de meses, incluso semanas, cada nuevo modelo que salía era un salto cualitativo enorme sobre el anterior, que cambiaba absolutamente el workflow de desarrollo, etc. etc.

Así que tomé la decisión de que, efectivamente, le iba a dar una oportunidad, iba a abrazar el “vibe coding”, a probar las capacidades reales del arnés que había elegido para la prueba, Claude Code. En un fin de semana, lo puse a desarrollar dos MVPs de dos proyectitos que llevaba tiempo queriendo desarrollar. Y efectivamente, el tío me oneshoteó los dos MVPs en una tarde cada uno. No os voy a negar que ese finde tuve una pequeña crisis existencial y estuve a puntito de replantearme mi carrera y mi vida y considerar seriamente montar un huerto y dedicarme a criar lechugas.

Pero lo que me salió fue el orgullo.

El orgullo de 14 años dedicándome profesionalmente a escribir código, y de más de 20 de hacerlo cada día. Mi identidad de toda una vida como desarrollador de software de repente se vió en peligro de verdad, y mi reacción fue:

*“Ni de coña una máquina estúpida va a hacer esto mejor que yo, que llevo 20 años dedicándome a ello.”*

Y acto seguido, diseñé una estrategia para humillarla: pedirle cada vez cosas más chungas. En algún momento se tendrá que dar la hostia. Ahí estarán sus verdaderas capacidades.

Vamos a buscarle las cosquillas al modelo.

Empecé a añadir feature tras feature tras feature, a cada cual más compleja, y la verdad es que las goteras no tardaron mucho en empezar a salir. Cosas que yo creo que hemos experimentado todos: algo que estaba funcionando pasa a romperse, diffs que solo AÑADEN lineas y código que va a engordando cada vez más, con sus consecuencias evidentes: cada vez más tiempo para desarrollar una feature, cada vez más consumo de tokens, mentiras y alucinaciones cada vez más frecuentes. y la frustración de tener cada vez más conversaciones de este estilo:

- modelo: ya funciona
- yo: no man
- modelo: uy es verdad perdona, lo arreglo
- yo: sigue sin funcinoar
- modelo: jeje ups sorry
- yo: …
- *<repeat>*

Nada que no sepamos desde hace tiempo.

Así que, en unos días pasé del miedo a “me quedo sin curro”, a la frustración de “este bicho es tonto”, mezclada con un poquito de alivio, y al final acabó dando paso a la curiosidad.

Claramente, el bicho tiene un techo a partir del cual empieza a fliparse y deja de trabajar bien. Pero por otra parte, también tiene unas capacidades increíbles, mucho mayores de las que yo pueda tener. La pregunta entonces es: ¿cómo puedo ayudarle para que pueda sacar todo su potencial y quitarle piedras del camino? (Piedras que por otra parte se ha puesto él mismo, pero eso es adelantarnos).

O, dicho de otro modo: cuál es la mejor forma de hacer equipo.

## Ayudar al bicho

Sin ayuda, el modelo trabajando en tu código es básicamente un caballo desbocado. Existen esencialmente dos formas de ayudar al modelo, que seguro que habéis oído hablar de ellas:

- ***Steering***: Decirle explícitamente lo que no podría averiguar de otra manera.
- ***Guardrails***: Darle límites duros de los que no se puede salir.

Cada categoría es un mundo, y dentro de cada una hay a su vez muchísimas técnicas. El steering es la más sencilla, la más efectiva al principio y la primera que yo usé.

Si sabéis como funciona un modelo, sabréis que no tiene absolutamente nada de memoria: cada vez que le pides una tarea nueva parte de un estado completamente vacío (bueno, tiene el system prompt, los CLAUDE.md y poco más). El agente entonces tiene que, en base a la tarea que le das, explorar tu codebase y descubrir el conocimiento necesario para llevarla a cabo.

Esto puede significar:

- leer el código
- leer scripts para saber cómo se opera
- reconstruir el conocimiento del dominio
- leer documentación

Todo esto, cada vez que le das una tarea.

Esto, que al principio es casi trivial, con el tiempo, los cambios, el slop creciente, parche sobre parche, incrementos de complejidad… cada vez le cuesta más. Si notas que al modelo empieza a costarle terminar tareas, ¿por qué no observar dónde se queda atorado y le damos instrucciones para ponerle las cosas más fáciles?

## Identificando lo que le cuesta

Al principio, hacía esto simplemente siguiendo la salida de Claude, y viendo en tiempo real lo que estaba haciendo. Es un coñazo, pero se pueden ver muchas cosas prestando atención.

Hoy en día uso la skill `/retro` después de cada sesión, que básicamente inspecciona el log de Claude, mira el uso de tools, el razonamiento intermedio etc, e identifica puntos de mejora.

(mi versión de la skill aquí, inspirada por la de Matt Pocock, aquí).

Y hay dos tareas que el modelo tiene que averiguar literalmente en el 100% de runs:

1. cómo ejecutar tu aplicación,
2. cómo verificar los cambios que ha hecho.

Sin steering, tiene que averiguarlo cada vez: tardará mucho, consumirá más tokens, e incluso puede que no lo haga a medida que el codebase crezca.

Con steering, tú le dices exactamente cómo hacerlo, y eso que ya tiene ganado.

¿Cómo?

Con **skills**.

## La skill “run”: cómo levantar un entorno de forma determinista

¿Por qué querría un agente levantar un entorno de ejecución de tu aplicación?

Primero, porque tú se lo pidas, que estamos muy vagos últimamente.

Pero sobre todo, para verificar su trabajo contra un entorno real.

¿O cómo si no va a comprobar que lo que ha hecho cumple la especificación de lo que lo que tú le has pedido? ¿Leyendo el código que él mismo ha escrito, y fiándote de que te diga “ya está man, todo ok”? Nah.

No voy a entrar aún en cómo hacer que haga esto siempre. El caso es que, suponiendo que se de cuenta de que lo necesita, ¿cómo lo hace?

Esto que puede parecer un problema trivial, no lo es para nada.

Cada aplicación es diferente y tiene sus particularidades a la hora de crear un entorno de ejecución. A veces no es tan fácil como levantar un servidor vite, igual necesitas un backend detrás rulando, hace falta construirlo, pero es una imagen docker, pero detrás necesita una base de datos, pero hay que meterle seed data, pero hay que comprobar que no esté corriendo ya de antes, pero además necesitas un servidor de autenticación para poder logearte, o un object storage, o un broker de colas… a lo mejor lo tienes en un docker compose, o tienes las piezas separadas, o algunas en un docker compose pero quieres que vite se ejecute fuera porque asi tienes hot reload y no montar un volumen en un container… BLABLABLABLABALA.

Las posibilidades son infinitas.

Y mientras más complejidad, más se lía un agente.

Solución: darle las instrucciones. Y para eso tenemos las skills. En concreto, podemos crear una skill `run`:

```yaml
name: run
description: “Provides a known, stable local environment for this app. Use when asked to run, start, inspect, screenshot, or manually exercise the API or the admin panel.”
model: haiku
```

Dentro de esa skill puedes describir los comandos que el agente tiene que utilizar para levantar el entorno: qué piezas hay, cómo levantar cada una, corner cases que se puede encontrar, etc.

En mi caso, por ejemplo, que desarrollo apps que tienen un frontend y un backend, describo varios modos de ejecución: `frontend-dev`, `backend-dev` y `full-stack`.

- **Frontend-dev** me arma un servidor vite con hot reload contra una imagen docker del backend ya construido. Así tengo un backend listo para funcionar y un frontend que se recarga en real time.
- **Backend-dev** no me levanta el frontend, solo una API, pero fuera de docker, con hot reload, para hacer lo propio cuando estoy tocando backend.
- **Full-stack** compila todos los contenedores y monta un entorno docker-compose, para que el agente pueda hacer pruebas end 2 end usando un navegador controlado con playwright.

Pero esto es para UN proyecto y UNOS casos de uso / forma de trabajar concretos. Cada proyecto tendrá los suyos.

Por eso, considero que la skill `run` es algo que cada proyecto debe proporcionar la suya.

Con el tiempo, me fui dando cuenta de que la superficie de comandos para levantar el entorno era bastante limitada y que rentaba más automatizarlo con scripts deterministas que con una skill, de tal forma que el resultado final es:

- **scripts/run-env:** un bash determinista que levanta el entorno en los diferentes modos, limpia procesos, visualiza logs etc.
- **.claude/skills/run**: una skill más finita que solamente le explica cómo usar el bash, la narrativa y casos particulares más concretos descritos en lenguaje natural.

O sea, lo que está probado y se puede automatizar, se automatiza. Lo que es más ambiguo y renta más describirlo de palabra, a la skill.

Pero hay otra cosa igual de importante que lanzar un entorno: conseguir que Claude no considere un diff que “tiene buena pinta” como una prueba de que lo que ha hecho es correcto. Para esto existe la skill “**verify”**.

## La skill “verify”: verificación basada en riesgo

La skill verify es otra skill que considero que todo repo debería tener. Al final, no es más que, de nuevo, decirle a Claude cómo tiene que verificar los cambios que ha hecho.

Inicialmente puede ser tan sencillo como: corre los tests + el comando que tiene que ejecutar.

Todo esto, evidentemente, asumiendo que tienes una buena suite de tests y que te fías de ella, cosa que no tiene por qué ser cierta, pero de la que hablaremos en otro momento.

Pero, suponiendo que sí, el reto no es tanto decirle que la ejecute, sino en un repo que cada vez crece más y cuya suite de tests también va creciendo, no ejecute una batería de tests completa de 30 minutos para verificar cualquier cambio, sino que Claude tenga conocimiento de qué tests tiene que ejecutar para cada tipo de cambio, PERO sin tener que descubrirlo en cada run.

La estrategia es la siguiente:

1. **scripts/verify:** Igual que con el run, defino un script determinista con diferentes niveles de verificación. P.ej. podríamos tener “backend-unit”, “backend-integration”, “backend-acceptance”, “frontend-unit”, “frontend-storybook”, “frontend-acceptance”.
2. **.claude/skills/verify:** Una skill que contiene una matriz de casos típicos, y le enseña a Claude qué suite tiene que ejecutar para cada tipo de cambio que se encuentre.

Por ejemplo:

- Lógica de dominio → backend-unit
- Cambio en la UI de frontend → frontend-storybook
- Cambio en el contrato de la API → frontend-acceptance + backend-acceptance
- …etc.

NO es determinista. Claude puede decidir saltarsela, o puede equivocarse al clasificar un cambio. No se debe confiar solamente en esta skill para validar un cambio. Para eso está la integración continua. La idea es que, durante el desarrollo, tener feedback de verificación rápido, y poder darle feedback al agente de que un test relevante está fallando, para que pueda seguir iterando.

Y eso, en la práctica, encuentro que es suficientemente bueno.

Porque al final muchas cosas en el desarrollo con agentes van de construir capas “suficientemente buenas”, lo antes posible.

Es como el modelo del queso suizo en QA: no quiero que todas las capas de seguridad cubran todos los posibles riesgos: quiero que:

1. las capas más baratas (la skill en este caso) sean best effort y cubran los fallos más comunes, y poner estas capas antes.
2. las capas más caras (el CI) sean exhaustivas pero cacen lo que las otras no, de manera que la **superposición de todas las capas no deja ningún agujero abierto**.

## Donde hay patrón no manda agente (otra vez)

Desde muy temprano, las skills run y verify son, probablemente junto al setup de un buen CLAUDE.md, lo primero que hago en cualquier proyecto en el que empiezo a trabajar con agentes. Por eso, a día de hoy lo considero patrón, y lo tengo documentado en mi catálogo de patrones. Podéis leer más exhaustivamente los detalles y ejemplos de implementación aquí:

- [https://patterns.exeal.com/patterns/skill-verify/](https://patterns.exeal.com/patterns/skill-verify/)
- [https://patterns.exeal.com/patterns/skill-run/](https://patterns.exeal.com/patterns/skill-run/)

## ¿Cómo puedo implementar estas skills en mi proyecto?

Lo que yo hago cuando tengo un proyecto nuevo, donde quiero implementar estas skills, es:

- Pasarle al agente el articulo correspondiente.
- Pasarle un ejemplo de implementación de otro repo que ya tenga, y decirle que lo estudie.
- Pedirle que adapte la skill (o el patrón en cuestión) al repo actual.

Y a partir de ahi, patrón aplicado, profit.

## ¿Es suficiente?

Ni mucho menos. Esto es un punto de partida decente, pero ni de coña arregla el problema de los agentes por sí solo.

El objetivo no es conseguir que el modelo sea más inteligente. De hecho, eso ya lo vamos a tener de gratis con cada nuevo modelo que salga. Pero por muy capaz que sea el modelo, tener que reconstruir conocimiento implícito o recordar qué reglas no puede saltarse cada vez que se ejecuta sigue siendo trabajo que podemos ahorrarle.

De hecho, un buen arnés puede evitar que tengas que recurrir a modelos más caros para conseguir buenos resultados, con el subsiguiente ahorro en costes. Yo, por ejemplo, en proyectos con arneses y arquitecturas bastante maduras, utilizo Sonnet con esfuerzo medio para la mayoría de tareas.

Y es que, al final, un buen arnés no consiste solamente en una cosa. Son pequeñas cositas las que suman y hacen que el agente vaya por donde tú quieres.

Cosas como:

- guardarrailes efectivos para que el agente no se salte la arquitectura
- cómo identificar cuando te cambia tests o el contrato de la API u otros invariantes sin querer
- una arquitectura y estrategia de testing efectivas, que minimice el riesgo y maximice la eficiencia de ejecutar verificaciones lo antes posible
- y muchas más

De estas cosas hablaré en los próximos posts.

Hasta entonces, nos vemos en la próxima versión.

Un saludo,

Pedro
