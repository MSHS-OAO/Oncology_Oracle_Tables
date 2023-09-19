RhandsonUI <- function(id) {
  tagList(
    rHandsontableOutput(NS(id, "table"))
  )
}

submitButtonUI <- function(id) {
  ns <- NS(id)
  tagList(
    actionButton(ns("submit_button_test"), "Submit",
                 width = '100%',
                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
                 )
  )
}

RhandsonServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    renderRHandsontable({
      rhandsontable(data) %>% hot_table(stretchH = "all") %>%
        hot_cols(columnSorting = TRUE)
    })
  })
  
}



table_collect <- function(id, table, button) {
  moduleServer(id, function(input, output, session) {
    reactive({
      input$button
      data <- table %>% collect() %>% mutate(across(where(is.numeric), as.integer))

    })
    
  })
}

download_buttonUI <- function(id) {
  downloadButton(outputId = NS(id, "savefile"), "Download Table", width = '100%',
               style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
}


