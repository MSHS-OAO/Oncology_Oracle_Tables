RhandsonUI <- function(id) {
  tagList(
    rHandsontableOutput(NS(id, "table"))
  )
}

RhandsonServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    renderRHandsontable({
      rhandsontable(data, height = 600) %>% hot_table(stretchH = "all") %>%
        hot_cols(columnSorting = TRUE)
    })
  })
  
}



table_collect <- function(id, table) {
  moduleServer(id, function(input, output, session) {
    reactive({
      data <- table %>% collect()
    })
    
  })
}

download_buttonUI <- function(id) {
  downloadButton(outputId = NS(id, "savefile"), "Download Table", width = '100%',
               style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
}


