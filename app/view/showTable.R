# app/view/showTable.R

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
    req
    ],
  DT[
    dataTableOutput,
    renderDataTable
    ],
  tibble[tibble],
  glue[glue]
)

# box::use(
#   app/view/site
# )

box::use(
  app/view[site]
)


#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    dataTableOutput(
      ns("table")
    )
  )
}

#' @export
server <- function(
    id,
    data
    ) {
  moduleServer(id, function(input, output, session) {

    output$table <- renderDataTable(
      data()[, -c(1:4, 10:18)],
      rownames = FALSE,
      selection = "single"
      )

    selected_row <- reactive({
      req(input$table_rows_selected)
      data()[input$table_rows_selected, ]
    })

    modal_table <- reactive({
      data.frame(
      c(
          glue("Name: {selected_row()$full_name}"),
          glue("Email: {selected_row()$email}"),
          glue("Phone number: {selected_row()$phone_number}"),
          glue("Qualification: {selected_row()$qualification}"),
          glue("Facility: {selected_row()$facility}"),
          glue("Courses taken:
              Fundamentals of HIV
              ")
          ),
        c(
          glue("LGA: {selected_row()$lga}"),
          glue("State: {selected_row()$state}"),
          glue("Program area: {selected_row()$program_area}"),
          glue("Indicators: {selected_row()$indicators}"),
          glue("Courses taken: {selected_row()$courses_taken}"),
          glue("Planned courses: {selected_row()$planned_courses}"
              )
        ),
      check.names = FALSE,
      fix.empty.names = FALSE
        )

    })


    observeEvent(input$table_rows_selected, {


      showModal(
        modalDialog(
          renderTable(modal_table()),
          # "This will be the content of the table",
          title = "Learner profile",
          size = "xl",
          easyClose = TRUE,
          fade = TRUE
          # ,
          # footer = modalButton("Close", icon = icon("close"))
        )
      )

    })

  })
}
