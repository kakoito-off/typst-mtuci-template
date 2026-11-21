#import "../template/lib.typ": lab-report

#lab-report(
  toml("report.toml"),
  toml("sections/chapters.toml").chapters,
  file => include file,
  file => read(file, encoding: none),
)
