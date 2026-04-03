---
title: 'Cómo metí observabilidad y una red de seguridad real en un backend legacy sin tests (sin romper producción)'
description: 'Cómo introducir observabilidad y una red de seguridad real en un backend legacy sin tests, usando structured logging, trazabilidad end-to-end y approval testing sobre flujos críticos'
author: pedropardal
date: 2025-12-20T00:00:00.000Z
layout: post
tags: [legacy, observabilidad]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
card_image: /images/blog/posts/programador.jpg
---

Entré en un backend Symfony en producción con el clásico combo: cero tests, flujos de negocio complejos, mucha automatización (crons + colas), integraciones con terceros y clientes esperando. No era un entorno para “hacer las cosas perfectas”. Era un entorno para **no cargarte nada**, aprender rápido y empezar a recuperar control.

Mi objetivo de la primera semana no fue “añadir tests”. Fue **hacer el sistema observable**.

Porque en legacy, cuando no tienes red, el primer problema no es la calidad del código. Es que **no puedes explicar qué está pasando**.

### El problema real: no era el bug, era la falta de una historia

Había pedidos atascados y reintentos interminables. Pero el dolor de verdad era otro:

* No podías seguir un pedido end-to-end sin abrir 5 sitios distintos.
* Los logs no eran consistentes: cada flujo logueaba lo que quería, como quería.
* Había ruido (errores que no eran errores) y silencio (fallos que no se veían).
* Con colas y crons, el pedido “saltaba” entre procesos y perdías contexto.

Cuando estás así, los tests son difíciles por una razón simple: **no sabes qué estás testando**. Lo primero es poder responder: “para este pedido concreto, ¿qué pasos ha dado el sistema, en qué orden, y por qué?”.

### Principio guía: tocar código con el mínimo riesgo posible

En la fase 1 mi regla fue: **instrumentar, no reescribir**.

Eso significa:

* Nada de refactors grandes.
* Nada de “ya que estoy” limpiando lógica.
* Cambios locales, mecánicos, reversibles.
* Si el cambio no se puede revertir rápido, no entra.

La idea: mejorar visibilidad sin cambiar comportamiento.

## Fase 1 — Observabilidad: structured logging + campos canónicos

### 1) Structured logging (JSON) como contrato

En vez de logs “bonitos”, busqué logs “útiles”.

* JSON por defecto (para parseo, query, agregación).
* Mensajes cortos.
* Contexto siempre presente.

Ejemplo de estructura (conceptual):

* `event`: nombre canónico del evento (ej: `order.process.started`)
* `order_id`: ID interno (tu “primary key” de verdad)
* `customer_id`: si aplica
* `connection_id` / `store_id`: si aplica
* `flow`: nombre del flujo (“new_order”, “post_kyc_validation”, “capture”, etc.)
* `step`: paso dentro del flujo
* `correlation_id`: para seguir saltos entre cron/worker/webhook
* `duration_ms`: cuando tenga sentido
* `result`: ok/fail + motivo

No necesitas todos desde el minuto 1. Pero sí necesitas **un estándar**.

### 2) Campos canónicos: `order_id` y `customer_id` como religión

Esto es lo que más impacto tuvo: **que todos los logs importantes tuvieran `order_id`**.

Con sistemas asíncronos, si no tienes un identificador canónico:

* no puedes reconstruir historias,
* no puedes comparar casos,
* no puedes automatizar alertas,
* no puedes testear trazas.

`order_id` + `customer_id` fueron los mínimos. Luego puedes sumar `shopify_order_id`, `payment_method`, etc.

### 3) Trazar todos los flujos de negocio críticos

Aquí fui muy explícito: quería trazas en los puntos donde el pedido cambia de “fase” o de “responsable”.

Por ejemplo (conceptual, no exacto):

* Entrada de pedido (webhook / cron pull)
* Sync / refresh de datos desde Shopify
* Evaluación antifraude / reglas
* Disparo de KYC / post-KYC
* Encolado a procesamiento
* Procesamiento de líneas (allocación / compra)
* Envío de email
* Captura del pago
* Fulfillment / cierre

Los puntos de instrumentación típicos:

* Handlers de Messenger (porque son saltos de proceso)
* Commands de cron (porque son triggers repetitivos)
* Servicios “núcleo” donde pasan cosas irreversibles (captura, compra a vendor, email)

### 4) Riesgo controlado: instrumentar sin alterar lógica

