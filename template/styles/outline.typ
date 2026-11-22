#import "heading.typ": centered-section

#let chapter-with-toc-title(title, body) = {
  let title = title.trim()
  if title == "" { return body }
  // Bound the override to this file, including when the file has no heading.
  [#metadata(title) <report-chapter-toc-title>#body#metadata(none) <report-chapter-toc-title>]
}

#let contents() = {
  centered-section(outlined: false, bookmarked: true)[Содержание]
  set par(first-line-indent: 0pt)
  set outline.entry(fill: repeat(box(width: 3.5mm, align(center)[.])))
  show outline.entry: entry => context {
    let target = entry.element.location()
    let marker = query(selector(<report-chapter-toc-title>).before(target)).last(default: none)
    if marker == none or marker.value == none { return entry }

    let first-heading = query(selector(heading.where(level: 1)).after(marker.location())).first()
    if first-heading.location() != target { return entry }

    let inner = [#marker.value #box(width: 1fr, entry.fill) #entry.page()]
    link(target, entry.indented(entry.prefix(), inner))
  }
  outline(title: none, depth: 1, indent: 0pt)
}
