# DESIGN.md — Pedro Pardal / La Próxima Versión

Tokens y componentes extraídos de la mesa de trabajo de Figma
[Web Pedro Pardal](https://www.figma.com/design/PBnuxYUrtUwuM6LleuqKnE/Web-Pedro-Pardal?node-id=1-4)
(página `Web`, 5 pantallas a 1440 px: Home, Team coaching, Newsletter, Artículo, Blog).

El fichero de Figma **no define variables ni estilos** (`getLocalVariableCollections`,
`getLocalTextStyles`, `getLocalPaintStyles` vacíos). Los tokens de abajo se han inferido
de los valores reales de los nodos y se han nombrado aquí. Fuente de verdad en código:
`themes/ppardalj/assets/scss/foundation/_variables.scss`.

## 1. Color

| Token (SCSS) | Valor | Uso en Figma |
|---|---|---|
| `$ink` (`$dark-background-color`) | `#071217` | Fondo oscuro (nav, heros, secciones dark, cards, footer). Texto sobre fondo claro |
| `$white` | `#ffffff` | Fondo claro de secciones. Texto sobre fondo oscuro |
| `$neon-mint` (`$primary-color`) | `#04ffca` | Bordes (2 px) de nav, cards, inputs, filas, tags; acento de enlaces |
| `$neon-green` (`$secondary-color`) | `#78fd7e` | Inicio del degradado, texto de tags en cards, borde de tags en hero |
| `$neon-lime` | `#caf95d` | Final del degradado, bullet central del carrusel |
| `$slate` (`$mid-gray`) | `#4c707f` | Placeholder de inputs, texto de tags, metadatos secundarios |
| `$mist` (`$light-gray`) | `#81b0c4` | Enlaces legales del footer, fechas, texto del checkbox, borde del paginador |
| `$error` | `#ff5500` | Icono "cruz" (lista de problemas) |

Degradados:

| Token | Definición | Uso |
|---|---|---|
| `$gradient-cta` | `linear-gradient(90deg, #78fd7e 0%, #04ffca 50%, #caf95d 100%)` | Botón primario |
| `$gradient-number` | `linear-gradient(90deg, #caf95d 0%, #78fd7e 100%)` aplicado al texto | Números 1·2·3 de las cards de servicios |

Fondos de sección: alternan **dark** (`#071217` + estrellas) y **light** (`#ffffff`).
Nunca hay grises intermedios.

### Fondo "estrellas"
Campo de ~900 puntos blancos con opacidad individual 0.4–1, grupo al 50 % de opacidad,
sobre `#071217`. Asset: `static/assets/img/brand/stars.svg` (1440×1440). Se usa en heros
y bandas dark (`.dark`), centrado y a `cover`.

## 2. Tipografía

Familia única: **Sora** (variable 100–800, autohospedada en `static/assets/font/`).
Código: JetBrains Mono (sin cambios). Line-height **1.5** en todo salvo el paginador (27 px).

| Token | Tamaño / peso | Uso |
|---|---|---|
| `display-xl` | 80 / 700, ls 0.37 | Título del artículo |
| `display` | 52 / 700 | H1 de hero |
| `h2` | 34 / 700 | Título de sección |
| `numeral` | 80 / 700 + degradado | Número de card de servicio |
| `h3` | 28 / 700 | Subtítulo de artículo |
| `h3-light` | 24 / 400 | Numeración / subtítulos secundarios de artículo |
| `lead-lg` | 22 / 400 | Subtítulo de hero |
| `card-title-lg` | 22 / 700 | Título de card de servicio |
| `title-row` | 25.2 / 400 | Título de fila de newsletter |
| `lead` | 20 / 400 | Entradilla, ítems del nav |
| `label` | 20 / 700 | Label de formulario |
| `button` | 24 / 600 | Texto de botón primario (nav: 20 / 600) |
| `body` | 18 / 400 | Párrafos, inputs, texto de cards |
| `card-title` | 18 / 700 | Título de post-card |
| `small` | 16 / 400, ls 0.37 | Tags de lista, checkbox, fechas, paginador |
| `meta` | 14 / 400, ls 0.35 | Tags y autor de post-card |

## 3. Espaciado, layout, forma

| Token | Valor |
|---|---|
| Ancho de página | 1440 |
| Padding lateral | 150 → contenedor de contenido **1140** |
| Padding vertical de sección | 80 (heros: 120) |
| Escala de gaps | 8 · 10 · 14 · 16 · 24 · 32 · 40 · 48 · 64 · 80 |
| Borde estándar | 2 px sólido `$neon-mint` |
| Radio píldora (botones) | 40 |
| Radio círculo (paginador, bullets) | 50 % |
| Radio tags / cards / inputs | 0 (esquinas rectas) |

## 4. Componentes

| Componente | Definición |
|---|---|
| **Nav** | Alto 92, fondo `$ink`, borde inferior 2 px `$neon-mint`, padding 20.5/150. Logo SVG (295×40) a la izquierda; items (Sora 20 blanco + chevron) gap 32; CTA "Contacto" = botón primario compacto |
| **Botón primario** | Píldora r=40, padding 12/24, `$gradient-cta`, texto `$ink` Sora 600 24 + flecha `arrow-cta` (62×26), gap 16 |
| **Botón secundario** | Igual pero fondo `$ink` y texto/flecha blancos (sobre secciones claras) |
| **Hero** | Fondo `$ink` + estrellas; padding 120/150; H1 52 blanco; lead 22 blanco; CTA primario |
| **Section heading** | H2 34/700; en landing de servicios lleva icono a la izquierda (gap 24) |
| **Card (dark)** | Fondo `$ink`, borde 2 px `$neon-mint`, padding 40, gap 40. Variante servicio: numeral + título + texto. Variante "superpoder": solo texto |
| **Input** | Fondo blanco, borde 2 px `$neon-mint`, padding 8/16, texto 18, placeholder `$slate`; label 20/700 encima, gap 14 |
| **Checkbox** | 20×20 blanco, borde 2 px `$ink`; texto 16 `$mist` |
| **Tag (filtro)** | Borde 2 px `$neon-mint`, padding 8/16, texto 16 `$slate`, sin radio |
| **Tag (hero)** | Igual con borde `$neon-green` y texto blanco |
| **Tag (card)** | Borde 2 px blanco, padding 6/10, texto 14 `$neon-green` |
| **Post-card** | 364 de ancho; imagen 170 de alto con borde 2 px `$neon-mint`; cuerpo `$ink` borde 2 px, padding 24/32, gap 24: tags → título 18/700 blanco → autor 14 `$neon-mint` |
| **Fila de newsletter** | Padding 24/0, borde inferior 2 px `$neon-mint`; `v1.N` (Work Sans 24 `$slate`), título 25 `$ink`, fecha 16 `$mist`; flecha `arrow-down` rotada a la derecha |
| **Testimonio** | Card dark padding 80; cita 20 blanca; avatar 156 con borde 3 px `$neon-mint`; nombre 24, cargo 24; debajo flecha + 3 bullets (10 px: mint, lime, mint) + flecha |
| **Paginador** | Círculos de 32/40; activo `$ink` con texto blanco; flecha en círculo 40 borde 1 px `$mist` |
| **Footer** | Fondo `$ink`, padding 56/150; logo + enlaces legales (Sora 500 ~14 `$mist` (Figma usa Inter, no cargada: se unifica en Sora), separadores `|` `$neon-mint`); redes (37 px) a la derecha, gap 9 |
| **Artículo** | Cuerpo 18 `$ink`; h2 28/700; h3 24/400; hero con fecha + reloj (16) a la derecha |

## 5. Iconos y assets

Todos en `themes/ppardalj/static/assets/img/brand/` (descargados de Figma):

| Archivo | Nodo Figma | Uso |
|---|---|---|
| `logo-pedro-pardal.svg` | `5:192183` | Logo nav y footer |
| `stars.svg` | `5:192290` (limpiado) | Fondo de estrellas |
| `arrow-cta.svg` | `5:204574` | Flecha de botón (`#071217`) |
| `arrow-right.svg` | `5:241501` | Flechas del carrusel (blanco) |
| `arrow-down.svg` | `9:223646` | Flecha de fila de newsletter |
| `icon-chevron-down.svg` | `5:192282` | Chevron del nav |
| `icon-chevron-down-muted.svg` | `9:223967` | Paginador |
| `icon-clock.svg` | `10:348750` | Fecha de artículo |
| `icon-cross.svg` | `9:62029` | Lista de problemas |

Los iconos sociales del footer ya coincidían con los de Figma (`assets/img/social/`).
Fotos/logos de clientes del diseño son contenido: se mantienen los del repo.

## 6. Correspondencia pantalla → plantilla

| Pantalla Figma | Plantilla / bloques |
|---|---|
| Home (`5:192181`) | `content/_index.md` → `hero`, `newsletter-subscribe`, `three-steps`, `guide`, `clients`, `testimonials`, `contact-form` |
| Team coaching (`9:49646`) | `content/team-coaching/_index.md` (mismos bloques) |
| Newsletter (`9:211220`) | `newsletter.html` → `newsletter-subscribe`, `newsletter-prev-entries` |
| Artículo (`10:336379`) | `newsletterpost.html` / `post.html` (+ `newsletter/hero`, `blog/hero`) |
| Blog (`12:374451`) | `blog.html` → `blog/postlist`, `blog/postcard` |
