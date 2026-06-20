import path from "node:path";

export function getCategoria(nota: any) {
  if (nota.data.categoria) return nota.data.categoria;

  const dir = path.dirname(nota.id);
  if (dir === ".") return "General";

  return dir.split("/")[0];
}

export function agruparPorCategoria(notas: any[]) {
  const grupos = new Map<string, any[]>();

  for (const nota of notas) {
    const categoria = getCategoria(nota);
    if (!grupos.has(categoria)) grupos.set(categoria, []);
    grupos.get(categoria)!.push(nota);
  }

  return grupos;
}
