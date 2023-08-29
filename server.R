server <- function(input, output, session) {
  
  observeEvent(input$sbm, {
    if(input$sbm == 'department') {
      department_data <- table_collect("department_data", department_table_last_arrived)
      
      output$department_table <- RhandsonServer("department_table", department_data())
    }
    
    if(input$sbm == 'visit_type') {
      visit_data <- table_collect("visit_data", visit_type_groupings_last_arrived)
      
      output$visit_table <- RhandsonServer("visit_table", visit_data())
    }
    if(input$sbm == 'disease') {
      disease_data <- table_collect("disease_data", disease_groupings_last_arrived)
      
      output$disease_table <- RhandsonServer("disease_table", disease_data())
    }
    if(input$sbm == 'zip_code') {
      zip_code_data <- table_collect("zip_code_data", zip_code_last_arrived)
      
      output$zip_code_table <- RhandsonServer("zip_code_table", zip_code_data())
    }
    if(input$sbm == 'diagnosis') {
      diagnosis_data <- table_collect("diagnosis_data", dx_groupings_last_arrived)
      
      output$diagnosis_table <- RhandsonServer("diagnosis_table", diagnosis_data())
    }
    if(input$sbm == 'race') {
      race_data <- table_collect("race_data", race_groupings_last_arrived)
      
      output$race_breakdown_table <- RhandsonServer("race_breakdown_table", race_data())
    }
    if(input$sbm == 'ethnicity') {
      ethnicity_data <- table_collect("ethnicity_data", ethnicity_groupings_last_arrived)
      
      output$ethnicity_table <- RhandsonServer("ethnicity_table", ethnicity_data())
    }
  })
  
}