# app/view/site.R

box::use(
  shiny[moduleServer, NS, tagList, icon, actionButton, observeEvent, eventReactive, reactive],
  shinyWidgets[pickerInput, updatePickerInput],
  base[list, sort, unique, unlist],
  purrr[map]
)

box::use(
  app/logic/pickInput[pickInput]
)


#' @export
ui <- function(id, df) {
  ns <- NS(id)

  tagList(
    pickInput(
      ns("continent"),
      "Continent",
      opts = sort(unique(df$continent))
    ),
    pickInput(ns("country"), "Country"),
    pickInput(ns("state"), "State"),
    pickInput(ns("lga"), "LGA"),
    actionButton(
      ns("update"),
      "Update",
      icon = shiny::icon("refresh"),
      class = "btn-success"
    )
  )
}

#' @export
server <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    continent_data <- reactive({
      df[df$continent %in% input$continent, ]
    })

    observeEvent(input$continent, {
      countries <- sort(as.character(unique(continent_data()$country)))

      updatePickerInput(session, inputId = "country", choices = countries, selected = countries, clearOptions = TRUE)
    })


    # choose states -------------------------------------------------------------------------------------------------------------

    country_data <- reactive({
      continent_data()[continent_data()$country %in% input$country, ]
    })

    observeEvent(input$country, {
      states <- sort(as.character(unique(country_data()$state)))

      lgas <- sort(as.character(unique(country_data()$lga)))

      updatePickerInput(session, inputId = "state", choices = states, selected = states, clearOptions = TRUE)
      updatePickerInput(session, inputId = "lga", choices = lgas, selected = lgas, clearOptions = TRUE)
    })


    # choose lgas -------------------------------------------------------------------------------------------------------------

    state_data <- reactive({
      country_data()[country_data()$state %in% input$state, ]
    })

    observeEvent(input$state, {

      lgas2 <- sort(as.character(unique(state_data()$lga)))

      updatePickerInput(session, inputId = "lga", choices = lgas2, selected = lgas2, clearOptions = TRUE)
    })



    # output selected data ------------------------------------------------------------------------------------------------------

    selected_table <- eventReactive(input$update, {
      subset(
        country_data(),
        state %in% input$state &
          lga %in% input$lga
        )
      })

    return(selected_table)



  })
}
