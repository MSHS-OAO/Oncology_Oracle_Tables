library(DBI)
library(odbc)
library(tidyverse)
library(pool)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinycssloaders)
library(rhandsontable)
library(glue)
library(assertr)
library(readxl)
library(doParallel)

con <- dbConnect(odbc(), "OAO Cloud DB Staging")

department_table <- tbl(con, "ONCOLOGY_DEPARTMENT_GROUPINGS")
department_table_last_arrived <- tbl(con, "ONCOLOGY_DEPARTMENT_GROUPINGS_LAST_ARRIVED")

visit_type_groupings_last_arrived <- tbl(con, "ONCOLOGY_PRC_GROUPINGS_LAST_ARRIVED") %>% rename("PRC_NAME" = "APPT_TYPE")

disease_groupings_last_arrived <- tbl(con, "ONCOLOGY_DISEASE_GROUPINGS_LAST_ARRIVED")

zip_code_last_arrived <- tbl(con, "ONCOLOGY_ZIP_CODE_GROUPINGS_LAST_ARRIVED")
zip_code_missing <- zip_code_last_arrived %>% filter(is.null(ZIP_CODE_LAYER_A)) %>% collect() %>% filter(!is.na(ZIP_CODE))

dx_groupings_last_arrived <- tbl(con, "ONCOLOGY_DX_GROUPINGS_LAST_ARRIVED")

race_groupings_last_arrived <- tbl(con, "ONCOLOGY_RACE_GROUPINGS_LAST_ARRIVED")
race_groupings_missing <- race_groupings_last_arrived %>% filter(is.null(RACE_GROUPER)) %>% collect() %>% filter(!is.na(RACE))

ethnicity_groupings_last_arrived <- tbl(con, "ONCOLOGY_ETHNICITY_GROUPINGS_LAST_ARRIVED")

source("modules/rhandson.R")

remove_whitespace <- function(data) {
  data <- data %>% mutate(across(where(is.character), trimws))
  data[rowSums(is.na(data))!=ncol(data), ] 
  
  if("LAST_ARRIVED" %in% colnames(data)) {
     data <- data %>% select(-LAST_ARRIVED)
  }
  
  return(data)
}

generate_insert_statements_empty_rows <- function(process_data, table) {
  table_name <- table
  columns <- paste(colnames(process_data), collapse = ",")
  process_data <- process_data[rowSums(is.na(process_data)) != ncol(process_data), ]
  process_data <- process_data %>% mutate(across(everything(), as.character))
  
  process_data[] <- lapply(process_data, sprintf, fmt = "'%s'")
  
  process_data <- process_data %>% mutate(values = paste0("(", col_concat(., sep = ","), ")"))
  
  values <- process_data %>% select(values)
  # values <- paste(values$values, collapse = ",")
  values$values <- gsub('NA', "", values$values)
  # values <- gsub(';', "\\\\;", values)
  
  
  inserts <- lapply(
    lapply(
      lapply(split(values , 
                   1:nrow(values)),
             as.list), 
      as.character),
    FUN = get_values ,columns = columns, table_name = table)
  
  values <- glue_collapse(inserts,sep = "\n\n")
  
  
  statement <- glue('INSERT ALL
                    {values}
                    SELECT 1 from DUAL;
                    ')

  return(statement)
  
}

generate_insert_statements <- function(process_data, table) {
  #data <- data %>% select(-LAST_ARRIVED)
  process_data<- process_data[rowSums(is.na(process_data))!=ncol(process_data)-1, ] 
  table_name <- table
  columns <- paste(colnames(process_data), collapse = ",")
  process_data <- process_data %>% mutate(across(everything(), as.character))
  
  process_data[] <- lapply(process_data, sprintf, fmt = "'%s'")
  
  process_data <- process_data %>% mutate(values = paste0("(", col_concat(., sep = ","), ")"))
  
  values <- process_data %>% select(values)
  # values <- paste(values$values, collapse = ",")
  values$values <- gsub('NA', "", values$values)
  # values$values <- gsub(';', "\\\\;", values$values)
  
  inserts <- lapply(
    lapply(
      lapply(split(values , 
                   1:nrow(values)),
             as.list), 
      as.character),
    FUN = get_values ,columns = columns, table_name = table)
  
  values <- glue_collapse(inserts,sep = "\n\n")
  
  
  statement <- glue('INSERT ALL
                    {values}
                    SELECT 1 from DUAL;
                    ')
  

  
}


get_values <- function(x, columns,table_name){
  
  values <- glue("INTO \"{table_name}\" ({columns}) 
                 VALUES{x}")
  
  return(values)
}

