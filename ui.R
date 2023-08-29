sidebar <- dashboardSidebar(
  sidebarMenu("Departments", tabName = "department")
)

body <- dashboardBody(
          tabItems(
            tabItem(
              tabName = "department",
              h2("Test")
            )
          )
        )


ui <- dashboardPage(
        dashboardHeader(title = "Oncology Mapping Tables"),
        sidebar,
        body
      )
