#import "heading.typ": centered-section
#import "bibliography-locales.typ": language-marker, localized-entry, reference-terms
#import "paragraph.typ": paragraph-indent

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

#let reference-entry(entry) = {
  // The entry body may be wrapped in a PDF tag that carries the citation target.
  let body = entry.body
  while body.has("body") { body = body.body }
  let first = if body.has("children") { body.children.first() } else { body }
  let locale = if first.has("text") { first.text.match(language-marker) }
  localized-entry(
    if locale == none { "ru" } else { locale.captures.first() },
    entry,
    prefix: h(paragraph-indent),
  )
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
    show bibliography: it => context {
      set block(spacing: par.leading + 2pt)
      show block: reference-entry
      it
    }
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
