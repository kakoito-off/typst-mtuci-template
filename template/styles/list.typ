#import "paragraph.typ": paragraph-indent

#let lists(leading, body) = {
  let item-spacing = leading + 2pt
  set list(marker: [–], indent: paragraph-indent, body-indent: 0.35em, spacing: item-spacing)
  set enum(numbering: "1)", indent: paragraph-indent, body-indent: 0.35em, spacing: item-spacing)
  body
}
