#import "heading.typ": centered-section

#let patent-details(source) = {
  let published = source.at("published", default: source.at("date", default: none))
  let details = (
    source.at("location", default: none),
    if "holder" in source { "правообладатель " + source.holder },
    if "filed" in source { "заявл. " + str(source.filed) },
    if published != none { "опубл. " + str(published) },
  )
  details.filter(item => item != none).join(", ")
}

#let reference-list(sources) = {
  if sources.len() > 0 {
    centered-section[Список использованных источников]
    set par(first-line-indent: 0pt, leading: 5pt, spacing: 2pt)
    let style = "gost-r-705-2008-numeric"
    let data = (:)
    for (key, source) in sources {
      if source.type == "patent" {
        style = "references-with-patents.csl"
        source += (note: patent-details(source),)
      }
      data.insert(key, source)
    }
    bibliography(bytes(yaml.encode(data)), title: none, style: style)
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
      if source.type == "patent" [
        #heading-text. Пат. №~#source.at("serial-number").
        #patent-details(source).
      ] else if source.type == "article" [
        #heading-text #text("//") #source.parent.title. #date.
        #if "volume" in source.parent [Т. #source.parent.volume.]
        #if "issue" in source.parent [№ #source.parent.issue.]
        #if "page-range" in source [С. #source.at("page-range").]
      ] else [
        #heading-text. #if date != none [#date.]
      ]
    }))
  }
}
