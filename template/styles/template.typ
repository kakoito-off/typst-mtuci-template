#import "typography.typ": typography
#import "page.typ": pages
#import "paragraph.typ": paragraphs, line-leading
#import "heading.typ": headings
#import "list.typ": lists
#import "math.typ": equations
#import "footnote.typ": footnotes
#import "figure.typ": figures
#import "table.typ": tables
#import "listing.typ": listings

#let report-style(body, author: (), title: none, line-spacing: 1) = {
  let leading = line-leading(line-spacing)
  set document(author: author, title: title)
  show: typography
  show: pages
  show: paragraphs.with(leading)
  show: headings
  show: lists.with(leading)
  show: equations
  show: footnotes
  show: figures
  show: tables
  show: listings
  body
}
