---
title: 'Cómo introducir tests E2E en un sistema legacy sin tests (parte 1/2)'
description: 'Un enfoque pragmático para introducir tests E2E en un backend legacy sin tests: refactors atómicos, arquitectura hexagonal y control del riesgo en producción.'
author: pedropardal
date: 2025-12-27T00:00:00.000Z
layout: post
tags: [legacy, testing, arquitectura]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
card_image: /images/blog/posts/programador.jpg
---

Hay sistemas en los que tocar código da respeto. Y luego están aquellos en los que tocar código **da miedo de verdad**: flujos críticos, dinero real, integraciones externas y cero red de seguridad.

Este era uno de esos casos.

Un e-commerce en Symfony, con años de evolución y mucha lógica de negocio acumulada. El sistema funcionaba, pero no había ningún tipo de tests automatizados. Ni unitarios. Ni de integración. Ni end-to-end. Cada cambio relevante se hacía con testing manual y mucha cautela.

Para fixes pequeños y locales, el enfoque aguantaba. Pero en cuanto el cambio tocaba un flujo crítico —creación de pedidos, sincronización con plataformas externas, reglas de negocio complejas— el riesgo se disparaba. Ahí el testing manual dejaba de escalar y no había forma real de saber si un refactor había roto algo sutil.

Ese es el punto en el que “no tener tests” deja de ser una cuestión técnica y se convierte en un **riesgo de negocio**.

---

## Antes de escribir tests, había que *entender el sistema*

El primer error habría sido lanzarse a escribir tests sin entender el comportamiento real del sistema. Antes de eso, fue necesario dar un paso previo: **añadir observabilidad básica**. Logs estructurados, contexto compartido y la trazabilidad mínima para poder seguir un pedido de principio a fin.

Ese trabajo no se hizo pensando todavía en tests. Se hizo para **entender el sistema**. De hecho, todo ese proceso lo cuento con más detalle en el [post anterior](como-meti-observabilidad-y-una-red-de-seguridad-real-en-un-backend-legacy-sin-tests-sin-romper-produccion.md). Sin esa capa previa, lo que vino después simplemente no habría sido posible.

La observabilidad permitió empezar a responder preguntas simples pero fundamentales:

* ¿Dónde empieza realmente este flujo?
* ¿Qué servicios participan?
* ¿Qué decisiones se toman y en qué orden?

Hasta ese momento, muchas de esas respuestas solo existían “más o menos” en la cabeza de alguien o enterradas en el código. Sin esa visibilidad previa, cualquier intento de escribir tests habría sido poco más que una **ilusión de control**: tests que pasan, pero que no protegen nada importante.

---

## El *error habitual*: empezar por el tipo de test equivocado

En sistemas sin tests, es tentador empezar por unit tests y “limpiar” diseño poco a poco. Aquí eso no era realista:

* El código no estaba diseñado para testear unidades aisladas.
* El coste inicial era enorme.
* El valor inmediato para el negocio era bajo.
* Y el riesgo, alto.

Así que se tomó una decisión consciente: **no íbamos a validar cómo debería funcionar el sistema, sino cómo funciona ahora mismo**.

Eso nos llevaba directamente a **tests de caracterización**.

---

## Tests de caracterización: el *comportamiento actual* como contrato

Un test de caracterización asume algo muy concreto:

> El comportamiento actual del sistema es el contrato que hay que proteger.

No se juzga si es elegante ni si está bien diseñado. Se captura tal cual. El objetivo no es expresar intención, sino detectar cambios.

La pregunta que responde el test no es *“¿esto está bien?”*, sino:

> *“¿esto sigue haciendo lo mismo que ayer?”*

Para un sistema legacy en producción, ese cambio de enfoque es clave.

---

## Elegir *un solo* flujo crítico

Aquí es fácil equivocarse queriendo cubrir demasiado pronto. En lugar de eso, se eligió **un único flujo**, el más sensible:

* atraviesa muchas capas,
* depende de integraciones externas,
* y su fallo impacta directamente en negocio.

Concretamente: **el flujo completo de creación y sincronización de un pedido** desde una plataforma externa hasta el core del sistema.

Ese flujo sería el primer test E2E. Nada más.

---

## Primer choque técnico: el flujo *no era ejecutable* desde un test

