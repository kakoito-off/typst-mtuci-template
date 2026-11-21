#import "references/load.typ": library
#import "styles/template.typ": report-style
#import "styles/heading.typ": centered-section
#import "styles/listing.typ": listing
#import "styles/table.typ": continued-table
#import "styles/example.typ": example-divider, example-emphasis
#import "sections/title.typ": title-page
#import "sections/references.typ": reference-section
#import "sections/bibliographic-note.typ": bibliographic-note

#let lab-report(data, chapters, include-section, read-data) = {
  show: report-style.with(
    author: data.student.name,
    title: if data.theme != "" { data.theme } else { [Лабораторная работа № #data.lab-number] },
  )

  title-page(data)
  include "sections/contents.typ"

  pagebreak(weak: true)
  centered-section[Введение]
  include-section("sections/introduction.typ")

  heading[Цель работы]
  include-section("sections/goal.typ")

  for chapter in chapters {
    include-section(chapter)
  }

  pagebreak(weak: true)
  centered-section[Заключение]
  include-section("sections/conclusion.typ")

  let bibliography-file = data.bibliography.file
  let sources = library(read-data(bibliography-file), json-format: bibliography-file.ends-with(".json"))
  reference-section(sources)

  if data.sections.bibliographic-note {
    bibliographic-note(sources, yaml(read-data(data.bibliography.publications)))
  }

  if data.sections.examples {
    pagebreak(weak: true)
    include-section("sections/examples.typ")
  }
}
