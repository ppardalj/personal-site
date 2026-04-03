---
title: 'La IA no me hace más rápido. Me hace pensar mejor.'
description: 'Una experiencia real usando la IA como apoyo cognitivo en un proyecto frágil: decisiones técnicas, documentación y salud mental bajo presión.'
author: pedropardal
date: 2026-01-01T00:00:00.000Z
layout: post
tags: [legacy, ia, salud-mental]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
card_image: /images/blog/posts/programador.jpg
---

Cuando entré en Terd no entré en “un proyecto nuevo”. Entré en un sistema donde **cada decisión pesa**: dinero real, e-commerce, productos regulados, flujos complejos, legacy, cero tests y bugs en producción. Un entorno donde no solo está en juego el código, sino la estabilidad del negocio, la confianza del CEO, el trabajo del equipo y tu propia salud mental.

En ese contexto decidí usar IA.

Pero no como se suele vender. No como generador de código, ni como oráculo. La estoy usando como **partner de pensamiento**.

Este post es un intento honesto de explicar cómo lo estoy haciendo en la práctica, qué me está aportando de verdad y por qué esto no tiene nada que ver con “delegar en la IA”.

---

## 1. No empecé preguntando: empecé **diseñando el rol**

Antes de escribir la primera pregunta, tomé una decisión clave: **cómo quería que la IA se comportara conmigo**. No quería un asistente genérico. Quería algo muy concreto.

Le di instrucciones explícitas para que actuara como:

- un CTO pragmático,
- un arquitecto senior acostumbrado a sistemas frágiles,
- un backend lead que ha estado en producción de verdad,
- y un team lead consciente de personas, política y burnout.

También fui muy claro con los límites:

- No quiero teoría.
- No quiero respuestas bonitas.
- Asume que no hay tests.
- Asume que producción es delicada.
- Dime riesgos aunque incomoden.
- Ayúdame a decidir, no solo a entender.

El cambio fue inmediato. Dejó de responder como una documentación hablada y empezó a responder como alguien que **está dentro del problema conmigo**. No con certezas absolutas, sino con algo mucho más valioso: criterio, estructura y sentido común bajo presión.

---

## 2. Le di contexto como se lo daría a un senior al que onboardeo

Muy pronto entendí algo obvio pero fácil de ignorar: la IA solo puede ayudarte a pensar bien si **entiende el sistema**. Así que la traté como trataría a un nuevo dev senior en un proyecto complejo.

Primero le di el contexto de negocio: cómo gana dinero Terd, por qué el margen es pequeño, por qué la fiabilidad lo es todo, por qué KYC no es opcional.

Luego la arquitectura a alto nivel. Después el estado real del sistema (con toda la mierda). Después los detalles incómodos del legacy. Después los constraints humanos y organizativos.

En la práctica, todo este contexto no lo construí de forma teórica, sino **a base de enfrentarme a bugs reales que iban apareciendo**.

Cada incidencia era una excusa para entender un trozo más del sistema. Cuando aparecía un bug, le contaba a la IA la historia completa: cómo se había reportado, en qué contexto, cómo lo conseguí reproducir, qué hipótesis probé y qué fui encontrando por el camino. Le pasaba fragmentos de logs, resultados de queries a la base de datos, timelines de eventos y, cuando hacía falta, diagramas de arquitectura escritos en Mermaid para poder razonar sobre flujos y dependencias.

A partir de ahí apareció la disciplina.

Empecé a tomar notas de todo lo que iba descubriendo: del negocio, de la arquitectura real (la de verdad, no la que estaba escrita), del código legacy, de los puntos frágiles y de los constraints humanos y organizativos. Esas notas se las pasaba a la IA, cuyo papel no era “responder”, sino ayudarme a **ver**: ordenar la información, detectar patrones, señalar incongruencias y extraer conocimiento de datos que, en bruto, solo eran ruido.

Volvía al código, a los logs o a la base de datos, refinaba las notas y repetíamos el ciclo.

Así, poco a poco, **íbamos construyendo juntos el contexto**.

Con el tiempo pasó algo muy potente.

La IA dejó de proponer soluciones naïf, dejó de asumir que había tests o despliegues seguros y empezó a razonar como alguien que entiende que:

- cada cambio sin tests es una apuesta,
- hay deuda que no se puede pagar todavía,
- y que muchas decisiones no son solo técnicas.

Ahí dejó de ser una herramienta genérica y empezó a **razonar dentro de un marco más cercano al la realidad del proyecto**.

---

