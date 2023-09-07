library(DBI)
library(odbc)
library(tidyverse)
library(pool)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinycssloaders)
library(rhandsontable)

con <- dbConnect(odbc(), "OAO Cloud DB")

department_table <- tbl(con, "ONCOLOGY_DEPARTMENT_GROUPINGS")
department_table_last_arrived <- tbl(con, "ONCOLOGY_DEPARTMENT_GROUPINGS_LAST_ARRIVED")

visit_type_groupings_last_arrived <- tbl(con, "ONCOLOGY_PRC_GROUPINGS_LAST_ARRIVED")

disease_groupings_last_arrived <- tbl(con, "ONCOLOGY_DISEASE_GROUPINGS_LAST_ARRIVED")

zip_code_last_arrived <- tbl(con, "ONCOLOGY_ZIP_CODE_GROUPINGS_LAST_ARRIVED")
zip_code_missing <- zip_code_last_arrived %>% filter(is.null(ZIP_CODE_LAYER_A)) %>% collect() %>% filter(!is.na(ZIP_CODE))

dx_groupings_last_arrived <- tbl(con, "ONCOLOGY_DX_GROUPINGS_LAST_ARRIVED")

race_groupings_last_arrived <- tbl(con, "ONCOLOGY_RACE_GROUPINGS_LAST_ARRIVED")
race_groupings_missing <- race_groupings_last_arrived %>% filter(is.null(RACE_GROUPER)) %>% collect() %>% filter(!is.na(RACE))

#ethnicity_groupings_last_arrived <- tbl(con, "ONCOLOGY_ETHNICITY_GROUPINGS_LAST_ARRIVED")

source("modules/rhandson.R")

