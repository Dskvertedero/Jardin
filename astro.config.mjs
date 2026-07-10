// @ts-check
import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import remarkObsidianMd from 'remark-obsidian-md';
import remarkMath from 'remark-math';
import rehypeMathjax from 'rehype-mathjax';

// https://astro.build/config
export default defineConfig({
  integrations: [mdx()],
  markdown: {
    remarkPlugins: [
      [remarkObsidianMd, { root: './src/content/garden' }], remarkMath,
    ],

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
      },

      macros: {
        "\\R": "\\mathbb{R}",
        "\\C": "\\mathbb{C}",
        "\\N": "\\mathbb{N}",
        "\\Z": "\\mathbb{Z}",
        "\\Q": "\\mathbb{Q}",

        "\\eps": "\\varepsilon",
        "\\vphi": "\\varphi",

        "\\grad": "\\nabla",
        "\\diver": "\\nabla\\cdot",
        "\\curl": "\\nabla\\times"
      }
    }
  }],
],
  },
});