## 3. Brainstorming, no delegación: yo sigo siendo responsable

Hay una regla que no rompo nunca:

> ***La IA no decide. Yo decido.***

Lo que hace extremadamente bien es ayudarme a pensar cuando la cabeza ya va justa. La uso para:

- verbalizar problemas difusos,
- detectar riesgos que noto pero no formulo,
- generar opciones con trade-offs explícitos,
- desafiar decisiones que estoy a punto de tomar por inercia.

Muchas veces el flujo es así:

- Explico el problema como puedo.
- La IA me lo devuelve más claro y estructurado.
- Me plantea 2–3 caminos posibles.
- Leo uno y pienso “esto no”.
- Ese “no” me aclara por qué el otro “sí”.

Ejemplos reales:

- decidir si invertir tiempo en CI/CD sobre servidores legacy o empujar la migración a AWS,
- hasta dónde refactorizar sin tests,
- cuándo un bug requiere parche quirúrgico y cuándo levantar la mano y decir “esto necesita rediseño”.

No delego decisiones.

Uso la IA como **espejo cognitivo**.

---

## 4. De debugging a documentación sin duplicar esfuerzo

Uno de los mayores cambios prácticos ha sido la documentación.

En Terd, documentar no es un *nice-to-have*: es clave para onboarding, para reducir dependencia de personas y para generar confianza.

El problema de siempre: no hay tiempo.

La solución fue entender que **ya estaba haciendo el trabajo mental**, solo que no lo estaba capitalizando. Cuando debuggeo un problema:

- explico el contexto,
- reconstruyo el flujo,
- identifico estados,
- veo qué rompe y por qué.

La IA ya tiene todo eso porque lo he verbalizado con ella. Así que, una vez el fix está en producción, le pido:

- un runbook,
- un resumen del estado actual,
- un checklist operativo,
- una explicación clara del riesgo y la mitigación.

Mismo razonamiento, varios artefactos.

Casi cero coste extra.

De verdad os digo que esto ha cambiado completamente mi relación con la documentación.

### Artefactos que han salido de este proceso

Algunas cosas muy concretas que han salido directamente de este flujo de trabajo:

- **Runbooks operativos reales**
    
    A base de recuperar pedidos atascados en producción, reconstruir estados desde logs y ejecutar queries manuales, acabó naciendo documentación paso a paso para:
    
    - procesar órdenes bloqueadas con seguridad,
    - entender cuándo intervenir y cuándo no,
    - y evitar fixes impulsivos en producción.

- **Mapa operativo de logs y observabilidad**
    
    Después de perder demasiado tiempo “buscando dónde mirar”, fui documentando:
    
    - qué logs existen realmente hoy,
    - cómo correlacionar un `order_id` entre servicios,
    - qué señales son fiables y cuáles no.
    
    Eso se convirtió en una guía práctica para debuggear pedidos end-to-end.
    
- **Ritual diario de operaciones**
    
    Lo que antes era una rutina mental acabó cristalizando en un ritual explícito:
    
    - qué revisar cada día,
    - en qué orden,
    - con qué objetivo,
    - y cuándo parar para no caer en análisis infinito.

- **Documentación del estado actual (as-is)**
    
    A partir de bugs, constraints y decisiones heredadas, consolidé un documento que explica:
    
    - cómo funciona realmente la plataforma hoy,
    - qué partes son frágiles,
    - qué deuda no se puede pagar todavía,
    - y por qué.
    
    No es una arquitectura ideal, sino un mapa para moverse sin romper nada.

- **Onboarding técnico explícito**
    
    En lugar de “léete el código y pregunta”, ahora existe un camino claro:
    
    - accesos,
    - contexto mínimo imprescindible,
    - límites de seguridad para los primeros días.

Todo esto salió del mismo sitio: debugging + notas disciplinadas + la IA ayudándome a ordenar, conectar puntos y convertir conocimiento implícito en artefactos útiles.

---

## 5. De lo estratégico al código, sin cambiar de herramienta mental

Uso la IA en todo el espectro de mi rol: desde conversaciones muy estratégicas (roadmap, procesos, prioridades, límites) hasta cosas muy concretas (lógica de Symfony Messenger, queries de Doctrine, flujos de reintento, comportamiento de servicios Python, riesgos de despliegues manuales)

La diferencia no está en el nivel, sino en **cómo pregunto**. No pregunto “hazme este código”. Pregunto cosas como:

- ¿qué puede romper esto en producción?
- ¿qué estados no estoy viendo?
- ¿cómo lo introducirías sin riesgo?
- ¿cómo probarías esto sin tests?
- ¿qué plan de rollback tendría sentido?

