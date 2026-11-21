#import "../../../../template/lib.typ": centered-section, listing, continued-table, example-divider, example-emphasis
#import "../assets/diagrams/optimization.typ": optimization

#centered-section(outlined: false)[Дополнительные примеры оформления контента]

В данном разделе рассмотрены дополнительные примеры, которые могут быть
использованы для оформления контента в отчете.

Чтобы убрать этот раздел из итогового PDF, задайте `examples = false`
в разделе `[sections]` файла `report.toml`.


#example-divider

Пример #example-emphasis[использования русских индексов в формуле]:

#let st = math.upright("ст")
#let dn = math.upright("дин")
#let epoch = math.upright("э")

$ F^H (D^m) = -log_2 lr((
  frac(F_st (P_st^alpha) + F_dn (P_dn^alpha),
    2 dot lr((F_st (G P_st^alpha (T_epoch)) + F_dn (G P_dn^alpha (T_epoch)))))
  + 0.5
)), $ <eq-entropy>
где $F_st (P_st^alpha)$~– функция, вычисляющая сумму весовых коэффициентов для
статических параметров; $F_dn (P_dn^alpha)$~– функция, вычисляющая сумму весовых
коэффициентов для динамических параметров с учетом их «устаревания»;
$G P_st^alpha (T_epoch)$~– функция, генерирующая множество теоретически возможных
статических параметров системы за время эксплуатации $T_epoch$;
$G P_dn^alpha (T_epoch)$~– функция, генерирующая множество теоретически возможных
динамических параметров за время эксплуатации $T_epoch$.

#example-divider

Интеграция листинга в документ #example-emphasis[без использования внешнего файла]
(@lst-inline[лист.]).

#listing(
  ```sql
  select s.last_name
  from student s, student_hobby sh, hobby h
  where s.id=sh.id_student and sh.id_hobby=h.id
  group by 1
  having count(sh.id_hobby)>1;
  ```.text,
  [Интеграция листинга без использования внешнего файла],
  target: <lst-inline>,
)

#example-divider

Пример интеграции #example-emphasis[многостраничного листинга] (@lst-db[лист.]).

#listing(
  read("../assets/listings/dbstart.txt"),
  [Скрипт демонстрационной *БД*],
  target: <lst-db>,
  breakable: true,
)

#example-divider

Результаты выполнения запроса можно визуализировать в отчете следующим образом
(@lst-result[лист.]).

#listing(
  read("../assets/listings/demoresult.txt"),
  [Пример результата запроса],
  target: <lst-result>,
  lang: none,
  numbers: false,
)

#example-divider

Создадим таблицу во всю ширину страницы и продемонстрируем выравнивание текста
внутри ячеек. В LaTeX для этого использовался `tabular` (@tbl-alignment[табл.]).

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    align: (x, y) => (left, center, right).at(x),
    [По левому краю], [В центре], [По правому краю],
    [Существует \ множество пакетов \ для рисования таблиц],
    table.cell(align: center + horizon)[1.00], [2.00],
    [Существует множество пакетов для рисования таблиц],
    table.cell(align: center + horizon)[3.00],
    table.cell(align: right + bottom)[4.00],
  ),
  caption: [Пример таблицы во всю ширину с выравниванием],
) <tbl-alignment>

#pagebreak(weak: true)
#example-divider

Создадим таблицу во всю ширину страницы, в которой текст второй строки выделен
жирным шрифтом и определена пропорция ширины столбцов
(@tbl-widths[табл.]). В LaTeX для этого использовался `tabularray`.

#let sample-cell = [Пример размещения длинной текстовой строки в ячейке таблицы]
#figure(
  table(
    columns: (1fr, 1fr, 2fr),
    align: left + top,
    table.cell(colspan: 3, align: center)[Ширина столбцов указана в следующей строке таблицы],
    table.cell(align: center)[*25 %*], table.cell(align: center)[*25 %*],
    table.cell(align: center)[*50 %*],
    sample-cell, sample-cell, sample-cell,
  ),
  caption: [Пример таблицы с пропорциональной шириной столбцов (`tabularray` в LaTeX)],
) <tbl-widths>

#example-divider

Для демонстрации оформления многостраничных таблиц рассмотрим следующий пример
(@tbl-long[табл.]).

#let sample-rows = (
  ([Alpha], [Beta], [Gamma]),
  ([Epsilon], [Zeta], [Eta]),
  ([Iota], [Kappa], [Lambda]),
  ([Nu], [Xi], [Omicron]),
  ([Rho], [Sigma], [Tau]),
  ([Phi], [Chi], [Psi]),
)
#continued-table(
  [Пример интеграции в документ многостраничной таблицы
   (в LaTeX — `\begin{longtblr}` … `\end{longtblr}`)],
  ([Заголовок \ столбец-1], [Заголовок \ столбец-2], [Заголовок \ столбец-3]),
  sample-rows * 3 + (
    sample-rows.at(0), sample-rows.at(3), sample-rows.at(5),
    sample-rows.at(0), sample-rows.at(1),
  ),
  <tbl-long>,
)

#example-divider

Рассмотрим создание блок-схемы. В оригинале иллюстрация создана с помощью
пакета *TikZ* (@fig-optimization[рис.]).

#figure(
  optimization,
  kind: image,
  caption: [Пример блок-схемы, созданной в оригинале с помощью *TikZ*],
  alt: "Обработка входного документа с повторным циклом оптимизации параметра",
) <fig-optimization>

#example-divider
