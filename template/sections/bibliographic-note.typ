#import "../styles/heading.typ": centered-section
#import "../styles/bibliography.typ": publication-groups

#let tagged-groups(sources) = (
  (title: "Публикации ВАК", matches: entry => "vak" in entry.at("tags", default: ())),
  (title: "Патенты", matches: entry => entry.type == "patent"),
).map(group => (
  title: group.title,
  sources: sources.keys().filter(key => {
    let entry = sources.at(key)
    "own" in entry.at("tags", default: ()) and (group.matches)(entry)
  }),
))

#let bibliographic-note(sources, selection) = {
  let groups = selection
  if groups.len() == 0 { groups = tagged-groups(sources) }
  groups = groups.filter(group => group.sources.len() > 0)
  if groups.len() > 0 {
    centered-section[Библиографическая справка]
    publication-groups(sources, groups)
  }
}
