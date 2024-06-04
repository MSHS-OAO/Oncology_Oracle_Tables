sidebar <- dashboardSidebar(
              sidebarMenu(id = 'sbm',
                menuItem("Data Submssion", tabName = "datasubmission"),
                menuItem("Department", tabName = "department"),
                menuItem("Visit Type", tabName = "visit_type"),
                menuItem("Disease Group", tabName = "disease"),
                menuItem("Zip Code", tabName = "zip_code"),
                menuItem("Diagnosis", tabName = "diagnosis"),
                menuItem("Race", tabName = "race"),
                menuItem("Ethnicity", tabName = "ethnicity")
                
                
              )
            )

body <- dashboardBody(
          tabItems(
            tabItem(
              tabName = "datasubmission",
              tabPanel("Data Mapping", br(),
                       fileInput("data_mappings", 
                                 label = "Please upload Mapping File",
                                 accept = ".xlsx",
                                 width = '100%'),
                       column(4, offset = 4,
                       actionButton("submit_mappings", 
                                    label = "Submit",
                                    width = '100%',
                                    style="color: #fff; background-color: #d80b8c; border-color: #d80b8c")
                       )
              )
            ),
            tabItem(
              tabName = "department",
                rHandsontableOutput("department_table"),
              br(),
              column(5),
                #column(3,download_buttonUI("department_table_download"))
              downloadButton("department_table_download", "Download Department Mapping Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
              
              # h3("Update Department Mapping"),
              #   rHandsontableOutput("department_submit_table"),
              #   br(),
              # column(5),
              # column(1,
              #        actionButton("department_submit", "Submit",
              #                     width = '100%',
              #                     style="color: #fff; background-color: #d80b8c; border-color: #d80b8c"
              #        )
              # ),
              # br(),
              # br(),
              # column(3),
              # p("Please note any submissions made will be reflected in the data the following day by 8am")
              
            ),
            tabItem(
              tabName = "visit_type",
              rHandsontableOutput("visit_table"),
              br(),
              column(5),
              downloadButton("visit_table_download", "Download Visit Mapping Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
              
              h3("Update Visit Type Mapping"),
              rHandsontableOutput("visit_type_submit_table"),
              br(),
              column(5)
              # column(1,
              #        actionButton("visit_type_submit", "Submit",
              #                     width = '100%',
              #                     style="color: #fff; background-color: #d80b8c; border-color: #d80b8c"
              #        )
              # ),
              # br(),
              # br(),
              # column(3),
              # p("Please note any submissions made will be reflected in the data the following day by 8am")
            ),
            tabItem(
              tabName = "disease",
              rHandsontableOutput("disease_table"),
              column(5),
              downloadButton("disease_table_download", "Download Disease Mapping Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
              
              # h3("Update Disease Group Mapping"),
              # rHandsontableOutput("disease_group_submit_table"),
              # br(),
              # column(5),
              # column(1,
              #        actionButton("disease_submit", "Submit",
              #                     width = '100%',
              #                     style="color: #fff; background-color: #d80b8c; border-color: #d80b8c"
              #        )
              # ),
              # br(),
              # br(),
              # column(3),
              # p("Please note any submissions made will be reflected in the data the following day by 8am")
              
            ),
            tabItem(
              tabName = "zip_code",
              rHandsontableOutput("zip_code_table"),
              column(5),
              downloadButton("zip_code_table_download", "Download Zip Code Mapping Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
              h3("Items Needing Updates"),
              rHandsontableOutput("zip_code_submit_table")
              
              # br(),
              # column(5),
              # column(1,
              #        actionButton("zip_code_submit", "Submit",
              #                     width = '100%',
              #                     style="color: #fff; background-color: #d80b8c; border-color: #d80b8c"
              #        )
              # ),
              # br(),
              # br(),
              # column(3),
              # p("Please note any submissions made will be reflected in the data the following day by 8am")
              
            ),
            tabItem(
              tabName = "diagnosis",
              rHandsontableOutput("diagnosis_table"),
              column(5),
              downloadButton("diagnosis_table_download", "Download Diagnosis Mapping Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
              
              h3("Items Needing Updates"),
              rHandsontableOutput("dx_grouper_submit_table")
              # br(),
              # column(5),
              # column(1,
              #        actionButton("diagnosis_grouper_submit", "Submit",
              #                     width = '100%',
              #                     style="color: #fff; background-color: #d80b8c; border-color: #d80b8c"
              #        )
              # ),
              # br(),
              # br(),
              # column(3),
              # p("Please note any submissions made will be reflected in the data the following day by 8am")
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

                  rHandsontableOutput("race_submit_table"),
                  br()
              #     column(5),
              #     column(1,
              #            actionButton("race_grouper_submit", "Submit",
              #                         width = '100%',
              #                         style="color: #fff; background-color: #d80b8c; border-color: #d80b8c"
              #            )
              #     ),
              #     br(),
              # br(),
              # column(3),
              # p("Please note any submissions made will be reflected in the data the following day by 8am")

              
            ),
            tabItem(
              tabName = "ethnicity",
              rHandsontableOutput("ethnicity_table"),
              br(),
              column(5),
              downloadButton("ethnicity_table_download", "Download Ethnicity Grouper Table", width = '100%',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
              
              h3("Update Ethnicity Grouper Mapping"),
              rHandsontableOutput("ethnicity_grouper_submit_table"),
              br()
              # column(5),
              # column(1,
              #        actionButton("ethnicity_grouper_type_submit", "Submit",
              #                     width = '100%',
              #                     style="color: #fff; background-color: #d80b8c; border-color: #d80b8c"
              #        )
              # ),
              # br(),
              # br(),
              # column(3),
              # p("Please note any submissions made will be reflected in the data the following day by 8am")
            )
          )
        )


ui <- dashboardPage(
        dashboardHeader(title = "Oncology Mapping Tables"),
        sidebar,
        body
      )
