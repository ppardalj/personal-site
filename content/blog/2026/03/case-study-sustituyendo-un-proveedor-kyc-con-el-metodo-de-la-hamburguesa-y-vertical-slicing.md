---
title: 'Case Study: Sustituyendo un proveedor KYC con el método de la hamburguesa + Vertical Slicing.'
description: 'Un caso práctico sobre cómo utilizar el método de la hamburguesa y Vertical Slicing para planificar un proyecto de integración técnica.'
author: pedropardal
date: 2026-03-31T00:00:00.000Z
layout: post
tags: [product]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
card_image: /images/blog/posts/programador.jpg
---

Integrar un nuevo proveedor externo suele parecer una tarea puramente técnica: leer documentación, escribir código, conectar APIs. En la práctica, rara vez es tan simple. Cuando sustituimos un proveedor KYC por otro en uno de nuestros sistemas, nos dimos cuenta de que el verdadero problema no era la integración técnica, sino cómo descomponer el trabajo de forma que **el valor llegase lo antes posible** y el riesgo técnico se descubriera pronto.

Este artículo cuenta cómo utilizamos dos herramientas muy simples pero extremadamente poderosas: el **Método de la hamburguesa** y **Vertical Slicing**, y qué papel jugó la IA en el proceso.

## El problema: sustituir un proveedor KYC

El contexto era el siguiente: nuestro sistema ya tenía integrado un proveedor KYC. Ahora necesitábamos sustituirlo por otro vendor que expone una API diferente y un flujo de verificación distinto.

A primera vista parece un trabajo clásico de integración: leer documentación, implementar cliente API, conectar con el flujo existente, manejar callbacks, procesar resultados... El problema es que este tipo de integraciones suele esconder **muchas dimensiones de complejidad**:

- entornos de integración
- asincronía (webhooks / polling)
- estados intermedios
- idempotencia
- expiración de intentos
- datos opcionales vs obligatorios
- compatibilidad con abstractions existentes

Si abordas esto **por capas**, el trabajo se vuelve algo así:

    1. construir cliente API
    2. construir modelo de datos
    3. implementar webhooks
    4. integrar con el dominio
    5. conectar con la abstracción
    6. manejar estados
    7. manejar retries

El problema es evidente: **El sistema no funciona hasta el final del proyecto.** El valor llega tarde y el riesgo técnico se descubre tarde.

## El método de la hamburguesa

Antes de hablar de slices, usamos una técnica conocida como **el método de la hamburguesa**. La idea es muy simple: una feature compleja se puede ver como una **hamburguesa compuesta por ingredientes**. Cada "ingrediente" representa **una dimensión de complejidad**, con diferentes "sabores" o **variantes**.

En nuestro caso identificamos las diferentes dimensiones (con sus respectivas variantes):

- **Entornos**: nuestro entorno de desarrollo, producción
- **Entornos del proveedor**: sandbox, producción
- **Datos de cliente**: solo datos obligatorios, todos los datos disponibles
- **Integración con el sistema existente**: fuera de la abstracción actual, dentro de la abstracción `KycProviderInterface`
- **Idempotencia**: ignorarla, persistir `external_reference` (un ID de correlación).
- **Recuperación de resultados**: comando manual, webhook, polling, polling con exponential backoff
- **Expiración de intentos**: ignorarla, manejar expiración automática
- **Procesamiento de estados**: solo pass / fail, estados intermedios más complejos

Cada una de estas variantes añade complejidad. Por tanto, la hamburguesa completa es enorme, imposible de comer de una sola vez.

## El error clásico: planificar por capas

La forma habitual de planificar sería algo así:

- Ticket 1: cliente API
- Ticket 2: persistencia
- Ticket 3: webhooks
- Ticket 4: polling
- Ticket 5: idempotencia
- Ticket 6: integración con dominio

Este enfoque tiene dos problemas graves:

- **1. No hay valor hasta el final**: nada funciona hasta que todas las capas están implementadas.
- **2. El riesgo técnico aparece tarde**: Si el vendor tiene un comportamiento inesperado, lo descubres semanas después.

