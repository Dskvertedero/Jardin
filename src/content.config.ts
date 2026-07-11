import { glob } from "astro/loaders";
import { defineCollection, z } from "astro:content";

const garden = defineCollection({
  loader: glob({
    pattern: "**/*.md",
    base: "./src/content/garden",
  }),
  schema: z.object({
    title: z.string().optional(),
    categoria: z.string().optional(),
    draft: z.union([z.boolean(), z.string()]).optional(),
    descripcion: z.string().optional(),
    portada: z.string().optional(),
  }),
});

export const collections = { garden };
