#let headings(body) = {
  set heading(numbering: "1.1")
  show heading: set text(size: 14pt, weight: "bold", hyphenate: false)
  show heading: set par(justify: false, first-line-indent: 0pt)
  show heading: set block(above: 12pt, below: 10pt, sticky: true)

  show heading.where(level: 1): it => {
    if it.numbering == none { it } else { pad(left: 12.5mm, it) }
  }
  show heading.where(level: 1, numbering: none): set align(center)

  show heading.where(level: 2): set heading(
    numbering: none, outlined: false, bookmarked: false,
  )
  show heading.where(level: 2): set align(center)
  body
}

#let centered-section(body, outlined: true, bookmarked: auto) = {
  heading(level: 1, numbering: none, outlined: outlined, bookmarked: bookmarked, body)
}
