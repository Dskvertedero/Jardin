function stripMarkdown(body: string) {
  if (!body) return "";

  return body
    .replace(/^---[\s\S]*?---/, "")
    .replace(/\[\[([^\]|]+)(?:\|([^\]]+))?\]\]/g, (_, target, alias) => alias || target)
    .replace(/[#*_>`~]/g, "")
    .replace(/\[([^\]]+)\]\([^)]+\)/g, "$1")
    .replace(/\n+/g, " ")
    .trim();
}

export function getExcerpt(body: string, maxLength = 120) {
  const texto = stripMarkdown(body);
  if (texto.length <= maxLength) return texto;
  return texto.slice(0, maxLength).trim() + "...";
}

export function getContenidoCompleto(body: string) {
  return stripMarkdown(body).toLowerCase();
}
