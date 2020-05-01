# Linear Regression {#LR}


```r
rm(list = ls())
```

Following packages and functions are used in this project.


```r
## basic packages
library(knitr)
library(kableExtra)
library(tidyverse)
library(conflicted)
library(magrittr)
library(broom)
## paticular packages for this project
library(lmtest)
library(corrr)
library(tseries)
library(corrplot)
source("../src/funcs.R")
source("../src/tests.R")
```



The data set is defined as follows based on file `recs.csv`:


```r
set.seed(6)
dat <-
  read_csv("../data/recs.csv") %>%
  dplyr::slice(sample(nrow(.), 300)) %>%
  mutate(y = log(KWH / NHSLDMEM)) %>%
  mutate(x8 = TOTROOMS + NCOMBATH + NHAFBATH) %>%
  dplyr::select(y, x2 = NHSLDMEM, x3 = EDUCATION, x4 = MONEYPY, x5 = HHSEX,
    x6 = HHAGE, x7 = ATHOME, x8) %>%
  mutate_at(seq(2, 8), as.integer) %>%  # make continuous variables discrete
  mutate(x5 = - x5 + 2)
```

<!-- ```{r child = '../docs/1-1.Rmd'} -->
<!-- ``` -->

<!-- ```{r child = '../docs/1-2.Rmd'} -->
<!-- ``` -->

