---
title: 'Tu refactor suena genial… pero al CEO le da igual'
description: 'Tienes una iniciativa técnica que sabes que aporta, pero en la reunión con stakeholders te sientes como predicando en el desierto.'
date: 2025-06-05T00:00:00.000Z
layout: newsletterpost
author: pedropardal
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 8
---
Víctor se había currado la migración a .NET 8.

Sabía que había mucho que arreglar: módulos frágiles, dependencias antiguas, código heredado que daba miedo. Tenía claro lo que tocaba: refactors, limpiezas, dejar la base sólida para avanzar.

¿Y negocio?

Querían features. Querían “cosas que se vean”. Todo lo demás —aunque fuera urgente— se iba al fondo del backlog. Y cada semana aparecía algo más “prioritario” que lo anterior.

Esta historia salió en una sesión privada que hice con varios developers para hablar de arquitectura y toma de decisiones. Cuando Víctor lo contó, hubo risas… de esas que salen cuando algo duele porque te ha pasado.

**¿Te suena?**

Tienes una iniciativa técnica que sabes que aporta, pero en la reunión con stakeholders te sientes como predicando en el desierto. No porque tu idea sea mala. Sino porque la estás contando en el idioma equivocado.

La buena noticia: **esto se puede aprender**.

No necesitas un MBA. Solo saber enfocar y comunicar mejor.

Hoy te cuento cómo:

- Traducir tu propuesta al lenguaje de negocio
- Enfocarla como una inversión, no como un gasto
- Ganarte influencia de verdad en la toma de decisiones

### 1. Cambia primero tu propio mindset

La mayoría de nosotros venimos de una mentalidad centrada en la calidad del código, la arquitectura, los tests.

Pero el negocio no compra “código bonito”. Compra tres cosas:

- Menos costes
- Más ingresos
- Menos riesgo

Si no conectas tu propuesta técnica con alguna de esas tres monedas, suena a capricho.

Ejemplo clásico:

→ “Este módulo es una chapuza, deberíamos refactorizarlo.”

Nadie va a mover un dedo.

En cambio:

→ “Este módulo genera 6 bugs al mes, con un coste de soporte de 2000 €/mes. Refactorizarlo reduce la incidencia en un 80 % y libera al equipo para nuevas features.”

Ahora sí: estás hablando su idioma.

**¿Clave? Reescribir tus argumentos en € (o tiempo, o riesgo)**. Todo lo demás es accesorio.

### 2. Aprende el idioma del otro lado

No todos los perfiles de negocio quieren lo mismo. Pero todos miden con métricas claras:

- El **CEO** no quiere saber qué framework usas. Quiere saber si esa decisión ayuda a crecer y proteger su ventaja competitiva. Mira revenue, NPS, cuota de mercado.
- El **CFO** quiere controlar el flujo de caja y minimizar riesgos. Mira OPEX, CAPEX, TCO, Cost of Delay.
- El **CMO** solo va a escucharte si le ayudas a captar y retener usuarios. Mira CAC, LTV, tasa de conversión.
- El **CTO** sí se preocupa por rendimiento técnico, pero tampoco por la pureza del código. Mira Lead Time, MTTR, frecuencia de releases.

Si tú hablas de “deuda técnica” y ellos de “coste de oportunidad”, no hay puente posible.

Coge esas métricas, hazte un glosario, y practica hasta que te salgan solas.

No es postureo. Es ser bilingüe: tech y negocio.

### 3. Rediseña tus conversaciones como si fueran pitches

¿Has visto cómo presenta un CMO su plan anual?

No empieza con teoría. Empieza con un problema, lo cuantifica, plantea solución y estima ROI.

Haz lo mismo con tus propuestas técnicas:

1. **Problema visible**
    
    “Nuestra app tarda 4 s en cargar. Cada segundo extra reduce la conversión un 7 %.”
    
2. **Impacto cuantificado**
    
    “Eso son 120.000 € de ingresos perdidos al mes.”
    
3. **Solución técnica (resumida)**
    
    “Con un refactor + lazy-loading reducimos el TTI a 1,8 s.”
    
4. **ROI y horizonte temporal**
    
    “4 semanas de trabajo → break-even en 3 meses.”
    
