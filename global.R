library(DBI)
library(odbc)
library(tidyverse)
library(pool)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinycssloaders)
library(rhandsontable)

con <- dbPool(drv = odbc(), dsn = "OAO Cloud DB")

department_table <- tbl(con, "ONCOLOGY_DEPARTMENT_GROUPINGS")
department_table_last_arrived <- tbl(con, "ONCOLOGY_DEPARTMENT_GROUPINGS_LAST_ARRIVED")

visit_type_groupings_last_arrived <- tbl(con, "ONCOLOGY_PRC_GROUPINGS_LAST_ARRIVED")

disease_groupings_last_arrived <- tbl(con, "ONCOLOGY_DISEASE_GROUPINGS_LAST_ARRIVED")

zip_code_last_arrived <- tbl(con, "ONCOLOGY_ZIP_CODE_GROUPINGS_LAST_ARRIVED")

dx_groupings_last_arrived <- tbl(con, "ONCOLOGY_DX_GROUPINGS_LAST_ARRIVED")

race_groupings_last_arrived <- tbl(con, "ONCOLOGY_RACE_GROUPINGS_LAST_ARRIVED")

#ethnicity_groupings_last_arrived <- tbl(con, "ONCOLOGY_ETHNICITY_GROUPINGS_LAST_ARRIVED")

source("modules/rhandson.R")