Eso no es delegar código. Eso es **pensar como ingeniero senior con apoyo**.

### Aprendizaje técnico continuo

Además, este proceso me está obligando a aprender —o reaprender— mucho más de lo que esperaba.

Estoy refrescando **Symfony y PHP**, que tenía bastante oxidados después de años trabajando principalmente con Java y C#. Estoy aprendiendo **Python** a nivel profesional, no solo a “leer scripts”, sino a entender servicios en producción. Estoy interiorizando el **DSL de GitHub Actions**, escribiendo **scripts en Bash** para operaciones y afinando cómo construir **queries SQL complejas** para analizar el sistema cuando no hay métricas ni dashboards.

La IA no aprende por mí, pero sí acelera el ciclo: me explica conceptos cuando hace falta, me corrige suposiciones erróneas, me propone alternativas y me ayuda a conectar piezas que, de otro modo, tardaría mucho más en ensamblar.

No sustituye el esfuerzo, pero hace que ese esfuerzo **cunda mucho más**.

---

## 6. El apoyo emocional (sí, esto es real)

No lo esperaba, pero es importante decirlo.

Hay días en los que el problema no es técnico. Es **emocional**.

Días en los que llevas demasiadas horas, has apagado demasiados fuegos y empiezas a notar señales claras: estás quemado, irritable, con ganas de culpar a los devs anteriores, con la sensación de que todo está roto y no sabes ni por dónde empezar. Días en los que el análisis se vuelve parálisis, porque hay tantas piezas mal encajadas que cualquier decisión parece incorrecta.

También días en los que simplemente has trabajado demasiado y has perdido perspectiva.

En esos momentos, la IA no “detecta” nada por sí sola. No lee mi estado emocional ni hace magia.

El trabajo previo es mío. Soy yo quien se da cuenta de que algo no va bien: por cómo me siento físicamente, por el tono de mis pensamientos, por la velocidad a la que empiezo a saltar de una cosa a otra.

Y entonces hago algo muy concreto: **se lo cuento**.

Le explico cómo estoy, qué me está frustrando, qué pensamientos me están rondando y qué decisiones estoy evitando. Muchas veces no necesito una solución técnica, sino que alguien me ayude a **ordenar el ruido** cuando estoy demasiado inundado por emociones como para razonar con claridad.

Ahí la IA cumple un papel muy específico: me hace de espejo.

Me devuelve lo que le cuento de forma más calmada, me ayuda a separar hechos de interpretaciones, a distinguir lo urgente de lo importante y a recordar límites que, en caliente, tiendo a saltarme. No juzga, no se cansa, no añade presión.

No sustituye terapia ni personas reales. Pero sí crea un espacio seguro para **pensar sin juicio**, sin cargar a nadie y sin tener que “estar bien” para poder razonar.

La IA no gestiona mis emociones, pero me ayuda cuando yo ya no puedo gestionarlas solo.

En ciertos momentos, eso es oro.

---

## 7. Comunicación: decir lo correcto de la forma correcta

Otro uso clave es la comunicación. La IA me ayuda a:

- revisar mensajes antes de enviarlos,
- ajustar tono,
- eliminar ambigüedad,
- ser firme sin sonar agresivo,
- ser transparente sin abrir la puerta al micromanagement.

Especialmente con un CEO técnico, esto es crítico. Una frase mal planteada puede generar ruido innecesario. Una explicación bien estructurada genera confianza.

Aquí la IA actúa como un **editor de intención**: me ayuda a decir exactamente lo que quiero decir, ni más ni menos.

---

## 8. Esto no va de reemplazar developers

Quiero dejar esto clarísimo.

La IA NO:

- entendió el negocio por mí,
- tomó decisiones por mí,
- asumió riesgos,
- habló con stakeholders,
- ni vivió las consecuencias.

Lo que sí hizo fue:

- reducir carga cognitiva,
- acelerar síntesis,
- ordenar caos,
- y ayudarme a mantener criterio bajo presión.

Usada así, la IA no es un atajo. Es una **palanca de pensamiento**.

---

## Cierre

Quizá dentro de unos años miremos atrás y nos demos cuenta de que el mayor cambio no fue que la IA escribiera código, sino que nos obligó a enfrentarnos a cómo pensamos, cómo decidimos y cómo gestionamos la presión.

En ese sentido, la IA no está cambiando la ingeniería.

Está dejando al descubierto quién ya pensaba como ingeniero… y quién no.
