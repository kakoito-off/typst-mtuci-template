#import "../../../template/lib.typ": lab-report

#lab-report(
  toml("report.toml"),
  toml("sections/chapters.toml").chapters,
  file => {
    import file as section
    section
  },
  file => read(file, encoding: none),
)
