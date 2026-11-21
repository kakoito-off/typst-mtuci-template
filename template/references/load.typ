#let import-json-record(record) = {
  let common = (
    type: record.type,
    author: record.authors.map(person => person.family + ", " + person.given),
    language: record.lang,
    title: record.title,
    tags: record.at("tags", default: ()),
  )
  if record.type == "article" {
    common + (
      date: record.year,
      page-range: record.pages,
      parent: (
        type: "periodical",
        title: record.journal,
        volume: record.volume,
        issue: record.number,
      ),
    )
  } else if record.type == "patent" {
    common + (
      serial-number: record.number,
      location: record.country,
      holder: record.holder,
      filed: record.filed,
      published: record.published,
    )
  } else {
    panic("Импорт JSON поддерживает записи article и patent: " + record.type)
  }
}

#let library(input, json-format: false) = if json-format {
  let sources = (:)
  for (key, record) in json(input) {
    sources.insert(key, import-json-record(record))
  }
  sources
} else {
  yaml(input)
}
