server <- function(input, output, session) {
  
  observeEvent(input$sbm, {
    if(input$sbm == 'department') {
      department_data <- table_collect("department_data", department_table_last_arrived, department_submit)
      
      output$department_table <- RhandsonServer("department_table", department_data())
      
      output$department_table_download <- downloadHandler(
        filename = function(){
          paste0("department_mapping ", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(department_data(),file, row.names = F)
        }
      )
      
    #   output$department_submit_table <- renderRHandsontable({
    #                                       input$department_submit
    #                                       data <- department_data()[0, ] %>% select(-LAST_ARRIVED) 
    #                                       data[1:5,] <- NA
    #                                       site <- department_table_last_arrived %>% select(SITE) %>% distinct() %>% collect()
    #                                       
    #                                       rhandsontable(data) %>% hot_table(stretchH = "all") %>%
    #                                         hot_cols(columnSorting = TRUE) %>%
    #                                         hot_col(col = "SITE", type = "autocomplete", source = sort(unique(site$SITE)), strict = TRUE)
    #                                     })
    #   
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
      
      visit_data_missing <- eventReactive(input$visit_type_submit, {
        data <- visit_type_groupings_last_arrived %>% filter(is.na(ASSOCIATIONLISTA)) %>% collect() %>% mutate(LAST_ARRIVED = as.character(LAST_ARRIVED))
      }, ignoreNULL = FALSE)
      output$visit_type_submit_table <- renderRHandsontable({
                                      data <- visit_data_missing()
                                      association_list_a <- visit_type_groupings_last_arrived %>% select(ASSOCIATIONLISTA) %>% distinct() %>% collect()
                                      association_list_b <- visit_type_groupings_last_arrived %>% select(ASSOCIATIONLISTB) %>% distinct() %>% collect()
                                      association_list_t <- visit_type_groupings_last_arrived %>% select(ASSOCIATIONLISTT) %>% distinct() %>% collect()
                                      
                                      rhandsontable(data) %>% hot_table(stretchH = "all") %>%
                                        hot_cols(columnSorting = TRUE) %>%
                                        hot_col(col = "ASSOCIATIONLISTA", type = "autocomplete", source = sort(unique(association_list_a$ASSOCIATIONLISTA)), strict = TRUE) %>%
                                        hot_col(col = "ASSOCIATIONLISTB", type = "autocomplete", source = sort(unique(association_list_b$ASSOCIATIONLISTB)), strict = TRUE) %>%
                                        hot_col(col = "ASSOCIATIONLISTT", type = "autocomplete", source = sort(unique(association_list_t$ASSOCIATIONLISTT)), strict = TRUE) %>%
                                        hot_col(col = "INPERSONVSTELE", type = "autocomplete", source = c("In Person", "Telehealth"))
                                      
      })
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
      
      output$disease_group_submit_table <- renderRHandsontable({
        input$disease_submit
        data <- disease_data()[0, ] %>% select(-LAST_ARRIVED) 
        data[1:5,] <- NA
        disease <- disease_groupings_last_arrived %>% select(DISEASE_GROUP) %>% distinct() %>% collect()
        disease_b <- disease_groupings_last_arrived %>% select(DISEASE_GROUP_B) %>% distinct() %>% collect()
        provider_type <- disease_groupings_last_arrived %>% select(PROVIDER_TYPE) %>% distinct() %>% collect()
        disease_site <- disease_groupings_last_arrived %>% select(SITE) %>% distinct() %>% collect()
        
        
        rhandsontable(data) %>% hot_table(stretchH = "all") %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_col(col = "DISEASE_GROUP", type = "autocomplete", source = sort(unique(disease$DISEASE_GROUP))) %>%
          hot_col(col = "DISEASE_GROUP_B", type = "autocomplete", source = sort(unique(disease_b$DISEASE_GROUP_B))) %>%
          hot_col(col = "PROVIDER_TYPE", type = "autocomplete", source = sort(unique(provider_type$PROVIDER_TYPE))) %>%
          hot_col(col = "SITE", type = "autocomplete", source = sort(unique(disease_site$SITE)))
        
      })
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
      
      zip_code_missing <- eventReactive(input$zip_code_submit, {
        data <-  zip_code_last_arrived %>% filter(is.null(ZIP_CODE_LAYER_A)) %>% collect() %>% filter(!is.na(ZIP_CODE)) %>% mutate(LAST_ARRIVED = as.character(LAST_ARRIVED))
      }, ignoreNULL = FALSE)
      
      output$zip_code_submit_table <- renderRHandsontable({
        data <- zip_code_missing()
        zip_code_layer <- zip_code_last_arrived %>% select(ZIP_CODE_LAYER_A) %>% distinct() %>% collect()
        
        
        rhandsontable(data) %>% hot_table(stretchH = "all") %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_col(col = "ZIP_CODE_LAYER_A", type = "autocomplete", source = sort(unique(zip_code_layer$ZIP_CODE_LAYER_A)), strict = TRUE) 
        
      })
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
      
      dx_missing <- eventReactive(input$diagnosis_grouper_submit, {
        data <- dx_groupings_last_arrived %>% filter(is.null(DX_GROUPER)) %>% collect() %>% filter(!is.na(PRIMARY_DX_CODE)) %>% mutate(LAST_ARRIVED = as.character(LAST_ARRIVED))
      }, ignoreNULL = FALSE)
      output$dx_grouper_submit_table <- renderRHandsontable({
        data <- dx_missing()
        dx_grouper <- dx_groupings_last_arrived %>% select(DX_GROUPER) %>% distinct() %>% collect()
        dx_grouper_detail <- dx_groupings_last_arrived %>% select(DX_DETAIL) %>% distinct() %>% collect()
        
        
        
        rhandsontable(data) %>% hot_table(stretchH = "all") %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_col(col = "DX_GROUPER", type = "autocomplete", source = sort(unique(dx_grouper$DX_GROUPER)), strict = TRUE) %>%
          hot_col(col = "DX_DETAIL", type = "autocomplete", source = sort(unique(dx_grouper_detail$DX_DETAIL)), strict = TRUE) 
        
        
      })
      
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
      
      race_groupings_missing <- eventReactive(input$race_grouper_submit, {
        data <-  race_groupings_last_arrived %>% filter(is.null(RACE_GROUPER)) %>% collect() %>% filter(!is.na(RACE)) %>% mutate(LAST_ARRIVED = as.character(LAST_ARRIVED))
      }, ignoreNULL = FALSE)
      
      
      output$race_submit_table <- renderRHandsontable({
        data <- race_groupings_missing()
        race_grouper <<- race_groupings_last_arrived %>% select(RACE_GROUPER) %>% distinct() %>% collect()
        race_grouper_detail <<- race_groupings_last_arrived %>% select(RACE_GROUPER_DETAIL) %>% distinct() %>% collect()

        rhandsontable(data) %>% hot_table(stretchH = "all") %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_col(col = "RACE_GROUPER", type = "autocomplete", source = sort(unique(race_grouper$RACE_GROUPER)), strict = TRUE) %>%
          hot_col(col = "RACE_GROUPER_DETAIL", type = "autocomplete", source = sort(unique(race_grouper_detail$RACE_GROUPER_DETAIL)), strict = TRUE)
      })
    }
    if(input$sbm == 'ethnicity') {
      ethnicity_data <- table_collect("ethnicity_data", ethnicity_groupings_last_arrived)
      
      output$ethnicity_table <- RhandsonServer("ethnicity_table", ethnicity_data())
      
      output$ethnicity_table_download <- downloadHandler(
        filename = function(){
          paste0("ethnicity_grouper_mapping ", Sys.Date(), ".csv")
        },
        content = function(file) {
          write.csv(ethnicity_data(),file, row.names = F)
        }
      )
      
      ethnicity_data_missing <- eventReactive(input$ethnicity_grouper_type_submit, {
        data <- ethnicity_groupings_last_arrived %>% filter(is.na(ETHNICITY_GROUPER)) %>% collect() %>% filter(!is.na(ETHNIC_BACKGROUND)) %>% mutate(LAST_ARRIVED = as.character(LAST_ARRIVED))
      }, ignoreNULL = FALSE)
      
      output$ethnicity_grouper_submit_table <- renderRHandsontable({
        data <- ethnicity_data_missing()
        ethnicity_grouper <- ethnicity_groupings_last_arrived %>% select(ETHNICITY_GROUPER) %>% distinct() %>% collect()
        
        
        rhandsontable(data) %>% hot_table(stretchH = "all") %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_col(col = "ETHNICITY_GROUPER", type = "autocomplete", source = sort(unique(ethnicity_grouper$ETHNICITY_GROUPER)), strict = TRUE)
          
        
      })
      
    }
  })
  
  
  # observeEvent(input$department_submit, {
  #   tryCatch({ table_data <- hot_to_r(input$department_submit_table)
  #   process_data <- remove_whitespace(table_data)
  #   # dbAppendTable(con, "ONCOLOGY_DEPARTMENT_GROUPINGS", process_data)
  #   insert <- generate_insert_statements_empty_rows(process_data, "ONCOLOGY_DEPARTMENT_GROUPINGS")
  #   dbExecute(con, insert)
  #   showModal(modalDialog(
  #     title = "Success",
  #     paste0("The Department Mapping has been updated."),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   
  #   }, 
  #   
  #   error = function(err){showModal(modalDialog(
  #     title = "Error",
  #     paste0("There seems to be an issue submitting the new departments.", err),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   })
  #   
  # })
  
  
  
  # observeEvent(input$visit_type_submit, {
  #   print("observer visit")
  #   tryCatch({ table_data <- hot_to_r(input$visit_type_submit_table)
  #   process_data <- remove_whitespace(table_data)
  #   insert <- generate_insert_statements(process_data, "ONCOLOGY_PRC_GROUPINGS")
  #   dbExecute(con, insert)
  #   showModal(modalDialog(
  #     title = "Success",
  #     paste0("The Visit Type Mapping has been updated."),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   
  #   }, 
  #   
  #   error = function(err){showModal(modalDialog(
  #     title = "Error",
  #     paste0("There seems to be an issue submitting the new visit types", err),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   })
  #   
  # })
  
  
  # observeEvent(input$disease_submit, {
  #   tryCatch({ table_data <- hot_to_r(input$disease_group_submit_table)
  #   process_data <- remove_whitespace(table_data)
  #   insert <- generate_insert_statements_empty_rows(process_data, "ONCOLOGY_DISEASE_GROUPINGS")
  #   dbExecute(con, insert)
  #   showModal(modalDialog(
  #     title = "Success",
  #     paste0("The Disease Mapping has been updated."),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   
  #   }, 
  #   
  #   error = function(err){showModal(modalDialog(
  #     title = "Error",
  #     paste0("There seems to be an issue submitting the disease mappings", err),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   })
  #   
  # })
  
  # observeEvent(input$zip_code_submit, {
  #   tryCatch({ table_data <- hot_to_r(input$zip_code_submit_table)
  #   process_data <- remove_whitespace(table_data)
  #   insert <- generate_insert_statements(process_data, "ZIP_CODE_LAYER")
  #   dbExecute(con, insert)
  #   showModal(modalDialog(
  #     title = "Success",
  #     paste0("The Zip Code Mapping has been updated."),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   
  #   }, 
  #   
  #   error = function(err){showModal(modalDialog(
  #     title = "Error",
  #     paste0("There seems to be an issue submitting the zip code mappings", err),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   })
  #   
  # })
  
  # observeEvent(input$race_grouper_submit, {
  #   tryCatch({ table_data <- hot_to_r(input$race_submit_table)
  #   print("observer")
  #   process_data <- remove_whitespace(table_data)
  #   insert <- generate_insert_statements(process_data, "ONCOLOGY_RACE_GROUPER")
  #   dbExecute(con, insert)
  #   showModal(modalDialog(
  #     title = "Success",
  #     paste0("The Race Mapping has been updated."),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   
  #   }, 
  #   
  #   error = function(err){showModal(modalDialog(
  #     title = "Error",
  #     paste0("There seems to be an issue submitting the race mappings", err),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   })
  #   
  # })
  
  
  # observeEvent(input$ethnicity_grouper_type_submit, {
  #   print("observer visit")
  #   tryCatch({ table_data <- hot_to_r(input$ethnicity_grouper_submit_table)
  #   process_data <- remove_whitespace(table_data)
  #   process_data_test <<- process_data
  #   insert <- generate_insert_statements(process_data, "ONCOLOGY_ETHNICITY_GROUPER")
  #   dbExecute(con, insert)
  #   showModal(modalDialog(
  #     title = "Success",
  #     paste0("The Ethnicity Grouper Mapping has been updated."),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   
  #   }, 
  #   
  #   error = function(err){showModal(modalDialog(
  #     title = "Error",
  #     paste0("There seems to be an issue submitting the new ethnicity groupers", err),
  #     easyClose = TRUE,
  #     footer = NULL
  #   ))
  #   })
  #   
  # })
  
  ## File Submission ----
  observeEvent(input$submit_mappings, {
    button_name <- "submit_mappings"
    shinyjs::disable(button_name)
    datamappings <- input$data_mappings
    mapping_filepath  <- datamappings$datapath
    flag <- 0
    
    if(is_null(mapping_filepath)){
      showModal(modalDialog(
        title = "Error",
        paste0("No Datafile uploaded, Please upload the mapping file."),
        easyClose = TRUE,
        footer = NULL
      ))
      shinyjs::enable(button_name)
    }else{
      tryCatch({
      mapping_filepath <- "/SharedDrive/deans/Presidents/HSPI-PM/Operations Analytics and Optimization/Projects/Service Lines/Oncology/Oncology Data Mapping/DataSubmission/Oncology Mapping File - All May 2024.xlsx"
      sheets <- readxl::excel_sheets(path = mapping_filepath)
      data_sheets <- lapply(sheets, function(X) readxl::read_excel(mapping_filepath, sheet = X))
      names(data_sheets) <- sheets
      data_sheets <- lapply(data_sheets, function(X) remove_whitespace(X))
      
      # Treating the Association lists in Visit Types
      data_sheets[['Visit Types']]$ASSOCIATIONLISTA <- gsub('Labs','Lab',data_sheets[['Visit Types']]$ASSOCIATIONLISTA)
      data_sheets[['Visit Types']]$ASSOCIATIONLISTA <- gsub('Exams','Exam',data_sheets[['Visit Types']]$ASSOCIATIONLISTA)
      print(sheets)
      flag <- 1},
      
      error = function(err){  showModal(modalDialog(
        title = "Error",
        paste0("There seems to be an storing the Cost Center Mapping Data"),
        easyClose = TRUE,
        footer = NULL
      ))
        shinyjs::enable(button_name)
      })
      if(flag == 1){
        ##Compare submitted results to what is in the Summary Repo in db and return only updated rows
        #overtime_summary_data <- file_return_updated_rows(overtime_summary_data)
        
        #wirte the updated data to the Supplier Mapping table in the server
        tryCatch({
          
          lapply(sheets,function(x) write_temporary_table_to_database_and_merge_updated(
            data = as.data.frame(unname(data_sheets[x])),
            key_columns = unname(key_cols[[x]]),
            destination_table_name =  unname(table_mapper[x]),
            source_table_name = unname(table_mapper_st[x]),
            update_columns = unname(update_cols[[x]])))
          
        },
        error = function(err){  showModal(modalDialog(
          title = "Error",
          paste0("There seems to be an storing the Cost Center Mapping Data"),
          easyClose = TRUE,
          footer = NULL
        ))
          shinyjs::enable(button_name)
        })
        
    }
      
    }

  shinyjs::enable(button_name)
    
  })
  
}
