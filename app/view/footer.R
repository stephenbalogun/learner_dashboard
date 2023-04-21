# app/view/footer.R

box::use(
  shiny[moduleServer, NS, tags, HTML],
)


#' @export
ui <- function(id) {
  ns <- NS(id)

  tags$footer("copyright", HTML("&copy; 2023"))

}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {

  })
}
