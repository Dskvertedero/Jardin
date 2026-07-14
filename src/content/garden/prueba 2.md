---
draft: true
---
[[index]]
hola verificao que esta cochimaada sirva

[[prueba -1]]

[[Welcome]]
# Integración de MathJax en el Jardín Digital

## Objetivo

El objetivo fue integrar un sistema de escritura matemática dentro del jardín digital desarrollado con Astro, permitiendo escribir expresiones matemáticas directamente desde Obsidian utilizando una sintaxis muy cercana a LaTeX.

La idea era poder redactar apuntes universitarios, demostraciones, ejercicios y artículos técnicos sin necesidad de compilar un documento LaTeX completo.

---

# Arquitectura

El flujo de procesamiento matemático es el siguiente:

```text
Obsidian (.md)
        │
        ▼
remark-math
        │
        ▼
rehype-mathjax
        │
        ▼
MathJax
        │
        ▼
HTML
        │
        ▼
CSS personalizado
```

---

# Dependencias utilizadas

Se instalaron únicamente dos librerías:

```json
"remark-math"
"rehype-mathjax"
```

Estas permiten que Astro detecte expresiones matemáticas en Markdown y las convierta automáticamente en ecuaciones renderizadas por MathJax.

---

# Configuración de Astro

Se añadió `remark-math` dentro de los plugins de Markdown.

```js
remarkPlugins: [
  [remarkObsidianMd, {
    root: "./src/content/garden"
  }],
  remarkMath
]
```

Posteriormente se configuró `rehype-mathjax`.

```js
rehypePlugins: [
  [rehypeMathjax, {
    tex: {
      packages: {
        "[+]": [
          "ams",
          "newcommand",
          "configmacros",
          "color",
          "bbox",
          "cancel",
          "braket",
          "enclose",
          "textmacros",
          "unicode"
        ]
      }
    }
  }]
]
```

---

# Paquetes habilitados

Actualmente el proyecto utiliza los siguientes paquetes de MathJax:

| Paquete | Función |
|----------|----------|
| ams | Comandos matemáticos avanzados |
| newcommand | Definición de macros |
| configmacros | Configuración de macros |
| color | Colorear expresiones |
| bbox | Cajas alrededor de ecuaciones |
| cancel | Tachado de términos |
| braket | Notación de Dirac |
| enclose | Encerrar expresiones |
| textmacros | Texto dentro de matemáticas |
| unicode | Caracteres Unicode |

---

# Estilos CSS personalizados

Para integrar visualmente las ecuaciones con el resto del sitio se añadieron estilos específicos.

Las principales características son:

- ecuaciones centradas;
- fondo diferenciado para ecuaciones en bloque;
- borde lateral;
- compatibilidad con modo claro y oscuro;
- desplazamiento horizontal automático para ecuaciones largas;
- integración con la paleta de colores del sitio.

Ejemplo:

```css
.prose mjx-container[display="true"]{
    padding:1rem;
    border-left:4px solid var(--color-accent);
    border-radius:10px;
    background:var(--color-bg-card);
}
```

---

# Sintaxis soportada

## Matemática en línea

```markdown
$E=mc^2$
```

Resultado:

\(E=mc^2\)

---

## Matemática en bloque

```
$$
\int_0^1 x^2\,dx
$$
```

---

# Organización de las macros

Para mantener el proyecto organizado se decidió separar las macros en distintos archivos.

La estructura quedó de la siguiente forma:

```
src/
└── math/
    ├── macros/
    │   ├── 00-sets.tex
    │   ├── 10-analysis.tex
    │   ├── 20-linear-algebra.tex
    │   ├── 30-probability.tex
    │   ├── 40-physics.tex
    │   ├── 50-symbols.tex
    │   ├── 60-formatting.tex
    │   └── 99-personal.tex
    │
    └── preamble.txt
```

Cada archivo agrupa un conjunto específico de macros, facilitando su mantenimiento y ampliación.

---

# Intento de automatización

Inicialmente se desarrolló un plugin de Remark encargado de leer automáticamente todos los archivos `.tex` e insertarlos al inicio de cada nota.

La idea era no tener que copiar manualmente el preámbulo.

