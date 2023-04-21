# app/view/learners.R

box::use(
  shiny[moduleServer, NS, tabPanel, icon, sidebarLayout, sidebarPanel, mainPanel],
  DT[dataTableOutput]
)

box::use(
  app/view[site, showTable]
  )

#' @export
ui <- function(id, data) {
  ns <- NS(id)

  tabPanel(
    title = "Learners",
    class = "add-margin",
    sidebarLayout(
      sidebarPanel(
        site$ui(ns("sites"), data)
        ),
      mainPanel(
        showTable$ui(ns("table"))
        )
      ),
    icon = icon("chalkboard-user")
    )

}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {

    df_table <- site$server("sites", data)

    showTable$server("table", df_table)

  })
}
