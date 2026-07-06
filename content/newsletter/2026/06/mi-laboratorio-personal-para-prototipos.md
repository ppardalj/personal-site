---
title: 'Mi laboratorio personal para prototipos'
description: 'Por qué y cómo he montado un servidor virtual VPS como infraestructura para desplegar los prototipos y MVPs que desarrollo.'
author: pedropardal
date: 2026-06-19T00:00:00.000Z
layout: post
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 18
---

Llevo 15 años construyendo software.

Pero durante estos últimos meses, con todo este rollo de la IA, me estoy dando cuenta de algo curioso: es cierto que es más barato que nunca crear aplicaciones desde cero, prototipos y MVPs, con métodos como el *vibe coding*. El cuello de botella ya no está tanto en el tiempo que tienes para desarrollar, sino en otros aspectos.

El primero, en la cantidad y calidad de las ideas que tengas, i.e.: ¿soy capaz de identificar un problema que merezca ser solucionado con software a medida, y tengo una idea para hacer un software que lo haga de una forma particular?

En mi caso particular, tengo una empresa, que tiene sus problemas y procesos, y trabajo con varios clientes, que también tienen sus problemas y procesos, y que se repiten cada día. Ideas de problemas que resolver y procesos que automatizar no me faltan. En este sentido, el boom IA me ha venido hasta bien.

## La infraestructura: el cuello de botella

Pero otro de los cuellos de botella, y del que precisamente quiero hablar en este post, es el de la infraestructura donde alojar todas esas aplicaciones. Porque una cosa es vibrar en Google AI Studio mientras estás prototipando, pero cuando sales de ahí y quieres desplegar ese prototipo para seguir iterando y montar un producto con cara y ojos, ponerlo a disposición de usuarios, etc., ya la cosa cambia.

Dicho de otro modo: cada vez es más fácil crear apps, pero desplegarlas y operarlas sigue siendo igual de chungo que siempre.

## La solución por defecto: los Platform as a service (PaaS)

Para resolver este problema, lo más socorrido, y lo que creo que hace todo el mundo al principio, es irse a soluciones como Vercel, Netlify, Render o Supabase, que con relativamente poquitas piezas te dan una base más que suficiente para empezar. A mi, particularmente, se me quedó corto pronto:

- Los costes se disparan rápido: Cuando tienes uno o dos proyectos, todo bien. Pero cuando te vienes arriba y empiezas a crear cosas, te agotas los *free tiers* rápido. Por ejemplo, en Supabase sólo puedes tener 2 proyectos activos a la vez, si quieres más, ya tienes que pagar. En Netlify puedes tener los que quieras, pero el pago es por deploy, y a mi me gusta hacer CI/CD y commits pequeñitos, así que eso de pagar por hacer commit es algo que me hacía sarpullido.
- Vendor / Tech lock-in: Muchas de estas herramientas son *opinionadas*, o te limitan en las decisiones de tecnología. Por ejemplo, para montar un backend con Supabase, estás obligado a usar Deno/Typescript (hasta donde yo sé), y sus propias librerías y soluciones (de auth, storage, etc.). Si no te importa, puede estar bien. Pero a mi Typescript me da pereza. Yo quería tener la libertad para usar el lenguaje/framework que me diera la gana. Además, muchos de mis pet projects son laboratorios de prueba para clientes finales: p.ej. si tengo que aprender Rust para un cliente, mi forma de aprender es montarme un pet project en Rust, y quiero poder tener donde desplegarlo.

## Cloud providers

En el otro lado de la balanza, tenía la opción de irme a un cloud provider, como AWS, Google Cloud o Azure, y utilizar la infraestructura y las soluciones de plataforma de alguno de estos. Para proyectos que van a escalar, sin duda hubiera sido una decisión más que sensata, pero para juguetear con prototipos o MVPs no validados, me pareció matar moscas a cañonazos plantearme montar clusters de Kubernetes en EKS, terraforms y mil historias. Además, ni tengo el conocimiento para hacerlo, pero sobre todo, no me interesa lo más mínimo ponerme a aprender administración de sistemas a ese nivel.

