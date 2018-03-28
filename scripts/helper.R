as_numeric_german <- function(x) {

  x <- str_replace(x, "\\.", "")
  x <- str_replace(x, ",", ".")
  as.numeric(x)
}


calc_delta <- function (df, col) {
  # mutates a tibble by calculating absolute and relative difference of col.x and col.y 
  
  expr <- enquo(col)
  name <- quo_name(expr)
  col_x <- as.symbol(paste0(name, ".x"))
  col_y <- as.symbol(paste0(name, ".y"))
  col_abs <- paste0(name, "_abs")
  col_rel <- paste0(name, "_rel")
  
  df %>%
    mutate(!!col_abs := (!!col_y) - (!!col_x)) %>%
    mutate(!!col_rel := ((!!col_y) - (!!col_x)) / (!!col_x) * 100)
}

import_residential <- function (table, year) {
  # Imports 'Flaeche nach tatsächlicher Nutzung' for a given year
  
  file_name <- str_c("./input/", table, "-", year, ".csv")
  
  residential <- read_csv2(file_name,
   col_names = FALSE, col_types = cols(.default = col_character()),
   comment = "#",
   skip = 9,
   locale = locale(encoding = "ISO-8859-14", decimal_mark = ",", grouping_mark = "."),
   na = c("", ".", "/")
  )
  
  colnames(residential)[1:3] <- c("id", "name", "buildings")
  residential[residential == "-"] <- 0
  residential <- residential %>%
    filter(name != "Gemeindefreie Gebiete")
  
  # residential$year <- rep(as.integer(year), dim(residential)[1])
  residential <- residential %>% 
    mutate(year = year) %>%
    mutate(buildings = parse_integer(buildings))
  
}

import_area <- function (table, year) {
  # Imports 'Flaeche nach tatsächlicher Nutzung' for a given year
  
  file_name <- str_c("./input/", table, "-", year, ".csv")
  
  area <- read_csv2(file_name,
                    col_names = TRUE, col_types = cols(.default = col_character()),
                    comment = "#",
                    skip = 8,
                    locale = locale(encoding = "ISO-8859-14", decimal_mark = ",", grouping_mark = "."),
                    na = c("", ".", "/")
  )
  
  if (table == "33111-001r") {
    
    colnames(area) <- str_c("cat", str_sub(colnames(area), 1, 5))
    colnames(area)[3] <- "cat00000"
  }
  
  else if (table == "33111-101r") {
    
    colnames(area) <- str_c("cat", colnames(area))
  }
  
  
  colnames(area)[1:2] <- c("id", "name")
  area[area == "-"] <- 0
  area <- area %>%
    filter(!is.na(id)) %>%
    filter(name != "Gemeindefreie Gebiete")
  
  area_cat <- area %>%
    select(starts_with("cat")) %>%
    mutate_all(as_numeric_german)
  
  if (table == "33111-101r") {
    
    area_cat <- area_cat %>%
      mutate_all(function(x) {x / 100})
  }
  
  area_cat$id <- area$id
  area_cat$year <- rep(as.integer(year), dim(area)[1])
  
  area %>%
    select(id, name) %>%
    inner_join(area_cat)
}
