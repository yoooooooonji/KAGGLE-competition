# 0. install packages 
options(scipen=10)

ipak <-function(pkg){
  new.pkg<-pkg[!(pkg %in% installed.packages()[,"Package"])]
  if(length(new.pkg))
    install.packages(new.pkg,dependencies=TRUE)
  sapply(pkg,require,character.only=TRUE)
}

pkg <- c("readr", "MatchIt", "dplyr", "tidytext", "tidyverse", "lubridate", "reshape2", "psych", "gtsummary", "readxl", "MASS", "pROC", "Epi") # nolint
ipak(pkg)
##########################################################################################################################################################

data <- read.csv('kaggle-Binary/train.csv', encoding = 'utf-8', stringsAsFactors = FALSE)
dim(data)
colSums(is.na(data))
str(data)
summary(data)

# vars_to_convert <- setdiff(names(data), c('', '실제수행기간', '기본배달비_중간값', '총배달비_중간값', 'not_working', '첫운행이후'))
# df[vars_to_convert] <- lapply(df[vars_to_convert], as.factor)
# str(df)

data  %>%  
  tbl_summary(
    by = defects,
   type = list(
    all_continuous() ~ "continuous2"
   ),  
    statistic = all_continuous() ~ c("{mean} ({sd})", "{min}, {max}"),
    missing_text = "(Missing value)", 
    digits = list(all_continuous() ~ 2, all_categorical() ~ c(0, 1))
  ) %>%
  add_overall() %>%
  add_p(pvalue_fun = ~style_pvalue(., digits = 3)) %>%
  bold_labels()

