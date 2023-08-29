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
