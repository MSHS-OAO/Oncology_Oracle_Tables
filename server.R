server <- function(input, output, session) {
  
  
  
  observeEvent(input$sbm, {
    if(input$sbm == 'department') {
      department_data <- table_collect("department_data", department_table_last_arrived)
      
      output$department_table <- RhandsonServer("department_table", department_data())
      
      output$department_table_download <- downloadHandler(
        filename = function(){
          paste0("department_mapping ", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(department_data(),file, row.names = F)
        }
      )
    }
    
    if(input$sbm == 'visit_type') {
      visit_data <- table_collect("visit_data", visit_type_groupings_last_arrived)
      
      output$visit_table <- RhandsonServer("visit_table", visit_data())
      output$visit_table_download <- downloadHandler(
        filename = function(){
          paste0("visit_type_mapping ", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(visit_data(),file, row.names = F)
        }
      )
    }
    if(input$sbm == 'disease') {
      disease_data <- table_collect("disease_data", disease_groupings_last_arrived)
      
      output$disease_table <- RhandsonServer("disease_table", disease_data())
      
      output$disease_table_download <- downloadHandler(
        filename = function(){
          paste0("disease_group_mapping ", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(disease_data(),file, row.names = F)
        }
      )
    }
    if(input$sbm == 'zip_code') {
      zip_code_data <- table_collect("zip_code_data", zip_code_last_arrived)
      
      output$zip_code_table <- RhandsonServer("zip_code_table", zip_code_data())
      
      output$zip_code_table_download <- downloadHandler(
        filename = function(){
          paste0("zip_code_mapping ", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(zip_code_data(),file, row.names = F)
        }
      )
      
      output$zip_code_submit_table <- RhandsonServer("zip_code_submit_table", zip_code_missing)
    }
    if(input$sbm == 'diagnosis') {
      diagnosis_data <- table_collect("diagnosis_data", dx_groupings_last_arrived)
      
      output$diagnosis_table <- RhandsonServer("diagnosis_table", diagnosis_data())
      
      output$diagnosis_table_download <- downloadHandler(
        filename = function(){
          paste0("diagnosis_group_mapping ", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(diagnosis_data(),file, row.names = F)
        }
      )
    }
    if(input$sbm == 'race') {
      race_data <- table_collect("race_data", race_groupings_last_arrived)
      
      output$race_breakdown_table <- RhandsonServer("race_breakdown_table", race_data())
      
      output$race_breakdown_table_download <- downloadHandler(
        filename = function(){
          paste0("race_group_mapping ", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(race_data(),file, row.names = F)
        }
      )
      
      output$race_submit_table <- RhandsonServer("race_submit_table", race_groupings_missing)
    }
    if(input$sbm == 'ethnicity') {
      ethnicity_data <- table_collect("ethnicity_data", ethnicity_groupings_last_arrived)
      
      output$ethnicity_table <- RhandsonServer("ethnicity_table", ethnicity_data())
    }
  })
  
}