## ¿Infra y plataforma propias?

Entonces paré a pensar y poner en orden realmente lo que necesitaba:

- Una infra/plataforma básica donde poder desplegar mis MVPs y prototipos rápidamente y sin fricción.
- Que no requiera muchísimos conocimientos profundos de administración de sistemas.
- *Low budget*: no quiero tener la fricción de tomar la decisión de gastarme pasta para cada nueva idea loca que se me ocurra, porque sino no la hago. Quiero hacerla y ya.
- *Low maintenance*: que requiera el mínimo mantenimiento posible una vez esté montada.
- Que me permita tener control suficiente para desplegar piezas de infra locas que se me ocurran (y spoiler: se me han ocurrido ya unas cuantas).
- Idealmente, que me permita aprender algo nuevo, que esté dentro de mis competencias actuales, mejor.

¿Existe alguna solución que satisfaga estos requisitos? Pues resulta que sí: montar una plataforma basada en soluciones open source, y desplegarla en un servidor dedicado virtual (VPS).

Y justo eso es lo que hice. En el resto de este post explico cómo, qué decisiones tomé y qué he aprendido por el camino.

## La infra: un servidor virtual privado (VPS)

Aquí pensé poco: la opción más budget es un servidor VPS. En concreto me decanté por OVH, ya que llevo trabajando con ellos 15 años para diferentes proyectos (dominios, servidores dedicados etc.) y sé que funcionan bien.

Me agencié un VPS con 6 cores, 12 gigas de RAM y 100 GB de disco. Acceso root por SSH con una Ubuntu 24, donde tengo control total y absoluto sobre la máquina, tráfico ilimitado y backups automatizados. Para pet projects o MVPs, dudo mucho que se quede corto.

Respecto a economics: esta es la única pieza del puzzle que me cuesta dinero: 120€ al año. Eso es más o menos lo que me cuesta el plan más barato de Netlify, y aquí puedo desplegar todos los proyectos que quiera, todas las veces que me de la gana.

## La plataforma base: Coolify

Desplegar aplicaciones en VPS a pelaco es bastante doloroso, así que entre montar el clásico apache/nginx o servidor de aplicaciones preferido y un cluster de Kubernetes que solo de oirlo se me ponen los pelos como escarpias, estuve investigando posibilidades, y di con Coolify.

Coolify es un PaaS open source, similar a Render, Vercel o Netlify, pero que instalas en tu servidor y te permite desplegar cosas ahí, y él te gestiona los deploys, enrutamiento, etc.

Funciona íntegramente con Docker, es decir:

- Si quieres desplegar una app, tienes que dockerizarla.
- Cualquier cosa que sea una imagen de docker (o un docker-compose) se puede desplegar.

Además, Coolify tiene un montón de templates preconfiguradas para desplegar software open source en tu servidor en unos pocos clicks: Wordpress, n8n Community, la versión de Supabase selfhosted, Postgresql… por nombrar unas cuentas. No tenía del todo claro cuáles iba a utilizar, pero es bastante probable que en algún momento quisiera hacerlo, y la posibilidad de hacerlo es bien.

Coolify se encarga de todo el enrutado a tus apps, tú solo tienes que configurar las DNS de tu dominio, construir las imagenes docker (hablaré de esto después), y él se encarga del enrutado con traefik y de generar certificados SSL let’s encrypt.

Todo esto me pareció excelente, así que no lo pensé mucho más.

## Apps: todo en Docker

Todas las apps de usuario que despliego en Coolify están dockerizadas y a nivel de infraestructura se gestionan casi de la misma manera, lo cual ahorra mucho trabajo. A nivel de aplicación sin embargo, tengo 3 stacks preferidos:

