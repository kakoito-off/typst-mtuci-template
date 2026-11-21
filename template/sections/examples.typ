#import "../lib.typ": centered-section, listing

#centered-section(outlined: false)[Дополнительные примеры оформления]

Подпись и номер таблицы формирует шаблон. См. @example-table[табл.].

#figure(
  table(
    columns: (1fr, 1fr),
    table.header([Параметр], [Значение]),
    [Время выполнения], [12 мс],
  ),
  caption: [Пример результата измерений],
) <example-table>

Листинг может быть записан внутри главы или прочитан из файла. См. @example-code[лист.].

#listing("select 1;", [Пример SQL-запроса], target: <example-code>)
