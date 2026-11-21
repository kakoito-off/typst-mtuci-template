#let optimization = {
  let stroke = 0.65pt
  let width = 60mm
  let column = 8mm
  let middle = column + width / 2
  let purple = rgb("#bebdf9")
  let green = rgb("#c6ffbd")
  let orange = rgb("#ffdfbd")
  let pink = rgb("#ffc0c0")
  let yellow = rgb("#fffcbe")

  let connector(x, y, dx, dy) = place(
    top + left, dx: x, dy: y, line(end: (dx, dy), stroke: stroke),
  )
  let arrow-tip(x, y, right: false) = {
    let arrow = if right {
      polygon((0mm, 0mm), (1.5mm, 0.7mm), (0mm, 1.4mm), fill: black)
    } else {
      polygon((0mm, 0mm), (1.4mm, 0mm), (0.7mm, 1.5mm), fill: black)
    }
    place(top + left, dx: x, dy: y, arrow)
  }
  let node(y, height, shape, title) = {
    place(top + left, dx: column, dy: y, shape)
    place(top + left, dx: column, dy: y, block(
      width: width, height: height, align(center + horizon, title),
    ))
  }
  let terminal(y, title) = node(y, 10mm, rect(
    width: width, height: 10mm, radius: 1.6mm, fill: purple, stroke: stroke,
  ), title)
  let document-node(y, title) = node(y, 10mm, polygon(
    (2.5mm, 0mm), (width, 0mm), (width - 2.5mm, 10mm), (0mm, 10mm),
    fill: green, stroke: stroke,
  ), title)
  let add-iteration = polygon(
    (0mm, 0mm), (width, 0mm), (width, 10mm), (width - 5.5mm, 15mm),
    (5.5mm, 15mm), (0mm, 10mm), fill: orange, stroke: stroke,
  )

  block(width: 96mm, height: 160mm, {
    set text(size: 12pt, hyphenate: false)
    set par(justify: false, first-line-indent: 0pt, leading: 2pt)
    connector(middle, 10mm, 0mm, 142mm)
    connector(4.5mm, 32mm, middle - 4.5mm, 0mm)
    connector(4.5mm, 32mm, 0mm, 79mm)
    connector(4.5mm, 111mm, 15mm, 0mm)
    for y in (18mm, 36mm, 58mm, 76mm, 99mm, 131mm, 149mm) {
      arrow-tip(middle - 0.7mm, y - 1.5mm)
    }
    arrow-tip(middle - 1.5mm, 31.3mm, right: true)

    terminal(0mm, [Начало])
    document-node(18mm, [Входной документ])
    node(36mm, 15mm, polygon(
      (5.5mm, 0mm), (width - 5.5mm, 0mm), (width, 5.5mm), (width, 15mm),
      (0mm, 15mm), (0mm, 5.5mm), fill: orange, stroke: stroke,
    ), [Цикл $k$ \ от $1$ до $10$])
    node(58mm, 10mm, rect(
      width: width, height: 10mm, fill: pink, stroke: stroke,
    ), [Настройка параметра $p_k$])
    node(76mm, 15mm, add-iteration, [Увеличить $k$ на $1$ \ Цикл $k$])

    place(top + left, dx: column - 2mm, dy: 33.5mm, rect(
      width: width + 4mm,
      height: 60mm,
      stroke: (paint: black, thickness: 0.55pt, dash: "dotted"),
    ))
    place(top + left, dx: 72mm, dy: 59mm, block[Блок \ оптимизация])
    place(top + left, dx: 19.5mm, dy: 99mm, polygon(
      (18.5mm, 0mm), (37mm, 12mm), (18.5mm, 24mm), (0mm, 12mm),
      fill: yellow, stroke: stroke,
    ))
    place(top + left, dx: 19.5mm, dy: 99mm, block(
      width: 37mm, height: 24mm, align(center + horizon)[Повторное \ выполнение],
    ))
    place(top + left, dx: 16mm, dy: 104mm, [Да])
    place(top + left, dx: 43mm, dy: 121mm, [Нет])
    document-node(131mm, [Выходной документ])
    terminal(149mm, [Конец])
  })
}