5. **Petición clara**
    
    “Necesitamos 2 FTEs y posponer la feature X a Q4.”
    

¿Ves la diferencia?

Dejas de sonar como alguien que pide permiso para “limpiar el código”

Y pasas a sonar como alguien que propone una **inversión con retorno**.

### 4. Usa marcos mentales que ya dominan

No tienes que inventarte frameworks nuevos. Usa los que ya respetan:

- **Cost of Delay** = cuánto cuesta NO hacer esto ahora. (No lo ignores, cuantifícalo.)
- **TCO (Total Cost of Ownership)** = incluye mantenimiento, soporte, formación, incidentes.
- **Risk Heat-Map** = matriz de probabilidad × impacto. Si algo está en rojo, se mueve rápido.
- **OKRs** = alinea tu iniciativa con un objetivo de negocio real. No con tu “gut feeling”.

Si usas estos modelos, entras en su terreno. Y ahí sí te creen.

### 5. Aplica técnicas de persuasión sin bullshit

No estamos hablando de manipular. Estamos hablando de comunicar bien.

Algunas herramientas prácticas:

- **Storytelling**: en vez de explicar la arquitectura, cuenta lo que pasó cuando un bug tumbó producción en viernes a las 18 h. Y cómo esto lo evita.
- **Analogías financieras**: “la deuda técnica paga intereses compuestos del 20 % anual”.
    
    Funciona. Porque CFO = números.
    
- **Coste de oportunidad**: “si lo hacemos después de Navidad, nos costará el doble porque habrá más tráfico y más datos que migrar”.
- **Prueba social interna**: “el equipo mobile ya migró y ahora ganan 1 sprint por release”.

Esto no son trucos de PowerPoint. Son argumentos que el negocio ya usa. Solo hay que adoptarlos.

### 6. Influencia no se gana en una reunión

Uno de los mayores errores: creer que todo se decide en el comité.

No. Se decide en las conversaciones previas. En el café. En los chats uno a uno. En cómo mantienes el pulso día a día.

Consejos prácticos:

- Mapea aliados y detractores desde el minuto cero. No todos te van a apoyar. Adelántate.
- Comparte pequeños dashboards quincenales. Nada de “95 % test coverage”. Habla de resultados reales.
- Consigue quick wins visibles antes de pedir algo gordo.
    
    Si has entregado valor pequeño, te creen con el valor grande.
    
- Invita a demos de 15 min. Que vean, que toquen.
- Participa en las conversaciones informales. Si el CFO habla de fútbol, únete. La confianza no nace en el Confluence.

### 7. Entrena del “tech-speak” al “biz-speak”

Esto hay que practicarlo. Como tocar la guitarra.

Ejemplo real:

**ANTES:**

“Necesito dos semanas para refactorizar el service y reducir la complejidad ciclomática.”

**DESPUÉS:**

“Con dos semanas de trabajo reducimos el lead time en un 20 % y evitamos 3 incidencias críticas al trimestre. Eso ahorra ~30.000 € en soporte.”

¿Qué cambia? Nada del código. Solo cómo lo cuentas.

Haz este ejercicio con cada propuesta. Reescribe. Ensaya. Pide feedback a alguien no técnico. Si lo entiende, vas bien. Si no, vuelve al punto 1.

### 8. Recursos para seguir puliendo

No necesitas una carrera nueva. Pero sí buenas referencias:

- **The Phoenix Project** – Para entender DevOps desde el punto de vista del negocio.
- **Accelerate** – Métricas que sí correlacionan con crecimiento.
- **Gojko Adzic (Impact Mapping)** – Cómo alinear lo técnico con lo estratégico.

### Cierra con práctica

Escoge una iniciativa técnica que tengas en mente. Y haz esto:

1. Rellena esta estructura: **Problema → Impacto → Solución → ROI**
2. Ensáyala en menos de 3 minutos.
    
    Póntelo difícil: grábate o cuenta a alguien fuera del equipo.
    
3. Ajusta el lenguaje. ¿Te entienden sin mencionar código?

Cuando lo domines, no estarás pidiendo “tiempo para refactorizar”.

Estarás negociando una inversión que mejora ingresos, reduce costes o mitiga riesgos.

Y ahí, *my friend*, es donde empieza la verdadera influencia.