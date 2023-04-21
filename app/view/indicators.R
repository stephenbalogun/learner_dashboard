# app/view/indicators.R

box::use(
  shiny[
    moduleServer,
    NS,
    tabPanel,
    icon,
    sidebarLayout,
    sidebarPanel,
    mainPanel,
    ],
  DT[dataTableOutput],
)

box::use(
  app/view[site, indicatorTable, profile]
)


#' @export
ui <- function(id, data) {
  ns <- NS(id)

  tabPanel(
    title = "Indicators",
    class = "add-margin",
    sidebarLayout(
      sidebarPanel(
        site$ui(ns("sites"), data)
        ),
      mainPanel(
        indicatorTable$ui(ns("table"))
        )
      ),
    icon = icon("list-check")
    )

}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {

    df_table <- site$server("sites", data)

    selected_row <- indicatorTable$server("table", df_table)

    # profile$server("site")

  })
}
