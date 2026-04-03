---
title: 'Cómo introducir tests E2E en un sistema legacy sin tests (parte 2/2)'
description: 'Cómo convertir el comportamiento real de un sistema legacy en un contrato verificable usando tests E2E y Approval Tests.'
author: pedropardal
date: 2025-12-28T00:00:00.000Z
layout: post
tags: [legacy, testing, arquitectura]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 14
---

En el [post anterior](./como-introducir-tests-e2e-en-un-sistema-legacy-sin-test-parte-1-de-2.md) llegamos a un punto clave: conseguimos ejecutar **un flujo crítico completo** dentro de un test.

Eso, por sí solo, ya cambia las reglas del juego.

Pero ejecutar el flujo no es suficiente. El verdadero reto empieza ahora: ¿Cómo validas ese comportamiento sin escribir tests frágiles, llenos de asserts irrelevantes, que se rompen con cualquier cambio menor?

Este post va exactamente de eso.

---

## Qué queríamos validar (y qué no)

Antes de hablar de frameworks, asserts o snapshots, hubo que responder a una pregunta incómoda, pero fundamental:

**¿Qué significa realmente que este flujo “funcione correctamente”?**

La respuesta **no** era:

* que se llame a tal método,
* que se ejecute tal query concreta,
* que se dispare tal evento interno en un punto exacto.

Ese tipo de validaciones acaban generando tests extremadamente frágiles, acoplados a la implementación, que se rompen con refactors perfectamente legítimos.

Aquí aparece además una trampa muy habitual en sistemas legacy: **la falsa sensación de seguridad que dan ciertos tests unitarios**. Tests que pasan en verde, pero que solo validan fragmentos aislados del sistema, sin garantizar que el flujo completo siga funcionando cuando todas las piezas interactúan entre sí.

El problema no es el unit testing en sí, sino usarlo como sustituto de algo que no puede cubrir: la interacción real entre decisiones, estado persistido e integraciones externas.

Lo que queríamos validar era algo más grueso, pero también mucho más valioso:

* qué decisiones tomó el sistema,
* qué efectos persistentes produjo,
* y qué historia completa contó durante la ejecución del flujo.

En otras palabras: queríamos validar **el comportamiento observable del sistema**, no su implementación interna. Reducir el riesgo real de cambiar código crítico, no simplemente aumentar el número de tests en verde.

---

Buen punto, faltaba **cerrar el triángulo completo**: inputs → sistema → outputs.
Te dejo **la sección reescrita**, integrando los **inputs controlados** de forma clara y natural, sin alargarla innecesariamente.

---

## El test E2E como “caja negra controlada”

A partir de ahí, el test E2E se planteó deliberadamente como una caja negra. La idea no era inspeccionar el interior del sistema, sino observar su comportamiento desde fuera, controlando con precisión qué entra y qué sale:

* le damos **una entrada conocida**,
* dejamos que el sistema haga lo suyo,
* y observamos qué ha pasado.

Nada de asserts finos repartidos por todo el código.
Nada de mocks internos ni expectativas sobre llamadas concretas.

### Inputs controlados

Para que este enfoque funcione, los **inputs del sistema tienen que estar completamente bajo control**. En este caso, esos inputs eran básicamente dos:

1. **El payload del webhook**, que representa el evento externo que inicia el flujo.
   Ese payload se construye explícitamente en el test, con datos realistas pero deterministas: el pedido, el cliente, los importes, los estados relevantes. No llega por HTTP real, pero es exactamente el mismo contenido que llegaría en producción.

2. **Las respuestas de las dependencias externas**, que ya no vienen del mundo real, sino de *dobles de test* (stubs) controlados.
   APIs externas, proveedores de pago, plataformas de terceros… todo eso responde con datos predefinidos que el test decide de antemano.

De esta forma, el test define **el mundo exterior completo** en el que el sistema va a operar.

```php
public function test_create_order_from_shopify_webhook(): void {
    // Arrange
    $shopifyOrderId = //...
    $shopifyOrderData = ShopifyMother::createOrder($shopifyOrderId);
    $factory->fake()->withOrder($shopifyOrderId, $shopifyOrderData);

    // Act
    $payload = [
        // ...
    ];
    $this->shopifyWebhookListener->onOrderCreated($payload);

    // Assert
    // ...
}
```

### Fuentes de verdad observables

Con los inputs totalmente controlados, el test se apoya en **fuentes de verdad observables** para entender cómo se ha comportado el sistema:

1. **El estado final de la base de datos**, que refleja los efectos persistentes del flujo.
2. **La traza de ejecución**, que cuenta qué decisiones se tomaron y en qué orden.
3. **Los eventos que se dispararon**, que muestran cómo reaccionó el sistema y qué procesos secundarios se pusieron en marcha.