1. **Static landings**: utilizo Hugo, un CMS lightweight sin base de datos basado en Markdown. Más que un CMS es un constructor de sitios estáticos, con un template engine y algunas pijadas más. Lo uso para construir las homepages y landing pages de mis productos. Webs como https://www.ppardalj.com/, https://www.exeal.com/ o https://www.sibelclan.com/ funcionan así. El empaquetado es en una imagen de nginx alpine que apenas pesa 24mb, y que sólo sirve estáticos, y ya.
2. **SPAs**: para las apps frontend, uso React+vite. No porque tenga ninguna preferencia en particular, sino más bien porque es lo que producen todas las herramientas de vibe coding tipo Google AI Studio, Figma make, etc. Ya a lo largo de los últimos meses me tocó aprender más a fondo React para poder desarrollar después de dejar la primera etapa de vibrar. 
3. **Backend / APIs**: aquí uso apps C#.NET 10, no por nada, sino porque es el stack que me gusta, y como son mis proyectos personales, pues en mi tiempo libre quiero usar las tecnologías y el stack que a mi me de la gana XD pero lo guay es que podría ser cualquier cosa, porque al final empaquetas en docker, y se opera todo igual. 

Todas las apps siguen la filosofía 12factor: están versionadas en git, la config vive fuera del repo (en Coolify), los logs escriben a salida estándar (y ya Coolify los gestiona), los backing services son a su vez otros contenedores o servicios de Coolify… en general, las mismas buenas prácticas de desarrollo moderno que usaría si fuera a desplegar en AWS o Google Cloud.

## CI/CD y gestión de la configuración

Dado que el código de todas las apps está en Github, lo más socorrido para montar las pipelines de CI/CD es Github Actions.

Todas las pipelines tienen la misma pinta:

1. Construyen la app con el comando que toque (react, dotnet, hugo…)
2. Ejecutan las baterías de tests (por supuestísisisimo, ¿qué pensabas, que en mis pet projects no hago tests? jajaja)
3. Empaquetan la app en una imagen docker.
4. Pushean la imagen a GHCR (Github Container Registry)
5. Llaman a Coolify via Webhook para lanzar un deployment

Tomé la decisión de que el código de todas las aplicaciones que montaría y las imagenes docker en GHCR iban a ser públicas. Principalmente porque así me ahorro el paso tedioso de configurar credenciales (y de pasar por caja, pffff qué pesetero soy). Y no es algo que me importe, porque la configuración / secretos no vive dentro del repo de git. El código puede ser público sin problema, y así de paso me sirve como showcase.

Respecto al versionado de las imagenes: simple, nunca hago rollback, siempre deploy hacia adelante con el tag latest. Me ahorro muchísimas complicaciones, y como nunca hago deploys grandes, si algún deploy va mal es fácil saber qué se ha roto y arreglarlo rápido.

Hablando de la config, vive principalmente en variables de entorno.

- Para las apps front, estas variables viven en la propia pipeline en Github Actions. No hay secrets en front, solo config de entorno (Client IDs, endpoints, etc.)
- Para las apps back, donde sí hay secretos, tambien viven en variables de entorno, pero en este caso en Coolify. En el futuro quizá meta alguna solución tipo Vault, para versionar los secretos más decentemente, pero de momento me vale.

Las pipelines de mis apps backend también ejecutan las migraciones de base de datos. Como mis backends son todos C#.NET 10, utilizo las migraciones de Entity Framework. Como siempre despliego hacia adelante, nunca hago down de ninguna migración.

Respecto a los entornos, de momento únicamente trabajo en local y en producción. Pero meter un entorno de staging / preprod para alguna app sería trivial.

## Backing services

Una de las cosas chulas de Coolify es que puedes desplegar lo que te de la gana, siempre que sean imagenes de docker. Eso incluye también las bases de datos.

En mi caso, para ahorrar en recursos, tengo una única instancia de Postgresql compartida para todas las apps, con un usuario/schema para cada una de las apps.