## Vertical Slicing

Aquí entra **Vertical Slicing**: en lugar de implementar la hamburguesa capa a capa, cortamos **un slice vertical**, es decir, un bocado que contenga todos los ingredientes para que **algo funcione de extremo a extremo**. Aunque sea mínimo.

El primer slice que diseñamos fue extremadamente simple:

```
- integración desde nuestro entorno de desarrollo
- contra el sandbox del proveedor
- enviando solo datos obligatorios
- sin usar todavía la abstracción existente
- sin manejar idempotencia
- recuperando el resultado mediante comando manual
- ignorando expiración de intentos
- manejando solo pass / fail definitivo
```

Este slice tiene una propiedad clave: **El flujo completo funciona end-to-end.**. Podemos crear una verificación, esperar el resultado y procesarlo. Aunque sea manual. Eso ya es **valor**.

## El impacto del primer slice

Con este primer slice conseguimos validar que la API funciona como esperamos, entender realmente el flujo del proveedor, descubrir inconsistencias en la documentación, confirmar qué datos son realmente obligatorios y probar el flujo completo de KYC. Todo esto **en días en lugar de semanas**.

Una vez el flujo mínimo funciona, añadimos slices incrementales:

- **Slice 2**: integrar en `KycProviderInterface`
- **Slice 3**: añadir webhook automático
- **Slice 4**: añadir idempotencia
- **Slice 5**: manejar expiración de intentos
- **Slice 6**: manejar estados intermedios

Cada slice **aumenta valor y robustez**, pero el sistema **ya funciona desde el primero**.

## El papel de la IA

En este proyecto la IA ayudó mucho, sobre todo en cuestiones como analizar la documentación técnica del proveedor, explorar la implementación actual, identificar flujos existentes, generar esqueletos de código y escribir los tickets finales. La IA es excelente para **heavy lifting técnico**.

Pero hay algo importante: la IA **no identificó las capas de la hamburguesa**. Y tampoco identificó el **primer slice correcto**. Eso lo hice manualmente. De hecho, varias veces la IA intentó proponer soluciones más complejas de lo necesario. Y ahí es donde entra el criterio humano.

## La verdadera ventaja no es la IA

Estamos en plena era de la IA. Pero este proyecto me recordó algo importante: **La ventaja competitiva sigue estando en los fundamentos.**. En este caso:

- saber **descomponer un problema**
- saber **identificar dimensiones de complejidad**
- saber **diseñar slices que entreguen valor temprano**

La IA acelera muchísimo. Pero **solo si el método es correcto**. Si el método es incorrecto, la IA solo te ayuda a equivocarte más rápido.

## Una observación interesante

Algo que me llama la atención es que muy pocos desarrolladores trabajan así. Y sorprendentemente, también pocos Product Managers. Vertical slicing se menciona mucho en teoría, pero en la práctica muchos equipos siguen planificando **por capas técnicas**. Y eso retrasa el valor para el usuario.

## Resultado

Comparando ambos enfoques:

- **Planificación por capas**:
  - Valor entregado: **al final del proyecto**
  - Tiempo hasta valor: **semanas**

- **Vertical slicing**:
  - Valor entregado: **primer slice**
  - Tiempo hasta valor: **días**

Las ventajas son claras: los usuarios prueban antes el producto, los problemas aparecen antes, la incertidumbre se reduce antes y el equipo aprende antes

## Conclusión

Sustituir un proveedor KYC no era solo una integración técnica. Era un ejercicio de **descomposición del problema**. El método de la hamburguesa nos ayudó a entender **todas las dimensiones de complejidad**. Vertical slicing nos permitió **entregar valor en el primer slice**. Y la IA aceleró mucho la ejecución. Pero el verdadero impacto vino de algo más antiguo que cualquier modelo de lenguaje: **usar el método correcto para pensar el problema.**

## Recursos

- [Splitting user stories -- the hamburger method (Gojko Adzic, 2012)](https://gojko.net/2012/01/23/splitting-user-stories-the-hamburger-method/)
- 
