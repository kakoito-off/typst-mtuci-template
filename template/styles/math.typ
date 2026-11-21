#let equations(body) = {
  set math.equation(numbering: "(1)", supplement: none)
  show math.equation.where(block: true): set block(above: 5pt, below: 5pt)
  body
}