Para no meterme en un “refactor disfrazado”, mi criterio fue:

* Cambiar solo llamadas a logger + contexto.
* Evitar tocar condiciones / branching.
* Si necesito contexto, lo calculo de forma local (p.ej., leer `$order->getId()`), sin cambiar flujos.

Es sorprendente lo mucho que mejora el sistema con solo esto.

## Fase 2 — Preparar tests para flujos críticos sin volverte loco

Una vez que puedes ver un pedido end-to-end, puedes hacer algo que en legacy es oro:

**convertir una traza real en un test de regresión.**

Pero no con unit tests tradicionales. Con una estrategia que funciona especialmente bien en sistemas asíncronos: **approval testing / snapshot testing**.

La idea:

* Ejecutas un flujo real (controlado).
* Capturas el output observable (logs estructurados + estado final).
* Guardas eso como “foto”.
* Si cambia, alguien decidió que era correcto o se rompió algo.

### 5) Approval testing sobre logs: una foto de un pedido end-to-end

La clave aquí es diseñar el “artefacto verificable”. En mi caso:

* Un **snapshot de logs** del flujo crítico (filtrados por `order_id` / `correlation_id`)
* Y un **snapshot del estado final** relevante en base de datos

Eso te permite detectar:

* Cambios en el orden de pasos
* Pasos que desaparecen
* Errores que antes no ocurrían
* Estados finales inesperados

Y lo mejor: sin entender toda la lógica interna todavía.

### 6) Dobles en los bordes: no testear terceros, testear tu sistema

Para que un E2E sea estable necesitas controlar bordes:

* APIs de terceros (Shopify, PayPal/Klarna, KYC, vendors)
* Message queues / transport
* Reloj/tiempo (backoffs, expiraciones)

Estrategia:

* Dobles (stubs/fakes) en integraciones externas.
* Mantener “real” todo lo que sea tu código: servicios, handlers, repos, persistencia.

Esto te da un E2E que no depende de internet ni de estados de sandbox aleatorios.

### 7) BBDD con Docker: reproducibilidad antes que pureza

Montar una MySQL (o la que uses) en Docker te da:

* schema consistente
* fixtures deterministas
* reset rápido entre tests
* posibilidad de ejecutar local y en CI

No busco el test perfecto: busco el test que corre siempre.

### 8) “End-to-end sí, pero solo de nuestro código”

Esto es importante: “E2E” no significa “pegarle a todo lo externo”.

Significa:

* atravieso el flujo completo dentro de mi sistema,
* pero en los bordes tengo dobles,
* y verifico outputs observables (logs + estado).

Si mañana PayPal cambia algo, no me rompe el test. Si yo rompo mi flujo, sí.

## La mecánica del safety net: detectar mínimos cambios y decidir rápido

Aquí está el valor real para un CTO: **control del riesgo de cambios**.

La dinámica es:

1. Corro el test del flujo crítico
2. Si el snapshot cambia:

   * Si era esperable: apruebo el nuevo snapshot
   * Si no era esperable: revert o investigo antes de mergear

Esto convierte el trabajo en algo mucho más seguro:

* cambios pequeños,
* feedback rápido,
* regresiones detectadas por “historia” y no por asserts frágiles.

Y una vez que tienes esta red, puedes empezar a mejorar el sistema sin miedo.

## Paso a paso: cómo evoluciona después

Una vez tienes trazas y tests de snapshot, el camino natural es ir subiendo la calidad:

1. Mantener el test E2E “gordo” como red de seguridad
2. Ir extrayendo tests más finos:

   * unit tests donde haya lógica pura y estable
   * integration tests por componentes
3. Limpiar el logging:

   * niveles correctos
   * menos ruido
   * eventos más canónicos
4. Refactors graduales con protección

> La paradoja: los tests buenos llegan cuando ya entiendes.
> Y entiendes cuando observas.

## Cierre: la idea contraria (pero práctica)

En un legacy en producción, **la observabilidad no es un extra**. Es el primer mecanismo de control.

Primero haces el sistema explicable.
Luego lo haces comprobable.

Si estás heredando un backend sin tests y con incidentes reales, mi recomendación es esta:

* Instrumenta primero.
* Convierte la realidad (trazas + estado) en un safety net con snapshots.
* Y desde ahí, limpia y afina con tests de grano fino.

No es elegante. Es efectivo. Y te deja dormir.
