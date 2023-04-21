# app/view/indicatorTable.R

box::use(
  shiny[
    moduleServer,
    NS,
    tagList,
    observeEvent,
    showModal,
    modalDialog,
    renderTable,
    tableOutput,
    modalButton,
    icon,
    reactive,
    req,
    renderUI,
    uiOutput,
    h4,
    a,
    span
  ],
  DT[
    dataTableOutput,
    renderDataTable
  ],
  tibble[tibble],
  glue[glue],
  dplyr[distinct, mutate, across, filter],
  tidyselect[where],
  scales[percent_format],
  bslib[value_box, layout_column_wrap],
  bsicons[bs_icon],
  shiny.router[router_ui, router_server, route, route_link, change_page],
  DT[formatStyle]
)


box::use(
  app/view[site]
)


#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    router_ui(
      route("table", dataTableOutput(ns("table"))),
      route("site", uiOutput(ns("profile")))
    )
    # dataTableOutput(ns("table")),
    # uiOutput(ns("profile"))
  )
}

#' @export
server <- function(
    id,
    data
) {
  moduleServer(id, function(input, output, session) {

    router_server("table")

    output$table <- renderDataTable(
      distinct(
        data(),
        facility,
        .keep_all = TRUE
        )[, c("facility", "iit_rate", "vl_coverage", "vls_rate", "reg_optimization_rate")] |>
        mutate(
          across(
            where(is.numeric), percent_format()
          )
        ),
      rownames = FALSE,
      selection = "single",
      options = list(
        cursor = "pointer"
      )
    )

    selected_row <- reactive({
      req(input$table_rows_selected)
      data()[input$table_rows_selected, ]
    })

    dt <- reactive({

      filter(data(), facility %in% selected_row()$facility)[, c("full_name", "phone_number", "email")]

    })

    observeEvent(input$table_rows_selected, {

      change_page("/site")

      x <- 0.008

      output$profile <- renderUI({
        tagList(
          layout_column_wrap(
            width = "250px",
            value_box(
              "IIT rate",
              percent_format(accuracy = 0.1)(selected_row()$iit_rate),
              showcase = bs_icon("person-fill-down"),
              theme_color = ifelse(x < 0.01, "success","danger")
            ),
            value_box(
              "Facility",
              selected_row()$facility,
              showcase = bs_icon("hospital"),
              theme_color = "info"
            ),
            value_box(
              "State",
              selected_row()$state,
              showcase = bs_icon("geo-alt"),
              theme_color = "warning"
            )
          ),
          h4("send alert to Clinical team to institute mentoring and determine root cause"),

          span(
            class = "return",
            a(
              bs_icon("arrow-left-square-fill", size = "3em"),
              href = route_link("table")
              ),
            "return"
          )
        )

       # dt()

      })

    })

  })
}
