---
title: 'Por que los mocks hacen tus tests mas fragiles (y que usar en su lugar)'
description: 'Hay una alternativa mas robusta y expresiva: los fakes.'
date: 2025-06-11T00:00:00.000Z
layout: newsletterpost
author: pedropardal
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 9
---
Has escrito tus tests. Todo verde. Refactorizas una clase… y *boom*, 17 tests rotos.

Pero no porque el sistema haya dejado de funcionar. Sino porque el **mock esperaba un orden de llamadas exacto**, y ahora haces `Validate()` antes que `DoThing()`.

O porque cambiaste el nombre de un método privado. Que ni siquiera forma parte del contrato público. Pero el test lo usaba como si fuera sagrado.

Lo arreglas. Vuelve el verde. Respiras.

Y entonces lo ves: **el test no valida ningún resultado real**. Solo que se llamaron ciertas funciones con ciertos parámetros.

En producción, el sistema se comporta distinto. Y no te enteras hasta que ya es tarde.

Porque ese mock —que parecía tan útil— **nunca estuvo obligado a comportarse como el sistema real**.

Y ese es el problema de fondo: **estás probando contra algo que no tiene por qué cumplir el contrato**.

Para entender por qué ocurre —y cómo dejar de pisarte la manguera—, hay que volver a un concepto básico del testing: los **dobles de test**.

---

## Qué son los dobles de test (y por qué importan)

Cuando escribes un test y no quieres que participe una clase real (una base de datos, una API externa, un gateway de pagos…), usas un *doble de test*.

Un doble de test es, simplemente, **una pieza que sustituye a otra en un test**.

