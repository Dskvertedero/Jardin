import fs from "node:fs";
import path from "node:path";

const macroDir = "./src/math/macros";

const preamble = fs
  .readdirSync(macroDir)
  .filter(file => file.endsWith(".tex"))
  .sort()
  .map(file =>
    fs.readFileSync(path.join(macroDir, file), "utf8")
  )
  .join("\n\n");

export default function remarkMathPreamble() {
  return function (tree) {
    tree.children.unshift({
      type: "paragraph",
      children: [
        {
          type: "inlineMath",
          value: preamble,
        },
      ],
    });
  };
}
