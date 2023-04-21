# app/view/map.R

box::use(
  shiny[moduleServer, NS, tabPanel, icon, absolutePanel, div, h3, h4, h5, textOutput, plotOutput, renderText, renderPrint],
  leaflet[leafletOutput, renderLeaflet, leaflet, addTiles, setView, addLayersControl, layersControlOptions, addProviderTiles],
  glue[glue],
  base[Sys.Date],
  scales[comma]

)


#' @export
ui <- function(id) {
  ns <- NS(id)

  tabPanel(
    title = "Map",
    width = "100%",
    height = "100%",
    div(
      leafletOutput(ns("map"), height = "100vh"),
      # width = "100%"
    ),
    absolutePanel(
      id = "controls", class = "panel panel-default",
      top = 80, left = 20, width = 250, fixed = TRUE,
      draggable = TRUE, height = "auto",
      h3(textOutput(ns("active_clients")),
         align = "right"
      ),
      h4(
        textOutput(ns("new_enrollments")),
        align = "right"
      ),
      h4(
        textOutput(ns("losses")),
         align = "right"
      ),
      h4(
        textOutput(ns("vl_eligible")),
         align = "right"
      ),
      h4(
        textOutput(ns("vl_coverage")),
         align = "right"
      ),
      h4(
        textOutput(ns("vl_supp_rate")),
         align = "right"
      ),
      h5(
        textOutput(ns("clean_date")),
         align = "right"
      ),
      plotOutput(
        ns("tx_new_curve"),
        height = "130px",
        width = "100%"
      )
    ),
    icon = icon("earth-africa")
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    output$map <- renderLeaflet({
      leaflet() |>
        addTiles() |>
        setView(9.0778, 8.6775, zoom = 7) |>
        addLayersControl(
          position = "bottomright",
          options = layersControlOptions(collapsed = FALSE))  |>
        addProviderTiles("CartoDB.Positron")
    })

    output$clean_date <- renderPrint({
      glue("Last updated: {format(Sys.Date(), '%end %B %Y')}")
    })

    output$active_clients <- renderText({
      glue("{comma(10000)} active clients")
    })

    output$new_enrollments <- renderText({
      glue("{comma(1500)} new Clients")
    })

    output$losses <- renderText({
      glue("{comma(230)} Clients Lost")
    })


  })
}
