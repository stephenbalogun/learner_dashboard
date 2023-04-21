
# app/view/profile.R

box::use(
  shiny[
    moduleServer,
    NS,
    tagList,
    uiOutput,
    renderUI
  ],
  bslib[value_box, layout_column_wrap],
  bsicons[bs_icon],
  glue[glue],
  scales[percent_format]
)


box::use(
  app/view[site]
)


#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    uiOutput(
      ns("profile")
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    output$profile <- renderUI({
      layout_column_wrap(
        width = "250px",
        value_box(
          "IIT rate",
          percent_format()(0.013),
          showcase = bs_icon("person-fill-down"),
          theme_color = "primary"
        ),
        value_box(
          "Facility",
          glue("Savanah Hospital"),
          showcase = bs_icon("hospital"),
          theme_color = "info"
        ),
        value_box(
          "State",
          glue("Akwa-Ibom"),
          showcase = bs_icon("geo-alt"),
          theme_color = "success"
          )
        )
      })


    })
  }
