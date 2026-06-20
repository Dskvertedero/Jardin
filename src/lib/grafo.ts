import GithubSlugger from "github-slugger";

export function getGraphData(notas: any[]) {
  const slugger = new GithubSlugger();
  const idsValidos = new Set(notas.map((n) => n.id));

  const nodes = notas.map((nota) => ({
    id: nota.id,
    label: nota.data.title || nota.id,
  }));

  const links: { source: string; target: string }[] = [];
  const regex = /\[\[([^\]|]+)(?:\|[^\]]+)?\]\]/g;

  for (const nota of notas) {
    const body = nota.body || "";
    let match;
    regex.lastIndex = 0;

    while ((match = regex.exec(body)) !== null) {
      slugger.reset();
      const targetId = slugger.slug(match[1].trim());

      if (idsValidos.has(targetId) && targetId !== nota.id) {
        links.push({ source: nota.id, target: targetId });
      }
    }
  }

  return { nodes, links };
}
