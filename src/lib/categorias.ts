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

export function getCarpeta(nota: any) {
  const dir = path.dirname(nota.id);
  if (dir === ".") return "General";
  return dir.split("/")[0];
}

export function agruparPorCarpeta(notas: any[]) {
  const grupos = new Map<string, any[]>();

  for (const nota of notas) {
    const carpeta = getCarpeta(nota);
    if (!grupos.has(carpeta)) grupos.set(carpeta, []);
    grupos.get(carpeta)!.push(nota);
  }

  return grupos;
}

export function slugifyCategoria(nombre: string) {
  return nombre
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}
