---
title: 'Cómo un error de programación tonto costó 125 millones de dólares'
description: 'En 1998, la NASA lanzó la sonda Mars Climate Orbiter. 9 meses después del lanzamiento, la sonda se quemó en la atmósfera marciana. ¿Qué había detrás de este error?'
date: 2024-11-04T00:00:00.000Z
layout: newsletterpost
author: pedropardal
tags: [newsletter]
images: [/images/blog/posts/programador.jpg]
featured_image: /images/blog/posts/programador.jpg
type: newsletter
issue_number: 3
---

¿Crees que lo de envolver los tipos primitivos en clases es sobreingeniería?

Te voy a contar una historia.

En 1998, la NASA lanzó una sonda espacial, la Mars Climate Orbiter.

Su misión: explorar el clima del planeta marciano.

9 meses después del lanzamiento, la sonda se quemó en la atmósfera marciana.

El motivo es que, en lugar de pasar a 150k de la superficie, que era lo esperado, pasó a sólo 60km.

Un “pequeño” error de cálculo.

¿Te puedes imaginar qué es lo que había detrás de este error?

Es tan tonto que no te lo vas a creer.

O igual te resulta más familiar de lo que parece.

Resulta que el software de navegación que tenía que calcular la trayectoria, tenía [un error de conversión de unidades](http://news.bbc.co.uk/2/hi/science/nature/514763.stm) en el sistema inglés al sistema métrico.

La típica, una variable declarada tal que así:

```markdown
double distance;
```

¿Pero qué es `distance`?

¿Metros? ¿Pies? ¿Zapatos?

Pues lo que pasó es que, en algún sitio del código se usaba esa variable creyendo que eran metros, y en otro sitio creyendo que eran pies.

¿Resultado? Una misión de 125 millones de dólares (de la época, hoy serían más) a la basura.

Esto se podría haber evitado teniendo un tipo `Distance`, que envolviese las operaciones con distancias, y que proporcionase formas ordenadas de acceder al valor, p.ej.

```markdown
class Distance {
  Distance add(Distance other);
  // otras operaciones relevantes
  double asMeters();
  double asFeet();
}
```

Si todas las variables involucradas en el cálculo de distancia están declaradas del tipo Distance, y siempre que se opera se hace usando estos tipos, no hay lugar a confusión.

La representación interna será la que sea, pero será una sóla.

Las operaciones se harán como sean, pero se harán en un único sitio del código y teniendo en cuenta la representación interna.

Y si quiero convertir el valor a otra unidad, por el motivo que sea, lo puedo hacer de forma ordenada con los accesores `asMeters` y `asFeet`.

Es sencillo, pero potente. 

Envolver los tipos primitivos de esta manera en una clase que encapsule sus operaciones es una de las técnicas que explico en mi curso de **10 pasos para mejorar tu código hoy**.

No seas como los programadores del Mars Climate Orbiter, no arriesgues tu proyecto por bugs tan tontos como este.

- [Quiero aprender a evitar este bug](https://academia.exeal.com/courses/object-calisthenics?utm_source=newsletter&utm_medium=web&utm_campaign=mars_climate_orbiter)

Un abrazo,
Pedro
