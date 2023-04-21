# app/view/guide.R

box::use(
  shiny[moduleServer, NS, tabPanel, icon],
)


#' @export
ui <- function(id) {
  ns <- NS(id)

  tabPanel(
    title = "Guide",
    icon = icon("compass")
    )

}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {

  })
}