Estas tres vistas, combinadas con inputs completamente deterministas, permiten responder a la pregunta importante: no solo *“¿terminó bien?”*, sino *“¿se comportó el sistema exactamente igual dado este escenario?”*.

A partir de aquí, el reto deja de ser ejecutar el flujo y pasa a ser **cómo capturar y comparar todo esto sin que los tests se vuelvan frágiles**, que es donde entra el resto del enfoque.

---

## La base de datos como parte del contrato

Empecemos por la base de datos.

En este tipo de sistemas, una parte muy importante del comportamiento real queda reflejada ahí: estados de pedidos, transiciones, flags, registros auxiliares, tablas intermedias… Si el flujo ha cambiado de verdad, **la base de datos lo delata**.

La idea no fue comprobar *una* fila concreta ni validar campos individuales. El objetivo era capturar **una vista coherente del estado relevante del sistema** tras ejecutar el flujo completo.

### En la práctica

Al final de la ejecución del test, se extrae un snapshot de la base de datos. Pero aquí se tomó una decisión consciente: **no intentar ser fino demasiado pronto**.

En lugar de seleccionar columnas concretas y razonar una a una cuáles deberían cambiar y cuáles no, el test captura **todo el contenido de las tablas que forman parte del flujo**. Tal cual.

Algo así:

```php
$dbSnapshot = [
    'orders' => $this->fetchAll('SELECT * FROM orders'),
    'order_logs' => $this->fetchAll('SELECT * FROM order_logs'),
    'payments' => $this->fetchAll('SELECT * FROM payments'),
];
```

¿Es ruidoso? Sí.

¿Incluye campos que quizá no importan a largo plazo? También.

Pero en este punto del proyecto, esa es precisamente la intención.

Aquí el objetivo no es expresar reglas de negocio de forma precisa, sino **detectar cualquier cambio inesperado** en el comportamiento persistente del sistema. Si algo cambia en estas tablas como consecuencia de un refactor, queremos verlo. **Todo**.

Más adelante, cuando exista una red mínima de seguridad y se empiecen a introducir tests más específicos —unitarios o de integración más fina— tendrá sentido ir acotando: seleccionar columnas concretas, aislar invariantes, expresar expectativas más precisas.

Como primer test E2E de caracterización, **capturar todo el estado de las tablas implicadas en el flujo es una ventaja, no un defecto**.

---

## Los logs: la historia completa del sistema

Aquí es donde la observabilidad previa se vuelve clave.

Los logs no se usaron solo para debug, sino como **una segunda fuente de verdad** del comportamiento del sistema. Porque los logs bien estructurados cuentan cosas que la base de datos no siempre refleja:

* qué ramas se tomaron,
* qué reglas se evaluaron,
* qué integraciones se llamaron (o no),
* en qué orden ocurrieron las cosas.

### Captura de logs en tests

A nivel técnico, el enfoque fue simple:

* configurar Monolog con un handler en memoria,
* limitarlo a los canales relevantes del flujo,
* capturar los logs estructurados durante la ejecución del test.

Esquemáticamente:

```php
$logs = $this->logRecorder->records();
// cada record ya es un array estructurado
```

El resultado es una secuencia de eventos que describe **cómo pensó el sistema** mientras ejecutaba el flujo:

```json
{
    "channel": "webhook",
    "level": "INFO",
    "message": "Received orders/create webhook",
    "context": {
        "financial_status": "authorized",
        "shopify_order_id": 1234
    }
},
{
    "channel": "orders",
    "level": "INFO",
    "message": "Syncing order with Shopify...",
    "context": {
        "shopify_order_id": 1234
    },
},
{
    "channel": "orders",
    "level": "INFO",
    "message": "Synced order with Shopify with status = {order_status}, Shopify status = {shopify_status}",
    "context": {
        "shopify_order_id": 1234,
        "order_status": "new",
        "shopify_status": "authorized"
    },
},
//...
{
    "channel": "orders",
    "level": "INFO",
    "message": "New order added",
    "context": {
        "shopify_order_id": 1234
    },
},
```

---

## Capturar los eventos despachados

Además del estado final y de los logs, había una tercera señal clave del comportamiento del sistema: **los mensajes despachados a través de Symfony Messenger**.

Muchos efectos importantes no ocurren de forma síncrona. Un flujo puede completarse “bien” y, aun así, cambiar radicalmente su comportamiento si deja de despachar ciertos mensajes o empieza a despachar otros distintos. Por eso, el test necesitaba observar **qué trabajo decidió poner en marcha el sistema**.

