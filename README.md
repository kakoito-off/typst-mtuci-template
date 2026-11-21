# Шаблон отчёта МТУСИ в Typst

- [template/](template) — самостоятельный шаблон для новой лабораторной.
- [work/](work) — техническое описание, собранное на этом шаблоне. В [work/examples/](work/examples) находятся исходный LaTeX-образец и его перенос в Typst.

## Новая лабораторная

Скопируйте каталог `template/` целиком. Заполните `report.toml`, напишите введение, цель и заключение в `sections/`. Главы хранятся в `sections/chapters/`, а их порядок задаёт `sections/chapters.toml`.

Из скопированного каталога выполните:

```sh
typst compile report.typ
```

Автор использует обычные заголовки Typst. Правила нумерации, содержания, подписей и титульника находятся в `styles/`.

## Сборка технического описания и примера

Из корня репозитория выполните:

```sh
typst compile --root . work/report.typ
typst compile --root . work/examples/postgresql/report.typ
```

Команды создают `report.pdf` рядом с соответствующим `report.typ`. Сборка проверена на Typst 0.14.2.
