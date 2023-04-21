# app/logic/pickInput.R

box::use(
  shinyWidgets[pickerInput]
)

pickInput <- function(id, lab, opts = NULL, mult = TRUE) {
  pickerInput(
    inputId = id,
    label = lab,
    choices = opts,
    multiple = mult,
    options = list(
      `actions-box` = TRUE,
      dropAuto = TRUE,
      size = "auto",
      `live-search` = TRUE,
      `live-search-normalize` = TRUE
    )
  )
}
