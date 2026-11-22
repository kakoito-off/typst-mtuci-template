#import "references/load.typ": library
#import "styles/template.typ": report-style
#import "styles/heading.typ": centered-section
#import "styles/outline.typ": chapter-with-toc-title
#import "styles/bibliography.typ": bibliography-citations
#import "styles/listing.typ": listing
#import "styles/table.typ": continued-table
#import "styles/example.typ": example-divider, example-emphasis
#import "sections/title.typ": title-page
#import "sections/references.typ": reference-section

#let lab-report(data, chapters, load-section, read-data, bibliographic-note: none) = {
  let section-content(section) = if type(section) == module { include section } else { section }
  let line-spacing = data.at("layout", default: (:)).at("line-spacing", default: 1)
  if "line-spacing" in sys.inputs {
    line-spacing = float(sys.inputs.at("line-spacing"))
  }
  let bibliography-file = data.bibliography.file
  let sources = library(read-data(bibliography-file), json-format: bibliography-file.ends-with(".json"))

  show: report-style.with(
    author: data.student.name,
    title: if data.theme != "" { data.theme } else { [Лабораторная работа № #data.lab-number] },
    line-spacing: line-spacing,
  )
  show: bibliography-citations.with(sources)

  title-page(data)
  include "sections/contents.typ"

  pagebreak(weak: true)
  centered-section[Введение]
  section-content(load-section("sections/introduction.typ"))

  heading[Цель работы]
  section-content(load-section("sections/goal.typ"))

  for file in chapters {
    let chapter = load-section(file)
    let toc-title = if type(chapter) == module and "toc-title" in chapter {
      chapter.toc-title
    } else {
      ""
    }
    chapter-with-toc-title(toc-title, section-content(chapter))
  }

  pagebreak(weak: true)
  centered-section[Заключение]
  section-content(load-section("sections/conclusion.typ"))

  reference-section(sources)
  bibliographic-note

  if data.sections.examples {
    pagebreak(weak: true)
    section-content(load-section("sections/examples.typ"))
  }
}
