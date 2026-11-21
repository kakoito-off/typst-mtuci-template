#let language-marker = regex("⟦mtuci:lang:([a-zA-Z0-9-]+)⟧")
#let term-marker = regex("⟦mtuci:([a-z-]+)⟧")

#let terms = (
  ru: (
    volume: "Т.", issue: "№", page: "С.", page-total: "с", edition: "-е изд",
    editor: "под ред.", translator: "пер.", online: "Электронный ресурс", accessed: "дата обращения",
    patent: "Пат. №", holder: "правообладатель", filed: "заявл.", published: "опубл.",
  ),
  en: (
    volume: "Vol.", issue: "No.", page: "P.", page-total: "p", edition: " ed",
    editor: "ed. by", translator: "transl. by", online: "Electronic resource", accessed: "accessed",
    patent: "Patent No.", holder: "patent holder", filed: "filed", published: "published",
  ),
  de: (
    volume: "Bd.", issue: "Nr.", page: "S.", page-total: "S", edition: ". Aufl",
    editor: "Hrsg.", translator: "Übers.", online: "Elektronische Ressource", accessed: "abgerufen am",
    patent: "Patent Nr.", holder: "Patentinhaber", filed: "angemeldet",
    published: "veröffentlicht",
  ),
  fr: (
    volume: "Vol.", issue: "nº", page: "P.", page-total: "p", edition: "e éd",
    editor: "sous la dir. de", translator: "trad. par", online: "Ressource électronique", accessed: "consulté le",
    patent: "Brevet nº", holder: "titulaire", filed: "déposé", published: "publié",
  ),
)

#let reference-terms(locale) = terms.at(lower(locale.split("-").first()), default: terms.en)

#let localized-entry(locale, body) = {
  let parts = locale.split("-")
  let lang = lower(parts.first())
  let region = parts.slice(1).find(part => part.match(regex("^[a-zA-Z]{2}$")) != none)
  let labels = reference-terms(locale)
  set text(lang: lang, region: region)
  show language-marker: none
  show regex("[0-9]+⟦mtuci:edition⟧"): item => {
    let value = item.text.match(regex("^[0-9]+")).text
    let number = int(value)
    let suffix = if labels == terms.en {
      let ordinal = if calc.rem(number, 100) in (11, 12, 13) {
        "th"
      } else {
        ("th", "st", "nd", "rd").at(calc.rem(number, 10), default: "th")
      }
      ordinal + labels.edition
    } else if lang == "fr" and number == 1 {
      "re éd"
    } else {
      labels.edition
    }
    value + suffix
  }
  show term-marker: item => labels.at(item.text.match(term-marker).captures.first())
  body
}