En el entorno de test, el bus de mensajes se instrumenta para **registrar todos los mensajes despachados** durante la ejecución del flujo. No para inspeccionar handlers ni validar efectos secundarios todavía, sino para capturar la intención del sistema: qué procesos asíncronos decidió disparar como consecuencia de la entrada recibida.

Esa lista de mensajes se convierte en una señal más del comportamiento observable del sistema, complementando el estado persistido y la traza de logs.

---

## Unirlo todo: estado, historia y consecuencias

El punto clave fue entender que **ninguna de estas señales por separado era suficiente**.

* **Solo base de datos** → sabes *qué* cambió, pero no *por qué*.
* **Solo logs** → sabes *por qué*, pero no si el estado final es coherente.
* **Solo eventos** → sabes *qué se intentó hacer después*, pero no si el flujo llegó al estado esperado.

Fue la combinación de las tres lo que dio una imagen fiel del comportamiento real del sistema.

Por eso, el output efectivo del test terminó siendo una estructura compuesta, algo así:

```php
$output = [
    'database' => $dbSnapshot,
    'logs' => $logSnapshot,
    'events' => $dispatchedMessages,
];
```

Ese objeto no representa una implementación ni una serie de asserts aislados. Representa **la historia completa del flujo**:

* qué efectos persistentes produjo,
* qué decisiones se tomaron durante la ejecución,
* y qué consecuencias asíncronas decidió disparar el sistema.

Eso es lo que queríamos proteger frente a refactors y cambios agresivos.

---

## Approval Tests: el encaje natural

Llegados a este punto, el tipo de test casi se elige solo.

Tenemos un output grande, estructurado y con mucho significado: estado de base de datos, traza de logs y eventos despachados. Comparar eso “a mano”, campo a campo, con asserts tradicionales no solo sería tedioso, sino contraproducente. El test acabaría lleno de detalles irrelevantes y se volvería frágil con cualquier cambio razonable.

Lo que realmente necesitábamos era otra cosa:

* poder **ver el resultado completo** del flujo,
* revisarlo con calma y criterio,
* y que cualquier cambio futuro se mostrara de forma clara y comprensible.

Ahí es donde encajan los **Approval Tests**.

La idea detrás de este tipo de tests es simple, pero poderosa: en lugar de describir el resultado esperado con asserts, **guardas una representación completa del resultado y la “apruebas” conscientemente**. A partir de ese momento, ese snapshot se convierte en el contrato.

### Cómo funciona en la práctica

En este contexto concreto, el test sigue siempre el mismo esquema:

1. Ejecuta el flujo completo con inputs controlados.
2. Construye el output agregado (base de datos, logs y eventos).
3. Lo serializa a un formato legible, normalmente JSON.
4. Lo compara contra un snapshot previamente aprobado.

El assert se reduce a algo así:

```php
// Assert
Approvals::verifyAsJson($output);
```

La primera vez que ejecutas el test no hay snapshot. El test falla y te muestra el resultado completo que ha producido el sistema. Ese es el momento importante: revisas ese output con conocimiento del dominio y decides **“esto es lo que hoy consideramos correcto”**. Cuando lo apruebas, el snapshot se guarda.

A partir de ese momento, cualquier cambio futuro en el comportamiento del flujo genera un diff claro y legible. No un stack trace críptico, sino una comparación directa entre *lo que había antes* y *lo que hay ahora*. Y ese diff te obliga a tomar una decisión explícita: o has encontrado un bug, o estás cambiando el comportamiento de forma intencionada y debes aprobar el nuevo resultado.

Este enfoque encaja especialmente bien con **tests de caracterización**: no te obliga a decidir desde el principio qué está bien o mal, pero sí **te obliga a ser consciente de cada cambio de comportamiento que introduces**.

---

## Normalización: la clave para que no sea un infierno

Los snapshots que generan estos tests contienen mucha información que **no aporta significado real** al comportamiento del sistema: identificadores generados al vuelo, timestamps, hashes, tokens o valores dependientes del entorno. Si todo eso se compara tal cual, cada ejecución del test produciría diferencias irrelevantes y los diffs serían inútiles.

Por eso, antes de comparar snapshots, el output pasa siempre por una fase de normalización. El objetivo es eliminar o estabilizar cualquier dato que no represente una decisión real del sistema.

Sin normalización, este enfoque sería simplemente inviable.

En la práctica, eso implica cosas como:

* eliminar IDs autogenerados,
* reemplazar timestamps por valores fijos o placeholders,
* anonimizar hashes o tokens,
* y normalizar cualquier campo cuyo valor dependa del entorno o del momento de ejecución.

Conceptualmente, el código hace algo así:

