# app/view/login.R

box::use(
  shiny[moduleServer, NS, tabPanel, icon, navbarPage],
  shinyauthr[loginUI],
)


# login tab ui to be rendered on launch
login_tab <- tabPanel(
  title = icon("lock"),
  value = "login",
  loginUI("login")
)


#' @export
ui <- function(id) {
  ns <- NS(id)

  navbarPage(
    title = "",
    id = "tabs",
    collapsible = TRUE,
    login_tab
  )

}