El plugin generaba correctamente un único bloque con todas las macros.

Sin embargo, durante las pruebas apareció un problema importante.

MathJax procesa cada bloque matemático de manera independiente, por lo que las macros definidas mediante `\newcommand` únicamente existen dentro del bloque donde fueron declaradas.

Como consecuencia aparecían errores como:

```
Undefined control sequence \R

Undefined control sequence \dv

Undefined control sequence \Prob
```

Aunque el plugin funcionaba correctamente, el comportamiento interno de MathJax impedía que esa solución fuera suficiente.

---

# Segundo intento

Posteriormente se intentó leer automáticamente todas las macros desde los archivos `.tex` para convertirlas al formato esperado por MathJax.

Por ejemplo:

```latex
\newcommand{\R}{\mathbb{R}}
```

se transformaba automáticamente en

```js
macros:{
    R:"\\mathbb{R}"
}
```

y se pasaba a:

```js
rehypeMathjax({
    tex:{
        macros
    }
})
```

La extracción automática funcionó correctamente.

No obstante, la implementación utilizada por `rehype-mathjax` no terminó interpretando correctamente esa configuración, por lo que las macros seguían apareciendo como comandos indefinidos.

---

# Solución adoptada

Finalmente se optó por una solución mucho más sencilla y robusta.

Todas las macros se combinan en un único archivo:

```
src/math/preamble.txt
```

Ese archivo contiene absolutamente todas las definiciones mediante `\newcommand`.

Al comenzar una nueva nota matemática basta con copiar el contenido del preámbulo al inicio del documento.

De esta forma, MathJax procesa primero las definiciones y posteriormente todo el contenido de la nota, asegurando que las macros estén disponibles durante el resto del documento.

Aunque requiere copiar el preámbulo al crear una nota nueva, esta solución es completamente estable y evita depender de comportamientos internos de MathJax.

---

# Macros disponibles

Actualmente el preámbulo contiene macros agrupadas por categorías.

## Conjuntos

```
\R
\C
\N
\Z
\Q
\F
\K
```

---

## Derivadas

```
\dv
\ddv
\pdv
\ppdv
```

---

## Delimitadores

```
\abs
\norm
\paren
\bracket
\set
```

---

## Álgebra lineal

```
\ip
\Span
\Rank
\Null
\Trace
\diag
```

---

## Probabilidad

```
\E
\Prob
\Var
\Cov
```

---

## Física

```
\grad
\diver
\curl
\lap
\dd
\ee
\ii
```

---

## Símbolos

```
\eps
\vphi
\vtheta
\lam
```

---

## Escritura matemática

```
\st
\suchthat
```

---

# Compatibilidad

Actualmente pueden utilizarse sin problemas la mayoría de comandos básicos de LaTeX proporcionados por MathJax, junto con los paquetes habilitados durante la configuración.

Entre ellos:

- fracciones;
- matrices;
- alineación;
- ecuaciones numeradas;
- símbolos AMS;
- colores;
- cancelación de términos;
- cajas;
- notación de Dirac;
- texto dentro de expresiones;
- caracteres Unicode.

---

# Funcionalidades descartadas

Se evaluó utilizar el paquete `physics`, ampliamente empleado en documentos científicos.

Sin embargo, la versión de `rehype-mathjax` utilizada por el proyecto no incluye dicho paquete.

Por ello comandos como:

```
\require{physics}

\qty

\vb

\dv

\pdv
```

no pueden utilizarse directamente.

En su lugar se implementaron manualmente las macros necesarias mediante `\newcommand`.

---

# Resultado final

El sistema matemático del jardín digital permite:

- escribir expresiones matemáticas directamente desde Obsidian;
- utilizar una sintaxis muy cercana a LaTeX;
- renderizar automáticamente las ecuaciones mediante MathJax;
- mantener una colección organizada de macros reutilizables;
- disponer de estilos visuales integrados con el resto del sitio;
- visualizar correctamente las ecuaciones tanto en escritorio como en dispositivos móviles.

La solución final prioriza la simplicidad, la estabilidad y la facilidad de mantenimiento, permitiendo redactar documentación técnica y apuntes matemáticos de forma cómoda sin depender de una instalación completa de LaTeX.