Soy plenamente consciente de que, desde un punto de vista de seguridad y performance, es una solución que dista mucho de ser óptima. Pero para prototipos o MVPs sin validar que aún no necesitan escalar ni nada, me pareció suficientemente aceptable. Gestiono las bases de datos desde un pgadmin que también es una aplicación desplegada en el propio Coolify, que tampoco es lo óptimo, pero te pones a pensar y… realmente el nivel de seguridad que tiene un Supabase hosted (donde te logas con user/password o a lo sumo con 2FA) es más o menos el mismo… así que de momento he decidido no complicarlo mucho más.

Como IDP (gestión de identidad de usuarios, signup, login, etc.), por motivos históricos utilizo el tier gratuito de Auth0 (la mayoría de mis apps las monté ya con esto). Estuve bicheando hace poco Zitadel como alternativa self-hosted, pero aún no lo he investigado a fondo.

## Observabilidad

Aquí diferenciamos entre observabilidad de aplicaciones y observabilidad de sistema.

A nivel de **sistema**, tengo instalado a nivel global una instancia de Beszel, un servidor de monitorización super lightweight, que consume nada y menos, y que te da métricas básicas de CPU, memoria, disco, uso de red etc., tanto a nivel global como de todos los contenedores Docker que están corriendo en la máquina. Lo uso principalmente para saber si hay algún problema de carga a nivel global o con algun app en concreto, saber cómo va de sobrada la máquina, si tengo margen para desplegar más apps, etc.

A nivel de **apps**, desplegué un stack Grafana/Loki/Alloy bastante estándar, que me permite visualizar los logs de todas las aplicaciones. El único requisito es que cada app envíe logs estructurados en json a salida estándar, y ya por debajo el stack está configurado para almacenar esos logs en Loki y pintarlos con Grafana. Aunque he de decir que Grafana, por muy potente que sea, siempre me pareció ultra complicado de usar (no por nada sino porque tiene demasiadas historias), y estoy valorando otras opciones más simples.

## Distribución global con Cloudflare CDN

Cuando despliegas en un PaaS comercial, la gran mayoría sirven el contenido de tus apps globalmente a través de un CDN para optimizar el delivery a nivel mundial. Esto es especialmente crítico en las apps frontend y en las webs estáticas. Pero en un VPS todo el tráfico por defecto se lo come tu servidor. Así que necesitas una solución CDN.

En mi caso elegí Cloudflare, que ya lo había usado en otro proyecto. Es un CDN world class, que es bastante particular porque, al contrario que el resto de CDNs, la diferencia de tier gratuito y tier de pago no es volumen de tráfico, sino features. Y a mi me sobran con las features del tier gratuito de Cloudflare =)

Para instalar cloudflare simplemente tienes que apuntar los nameservers de tu dominio a los de Cloudflare, y él hace una copia de la zona DNS en su sistema. Luego, para los subdominios que quieras servir desde la CDN, activas la “nube naranja” y automáticamente Cloudflare servirá ese dominio desde su red, liberando la carga de tu servidor. Así de sencillo.

## Automatizaciones no-code y agentes IA con n8n

Hay ocasiones en las que no necesito montar una app entera para resolver un problema, con una simple automatización o un agente de IA me basta.

Por eso me instalé una instancia de n8n Community, una herramienta de automatización no code, similar a Make, Zapier o Power Automate. Lo guay de la versión Community es que es open source, puedes definir y ejecutar infinitos workflows (al contrario que con la hosted, que pagas bastante pronto), y puedes programarte tus propios nodos para añadir integraciones con tus propias apps desde n8n.

n8n está súper guay para prototipar integraciones o automatizar procesos sin hacer una app completa. Por ejemplo, yo tengo una automatización para que cada alumno que se da de alta en la academia de Exeal, automáticamente se suscribe a la newsletter de ConvertKit. No lo hago a mano, pero tampoco necesito una API para eso. También puedes crear formularios, servidores MCP, agentes de IA, webhooks…

## Próximos pasos

