sidebar <- dashboardSidebar(
              sidebarMenu(id = 'sbm',
                menuItem("Department", tabName = "department"),
                menuItem("Visit Type", tabName = "visit_type"),
                menuItem("Disease", tabName = "disease"),
                menuItem("Zip Code", tabName = "zip_code"),
                menuItem("Diagnosis", tabName = "diagnosis"),
                menuItem("Race", tabName = "race")#,
                #menuItem("Ethnicity", tabName = "ethnicity")
                
                
              )
            )

body <- dashboardBody(
          tabItems(
            tabItem(
              tabName = "department",
                rHandsontableOutput("department_table")
            ),
            tabItem(
              tabName = "visit_type",
              rHandsontableOutput("visit_table")
            ),
            tabItem(
              tabName = "disease",
              rHandsontableOutput("disease_table")
            ),
            tabItem(
              tabName = "zip_code",
              rHandsontableOutput("zip_code_table")
            ),
            tabItem(
              tabName = "diagnosis",
              rHandsontableOutput("diagnosis_table")
            ),
            tabItem(
              tabName = "race",
              rHandsontableOutput("race_breakdown_table")
            ),
            tabItem(
              tabName = "ethnicity",
              rHandsontableOutput("ethnicity_table")
            )
          )
        )


ui <- dashboardPage(
        dashboardHeader(title = "Oncology Mapping Tables"),
        sidebar,
        body
      )
