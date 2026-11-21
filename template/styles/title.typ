#let signature(label, role, name, year) = {
  let rule(width) = box(width: width, line(length: width, stroke: 0.4pt))
  block[
    #label \
    #role \
    #rule(27mm) #name \
    «#rule(10mm)» #rule(25mm) #year г.
  ]
}

#let cover(data) = page(
  paper: "a4",
  margin: 0pt,
  footer: none,
  header: none,
  {
    set text(hyphenate: false)
    set par(justify: false, first-line-indent: 0pt, leading: 5.5pt)
    let center-width = 175mm
    place(top + left, dx: 20mm, dy: 10mm, rect(
      width: 180mm, height: 277mm, stroke: 0.5mm,
    ))

    place(top + left, dx: 25mm, dy: 15.5mm, block(width: center-width, align(center)[
      #image("../assets/mtuci-logo.svg", width: 21mm, alt: "Логотип МТУСИ")
      #v(1mm)
      МИНИСТЕРСТВО ЦИФРОВОГО РАЗВИТИЯ, СВЯЗИ И \
      МАССОВЫХ КОММУНИКАЦИЙ РОССИЙСКОЙ ФЕДЕРАЦИИ
      #v(5mm)
      Ордена Трудового Красного Знамени федеральное государственное \
      бюджетное образовательное учреждение высшего образования \
      «*Московский технический университет связи и информатики*» \
      (*МТУСИ*)
      #v(5mm)
      Кафедра «#data.department»
    ]))

    place(top + left, dx: 25mm, dy: 133mm, block(width: center-width, align(center)[
      *ОТЧЕТ* \
      по лабораторной работе №~#data.lab-number
      #v(5mm)
      дисциплина «*#data.discipline*»
      #if data.theme != "" [
        #v(2mm)
        тема «#data.theme»
      ]
      #if data.revision != "" [
        #v(5mm)
        #text(fill: red, style: "italic")[Версия документа #data.revision]
      ]
    ]))

    place(top + left, dx: 121mm, dy: 185mm, block(width: 79mm)[
      #set par(leading: 9pt)
      #signature([Выполнил:], [студент гр.~#data.student.group], data.student.name, data.year)
      #v(3mm)
      #signature([Проверил:], data.reviewer.position, data.reviewer.name, data.year)
    ])

    place(top + left, dx: 25mm, dy: 268.5mm, block(width: center-width, align(center)[
      #data.city, #data.year~г.
    ]))
  },
)
