#let left-caption(item) = {
  set align(left)
  set par(first-line-indent: 0pt, justify: false, leading: 4pt)
  if item.numbering == none {
    [#h(12.5mm)#item.body]
  } else {
    [#h(12.5mm)#item.supplement~#context item.counter.display(item.numbering) – #item.body]
  }
}

#let figures(body) = {
  set figure(gap: 4pt, numbering: "1")
  set figure.caption(separator: [ – ])
  show figure: set block(above: 7pt, below: 7pt)
  show figure.caption: set par(first-line-indent: 0pt, justify: false, leading: 4pt)

  show figure.where(kind: image): set figure(supplement: [Рис.])
  show figure.caption.where(kind: image): set align(center)
  body
}
