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
      rehypeMathjax,
    ],
  },
});
