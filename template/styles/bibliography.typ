#import "heading.typ": centered-section
#import "bibliography-locales.typ": language-marker, localized-entry, reference-terms

#let source-language(source) = {
  let language = source.at("language", default: none)
  if language == none { "ru" } else { language }
}

#let patent-details(source, terms) = {
  let published = source.at("published", default: source.at("date", default: none))
  let details = (
    source.at("location", default: none),
    if "holder" in source { terms.holder + " " + source.holder },
    if "filed" in source { terms.filed + " " + str(source.filed) },
    if published != none { terms.published + " " + str(published) },
  )
  details.filter(item => item != none).join(", ")
}

#let reference-cell(cell) = {
  // Typst 0.14.2 places the reference text in the second column,
  // inside a PDF tag that also carries the bibliography link target.
  let body = cell.body
  while body.has("body") { body = body.body }
  let first = if body.has("children") { body.children.first() } else { body }
  let locale = if first.has("text") { first.text.match(language-marker) }
  localized-entry(if locale == none { "ru" } else { locale.captures.first() }, cell)
}

#let bibliography-citations(sources, body) = {
  // Full citations use the CSL bibliography layout, including its markers.
  show cite.where(form: "full"): item => {
    let source = sources.at(str(item.key), default: (:))
    localized-entry(source-language(source), item)
  }
  body
}

#let reference-list(sources) = {
  if sources.len() > 0 {
    centered-section[Список использованных источников]
    set par(first-line-indent: 0pt, leading: 5pt, spacing: 2pt)
    show grid.cell.where(x: 1): reference-cell
    let data = (:)
    for (key, source) in sources {
      let locale = source-language(source)
      source += (language: locale,)
      if lower(source.at("type", default: "misc")) == "patent" {
        source += (note: patent-details(source, reference-terms(locale)),)
      }
      data.insert(key, source)
    }
    bibliography(bytes(yaml.encode(data)), title: none, style: "gost-numeric.csl")
  }
}

#let display-author(author) = {
  if type(author) == str {
    author.replace(", ", " ")
  } else {
    (author.name, author.at("given-name", default: "")).join(" ").trim()
  }
}

#let publication-groups(sources, groups) = {
  for group in groups {
    heading(level: 2, group.title)
    enum(..group.sources.map(key => {
      let source = sources.at(key)
      let locale = source-language(source)
      let terms = reference-terms(locale)
      let authors = source.at("author", default: ())
      if type(authors) != array { authors = (authors,) }
      let names = authors.map(display-author).join(", ")
      let date = source.at("date", default: none)
      let heading-text = if names == "" {
        source.title
      } else {
        let separator = if names.ends-with(".") { " " } else { ". " }
        [#names#separator#source.title]
      }
      let entry = if source.type == "patent" [
        #heading-text. #terms.patent~#source.at("serial-number").
        #patent-details(source, terms).
      ] else if source.type == "article" [
        #heading-text #text("//") #source.parent.title. #date.
        #if "volume" in source.parent [#terms.volume~#source.parent.volume.]
        #if "issue" in source.parent [#terms.issue~#source.parent.issue.]
        #if "page-range" in source [#terms.page~#source.at("page-range").]
      ] else [
        #heading-text. #if date != none [#date.]
      ]
      localized-entry(locale, entry)
    }))
  }
}