Dentro de esa categoría hay varios tipos (stubs, spies, dummies…). Esta clasificación viene del trabajo de Martin Fowler en su artículo [*Mocks Aren’t Stubs*](https://martinfowler.com/articles/mocksArentStubs.html), donde explica las diferencias entre dobles basados en comportamiento (mocks) y los que simplemente simulan datos (fakes, stubs, etc.).

Sin embargo, para lo que nos interesa aquí, podemos simplificar el mapa en dos grandes grupos: **mocks** y **fakes**.

### Un caso a testear: registro de usuario

Supón que tienes una clase `UserRegistrationService` que registra un usuario si no existe ya en el sistema:

```csharp
public class UserRegistrationService
{
    private readonly IUserRepository _repository;

    public UserRegistrationService(IUserRepository repository)
    {
        _repository = repository;
    }

    public bool Register(string email)
    {
        var existing = _repository.FindByEmail(email);
        if (existing != null)
            return false;

        _repository.Save(new User(email));
        return true;
    }

```

La interfaz `IUserRepository` es simple:

```csharp
public interface IUserRepository
{
    void Save(User user);
    User? FindByEmail(string email);
}
```

Vamos a ver cómo se puede testear esto con mocks... y con fakes.

### Los mocks

Un *mock* es un objeto que **configuras desde el test** para que devuelva ciertos valores y registre las llamadas que se le hacen.

Lo usas así:

- Le dices qué debe devolver si se llama al método X con el parámetro Y.
- Luego, después de ejecutar el código, verificas que ese método se haya llamado como tú esperabas.

Es como un actor que **sigue el guion que tú le marcas,** y luego te pasa el informe de todo lo que ha hecho.

```csharp
var repoMock = new Mock<IUserRepository>();

repoMock.Setup(r => r.FindByEmail("pedro@exeal.com")).Returns((User?)null);

var service = new UserRegistrationService(repoMock.Object);
var result = service.Register("pedro@exeal.com");

Assert.True(result);
repoMock.Verify(r => r.Save(It.Is<User>(u => u.Email == "pedro@exeal.com")));
```

Este test no valida ningún resultado observable. Solo que se llamaron ciertos métodos con ciertos parámetros.

El mock es como un actor que improvisa (pero mal) con tu guion: puede decir cualquier cosa… incluso si contradice la historia.

### Los fakes

Un *fake*, en cambio, es **una implementación funcional del contrato**, que se comporta de forma coherente, aunque simplificada.

Por ejemplo: un `FakeUserRepository` que guarda usuarios en una lista en memoria. No hay `.Setup()`, no hay `.Verify()`. Solo comportamiento.

```csharp
public class FakeUserRepository : IUserRepository
{
    private readonly List<User> _users = new();

    public void Save(User user) => _users.Add(user);

    public User? FindByEmail(string email) =>
        _users.FirstOrDefault(u => u.Email == email);
}
```

```csharp
var repo = new FakeUserRepository();
var service = new UserRegistrationService(repo);

var result = service.Register("pedro@exeal.com");

Assert.True(result);
Assert.NotNull(repo.FindByEmail("pedro@exeal.com"));
```

Aquí el test valida un efecto real: que el usuario se ha guardado correctamente.

No le importa cómo se logró internamente. Le importa lo que el sistema hizo.

Entender esta diferencia lo cambia todo. Porque, aunque los dos sirven para sustituir dependencias en los tests, **solo uno de ellos se comporta como un sistema real**. Y no es el mock.

---

## **Por qué los mocks generan dolor**

A primera vista, usar mocks parece cómodo: sustituyen dependencias externas, te permiten configurar comportamientos… y puedes verificar que se llama a lo que toca.

Pero esa comodidad tiene trampa.

En cuanto haces un refactor mínimamente serio, los tests empiezan a romperse. No porque el sistema falle, sino porque **el test estaba acoplado a la implementación interna**.

### 1. Fragilidad ante refactors

¿Extraes un método privado? ¿Cambias el orden de ejecución? ¿Renombras un parámetro?

Aunque el comportamiento externo no cambie, los tests con mocks pueden fallar.

```csharp
repoMock.Verify(r => r.Save(...));
```

Este tipo de verificación exige que el sistema funcione de una forma exacta. Si el *cómo* cambia, el test falla… aunque el *qué* siga estando bien.

### 2. Testean configuraciones, no comportamientos

Un mock es tan listo como tú lo hagas. Tú decides qué devuelve. Pero lo haces de forma aislada, sin que dependa del flujo de ejecución.

```csharp
repoMock.Setup(r => r.FindByEmail("pedro@exeal.com")).Returns((User?)null);
```

Aquí el test declara que el usuario no existe, pero sin ninguna causa previa. **No estás describiendo el estado real del sistema, sino inyectando una simulación arbitraria.**

Eso crea una falsa sensación de seguridad. El test pasa, pero no valida el comportamiento del sistema real.

Has sido “mockeado” :P

### 3. Ruido y verbosidad

Mocks requieren configurar `.Setup()`, `.Returns()`, `.Verify()`...

Y si hay varios en un mismo test, el código se llena de detalles irrelevantes.

Cuesta leer qué se está probando. Cuesta ver la intención. El test ya no cuenta una historia: es una receta mecánica de configuraciones.

### 4. Alta duplicación y mantenimiento costoso

Cada test repite las mismas configuraciones. Cambias una firma o una lógica interna… y tienes que tocar decenas de líneas en decenas de tests.

Ese esfuerzo se multiplica con el tiempo y acaba erosionando la confianza en el valor de los tests.

### 5. Rompen el contrato semántico de las dependencias

El mayor riesgo: puedes configurar un mock para devolver respuestas que **no tienen sentido en ningún flujo real**.

```csharp
repoMock.Setup(r => r.FindByEmail("pedro@exeal.com"))
        .Returns(new User("pedro@exeal.com"));
```

Aquí el test simula que el usuario existe… sin que nunca se haya guardado.

Ese desacoplamiento entre *lo que el sistema haría* y *lo que el mock devuelve* **rompe el contrato implícito entre las partes**.

Ya no estás probando el sistema. Estás probando una historia inventada.

Gerard Meszaros lo resume bien en [*xUnit Test Patterns*](https://www.amazon.es/xUnit-Test-Patterns-Refactoring-Signature/dp/0131495054): cuando un doble no se comporta como su colaborador real, el test pierde valor como verificación del sistema. Especialmente si la verificación se basa en interacciones, no en resultados.

Hasta aquí, hemos visto cómo los mocks pueden darte una falsa sensación de seguridad.

Pero… ¿cuál es la alternativa?

Visto lo que no funciona, vamos a ver qué sí lo hace.

## **Qué ventajas tienen los fakes**

Frente a los problemas de los mocks, los fakes ofrecen una alternativa más robusta y sostenible. Son simples de escribir, fáciles de entender y se comportan como versiones mínimas del sistema real.

Vamos con las ventajas concretas:

### 1. Se escriben una vez y se reutilizan

Un fake es código real. Lo implementas una vez —normalmente en memoria— y puedes usarlo en todos los tests que lo necesiten.

Mientras que con mocks estás escribiendo `.Setup` y `.Returns` en cada test, con fakes lo único que cambias es el escenario.

### 2. Modelan el comportamiento real del sistema

El `FakeUserRepository` que vimos antes guarda usuarios en una lista y permite buscarlos.

No hay nada que configurar. Solo haces `Save()` y luego `FindByEmail()`.

Eso ya es suficiente para detectar errores de lógica, flujos incoherentes o datos mal gestionados. Porque el fake **tiene reglas internas reales**, no una simulación arbitraria.

### 3. Permiten tests orientados a resultados, no a llamadas

Con mocks, los tests suelen verificar *si se llamó a algo*.

Con fakes, verificas *qué pasó realmente*.

```csharp
// Con fake
service.Register("pedro@exeal.com");

var user = repo.FindByEmail("pedro@exeal.com");
Assert.NotNull(user);
```

Este test no necesita saber cómo se implementa `Register()`. Solo le importa el resultado observable.

### 4. Pueden actuar como contratos ejecutables

Si testéas bien tus fakes (con casos límite, reglas del dominio, validaciones...), acaban convirtiéndose en **especificaciones vivas** del comportamiento esperado de la dependencia.

Son una forma de protegerte contra cambios arbitrarios, igual que lo harías con tests de producción.

### 5. No necesitas librerías externas

Nada de frameworks. Nada de DSLs raros. Solo código.

Y eso hace que tus tests sean más portables, más claros y menos frágiles.

---

## **Cuándo tiene sentido usar fakes (y cuándo no)**

No todo se puede —ni se debe— fakear. Hay casos donde un mock es la opción más razonable, **no porque sea ideal, sino porque es suficiente**.

### Casos ideales para usar fakes

- **Repositorios**: tienen comportamiento, almacenan estado y devuelven datos. Perfectos para fakear.
- **Adaptadores a servicios externos** (APIs de terceros, gateways de pagos, etc.): puedes simular su lógica en memoria sin depender del mundo real.
- **Colaboradores con reglas de negocio**: si tiene condiciones, invariantes o efectos visibles, un fake bien diseñado ayuda a testear mejor.

### Casos límite donde un mock es suficiente (y sensato)

- **Loggers, métricas, sistemas de auditoría**: no devuelven nada, solo notifican. Mockearlos para verificar que se llamó a `LogError()` puede ser suficiente.
- **Notificaciones, emails, webhooks**: si lo único que necesitas es comprobar que se disparó una acción, no tiene sentido montar un fake complejo.
- **Sistemas tan simples que fakearlos sería más trabajo que valor**: si la colaboración no aporta lógica, construir un fake es sobreingeniería.

### Regla de oro:

> *Mocks para interacciones sin efecto.*
> 
> 
> ***Fakes para colaboraciones con comportamiento.***
> 

Dicho de otro modo: si solo necesitas saber *si se llamó a algo*, el mock vale.

Pero si quieres saber *qué hace ese algo*, entonces el fake es tu aliado.

## **Buenas prácticas si decides usar fakes**

Pasarte a los fakes no es solo cambiar cómo sustituyes una dependencia.

Es adoptar un enfoque de testing más realista, más expresivo y más conectado con el dominio.

Pero para que eso funcione, hay que hacerlos bien. Aquí van algunas pautas clave:

### 1. Testéalos como si fueran código de producción

Un fake no es un segundo plato. Si encapsula reglas del dominio, **debe estar bien cubierto por tests**.

- ¿Qué pasa si llamas a `FindByEmail()` sin haber guardado nada?
- ¿Permite duplicados? ¿Lanza excepción? ¿Devuelve siempre el último?

Asegúrate de capturar casos límite, validar invariantes y cumplir pre/postcondiciones.

Cuanto más robusto es el fake, más confianza te da toda la suite.

### 2. Usa la gestión de errores funcional para capturar mejor el comportamiento

Una de las ventajas de usar fakes es que **te obliga a pensar en serio cómo debería comportarse una colaboración**.

Y eso incluye cómo representar errores o condiciones excepcionales.

Por ejemplo:

```csharp
User? FindByEmail(string email);
```

Esta firma parece suficiente… hasta que tienes que implementar el fake.

¿Devuelves `null` si no lo encuentra? ¿Y si el email está mal formado? ¿Y si el sistema no está disponible?

Ahí es donde te das cuenta de que la firma **no te obliga a modelar explícitamente los posibles resultados**.

Y eso puede llevar a ambigüedades, bugs y tests frágiles.

Si usas un tipo como `Result<User, NotFound>` o `Either<Error, User>`, esa ambigüedad desaparece:

```csharp
Result<User, NotFound> FindByEmail(string email);
```

Ahora el contrato es claro: o devuelves un usuario, o un error bien tipado.

Y tanto el fake como el código de producción se benefician de esa precisión.

¿Podrías hacer esto con mocks? Claro.

Pero los mocks no te obligan a enfrentarte al diseño.

Los fakes, sí. Y eso es parte de su valor.

### 3. Mantenlos cerca del dominio

Un buen fake **cuenta una historia coherente**.

Si estás modelando un `FakePaymentGateway`, ¿qué ocurre si el usuario no tiene saldo?

¿Permite repetir pagos con el mismo ID? ¿Puedes consultar el estado de un cobro?

Cuanto más alineado esté con las reglas reales, más útil será para detectar errores *antes* de llegar a producción.

### En resumen:

> *Si tratas a tus fakes como código de juguete, obtendrás tests de juguete.
Si los tratas como parte del sistema, se convierten en contratos ejecutables.*
> 

---

### **Cómo migrar de mocks a fakes (paso a paso)**

No hace falta reescribir toda tu suite de tests de golpe.

Puedes empezar poco a poco, y **cada paso mejora tu diseño y tus tests**.

Aquí va una guía para migrar de mocks a fakes de forma progresiva y sostenible:

### Paso 1. Identifica los colaboradores que más mockeas

Abre tus tests y mira qué dependencias estás simulando constantemente.

Suelen ser cosas como:

- Repositorios
- Gateways a servicios externos
- Adaptadores de infraestructura

**Si ves `.Setup(...)` y `.Returns(...)` repetido en todos lados, tienes un candidato.**

### Paso 2. Escribe un primer `FakeX` sencillo

Crea una implementación in-memory que haga lo mínimo para comportarse como la clase real.

Por ejemplo, si tienes un `IUserRepository`, escribe un `FakeUserRepository` que guarde usuarios en una lista y te deje buscarlos.

No hace falta cubrir todos los casos al principio. **Empieza por los tests más simples.**

### Paso 3. Testea ese fake como si fuera código de producción

El fake **no es código de test**, es **infraestructura de confianza**.

Escribe tests para validar:

- Qué pasa si buscas un usuario que no existe
- Qué ocurre si guardas dos con el mismo email
- Qué invariantes debe cumplir ese colaborador

**Cuanto más lo testees, más robusta será tu suite.**

### Paso 4. Sustituye mocks por el fake

Ve test a test. Sustituye el mock por tu fake, elimina `.Setup()` y `.Verify()`, y valida el resultado del sistema directamente.

Lo más probable es que los tests sean más cortos, más claros y más expresivos.

### Paso 5. Usa los fallos como oportunidad

Puede que algún test empiece a fallar.

Bien.

Eso te está diciendo que había una **asimetría entre lo que el mock prometía y lo que el sistema real hace**.

Aprovecha para replantear:

- ¿Está bien diseñada esta interfaz?
- ¿El sistema se comporta como esperas?
- ¿Dónde debería estar esta lógica?

Migrar a fakes es también una forma de **refinar tus colaboraciones y tus contratos**.

---

## Conclusión: menos mocks, mejores tests

Muchos tests pasan.

Pocos tests protegen de verdad.

Cuando abusamos de los mocks, no estamos validando comportamiento real. Solo estamos comprobando que el sistema hace las llamadas que esperábamos… aunque el resultado final sea incorrecto.

Los fakes, bien usados, nos devuelven a lo importante: el comportamiento observable, el diseño orientado a propósito, la confianza real en que nuestro sistema hace lo que dice hacer.

Pero eso es solo una pieza del puzzle.

### ¿Y si el problema no fuera solo el tipo de doble que usas?

- ¿Cómo sabes que tus tests cubren lo que importa?
- ¿Qué tipo de test es el adecuado en cada capa?
- ¿Cómo construir una red de tests que aguante el paso del tiempo?

Aquí hemos hablado de mocks y fakes.

En la formación **“A prueba de fallos”**, vamos un paso más allá: te enseño a diseñar toda tu estrategia de testing para que sea una red de seguridad real — sin agujeros, sin ruido y sin sobrecoste.

👉 [**Descubre cómo blindar tu sistema con una estrategia de tests que aguanta lo que le eches.**](http://www.exeal.com/cursos/a-prueba-de-fallos)

Si alguna vez has tenido bugs en producción con todos los tests en verde, esta formación te ayudará a que no vuelva a pasar.

Un abrazo,

Pedro
