#import "typography.typ": code-font
#import "figure.typ": left-caption

#let listings(body) = {
  show figure.where(kind: raw): set figure(supplement: [Лист.])
  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.caption.where(kind: raw): left-caption
  body
}

#let listing(code, caption, target: none, lang: "sql", numbers: true, breakable: false) = {
  show figure.where(kind: raw): set block(breakable: breakable)
  let code-body = {
    set text(hyphenate: false)
    set par(first-line-indent: 0pt, justify: false, leading: 3.5pt)
    set raw(theme: "listing.tmTheme", align: left)
    show raw: set text(font: code-font, size: 12pt)
    show raw.line: line => if numbers {
      box(width: 100%, inset: (y: 1.3pt), grid(
        columns: (7mm, 1fr),
        column-gutter: 2mm,
        align(right, text(size: 10pt, fill: luma(75), str(line.number))),
        line.body,
      ))
    } else {
      line.body
    }
    raw(code.trim(at: end), lang: lang, block: true)
  }
  let content = figure(
    block(width: 100%, stroke: 0.45pt, inset: 5pt, breakable: breakable, code-body),
    kind: raw,
    caption: caption,
  )
  [#content #target]
}
