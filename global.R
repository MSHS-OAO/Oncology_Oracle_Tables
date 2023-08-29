library(DBI)
library(odbc)
library(tidyverse)
library(pool)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinycssloaders)


con <- dbPool(drv = odbc(), dsn = "OAO Cloud DB")


