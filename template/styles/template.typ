#import "typography.typ": typography
#import "page.typ": pages
#import "paragraph.typ": paragraphs
#import "heading.typ": headings
#import "list.typ": lists
#import "math.typ": equations
#import "footnote.typ": footnotes
#import "figure.typ": figures
#import "table.typ": tables
#import "listing.typ": listings

#let report-style(body, author: (), title: none) = {
  set document(author: author, title: title)
  show: typography
  show: pages
  show: paragraphs
  show: headings
  show: lists
  show: equations
  show: footnotes
  show: figures
  show: tables
  show: listings
  body
}
