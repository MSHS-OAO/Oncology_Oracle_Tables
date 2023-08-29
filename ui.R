ui <- dashboardBadge(
        dashboardSidebar(
          tags$head(tags$style(HTML('.logo {
                              background-color: #221f72 !important;
                              }
                              .navbar {
                              background-color: #221f72 !important;
                              }
                              
                              .content-wrapper {
                              background-color: white !important;
                              }'
                                    
          ))),
          
          # Overwrite fixed height of dashboard sidebar
          #tags$head(tags$style(HTML('.content-wrapper { height: 6000px !important;}'))),
          
          width = 200,
          sidebarMenu(id = "sbm")
        )
)