---
title: 'Cómo afrontar el onboarding en una nueva empresa'
description: 'Mi “Playbook de Onboarding” contiene todas aquellas cosas que tengo que hacer una vez entro a un equipo para conseguir el conocimiento que me permitirá ayudarles.'
date: 2025-02-16T00:00:00.000Z
layout: newsletterpost
author: pedropardal
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 6
---

Como sabéis (y si no lo sabéis ya os lo cuento ahora), una de las cosas que hago es colaborar con equipos de desarollo como team coach para implementar mejoras en los procesos y las prácticas de equipos de desarrollo.

Cada cliente me llama para un propósito diferente: algunos por un problema técnico o de arquitectura, otros por la parte más organizativa o de gestión...

La realidad es que da igual: en el fondo está todo relacionado.

Un equipo es un sistema muy complejo, en el que la organización influye en lo técnico y viceversa (por la [Ley de Conway](https://es.wikipedia.org/wiki/Ley_de_Conway)), por lo que no puedes limitarte a analizar una única de las dimensiones: tienes que analizar el sistema en conjunto.

Es por esto que, tras varios años de colaborar con diferentes equipos en diferentes clientes, poco a poco he ido confeccionando lo que yo llamo mi **“Playbook de Onboarding”**: es decir, todas aquellas cosas que tengo que hacer una vez entro a un equipo para conseguir el conocimiento que me permitirá ayudarles.

Tenerlo documentado y procedimentado me permite no tener que enfrentarme a una hoja en blanco cuando comienza la colaboración, no tener que improvisar, y me da una sensación de seguridad mucho mayor ya que sé que, independientemente de lo que haya oculto, mi sistema me va a permitir descubrirlo.

Este playbook no sirve únicamente si eres colaborador externo, como yo. Si ahora mismo entrase a un equipo como tech lead, desarrollador, engineering manager… también lo usaría, tal cual está. 

Es por eso, que en esta newsletter voy a compartirlo contigo, para que, si vas a comenzar, o has comenzado recientemente en un equipo nuevo, o inclusive si quieres procedimentar el onboarding de nuevas personas en tu equipo, puedas inspirarte en lo que yo hago.

Sin más dilación, estás son las cosas que hago en mis primeras semanas con un equipo.

## Entender la misión y visión de la organización

Lo primero cuando entras a una empresa es entender su razón de ser: por qué existe, o cuál es el objetivo último (la misión), qué impacto quiere tener en el mundo (la visión), cómo se sustenta (el modelo de negocio). Aunque no lo relleno explícitamente, intento buscar muchos de los elementos del [Business Model Canvas](https://en.wikipedia.org/wiki/Business_model_canvas), como la propuesta de valor, los revenue streams, segmentos de clientes y, en particular, intento averiguar si el departamento de desarrollo está concebido como un centro de valor o un centro de coste por el resto de la organización.

Desde la perspectiva del equipo, intento entender cómo encaja el equipo con el que voy a colaborar en el “big picture”, o dicho de otra forma, cuál es su papel en la consecución de la misión de la organización.

El problema es que, una gran mayoría de veces, ni siquiera la gente que hay dentro tiene esto claro.

Así que toca comenzar a investigar y atar cabos. Lo cual me lleva al siguiente punto.

## Conocer a las personas

El siguiente punto es conocer a la gente: tanto los miembros del equipo con el que voy a trabajar, como los managers, stakeholders, miembros de otros departamentos o equipos, y en general cualquier persona que esté relacionada de una forma u otra con el equipo.

Intento averiguar que es lo que cada persona espera del equipo. Primero mapeo el organization chart sobre el papel, y luego intento identificar las diferencias con el org. chart real: cuáles son las verdaderas relaciones de poder, canales de comunicación, quiénes se llevan bien y hacen grupitos, quienes están peleados, qué guerras políticas existen...

En este punto, intento tener 1:1 con todas las personas relevantes, para que me cuenten su punto de vista, sus pain points, pero sobre todo para construir confianza, rapport y abrir un canal de comunicación que tendré disponible más adelante cuando lo necesite.

## Entender el usuario y el producto

El siguiente punto es entender quiénes son los usuarios, qué necesidades tienen, y cómo el producto que desarrolla el equipo soluciona esas necesidades.

Busco entender (y si es posible, usar) el producto desde el punto de vista de un usuario, conocer los flujos críticos de negocio, los [jobs to be done](https://www.uifrommars.com/jobs-to-be-done-que-es/) del usuario, etc.

Para saber en qué punto se encuentra el desarrollo, busco conocer cuales son los product goals del equipo a día de hoy, y el roadmap a corto, medio y largo plazo. 

## Entender la solución técnica

Una vez conocemos el producto, el siguiente paso es entender cómo está hecho.

Busco analizar la arquitectura técnica de la solución, a diferentes niveles: vista de sistema (especialmente identificar con qué sistemas externos, ya sean usuarios u otros sistemas, interactua, utilizando el [modelo C4](https://c4model.com/)), estructura interna, infraestructura, dominios o bounded contexts, modelo de datos, lenguaje ubicuo, etc.

## Mapear el flujo de trabajo del equipo

Tal y como haría cualquier desarrollador, monto mi entorno de desarrollo e intento poner en producción algún desarrollo pequeño o bugfix por mi cuenta, desde el backlog hasta el despliegue y operativa, para saber exactamente cómo es la operativa del equipo y empezar a ver donde están los cuellos de botella.

Mientras hago esto, voy obteniendo la información que necesito de los miembros del equipo y de la documentación, y la voy actualizando sobre la marcha si identifico algo que no está o está obsoleto (la regla del boy scout, pero con la documentación).

También asisto atiendo a todas las sesiones o ceremonias del equipo. Intento entender y mapear el [Value Stream Map](https://en.wikipedia.org/wiki/Value-stream_mapping), es decir, un detalle del proceso end-to-end del equipo, desde que una idea o necesidad llega al equipo, hasta que se transforma en una solución software funcional desplegada en producción y entregando valor.

## Obtención y/o consulta de métricas

Si el equipo las tiene, consulto las principales métricas o KPIs del equipo.

Aquí me fijo en dos tipos de métricas:

- Los KPIs de operativa del equipo. Inicialmente, siempre busco las [DORA metrics](https://dora.dev/guides/dora-metrics-four-keys/) o alguna aproximación que esté disponible fácilmente.
- Los KPIs de producto y negocio, para entender mejor que significa aportar valor en el contexto de este equipo.

Otra métrica interesante que busco obtener es el [eNPS o Employee Net Promoter Score](https://factorial.es/blog/enps-employee-net-promoter-score/), para saber qué percepción tienen los miembros del equipo sobre el propio equipo y la empresa. Normalmente un eNPS más bajo te dice que tienes menos margen para solucionar los problemas críticos, ya que la gente está más cerca del burnout y por tanto tiene más peligro de largarse, lo cual me ayuda a planear una estrategia priorizando iniciativas.

Todo esto evidentemente tiene que ir acompañado de un análisis cualitativo de por qué el eNPS es bajo.

## ¿Cuánto tiempo me lleva esto?

No siempre hago absolutamente todo esto en cada equipo al que entro (podríamos decir que es una “checklist de máximos”), y no siempre lo hago en el mismo orden: voy priorizando sobre la marcha y avanzando en varios frentes en paralelo en función de las oportunidades que se presenten. El proceso completo suele durar entre varias semanas y unos pocos meses.

## Tras el onboarding

A medida que pasa el tiempo y voy averiguando pistas sobre la situación del equipo, sus mayores retos y lo que puedo aportar desde mi posición, mi actividad va pasando más de escuchar y entender en un rol más pasivo, a proponer y liderar desde un rol más activo.

Intento definir lo antes posible cuáles serán mis objetivos (qué impacto quiero dejar en el equipo), trazar el plan para conseguirlos, cuando podré darlos por concluidos, y también algo muy particular: como delegaré cualquier responsabilidad que haya adquirido temporalmente al resto del equipo.

Desde que comienzo a ejecutar la primera iniciativa de aportación de valor, ya comienzo a trazar mi camino de salida del equipo, o mi off-boarding. Esto lo hago ya que, como colaborador externo, mi objetivo es aportar todo el valor que pueda al equipo en el menor tiempo posible y salir cuánto antes para reducir la factura de mi cliente.

Pero eso lo trataremos más adelante, en otra newsletter.

## Cómo puedes aplicar este playbook

Tú también puedes utilizar este playbook cuando entres a un nuevo equipo, ya sea como desarrollador, como tech lead, manager, consultor, etc. Lo guay de este playbook es que te da una visión 360 del equipo y vale para cualquier rol que vaya a trabajar o a dar soporte al equipo.

Si pruebas algunas iniciativas de las que he hablado, házmelo saber y cuéntame la experiencia!

Un abrazo,
Pedro
