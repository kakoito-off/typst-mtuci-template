#import "figure.typ": left-caption

#let tables(body) = {
  set table(stroke: 0.45pt, inset: (x: 5pt, y: 3pt))
  set table.cell(breakable: false)
  show table.cell: set par(first-line-indent: 0pt, justify: false, leading: 4pt)

  show figure.where(kind: table): set figure(supplement: [Табл.])
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): left-caption
  body
}

#let continued-table(caption, header, rows, target) = {
  let columns = header.len()
  let end = label(str(target) + "-end")
  let cells = (..rows.flatten().slice(0, -1), [#rows.last().last() #metadata(none) #end])
  let continuation = table.cell(colspan: columns, inset: 0pt, stroke: none)[
    #context if here().page() > locate(target).page() {
      set text(weight: "regular")
      set par(first-line-indent: (amount: 12.5mm, all: true))
      pad(bottom: 4pt, block[#h(12.5mm)Табл. #ref(target, supplement: none) – #caption (Продолжение)])
    }
  ]
  let continuation-footer = table.cell(colspan: columns, inset: 0pt, stroke: none, align: center)[
    #context if here().page() < locate(end).page() {
      pad(top: 3pt)[Продолжение на следующей странице]
    }
  ]

  show figure.where(kind: table): set block(breakable: true)
  [
    #figure(
      table(
        columns: (1fr,) * columns,
        inset: (x: 5pt, y: 6pt),
        align: (x, y) => if y == 1 { center } else { left },
        table.header(continuation, ..header.map(strong)),
        ..cells,
        table.footer(continuation-footer),
      ),
      caption: caption,
    ) #target
  ]
}
