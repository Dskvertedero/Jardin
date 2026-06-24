import { getCollection } from "astro:content";
import { notasPublicadas } from "../../lib/draft";

export async function GET() {
  const todasLasNotas = await getCollection("garden");
  const notas = notasPublicadas(todasLasNotas);

  if (!notas.length) {
    return new Response(JSON.stringify({ error: "No hay notas" }), {
      status: 404,
    });
  }

  const aleatoria = notas[Math.floor(Math.random() * notas.length)];

  return new Response(
    JSON.stringify({ id: aleatoria.id }),
    {
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
}