El primer intento de ejecutar ese flujo desde PHPUnit dejó claro el problema principal: el sistema **no estaba pensado para ser invocado desde un test**. La lógica de negocio vivía mezclada con demasiadas cosas que no le correspondían: validación HTTP, parsing de requests, detalles del webhook y decisiones de infraestructura. Todo eso hacía que el flujo solo pudiera ejecutarse en un contexto “real”, nunca bajo control.

En la práctica, el punto de entrada del flujo era algo así:

```php
class ShopifyWebhookController extends AbstractController {
    #[Route('/shopify/orders/create', methods: ['POST'])]
    public function shopifyWebhookOrderCreate(Request $request): Response {
        // Validación del webhook (headers, firmas, etc.)
        // Parsing de la request HTTP
        // Manejo de errores de protocolo

        // Lógica de negocio embebida:
        // - crear o actualizar el pedido
        // - disparar procesamiento
        // - aplicar reglas
    }
}
```

Aquí el problema no era solo la falta de tests, sino que **el caso de uso estaba secuestrado por la infraestructura**. Para ejecutar la lógica de negocio tenías que pasar por HTTP, por Symfony, por el runtime completo. Desde un test, eso es una pesadilla.

El primer paso técnico fue **hacer explícito el punto de entrada del flujo**, sin reescribir la lógica y sin cambiar comportamiento. Solo separarla.

La lógica de negocio se extrajo a un servicio de aplicación invocable directamente:

```php
class ShopifyWebhookListener {
    public function onOrderCreated(array $orderData): void {
        // Lógica de negocio pura:
        // - interpretar el pedido
        // - aplicar reglas
        // - persistir cambios
        // - disparar procesos posteriores
    }
}
```

El controller pasó a ser simplemente un adaptador:

```php
class ShopifyWebhookController extends AbstractController {
    public function shopifyWebhookOrderCreate(Request $request): Response {
        $orderData = $this->parseRequest($request);

        $this->shopifyWebhookListener->onOrderCreated($orderData);

        return new Response('OK');
    }
}
```

Este cambio es pequeño, pero decisivo. No se ha reescrito la lógica, no se ha cambiado el comportamiento del sistema. Lo único que ha cambiado es que ahora **el caso de uso tiene un punto de entrada claro**, invocable tanto desde HTTP como desde un test.