Esta plataforma dista muchísimo de ser perfecta. Pero, de momento, para juguetear y para desplegar mis proyectos sin pensar mucho, sin mucho mantenimiento y sin dejarme una millonada en PaaS comerciales, me sirve.

Aún así aquí hay algunas líneas de trabajo futuro que tengo pendientes para alguna tarde que abra directo en Twitch:

1. **Backups**: aunque la máquina tiene backups automatizados de disco, estaría bien tener backups más finos, mínimo de las bases de datos (realmente de cualquier volumen docker que gestione Coolify). Y sobre todo probar a restaurarlos, porque un backup que está hecho y no sabes restaurar no vale para nada.
2. **Mejorar la seguridad**: probablemente ahora mismo el server esté lleno de agujeros. Hay muchas herramientas expuestas a internet directamente, que quizá convendría securizar con una VPN o tunel. Pero bueno, los básicos creo que están bien. 
3. **Mejores dashboards / observability**: como dije antes, me da una pereza terrible pelearme con Grafana. Lo dejé montado, los logs están aquí, se pueden hacer queries, tengo un feed de logs perruno para ver, pero ya está. Sé que se pueden hacer visualizaciones superguapas, pero no sé cómo y me da pereza meterme. Un día de estos quizá.
4. **Ephemeral Environments:** se trata de entornos de staging/preprod bajo demanda. No es que lo necesite ahora mismo para ninguna app, pero es algo que está muy de moda ahora y me gustaría saber montarlos.
5. **Más backing services**: sospecho que pronto me harán falta más piezas de infraestructura como:
    - Object storage (s3-like)
    - imgproxy
    - Rabbitmq (colas)
    - Feature flags
6. **Service templates**: Ahora mismo, cada vez que monto una app, o bien empiezo el repo de código de cero, o bien forkeo una existente, lo limpio y desarrollo desde ahí, lo cual es un poco guarrete. Molaría montarme un repo de base para cada stack con el código, framework y librerías mínimo para echar a andar una app en minutos. Mi objetivo sería que, cuando tenga una idea de negocio, en apenas una tarde pueda tener todo el stack funcionando, desplegado y listo para seguir iterando. Que mi sprint 0 dure una tarde, vaya.

## Conclusiones

Mi objetivo principal con todo esto era reducir la fricción a la hora de comenzar con un nuevo proyecto o una nueva idea de app. La IA nos soluciona la parte de código, hoy en día te coges el Google AI Studio y en pocos minutos / horas tienes algo muy decente. Sin embargo, la parte de infraestructura, hasta donde yo sé, sigue siendo igual de tediosa que siempre. Cuando el cuello de botella pasa a ser la infra, merece la pena invertir un poquito en montarte algo que te solucione la papeleta. Y a mi al menos me está sirviendo.

Pensando ya en producción, si tuviera que montar la infraestructura / plataforma de una startup, probablemente empezaría con una solución muy similar a esta. Porque ahí los incentivos son muy similares: lo que me interesa es montar algo funcional rápido, con 0 fricción y coste mínimo.

Ahora bien, si tuviera que montar la infra de un proyecto para que escale (o esa misma startup después de encontrar el product-market fit), probablemente mantendría un stack parecido en principio, e iría sustituyendo las diferentes partes que no escalan.

Iterativo e incremental =)

Lo que es seguro en cualquier caso, es que la experiencia y conocimientos que me está dando montar este stack, son absolutamente transferibles a montar un stack más complicado que escale.

Y en la era de la IA, donde parece que todo va cada vez hacia un escenario donde lo que tiene valor son los perfiles en T (conocimiento trasversal, un área de especialización), y que además la T es cada vez más ancha (desde diseño de producto hasta operaciones y sistemas), tener unas bases mínimas me parece muy útil.

¿Lo necesitas? Quizá no.

¿Es útil? Yo apuesto a que sí.

Oye, y si no, pues qué me quiten lo bien que me lo he pasao cacharreando.
