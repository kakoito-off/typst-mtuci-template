#let body-font = ("Times New Roman", "Liberation Serif", "New Computer Modern")
#let code-font = ("Courier New", "Liberation Mono", "DejaVu Sans Mono")

#let typography(body) = {
  set text(font: body-font, size: 14pt, lang: "ru")
  show raw: set text(font: code-font, size: 0.9em)
  body
}