Conceptualmente, esta separación viene directamente de [**arquitectura hexagonal**](https://academia.exeal.com/courses/masterclass-arquitectura-hexagonal): el controller es un adaptador de entrada y el servicio de aplicación actúa como **puerto primario**. El flujo ya no depende de cómo llega la petición, sino de qué se quiere hacer.

Y ese detalle marca la diferencia. A partir de aquí, el flujo puede ejecutarse bajo control desde PHPUnit, sin HTTP, sin webhooks reales y sin infraestructura innecesaria.

---

## Dejar que el test falle para saber *qué aislar*

Una vez el flujo tenía un punto de entrada claro y podía invocarse desde un test, llegó el siguiente choque con la realidad: **el test no avanzaba ni dos pasos sin romperse**.

Y eso era exactamente lo que tenía que pasar.

Cada fallo no era un problema, era una señal. El test estaba haciendo visible algo que antes estaba implícito: qué partes del flujo dependían directamente del mundo exterior y, por tanto, no podían controlarse desde un entorno de test.

Los primeros fallos eran siempre del mismo tipo:

* llamadas directas a APIs externas,
* clientes SDK instanciados dentro del método,
* `curl` o `HttpClient` invocados inline,
* servicios que asumían red, credenciales o estado real.

Por ejemplo, cosas de este estilo:

```php
class ShopifyWebhookListener {
    public function onOrderCreated(array $orderData): void {
        $shopifyOrder = (new ShopifySDK())->Order($orderData['id']);
        $paymentInfo = PaypalServerSdkClientBuilder::init()->getPaymentsController()->getAuthorizedPayment($orderData['payment_id']);

        // lógica de negocio a partir de datos externos
    }
}
```

Desde producción esto funciona.

Desde un test E2E, es **incontrolable**.

### No aislar “todo”, solo lo que el test necesita

Aquí es donde es fácil pasarse de frenada y empezar a “hexagonalizar” todo el sistema. No era el objetivo. La idea no era rediseñar la arquitectura, sino **hacer el flujo testeable lo justo**.

La regla es muy simple:

> *"Solo se aísla aquello que hace que el test no pueda avanzar."*

Nada más.

Cada vez que el test fallaba por una dependencia externa, se introducía un punto de aislamiento **en ese punto exacto**, no antes.

Siguiendo con el ejemplo anterior, el cambio fue algo así:

```php
interface ShopifyOrders {
    public function getOrder(string $orderId): array;
}

interface Payments {
    public function fetchPayment(string $paymentId): array;
}
```

Y el servicio pasó a depender de interfaces:

```php
class ShopifyWebhookListener {
    public function __construct(
        private ShopifyOrders $shopifyOrders,
        private Payments $payments,
    ) {}

    public function onOrderCreated(array $orderData): void {
        $shopifyOrder = $this->shopifyOrders->getOrder($orderData['id']);
        $paymentInfo = $this->payments->fetchPayment($orderData['payment_id']);

        // lógica de negocio
    }
}
```

En producción, esas interfaces se conectan a adapters reales.
En tests, a fakes controlados.

### ¿Qué pinta tiene un *fake* controlado (y cómo se usa en el test)?

Una vez introduces interfaces en los puntos justos, el siguiente paso natural es **reemplazar las dependencias externas por fakes controlados**. No mocks llenos de expectativas, sino [implementaciones simples que devuelven datos predecibles](https://www.ppardalj.com/newsletter/2025/06/por-que-los-mocks-hacen-tus-tests-mas-fragiles-y-que-usar-en-su-lugar/).

Un *fake* controlado suele ser algo así: una clase en memoria, sin red ni IO, que puedes programar explícitamente desde el test.

Ejemplo esquemático:

```php
final class FakeShopifyOrders implements ShopifyOrders {
    private array $orders = [];

    public function withOrder(string $id, array $order): self {
        $this->orders[$id] = $order;
        return $this;
    }

    public function getOrder(string $orderId): array {
        return $this->orders[$orderId];
    }
}
```

No hay magia. No hay expectativas implícitas.
Solo datos controlados.

En el test, el uso es igual de explícito:

```php
$shopify = new FakeShopifyOrders();
$shopify->withOrder('order-123', $this->sampleOrder());

$listener = new ShopifyWebhookListener(
    shopifyOrders: $shopify,
    // resto de dependencias
);

$listener->onOrderCreated($orderData);
```

Este tipo de fake te da tres cosas clave:

* control total sobre el escenario,
* cero dependencia del exterior,
* y una lectura muy clara del test.

El test no dice *“espero que se llame a X”*.
Dice *“dado este mundo, cuando ejecuto el flujo, el sistema se comporta así”*.

Y eso es exactamente lo que necesitas cuando estás caracterizando un sistema legacy.

### Interfaces cerca del IO (aunque no sea “clean”)

Aquí hay una decisión importante que conviene hacer explícita, porque es fácil juzgarla desde fuera.

Las interfaces **no** se colocaron en el core más puro posible. En muchos casos se colocaron **muy cerca del IO**, incluso delante de llamadas `curl` o SDKs externos.

Por ejemplo, en vez de envolver todo un cliente SDK enorme, se aisló justo el punto que hacía la llamada externa:

```php
class KlarnaHttpClient implements KlarnaGateway {
    public function requestPayment(array $payload): array {
        // llamada curl directa
    }
}
```

¿Es arquitectura hexagonal “de libro”?
No.

¿Es efectiva para testear un legacy real sin reescribirlo entero?
Sí.

El criterio fue siempre el mismo: **maximizar control en tests con el menor movimiento posible**.

### El test como motor del diseño

Lo interesante de este proceso es que **no hubo un diseño previo**. El diseño emergió a partir de los fallos del test.

El ciclo fue siempre el mismo:

1. Ejecutar el test.
2. Ver dónde falla.
3. Preguntarse: “¿esto depende del exterior?”
4. Introducir una interfaz mínima.
5. Repetir.

Esto encaja perfectamente con la idea de arquitectura hexagonal aplicada de forma pragmática: los **puertos secundarios** aparecen cuando el dominio necesita hablar con algo externo, no antes.

No se trata de imponer una arquitectura, sino de **dejar que el sistema la vaya pidiendo**.

### Qué se gana con este enfoque

Después de aislar las dependencias mínimas necesarias, el test empezó a avanzar de verdad. Y con ello aparecieron varias ventajas claras:

* el flujo podía ejecutarse completo sin tocar red,
* las integraciones externas quedaban bajo control,
* el core de negocio empezaba a ser invocable en aislamiento,
* y el diseño mejoraba **como efecto secundario**, no como objetivo.

Todavía no estábamos validando resultados.
Todavía no había asserts.

Pero el sistema ya había cruzado una frontera importante:
**el comportamiento crítico podía ejecutarse dentro de un test sin depender del mundo exterior**.

---

## La parte más peligrosa: refactorizar sin red (todavía)

Aquí viene la realidad que en muchos posts se barre bajo la alfombra: durante buena parte del proceso **aún no había tests que nos protegieran**. Estábamos refactorizando precisamente para poder llegar a ese primer test E2E… lo cual significa que cada cambio tenía que hacerse como si estuvieras operando a corazón abierto.

La única forma de que esto fuera viable fue imponer una disciplina extremadamente conservadora: **refactors atómicos**, uno a uno, y **validación manual entre pasos**. No “gran refactor”, no “ya que estoy aquí”. Cirugía.

La regla era simple:

> Cada commit debía poder explicarse como “misma lógica, diferente forma”.
> Y después de cada paso, había que comprobar manualmente que el flujo seguía funcionando.

### Qué significa “refactor atómico” en la práctica

En vez de tocar diez cosas a la vez, el trabajo se descompuso en transformaciones pequeñas, típicamente asistidas por el IDE:

* **Extract Method**: sacar un bloque con nombre, sin cambiar comportamiento.
* **Extract Class**: mover métodos enteros a otra clase.
* **Extract Interface**: introducir un contrato delante de una dependencia externa.
* **Introduce Parameter / Dependency**: pasar una dependencia como argumento (o por constructor) en vez de instanciarla inline.
* **Move Method / Rename**: clarificar sin alterar la lógica.
* **Inline** (a veces): eliminar capas falsas que estorbaban al siguiente paso.

El orden importaba. Primero hacer el código “movible”, luego introducir seams (interfaces), y solo entonces empezar a fakear dependencias en tests.

Ejemplo esquemático de cómo se veía ese camino:

```php
// Paso 1: Extract Method (sin cambiar nada)
private function fetchExternalOrder(string $orderId): array {
    return $this->shopifySdk->getOrder($orderId);
}

// Paso 2: Extract Interface (mismo comportamiento)
interface ExternalOrders { public function getOrder(string $orderId): array; }

// Paso 3: Adapter (mismo IO, pero detrás de interfaz)
final class ShopifyExternalOrders implements ExternalOrders {
    public function __construct(private ShopifySdk $sdk) {}
    public function getOrder(string $orderId): array { return $this->sdk->getOrder($orderId); }
}

// Paso 4: Inyección (ahora testeable)
final class OrderProcessor {
    public function __construct(private ExternalOrders $orders) {}
}
```

Nada de esto “añade features”. Solo crea puntos de acoplamiento controlables.

### Manual testing como guardrail temporal

Hasta que el primer test E2E no empezó a pasar, el guardrail era manual. Pero no era “probar un par de cosas y ya”: era un manual testing dirigido y repetible, siempre igual, para detectar regresiones rápido.

Un patrón típico era:

* disparar un webhook simulado en dev, con Postman,
* confirmar que el pedido entra,
* confirmar que atraviesa los estados esperados,
* y revisar logs/DB lo justo para saber que el flujo no se ha roto.

La obsesión aquí no era la cobertura, era la **confianza incremental**: después de cada transformación, necesitas una señal rápida de que sigues vivo.

### Por qué esto importa tanto

Porque si no haces esta parte bien, el resto del post es teoría bonita. En legacy real, el “cómo llego al primer test” es el tramo más difícil. Y la diferencia entre avanzar y liarla no está en saber hexagonal o DI: está en saber refactorizar con precisión quirúrgica cuando no tienes red.

Esta disciplina fue la que permitió que el test, poco a poco, dejara de romperse por todas partes… y empezara a avanzar.

Y cuando por fin el flujo ya no dependía del exterior, apareció el siguiente muro inevitable: **la base de datos**.

---

## La base de datos: cuando mockear deja de servir

Para este tipo de test E2E, mockear repositorios simplemente no era una opción realista. El comportamiento que queríamos caracterizar dependía directamente de cómo evolucionaba el estado persistido del sistema: qué entidades se creaban, cómo cambiaban de estado, qué registros auxiliares aparecían o desaparecían a lo largo del flujo. Todo eso forma parte del comportamiento real del sistema y no puede simularse con dobles sin perder fidelidad.

El enfoque fue asumir desde el principio que el test necesitaba una **base de datos real**, pero bajo control total.

### Una base de datos dedicada, no “la de dev”

El primer paso fue crear una base de datos **exclusiva para tests**, separada explícitamente de desarrollo y, por supuesto, de producción. No era una copia viva, sino un entorno preparado específicamente para ejecutar flujos completos de forma repetible.

Las reglas eran claras:

* mismo esquema que desarrollo, sin atajos,
* datos semilla inspirados en producción,
* información sensible anonimizada,
* y la capacidad de resetear el estado antes de cada ejecución.

El esquema se definía de forma explícita mediante un `schema.sql` con el DDL real. ¿Por qué? Simplemente porque, en proyectos legacy como este, las migraciones a veces cuentan una historia distinta a la de la base de datos real, así que el único punto de partida fiable era el esquema tal y como existía en ese momento, extraído directamente de la base de datos de producción.

### Carga de datos iniciales (fixtures mínimos)

Sobre ese esquema se cargaba un conjunto de datos semilla muy deliberado. No se trataba de replicar producción, sino de tener **el mínimo conjunto de datos necesario** para que el flujo pudiera ejecutarse de forma realista:

* una conexión activa,
* uno o dos productos,
* configuraciones mínimas para reglas y proveedores,
* y cualquier entidad estrictamente necesaria para que el flujo no fallara por motivos triviales.

Estos datos se cargaban siempre de la misma forma, al inicio del test o del suite, de manera que el entorno fuera completamente determinista.

### Reset controlado: qué se borra y qué no

Antes de cada ejecución del test, el estado variable de la base de datos se reseteaba de forma explícita. Pero aquí hubo que ser cuidadosos: **no todo se borra**.

La estrategia fue distinguir entre:

* **tablas de referencia**: configuración, catálogos, datos base → se mantienen.
* **tablas de estado**: pedidos, logs, intentos, eventos → se limpian.

En la práctica, el reset consistía en truncar un conjunto muy concreto de tablas, siempre las mismas, y en un orden controlado. Nada de “DROP ALL” ni resets genéricos.

```php
$this->loadSql($this->conn, __DIR__.'/DbSeed/999_reset.sql');
$this->loadSql($this->conn, __DIR__.'/DbSeed/000_baseline.sql');
```

### Guardrail: asegurarse de que nunca reseteas donde no debes

Este punto es crítico y merece mencionarse explícitamente.

Antes de ejecutar cualquier reset, el test verificaba una condición de seguridad en la base de datos: una **tabla o valor canary** que solo existe en la base de datos de tests. Si esa comprobación fallaba, el test abortaba inmediatamente.

Conceptualmente:

```sql
SELECT value FROM test_canary;
-- debe devolver algo como: "SAFE_TO_RESET"
```

Si esa fila no existe o no contiene el valor esperado, el reset **no se ejecuta**.

```php
$this->assertTestEnvironment();
$this->assertTestCanaryExists($this->conn);
```

Este guardrail evita errores catastróficos del tipo “he lanzado los tests contra la base de datos equivocada”, que en sistemas legacy no son una hipótesis teórica, sino un riesgo real.

### Resultado: un entorno reproducible y predecible

Con esta configuración, cada ejecución del test empezaba desde un estado conocido y terminaba con un estado completamente controlado. El flujo crítico podía ejecutarse de principio a fin, siempre bajo las mismas condiciones, sin dependencia de ejecuciones anteriores ni de efectos colaterales.

En ese punto, por primera vez, el sistema dejaba de ser una caja negra impredecible y pasaba a ser algo **ejecutable y observable bajo demanda**.

Y justo ahí, cuando ya tienes el flujo ejecutándose de forma determinista, aparece la siguiente pregunta inevitable:
¿cómo comprobamos que lo que ha pasado es “lo correcto” sin escribir tests frágiles?

---

## Hasta aquí solo hemos preparado el terreno

En este punto todavía no hemos validado nada. Solo hemos conseguido algo que antes no existía: **ejecutar un flujo crítico completo bajo control**.

No hemos hablado aún de:

* cómo verificar resultados complejos,
* cómo comparar estados sin tests frágiles,
* ni cómo evitar que estos tests se conviertan en una carga inmantenible.

Pero ahora el tablero es otro.

En el [siguiente post](https://www.ppardalj.com/newsletter/) entraremos justo ahí: cómo convertir todo ese comportamiento en un contrato verificable sin que los tests se rompan con cada cambio menor. Ahí es donde este enfoque se vuelve realmente potente… y donde empiezan las decisiones difíciles.
