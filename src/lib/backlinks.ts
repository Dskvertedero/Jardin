import GithubSlugger from "github-slugger";
import { notasPublicadas } from "./draft";

export function getBacklinksMap(notasOriginal: any[]) {
  const notas = notasPublicadas(notasOriginal);
  const map = new Map<string, Set<string>>();
  const slugger = new GithubSlugger();

  for (const nota of notas) {
    const body = nota.body || "";
    const regex = /\[\[([^\]|]+)(?:\|[^\]]+)?\]\]/g;
    let match;

    while ((match = regex.exec(body)) !== null) {
      slugger.reset();
      const targetId = slugger.slug(match[1].trim());

      if (!map.has(targetId)) {
        map.set(targetId, new Set());
      }
      if (targetId !== nota.id) {
        map.get(targetId)!.add(nota.id);
      }
    }
  }

  return map;
}
