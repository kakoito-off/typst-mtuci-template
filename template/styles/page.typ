#let margins = (left: 25mm, right: 10mm, top: 20mm, bottom: 20mm)

#let pages(body) = {
  set page(
    paper: "a4",
    margin: margins,
    footer: context align(center, counter(page).display("1")),
    footer-descent: 8mm,
  )
  body
}
