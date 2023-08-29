sidebar <- dashboardSidebar(
              sidebarMenu(
                menuItem("Department", tabName = "department"),
                menuItem("Visit Type", tabName = "visit_type")
              )
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
