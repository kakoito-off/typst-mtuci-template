#let paragraph-indent = 12.5mm

#let line-leading(factor) = {
  assert(factor in (1, 1.5), message: "line-spacing должен быть равен 1 или 1.5")
  // The single baseline distance is taken from the 14 pt LaTeX example.
  // Times New Roman contributes about 9.71 pt above each baseline in Typst.
  16.53pt * factor - 9.71pt
}

#let paragraphs(leading, body) = {
  set par(
    justify: true,
    first-line-indent: (amount: paragraph-indent, all: true),
    leading: leading,
    spacing: leading,
  )
  body
}
