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

  const matches = [
    ...content.matchAll(
      /\\newcommand\{\\([^}]+)\}(?:\[[0-9]+\])?\{([^}]*)\}/g
    ),
  ];

  for (const match of matches) {
    macros[match[1]] = match[2];
  }
}

// https://astro.build/config
export default defineConfig({
  integrations: [mdx()],

  markdown: {
    remarkPlugins: [
      [remarkObsidianMd, { root: "./src/content/garden" }],
      remarkMath,
    ],

    rehypePlugins: [
      [
        rehypeMathjax,
        {
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
                "unicode",
              ],
            },

            macros,
          },
        },
      ],
    ],
  },
});
