import { getCollection } from "astro:content";
import { notasPublicadas } from "../lib/draft";

export async function GET() {
  const todasLasNotas = await getCollection("garden");
  const notas = notasPublicadas(todasLasNotas);
  const ids = notas.map((n) => n.id);
  return new Response(JSON.stringify(ids), {
    headers: { "Content-Type": "application/json" },
  });
}
