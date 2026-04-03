---
title: "Cómo solucionar un 401 en tu API al integrar Auth0 con n8n"
date: 2025-06-01T00:00:00+01:00
description: "Si tu API devuelve un 401 a pesar de que Auth0 emite un access_token correctamente, el problema puede estar en el parámetro 'audience'. Te explico cómo solucionarlo en n8n."
featured_image: '/images/blog/lowcode.jpg'
card_image: '/images/blog/lowcode.jpg'
images: ['/images/blog/lowcode.jpg']
layout: post
author: pedropardal
tags: ["nocode"]
---

Si estás integrando **n8n** con **Auth0** para automatizar llamadas a una API protegida con OAuth2, es posible que te encuentres con un error desconcertante:

> **n8n realiza el login correctamente, Auth0 emite el token sin errores, pero tu API responde con un 401 Unauthorized.**

En concreto, esto es la stack trace del error:

```
NodeApiError: Authorization failed - please check your credentials
at ExecuteContext.execute (/opt/render/project/src/packages/nodes-base/nodes/HttpRequest/V3/HttpRequestV3.node.ts:769:15)
at processTicksAndRejections (node:internal/process/task_queues:105:5)
at WorkflowExecute.runNode (/opt/render/project/src/packages/core/src/execution-engine/workflow-execute.ts:1185:9)
at /opt/render/project/src/packages/core/src/execution-engine/workflow-execute.ts:1534:27
at /opt/render/project/src/packages/core/src/execution-engine/workflow-execute.ts:2098:11
```

Este problema suele deberse a que el `access_token` que recibe n8n **no tiene el `audience` correcto**. Es decir, Auth0 no está emitiendo un token dirigido a tu API específica, sino un token "genérico" que tu backend no reconoce como válido.

---

## ¿Por qué ocurre esto?

En Auth0, los tokens de acceso (JWT) incluyen un campo `aud` (audience) que indica para qué API están destinados. Si este valor no coincide con el que tu API espera, la validación del token fallará y devolverá un 401, incluso si el resto del flujo OAuth2 ha sido exitoso.

Por defecto, **n8n no incluye el parámetro `audience` en la URL de autorización que envía a Auth0**, por lo que el token recibido no está asociado a ninguna API concreta.

---

## Cómo solucionarlo

La solución consiste en añadir el parámetro `audience` manualmente en la configuración de la credencial OAuth2 en n8n.

### Pasos:

1. Ve a **Credenciales > OAuth2 API** en tu instancia de n8n.
2. Abre la credencial configurada con Auth0.
3. En el campo **Auth URI Query Parameters**, añade lo siguiente:

```text
audience=https://api.tu-dominio.com
````

Este valor debe coincidir exactamente con el **Identifier** que hayas definido en Auth0 al crear tu API (en Auth0 → APIs).

4. Guarda y reconecta la credencial.

---

## Resultado

A partir de ese momento:

* n8n incluirá el parámetro `audience` al redirigir al login de Auth0.
* Auth0 emitirá un `access_token` válido para tu API, con el campo `aud` correctamente establecido.
* Tu backend aceptará el token y procesará la solicitud sin devolver un 401.

---

## Conclusión

Cuando trabajas con Auth0 y OAuth2, es fundamental asegurarse de que los tokens de acceso contienen el `audience` esperado por tu API. En herramientas como n8n, donde la configuración OAuth2 es flexible pero no siempre obvia, este pequeño ajuste puede marcar la diferencia entre una integración funcional y una frustración silenciosa.
