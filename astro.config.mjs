// @ts-check
import fg from "fast-glob";
import fs from "node:fs";
import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import remarkObsidianMd from "remark-obsidian-md";
import remarkMath from "remark-math";
import rehypeMathjax from "rehype-mathjax";

const macroFiles = fg.sync("./src/math/macros/*.tex").sort();
const macros = {};

for (const file of macroFiles) {
  const content = fs.readFileSync(file, "utf8");

  // Regex mejorada: Captura el nombre, opcionalmente los argumentos [num], y el bloque de la macro
  // Nota: Soporta hasta un nivel de llaves anidadas comunes en LaTeX
  const regex = /\\newcommand\{\\([^}]+)\}(?:\[([0-9]+)\])?\{((?:[^{}]|\{[^{}]*\})*)\}/g;
  const matches = [...content.matchAll(regex)];

  for (const match of matches) {
    const name = match[1];
    const argsCount = match[2] ? parseInt(match[2], 10) : 0;
    const body = match[3];

    if (argsCount > 0) {
      // Si tiene argumentos, MathJax necesita un array: [definición, número_de_args]
      macros[name] = [body, argsCount];
    } else {
      // Si no tiene, basta con el string de la definición
      macros[name] = body;
    }
  }
}

// El resto de tu export default defineConfig se queda exactamente igual...
