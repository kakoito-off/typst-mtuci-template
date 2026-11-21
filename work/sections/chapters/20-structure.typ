= Структура проекта

Каталог `template/` содержит самостоятельный шаблон. Каталог `work/` содержит
данный отчёт и два материала для сравнения. В `examples/postgresql/` находится
перенос исходной работы в Typst, а в `examples/latex-original/` — LaTeX-образец.

== Состав шаблона

```text
template/
├── report.typ          точка входа
├── report.toml         данные титульника и настройки разделов
├── lib.typ             порядок и сборка разделов
├── sections/
│   ├── chapters.toml   список глав в порядке вывода
│   ├── chapters/       одна глава на файл
│   ├── introduction.typ, goal.typ, conclusion.typ
│   ├── title.typ, contents.typ, references.typ
│   └── bibliographic-note.typ, examples.typ
├── styles/             правила оформления
├── references/         данные источников и загрузчик
└── assets/             логотип и ресурсы отчёта
```

`report.typ` загружает конфигурацию и передаёт её в `lab-report` из `lib.typ`.
Имена файлов в списке глав и путях к источникам отсчитываются от файла отчёта.
Модуль подключает содержимое глав в указанном порядке через `include`
@typst-modules.

== Правила оформления

Модуль `styles/template.typ` подключает правила из отдельных файлов
(@style-files[табл.]). Файлы глав используют обычную разметку Typst.

#figure(
  table(
    columns: (5fr, 7fr),
    table.header([*Модуль*], [*Назначение*]),
    [`page.typ`, `typography.typ`, `paragraph.typ`],
    [Поля, номера страниц, шрифты, интервал и абзацный отступ],
    [`title.typ`, `heading.typ`, `outline.typ`],
    [Титульник, заголовки и содержание],
    [`figure.typ`, `table.typ`, `listing.typ`],
    [Подписи, таблицы с повторяемой шапкой, номера строк и подсветка кода],
    [`list.typ`, `math.typ`, `footnote.typ`],
    [Списки, нумерованные формулы и сноски],
    [`bibliography.typ`, `references-with-patents.csl`],
    [Список источников, справка и вывод реквизитов патентов],
  ),
  caption: [Основные модули оформления],
) <style-files>
