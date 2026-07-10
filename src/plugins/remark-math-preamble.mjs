import fs from "node:fs";

const preamble = fs.readFileSync(
  "./src/math/preamble.tex",
  "utf8"
);

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
