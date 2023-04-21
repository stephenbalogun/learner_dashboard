
box::use(
  shiny[
    navbarPage,
    moduleServer,
    NS,
    tabPanel,
    titlePanel,
    div,
    img,
    span,
    reactive,
    tableOutput,
    renderTable,
    fluidPage,
    icon,
    insertUI,
    observeEvent
    ],
  shinyauthr[
    logoutUI,
    loginUI,
    loginServer,
    logoutServer
    ],
  tibble[tibble],
  sodium[password_store],
  purrr[map_chr],
  htmltools[tags]
)

box::use(
  app/view[
    map,
    learners,
    indicators,
    guide,
    footer,
    login
    ]
)

box::use(
  app/logic/theme[adrap_theme],
  app/logic/sitesData[sites_data]
)


df <- sites_data()


# user database for logins
user_base <- tibble(
  user = c("user1", "user2"),
  password = map_chr(c("pass1", "pass2"), password_store),
  permissions = c("admin", "standard"),
  name = c("User One", "User Two")
)

# login tab ui to be rendered on launch
login_tab <- tabPanel(
  title = icon("lock"),
  value = "login",
  loginUI("login")
)

# user interface ------------------------------------------------------------------------------------------------------------


#' @export
ui <- function(id) {
  ns <- NS(id)

  # navbarPage(
  #   theme = adrap_theme(),
  #   title = "Learner dashboard",
  #   id = "tabs",
  #   collapsible = TRUE,
  #   login_tab
  # )

  navbarPage(
    theme = adrap_theme(),
    position = "fixed-top",
    collapsible = TRUE,
    title = titlePanel(
      div(
        img(src = "static/images/adrap.png", height = 50),
        span(id = "learner", "Learner Dashboard")
        ),
      windowTitle = NULL
      ),
    map$ui(ns("map")),
    learners$ui(ns("learners"), df),
    indicators$ui(ns("indicators"), df),
    guide$ui(ns("guide")),
    footer = footer$ui(ns("footer")),
    inverse = TRUE,
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    # # hack to add the logout button to the navbar on app launch
    # insertUI(
    #   selector = ".navbar .container-fluid .navbar-collapse",
    #   ui = tags$ul(
    #     class="nav navbar-nav navbar-right",
    #     tags$li(
    #       div(
    #         style = "padding: 10px; padding-top: 8px; padding-bottom: 0;",
    #         logoutUI("logout")
    #       )
    #     )
    #   )
    # )
    #
    # # call the shinyauthr login and logout server modules
    # credentials <- loginServer(
    #   id = "login",
    #   data = user_base,
    #   user_col = "user",
    #   pwd_col = "password",
    #   sodium_hashed = TRUE,
    #   reload_on_logout = TRUE,
    #   log_out = reactive(logout_init())
    # )
    #
    # logout_init <- logoutServer(
    #   id = "logout",
    #   active = reactive(credentials()$user_auth)
    # )
    #
    #
    #
    # observeEvent(credentials()$user_auth, {
    #   # if user logs in successfully
    #   if (credentials()$user_auth) {
    #     # remove the login tab
    #     removeTab("tabs", "login")
    #     # add home tab
    #     appendTab("tabs", map$ui(ns("map")), select = TRUE)
    #     # render user data output
    #     # output$user_data <- renderPrint({ dplyr::glimpse(credentials()$info) })
    #     # add data tab
    #     appendTab("tabs", learners$ui(ns("learners"), df))
    #     # render data tab title and table depending on permissions
    #     # user_permission <- credentials()$info$permissions
    #     # if (user_permission == "admin") {
    #     #   output$data_title <- renderUI(tags$h2("Storms data. Permissions: admin"))
    #     #   output$table <- DT::renderDT({ dplyr::storms[1:100, 1:11] })
    #     # } else if (user_permission == "standard") {
    #     #   output$data_title <- renderUI(tags$h2("Starwars data. Permissions: standard"))
    #     #   output$table <- DT::renderDT({ dplyr::starwars[, 1:10] })
    #     # }
    #   }
    # })

    map$server("map")

    learners$server("learners", df)

    indicators$server("indicators", df)



  })
}
