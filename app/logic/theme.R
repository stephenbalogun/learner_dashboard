# app/logic/theme.R

box::use(
  bslib[bs_theme, font_google]
)


adrap_theme <- function () {
  bs_theme(
    bootswatch = "minty",
    bg = "#EEE8D5",
    fg = "#2b3994",
    base_font = font_google("Fira Sans"),
    heading_font = font_google("Pacifico"),
    accent = "#2b3994",
    version = 5,
    primary = "#971230"

    )
}


# adrap_theme <- function () {
#   bs_theme(
#     bootswatch = "minty",
#     bg = "#002B36",
#     fg = "#E5B80B",
#     base_font = font_google("Fira Sans"),
#     heading_font = font_google("Pacifico"),
#     accent = "#2b3994",
#     version = 4,
#     primary = "#971230"
#
#   )
# }
