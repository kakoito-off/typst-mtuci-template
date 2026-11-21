#import "heading.typ": centered-section

#let contents() = {
  centered-section(outlined: false, bookmarked: true)[Содержание]
  set par(first-line-indent: 0pt, leading: 5pt, spacing: 2.5pt)
  set outline.entry(fill: repeat(box(width: 3.5mm, align(center)[.])))
  outline(title: none, depth: 1, indent: 0pt)
}
