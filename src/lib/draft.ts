export function notasPublicadas(notas: any[]) {
  return notas.filter((nota) => !nota.data.draft);
}