```php
$this->normalizer->stripIds($output);
$this->normalizer->normalizeTimestamps($output);
```

No es una limpieza cosmética. Es una decisión de diseño del test: **queremos que el snapshot capture intención y comportamiento**, no detalles accidentales de la ejecución.

Cuando esta normalización está bien hecha, ocurre algo interesante: los diffs dejan de ser ruido y pasan a contar una historia clara. Cada cambio visible suele corresponder a una decisión distinta en el flujo, y eso hace que el test sea realmente útil en el día a día.

---

## Qué tipo de cambios detecta este test

Este tipo de test E2E detecta cosas que otros tests no ven:

* una regla que deja de evaluarse,
* un cambio en el orden de decisiones,
* una integración que ya no se llama,
* un estado que deja de persistirse,
* un flujo que se corta antes de tiempo.

Y lo hace **sin conocer la implementación interna**.

Eso es justo lo que necesitas cuando refactorizas legacy con miedo.

---

## ¿Cuánto tardan estos tests?

Una pregunta inevitable con este tipo de tests es el tiempo de ejecución. La intuición suele ser que los tests E2E son lentos y costosos, y muchas veces lo son. En este caso concreto, no.

El test completo —ejecutando el flujo, tocando base de datos y capturando estado, logs y eventos— tarda **en torno a medio segundo**. Es un coste perfectamente asumible para un test que cubre un flujo crítico de principio a fin.

Además, estos tests se ejecutan **de forma automática en CI**. No son algo que alguien lanza “de vez en cuando” en local, sino una red de seguridad real que se ejecuta en cada cambio relevante. El objetivo no es tener cientos de estos tests, sino unos pocos bien escogidos que aporten máxima señal con un coste razonable.

---

## ¿Cuántos tests de estos tiene sentido tener?

No muchos. Y eso es una decisión consciente.

Este tipo de tests son muy potentes: cubren flujos completos, atraviesan muchas capas del sistema y detectan cambios de comportamiento que otros tests no ven. Pero precisamente por eso también tienen **un coste de mantenimiento**. Cada vez que el comportamiento legítimamente cambia, hay que revisar y aprobar nuevos snapshots.

La idea no es cubrir todos los flujos del sistema, ni sustituir otros tipos de tests. El objetivo es proteger **aquellos flujos que no te puedes permitir romper**, los que tienen impacto directo en negocio y donde un bug se paga caro.

En un e-commerce típico, esos flujos suelen ser bastante claros:

* creación de pedidos,
* pagos,
* fulfillment,
* KYC / antifraude.

Pocos tests, bien escogidos y bien entendidos. Como red de seguridad de alto nivel, no como malla fina. Cuando se usan así, el coste compensa de sobra el valor que aportan.

---

## El beneficio real (más allá de los tests)

Después de montar este primer test E2E, el cambio no fue únicamente técnico. Lo que cambió fue la relación con el sistema.

Cambió la forma de refactorizar, porque ya no se trabajaba a ciegas. Cambió la velocidad de ciertos cambios, porque el miedo dejó de ser el factor dominante. Cambió la confianza al tocar código sensible, porque había una señal clara que avisaría si algo importante se rompía. Y, de forma más sutil pero igual de relevante, cambió la conversación con negocio.

Antes, cualquier cambio en un flujo crítico se justificaba con un acto de fe:

> *“Creo que esto no rompe nada”*.

Después, la conversación pasó a otro nivel:

> *“Si rompe algo importante, el test nos lo va a decir”*.

Esa diferencia parece pequeña, pero en sistemas legacy críticos es enorme. No elimina el riesgo por completo, pero lo hace visible, gestionable y compartido. Y eso, muchas veces, es justo lo que permite empezar a mejorar un sistema que llevaba demasiado tiempo intocable.

---

## Mejorar un legacy sin jugar a la ruleta rusa

Este enfoque no es el más “limpio”, ni el más académico. No sigue al pie de la letra ningún libro ni persigue una arquitectura ideal desde el primer día.

Pero es **incremental, seguro** y, sobre todo, **realista**.

No intenta arreglar todo de golpe, ni promete convertir un sistema legacy en algo ejemplar en pocas semanas. Parte de la realidad tal y como es y trabaja desde ahí, reduciendo riesgo paso a paso.

Hace algo mucho más valioso:

👉 **te permite mejorar un sistema legacy sin jugar a la ruleta rusa en producción**.

Si estás en un proyecto donde sabes que necesitas tests pero no ves por dónde empezar, este tipo de test E2E de caracterización suele ser un punto de entrada muy razonable. No es el final del camino, ni pretende serlo.

Pero sí es, con diferencia, un muy buen principio.
