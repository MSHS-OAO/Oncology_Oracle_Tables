sidebar <- dashboardSidebar(
              sidebarMenu(id = 'sbm',
                menuItem("Department", tabName = "department"),
                menuItem("Visit Type", tabName = "visit_type"),
                menuItem("Disease Group", tabName = "disease"),
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
                rHandsontableOutput("department_table"),
              br(),
              column(5),
                #column(3,download_buttonUI("department_table_download"))
              downloadButton("department_table_download", "Download Department Mapping Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
              
            ),
            tabItem(
              tabName = "visit_type",
              rHandsontableOutput("visit_table"),
              br(),
              column(5),
              downloadButton("visit_table_download", "Download Visit Mapping Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
            ),
            tabItem(
              tabName = "disease",
              rHandsontableOutput("disease_table"),
              column(5),
              downloadButton("disease_table_download", "Download Disease Mapping Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
            ),
            tabItem(
              tabName = "zip_code",
              rHandsontableOutput("zip_code_table"),
              column(5),
              downloadButton("zip_code_table_download", "Download Zip Code Mapping Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
              h3("Items Needing Updates"),
              rHandsontableOutput("zip_code_submit_table")
              
            ),
            tabItem(
              tabName = "diagnosis",
              rHandsontableOutput("diagnosis_table"),
              column(5),
              downloadButton("diagnosis_table_download", "Download Diagnosis Mapping Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
            ),
            tabItem(
              tabName = "race",
              fluidRow(
                rHandsontableOutput("race_breakdown_table"),
                column(5),
                downloadButton("race_breakdown_table_download", "Download Race Grouper Table", width = '100%',
                               style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
              ),
              h3("Items Needing Updates"),
              fluidRow(

                  rHandsontableOutput("race_submit_table")
                  
              )
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
